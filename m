From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 16 Jul 2016 02:32:46 +0200
Subject: [PATCH v9 2/7] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
In-Reply-To: <1467997678-7107-3-git-send-email-sudeep.holla@arm.com>
References: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
 <1467997678-7107-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <1500653.yRCxZC8x7Y@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 08, 2016 06:07:53 PM Sudeep Holla wrote:
> ACPI 6.0 introduced an optional object _LPI that provides an alternate
> method to describe Low Power Idle states. It defines the local power
> states for each node in a hierarchical processor topology. The OSPM can
> use _LPI object to select a local power state for each level of processor
> hierarchy in the system. They used to produce a composite power state
> request that is presented to the platform by the OSPM.
> 
> Since multiple processors affect the idle state for any non-leaf hierarchy
> node, coordination of idle state requests between the processors is
> required. ACPI supports two different coordination schemes: Platform
> coordinated and  OS initiated.
> 
> This patch adds initial support for Platform coordination scheme of LPI.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/bus.c              |  14 +-
>  drivers/acpi/processor_driver.c |   2 +-
>  drivers/acpi/processor_idle.c   | 468 +++++++++++++++++++++++++++++++++++-----
>  include/acpi/processor.h        |  24 ++-
>  include/linux/acpi.h            |   4 +
>  5 files changed, 452 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 262ca31b86d9..80ebb05e387c 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -302,6 +302,14 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
>  EXPORT_SYMBOL(acpi_run_osc);
>  
>  bool osc_sb_apei_support_acked;
> +
> +/*
> + * ACPI 6.0 Section 8.4.4.2 Idle State Coordination
> + * OSPM supports platform coordinated low power idle(LPI) states
> + */
> +bool osc_pc_lpi_support_confirmed;
> +EXPORT_SYMBOL_GPL(osc_pc_lpi_support_confirmed);
> +
>  static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
>  static void acpi_bus_osc_support(void)
>  {
> @@ -322,6 +330,7 @@ static void acpi_bus_osc_support(void)
>  		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PPC_OST_SUPPORT;
>  
>  	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
> +	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
>  
>  	if (!ghes_disable)
>  		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
> @@ -329,9 +338,12 @@ static void acpi_bus_osc_support(void)
>  		return;
>  	if (ACPI_SUCCESS(acpi_run_osc(handle, &context))) {
>  		u32 *capbuf_ret = context.ret.pointer;
> -		if (context.ret.length > OSC_SUPPORT_DWORD)
> +		if (context.ret.length > OSC_SUPPORT_DWORD) {
>  			osc_sb_apei_support_acked =
>  				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> +			osc_pc_lpi_support_confirmed =
> +				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> +		}
>  		kfree(context.ret.pointer);
>  	}
>  	/* do we need to check other returned cap? Sounds no */
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index d2fa8cb82d2b..0ca14ac7bb28 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -90,7 +90,7 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
>  						  pr->performance_platform_limit);
>  		break;
>  	case ACPI_PROCESSOR_NOTIFY_POWER:
> -		acpi_processor_cst_has_changed(pr);
> +		acpi_processor_power_state_has_changed(pr);
>  		acpi_bus_generate_netlink_event(device->pnp.device_class,
>  						  dev_name(&device->dev), event, 0);
>  		break;
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index ca0de35d1c3a..98e8c62a961c 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -303,7 +303,6 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	union acpi_object *cst;
>  
> -
>  	if (nocst)
>  		return -ENODEV;
>  
> @@ -576,7 +575,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
>  	return (working);
>  }
>  
> -static int acpi_processor_get_power_info(struct acpi_processor *pr)
> +static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
>  {
>  	unsigned int i;
>  	int result;
> @@ -810,31 +809,12 @@ static void acpi_idle_enter_freeze(struct cpuidle_device *dev,
>  	acpi_idle_do_entry(cx);
>  }
>  
> -/**
> - * acpi_processor_setup_cpuidle_cx - prepares and configures CPUIDLE
> - * device i.e. per-cpu data
> - *
> - * @pr: the ACPI processor
> - * @dev : the cpuidle device
> - */
>  static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
>  					   struct cpuidle_device *dev)
>  {
>  	int i, count = CPUIDLE_DRIVER_STATE_START;
>  	struct acpi_processor_cx *cx;
>  
> -	if (!pr->flags.power_setup_done)
> -		return -EINVAL;
> -
> -	if (pr->flags.power == 0) {
> -		return -EINVAL;
> -	}
> -
> -	if (!dev)
> -		return -EINVAL;
> -
> -	dev->cpu = pr->id;
> -
>  	if (max_cstate == 0)
>  		max_cstate = 1;
>  
> @@ -857,31 +837,13 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
>  	return 0;
>  }
>  
> -/**
> - * acpi_processor_setup_cpuidle states- prepares and configures cpuidle
> - * global state data i.e. idle routines
> - *
> - * @pr: the ACPI processor
> - */
> -static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
> +static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>  {
>  	int i, count = CPUIDLE_DRIVER_STATE_START;
>  	struct acpi_processor_cx *cx;
>  	struct cpuidle_state *state;
>  	struct cpuidle_driver *drv = &acpi_idle_driver;
>  
> -	if (!pr->flags.power_setup_done)
> -		return -EINVAL;
> -
> -	if (pr->flags.power == 0)
> -		return -EINVAL;
> -
> -	drv->safe_state_index = -1;
> -	for (i = CPUIDLE_DRIVER_STATE_START; i < CPUIDLE_STATE_MAX; i++) {
> -		drv->states[i].name[0] = '\0';
> -		drv->states[i].desc[0] = '\0';
> -	}
> -
>  	if (max_cstate == 0)
>  		max_cstate = 1;
>  
> @@ -893,7 +855,7 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
>  
>  		state = &drv->states[count];
>  		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d", i);
> -		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
> +		strlcpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
>  		state->exit_latency = cx->latency;
>  		state->target_residency = cx->latency * latency_factor;
>  		state->enter = acpi_idle_enter;
> @@ -952,7 +914,7 @@ static inline void acpi_processor_cstate_first_run_checks(void)
>  
>  static inline int disabled_by_idle_boot_param(void) { return 0; }
>  static inline void acpi_processor_cstate_first_run_checks(void) { }
> -static int acpi_processor_get_power_info(struct acpi_processor *pr)
> +static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
>  {
>  	return -ENODEV;
>  }
> @@ -963,13 +925,415 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
>  	return -EINVAL;
>  }
>  
> -static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
> +static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>  {
>  	return -EINVAL;
>  }
>  
>  #endif /* CONFIG_ACPI_PROCESSOR_CSTATE */
>  
> +struct acpi_lpi_states_array {
> +	unsigned int size;
> +	struct acpi_lpi_state *entries;
> +};
> +
> +static int obj_get_integer(union acpi_object *obj, u32 *value)
> +{
> +	if (obj->type != ACPI_TYPE_INTEGER)
> +		return -EINVAL;
> +
> +	*value = obj->integer.value;
> +	return 0;
> +}
> +
> +static int acpi_processor_evaluate_lpi(acpi_handle handle,
> +				       struct acpi_lpi_states_array *info)
> +{
> +	acpi_status status;
> +	int ret = 0;
> +	int pkg_count, state_idx = 1, loop;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *lpi_data;
> +	struct acpi_lpi_state *lpi_state;
> +
> +	status = acpi_evaluate_object(handle, "_LPI", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No _LPI, giving up\n"));
> +		return -ENODEV;
> +	}
> +
> +	lpi_data = buffer.pointer;
> +
> +	/* There must be at least 4 elements = 3 elements + 1 package */
> +	if (!lpi_data || lpi_data->type != ACPI_TYPE_PACKAGE ||
> +	    lpi_data->package.count < 4) {
> +		pr_debug("not enough elements in _LPI\n");
> +		ret = -ENODATA;
> +		goto end;
> +	}
> +
> +	pkg_count = lpi_data->package.elements[2].integer.value;
> +
> +	/* Validate number of power states. */
> +	if (pkg_count < 1 || pkg_count != lpi_data->package.count - 3) {
> +		pr_debug("count given by _LPI is not valid\n");
> +		ret = -ENODATA;
> +		goto end;
> +	}
> +
> +	lpi_state = kcalloc(pkg_count, sizeof(*lpi_state), GFP_KERNEL);
> +	if (!lpi_state) {
> +		ret = -ENOMEM;
> +		goto end;
> +	}
> +
> +	info->size = pkg_count;
> +	info->entries = lpi_state;
> +
> +	/* LPI States start at index 3 */
> +	for (loop = 3; state_idx <= pkg_count;
> +	     loop++, state_idx++, lpi_state++) {

The line break is not necessary.

> +		union acpi_object *element, *pkg_elem, *obj;
> +
> +		element = &lpi_data->package.elements[loop];
> +		if (element->type != ACPI_TYPE_PACKAGE)
> +			continue;
> +
> +		if (element->package.count < 7)
> +			continue;

The two conditions above could be ORed.

> +
> +		pkg_elem = element->package.elements;
> +
> +		obj = pkg_elem + 6;
> +		if (obj->type == ACPI_TYPE_BUFFER) {
> +			struct acpi_power_register *reg;
> +
> +			reg = (struct acpi_power_register *)obj->buffer.pointer;
> +			if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO &&
> +			    (reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE))

Inner parens not needed.

> +				continue;
> +
> +			lpi_state->address = reg->address;
> +
> +			if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
> +				lpi_state->entry_method = ACPI_CSTATE_FFH;
> +			else
> +				lpi_state->entry_method = ACPI_CSTATE_SYSTEMIO;

I'd use the ternary operator here, but that's me.

> +		} else if (obj->type == ACPI_TYPE_INTEGER) {
> +			lpi_state->entry_method = ACPI_CSTATE_INTEGER;
> +			lpi_state->address = obj->integer.value;
> +		} else {
> +			continue;
> +		}
> +
> +		/* elements[7,8] skipped for now i.e. Residency/Usage counter*/
> +
> +		obj = pkg_elem + 9;
> +		if (obj->type == ACPI_TYPE_STRING)
> +			strlcpy(lpi_state->desc, obj->string.pointer,
> +				ACPI_CX_DESC_LEN);
> +
> +		lpi_state->index = state_idx;
> +		if (obj_get_integer(pkg_elem + 0, &lpi_state->min_residency)) {
> +			pr_debug("No min. residency found, assuming 10 us\n");
> +			lpi_state->min_residency = 10;
> +		}
> +
> +		if (obj_get_integer(pkg_elem + 1, &lpi_state->wake_latency)) {
> +			pr_debug("No wakeup residency found, assuming 10 us\n");
> +			lpi_state->wake_latency = 10;
> +		}
> +
> +		if (obj_get_integer(pkg_elem + 2, &lpi_state->flags))
> +			lpi_state->flags = 0;
> +
> +		if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags))
> +			lpi_state->arch_flags = 0;
> +
> +		if (obj_get_integer(pkg_elem + 4, &lpi_state->res_cnt_freq))
> +			lpi_state->res_cnt_freq = 1;
> +
> +		if (obj_get_integer(pkg_elem + 5, &lpi_state->enable_parent_state))
> +			lpi_state->enable_parent_state = 0;
> +	}
> +
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d power states\n",
> +			  state_idx));

I'd prefer acpi_handle_debug() here.  ACPI_DEBUG_PRINT() is an ACPICA thing
really.

> +end:
> +	kfree(buffer.pointer);
> +	return ret;
> +}
> +
> +/*
> + * max_leaf_depth - holds the depth of the processor hierarchy/tree
> + * flat_state_cnt - the number of composite LPI states after the process of flattening
> + */
> +static int max_leaf_depth, flat_state_cnt;
> +
> +/**
> + * combine_lpi_states - combine local and parent LPI states to form a composite LPI state
> + *
> + * @local: local LPI state
> + * @parent: parent LPI state
> + * @result: composite LPI state
> + */
> +static bool combine_lpi_states(struct acpi_lpi_state *local,
> +			       struct acpi_lpi_state *parent,
> +			       struct acpi_lpi_state *result)
> +{
> +	if (parent->entry_method == ACPI_CSTATE_INTEGER) {
> +		if (!parent->address) /* 0 means autopromotable */
> +			return false;
> +		result->address = local->address + parent->address;
> +	} else {
> +		result->address = parent->address;
> +	}
> +
> +	result->min_residency = max(local->min_residency, parent->min_residency);
> +	result->wake_latency = local->wake_latency + parent->wake_latency;
> +	result->enable_parent_state = parent->enable_parent_state;
> +	result->entry_method = local->entry_method;
> +
> +	result->flags = parent->flags;
> +	result->arch_flags = parent->arch_flags;
> +
> +	strlcpy(result->desc, local->desc, ACPI_CX_DESC_LEN);
> +	strlcat(result->desc, "+", ACPI_CX_DESC_LEN);
> +	strlcat(result->desc, parent->desc, ACPI_CX_DESC_LEN);
> +	return true;
> +}
> +
> +#define ACPI_LPI_STATE_FLAGS_ENABLED			BIT(0)
> +
> +static int flatten_lpi_states(struct acpi_processor *pr,
> +			      struct acpi_lpi_states_array *info,
> +			      struct acpi_lpi_state *lpi,
> +			      uint32_t depth)
> +{
> +	int j, state_count = info[depth].size;
> +	struct acpi_lpi_state *t = info[depth].entries;
> +
> +	for (j = 0; j < state_count; j++, t++) {
> +		struct acpi_lpi_state *flpi;
> +		bool valid = false;
> +
> +		if (!(t->flags & ACPI_LPI_STATE_FLAGS_ENABLED))
> +			continue;
> +
> +		flpi = &pr->power.lpi_states[flat_state_cnt];
> +
> +		if (depth == max_leaf_depth) { /* leaf/processor node */
> +			memcpy(flpi, t, sizeof(*t));
> +			flpi->index = flat_state_cnt++;
> +			valid = true;
> +		} else if (lpi && t->index <= lpi->enable_parent_state) {
> +			if (combine_lpi_states(lpi, t, flpi)) {
> +				flpi->index = flat_state_cnt++;
> +				valid = true;
> +			}
> +		}
> +
> +		/*
> +		 * flatten recursively from leaf until the highest level
> +		 * (e.g. system) is reached
> +		 */
> +		if (valid && depth)
> +			flatten_lpi_states(pr, info, flpi, depth - 1);
> +	}
> +	return 0;
> +}
> +
> +static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
> +{
> +	int ret, i;
> +	struct acpi_lpi_states_array *info;
> +	struct acpi_device *d = NULL;
> +	acpi_handle handle = pr->handle, pr_ahandle;
> +	acpi_status status;
> +
> +	if (!osc_pc_lpi_support_confirmed)
> +		return -EOPNOTSUPP;
> +
> +	max_leaf_depth = 0;
> +	if (!acpi_has_method(handle, "_LPI"))
> +		return -EINVAL;
> +	flat_state_cnt = 0;
> +
> +	while (ACPI_SUCCESS(status = acpi_get_parent(handle, &pr_ahandle))) {
> +		acpi_bus_get_device(pr_ahandle, &d);
> +		handle = pr_ahandle;
> +
> +		if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
> +			break;
> +
> +		if (!acpi_has_method(pr_ahandle, "_LPI"))
> +			break;
> +
> +		max_leaf_depth++;
> +	}
> +
> +	info = kcalloc(max_leaf_depth + 1, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	pr_ahandle = pr->handle;
> +	for (i = max_leaf_depth; i >= 0 && ACPI_SUCCESS(status); i--) {
> +		handle = pr_ahandle;
> +		ret = acpi_processor_evaluate_lpi(handle, info + i);
> +		if (ret)
> +			break;
> +
> +		status = acpi_get_parent(handle, &pr_ahandle);
> +	}
> +
> +	/* flatten all the LPI states in the entire hierarchy */
> +	flatten_lpi_states(pr, info, NULL, max_leaf_depth);
> +

The above code doesn't look particularly straightforward and it seems to be
using more memory than necessary.

For instance, you don't need to store the acpi_processor_evaluate_lpi() data
for all levels at the same time.  It only needs to be stored for the current
level and you need a list of states enabling the ones at the current from
the previous one.  Plus the current list of effective states available to the
CPU.

It also should check the upper bound of pr->power.lpi_states[] somewhere which
it doesn't do AFAICS.

> +	pr->power.count = flat_state_cnt;
> +
> +	for (i = 0; i <= max_leaf_depth; i++)
> +		kfree(info[i].entries);
> +
> +	kfree(info);
> +
> +	/* Tell driver that _LPI is supported. */
> +	pr->flags.has_lpi = 1;
> +	pr->flags.power = 1;
> +
> +	return 0;
> +}
> +
> +int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
> +{
> +	return -ENODEV;
> +}
> +
> +int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
> +{
> +	return -ENODEV;
> +}
> +
> +/**
> + * acpi_idle_lpi_enter - enters an ACPI any LPI state
> + * @dev: the target CPU
> + * @drv: cpuidle driver containing cpuidle state info
> + * @index: index of target state
> + *
> + * Return: 0 for success or negative value for error
> + */
> +static int acpi_idle_lpi_enter(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv, int index)
> +{
> +	struct acpi_processor *pr;
> +	struct acpi_lpi_state *lpi;
> +
> +	pr = __this_cpu_read(processors);
> +
> +	if (unlikely(!pr))
> +		return -EINVAL;
> +
> +	lpi = &pr->power.lpi_states[index];
> +	if (lpi->entry_method == ACPI_CSTATE_FFH)
> +		return acpi_processor_ffh_lpi_enter(lpi);
> +
> +	return -EINVAL;
> +}
> +
> +static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
> +{
> +	int i;
> +	struct acpi_lpi_state *lpi;
> +	struct cpuidle_state *state;
> +	struct cpuidle_driver *drv = &acpi_idle_driver;
> +
> +	if (!pr->flags.has_lpi)
> +		return -EOPNOTSUPP;
> +
> +	for (i = 0; i < flat_state_cnt && i < CPUIDLE_STATE_MAX; i++) {
> +		lpi = &pr->power.lpi_states[i];
> +
> +		state = &drv->states[i];
> +		snprintf(state->name, CPUIDLE_NAME_LEN, "LPI-%d", i);
> +		strlcpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
> +		state->exit_latency = lpi->wake_latency;
> +		state->target_residency = lpi->min_residency;
> +		if (lpi->arch_flags)
> +			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> +		state->enter = acpi_idle_lpi_enter;
> +		drv->safe_state_index = i;
> +	}
> +
> +	drv->state_count = i;
> +
> +	return 0;
> +}
> +
> +/**
> + * acpi_processor_setup_cpuidle_states- prepares and configures cpuidle
> + * global state data i.e. idle routines
> + *
> + * @pr: the ACPI processor
> + */
> +static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
> +{
> +	int i;
> +	struct cpuidle_driver *drv = &acpi_idle_driver;
> +
> +	if (!pr->flags.power_setup_done)
> +		return -EINVAL;
> +
> +	if (pr->flags.power == 0)
> +		return -EINVAL;

The checks above can be combined into one.

> +
> +	drv->safe_state_index = -1;
> +	for (i = CPUIDLE_DRIVER_STATE_START; i < CPUIDLE_STATE_MAX; i++) {
> +		drv->states[i].name[0] = '\0';
> +		drv->states[i].desc[0] = '\0';
> +	}
> +
> +	if (pr->flags.has_lpi)
> +		return acpi_processor_setup_lpi_states(pr);
> +
> +	return acpi_processor_setup_cstates(pr);
> +}
> +
> +/**
> + * acpi_processor_setup_cpuidle_dev - prepares and configures CPUIDLE
> + * device i.e. per-cpu data
> + *
> + * @pr: the ACPI processor
> + * @dev : the cpuidle device
> + */
> +static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
> +					    struct cpuidle_device *dev)
> +{
> +	if (!pr->flags.power_setup_done)
> +		return -EINVAL;
> +
> +	if (pr->flags.power == 0)
> +		return -EINVAL;
> +
> +	if (!dev)
> +		return -EINVAL;
> +

Again, the checks above can be combined.

> +	dev->cpu = pr->id;
> +	if (pr->flags.has_lpi)
> +		return acpi_processor_ffh_lpi_probe(pr->id);
> +
> +	return acpi_processor_setup_cpuidle_cx(pr, dev);
> +}
> +

The rest of the patch looks OK to me.

Thanks,
Rafael
