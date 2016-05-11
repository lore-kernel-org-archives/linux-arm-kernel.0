From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 11 May 2016 02:03:28 +0200
Subject: [PATCH v4 2/5] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
In-Reply-To: <1461069013-13292-3-git-send-email-sudeep.holla@arm.com>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <1857618.TLitUhExSh@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 19, 2016 01:30:10 PM Sudeep Holla wrote:
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
>  drivers/acpi/bus.c              |  11 +-
>  drivers/acpi/processor_driver.c |   2 +-
>  drivers/acpi/processor_idle.c   | 441 +++++++++++++++++++++++++++++++++++-----
>  include/acpi/processor.h        |  25 ++-
>  include/linux/acpi.h            |   4 +
>  5 files changed, 422 insertions(+), 61 deletions(-)
> 
> Hi Rafael,
> 
> Yet to be discussed(retained as in from previous version):
> - Kconfig entry removal: Need feedback on how to deal with that
>   without having to introduce dummy _CST related ARM64 callbacks
> - Didn't defer processing of LPI buffers to flattening as it
>   results in the same buffer decoded multiple times
> - ACPI_CSTATE_INTEGER : IMO it's reasonable to keep it aroundsince the
>   it's part of LPI specification(not just ARM FFH)

I'm basically fine with the current set, up to some minor points.

I've sent my comments on patch [1/5] already.

My main concern about the flattening of _LPI is that at one point we'll
probably decide to unflatten it and that will change the behavior for
current users.  There needs to be a plan for that IMO.

> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index c068c829b453..94fe6e0ccfd3 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -302,6 +302,11 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
>  EXPORT_SYMBOL(acpi_run_osc);
>  
>  bool osc_sb_apei_support_acked;
> +/*
> + * ACPI 6.0 Section 8.4.4.2 Idle State Coordination
> + * OSPM supports platform coordinated low power idle(LPI) states
> + */
> +bool osc_pc_lpi_support_confirmed;
>  static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
>  static void acpi_bus_osc_support(void)
>  {
> @@ -322,6 +327,7 @@ static void acpi_bus_osc_support(void)
>  		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PPC_OST_SUPPORT;
>  
>  	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
> +	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
>  
>  	if (!ghes_disable)
>  		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
> @@ -329,9 +335,12 @@ static void acpi_bus_osc_support(void)
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
> index 1f3fe54194b5..5c78d68c7311 100644
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
> @@ -929,6 +891,7 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
>  static inline void acpi_processor_cstate_first_run_checks(void)
>  {
>  	static int first_run;
> +	acpi_status status;
>  
>  	if (first_run)
>  		return;
> @@ -951,7 +914,7 @@ static inline void acpi_processor_cstate_first_run_checks(void)
>  
>  static inline int disabled_by_idle_boot_param(void) { return 0; }
>  static inline void acpi_processor_cstate_first_run_checks(void) { }
> -static int acpi_processor_get_power_info(struct acpi_processor *pr)
> +static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
>  {
>  	return -ENODEV;
>  }
> @@ -962,13 +925,386 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
>  	return -EINVAL;
>  }
>  
> -static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
> +static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>  {
>  	return -EINVAL;
>  }
>  
>  #endif
>  
> +struct acpi_processor_lpi_info {
> +	int state_count;
> +	struct acpi_processor_lpi *lpix;
> +};

This is a bit cryptic, especially the name of the lpix field.

I'd do something like

struct acpi_lpi_states_array {
	unsigned int size;
	struct acpi_lpi_state *entries;
};

and that is sort of self-documenting.

> +
> +static int obj_get_integer(union acpi_object *obj, u32 *value)
> +{
> +	if (obj->type != ACPI_TYPE_INTEGER)
> +		return -EINVAL;

I'd add an empty line here and everywhere where there's only one
statement after if () or for () etc.

You've done that in some places IIRC, but please stick to one convention
everywhere.

> +	*value = obj->integer.value;
> +	return 0;
> +}
> +
> +static int acpi_processor_evaluate_lpi(acpi_handle handle,
> +				       struct acpi_processor_lpi_info *info)
> +{
> +	acpi_status status = 0;
> +	int ret = 0;
> +	int pkg_count, state_idx = 1, loop;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *lpi;

I'd call this lpi_data.

> +	struct acpi_processor_lpi *lpix;

What about:

struct acpi_lpi_state *lpi_state;

> +
> +	status = acpi_evaluate_object(handle, "_LPI", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No _LPI, giving up\n"));
> +		return -ENODEV;
> +	}
> +
> +	lpi = buffer.pointer;
> +
> +	/* There must be at least 4 elements = 3 elements + 1 package */
> +	if (!lpi || lpi->type != ACPI_TYPE_PACKAGE || lpi->package.count < 4) {
> +		pr_debug("not enough elements in _LPI\n");
> +		ret = -ENXIO;

-ENODATA ?

> +		goto end;
> +	}
> +
> +	pkg_count = lpi->package.elements[2].integer.value;
> +
> +	/* Validate number of power states. */
> +	if (pkg_count < 1 || pkg_count != lpi->package.count - 3) {
> +		pr_debug("count given by _LPI is not valid\n");
> +		ret = -ENXIO;

And here.

> +		goto end;
> +	}
> +
> +	lpix = kcalloc(pkg_count, sizeof(*lpix), GFP_KERNEL);
> +	if (!lpix) {
> +		ret = -ENOMEM;
> +		goto end;
> +	}
> +
> +	info->state_count = pkg_count;
> +	info->lpix = lpix;
> +	/* LPI States start at index 3 */
> +	for (loop = 3; state_idx <= pkg_count; loop++, state_idx++, lpix++) {
> +		union acpi_object *element, *pkg_elem, *obj;
> +
> +		element = &lpi->package.elements[loop];
> +		if (element->type != ACPI_TYPE_PACKAGE)
> +			continue;
> +
> +		if (element->package.count < 7)
> +			continue;
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
> +				continue;
> +			lpix->address = reg->address;
> +			if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
> +				lpix->entry_method = ACPI_CSTATE_FFH;
> +			else
> +				lpix->entry_method = ACPI_CSTATE_SYSTEMIO;
> +		} else if (obj->type == ACPI_TYPE_INTEGER) {
> +			lpix->entry_method = ACPI_CSTATE_INTEGER;
> +			lpix->address = obj->integer.value;
> +		} else {
> +			continue;
> +		}
> +
> +		/* elements[7,8] skipped for now i.e. Residency/Usage counter*/
> +
> +		obj = pkg_elem + 9;
> +		if (obj->type == ACPI_TYPE_STRING)
> +			strlcpy(lpix->desc, obj->string.pointer,
> +				ACPI_CX_DESC_LEN);
> +
> +		lpix->index = state_idx;
> +		if (obj_get_integer(pkg_elem + 0, &lpix->min_residency)) {
> +			pr_debug("No min. residency found, assuming 10 us\n");
> +			lpix->min_residency = 10;
> +		}
> +
> +		if (obj_get_integer(pkg_elem + 1, &lpix->wake_latency)) {
> +			pr_debug("No wakeup residency found, assuming 10 us\n");
> +			lpix->wake_latency = 10;
> +		}
> +
> +		if (obj_get_integer(pkg_elem + 2, &lpix->flags))
> +			lpix->flags = 0;
> +
> +		if (obj_get_integer(pkg_elem + 3, &lpix->arch_flags))
> +			lpix->arch_flags = 0;
> +
> +		if (obj_get_integer(pkg_elem + 4, &lpix->res_cnt_freq))
> +			lpix->res_cnt_freq = 1;
> +
> +		if (obj_get_integer(pkg_elem + 5, &lpix->enable_parent_state))
> +			lpix->enable_parent_state = 0;
> +	}
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d power states\n",
> +			  state_idx));
> +end:
> +	kfree(buffer.pointer);
> +	return ret;
> +}
> +
> +static int max_leaf_depth, fl_scnt;

Add a comment describing these things?

> +/**
> + * combine_lpi_states - combine local and parent LPI states to form a
> + *			composite LPI state

One line, please.

> + * @l_lpi: local LPI state
> + * @p_lpi: parent LPI state
> + * @c_lpi: composite LPI state

I'd call these local, parent and result, respectively.

> + */
> +static void combine_lpi_states(struct acpi_processor_lpi *l_lpi,
> +			       struct acpi_processor_lpi *p_lpi,
> +			       struct acpi_processor_lpi *c_lpi)
> +{
> +	c_lpi->min_residency = max(l_lpi->min_residency, p_lpi->min_residency);
> +	c_lpi->wake_latency = l_lpi->wake_latency + p_lpi->wake_latency;
> +	c_lpi->enable_parent_state = p_lpi->enable_parent_state;
> +	c_lpi->entry_method = l_lpi->entry_method;
> +
> +	if (p_lpi->entry_method == ACPI_CSTATE_INTEGER)
> +		c_lpi->address = l_lpi->address + p_lpi->address;
> +	else
> +		c_lpi->address = p_lpi->address;
> +
> +	c_lpi->index = p_lpi->index;
> +	c_lpi->flags = p_lpi->flags;
> +	c_lpi->arch_flags = p_lpi->arch_flags;
> +
> +	strlcpy(c_lpi->desc, l_lpi->desc, ACPI_CX_DESC_LEN);
> +	strlcat(c_lpi->desc, "+", ACPI_CX_DESC_LEN);
> +	strlcat(c_lpi->desc, p_lpi->desc, ACPI_CX_DESC_LEN);
> +}
> +
> +#define ACPI_LPI_STATE_FLAGS_ENABLED			BIT(0)
> +
> +static int flatten_lpi_states(struct acpi_processor *pr,
> +			      struct acpi_processor_lpi_info *info,
> +			      struct acpi_processor_lpi *lpi,
> +			      uint32_t depth)
> +{
> +	int j, scount = info[depth].state_count;

state_count ?

> +	struct acpi_processor_lpi *t = info[depth].lpix;

struct acpi_lpi_state *lpi_state = states[depth].entries;

> +
> +	for (j = 0; j < scount; j++, t++) {
> +		struct acpi_processor_lpi *flpi;
> +		bool valid = false;
> +
> +		if (!(t->flags & ACPI_LPI_STATE_FLAGS_ENABLED))
> +			continue;
> +
> +		flpi = &pr->power.lpi_states[fl_scnt];
> +		if (depth == max_leaf_depth) { /* leaf/processor node */
> +			memcpy(flpi, t, sizeof(*t));
> +			fl_scnt++;
> +			valid = true;
> +		} else if (lpi && t->index <= lpi->enable_parent_state) {
> +			combine_lpi_states(lpi, t, flpi);
> +			fl_scnt++;
> +			valid = true;
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
> +	struct acpi_processor_lpi_info *info;
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
> +	fl_scnt = 0;
> +
> +	while (ACPI_SUCCESS(status = acpi_get_parent(handle, &pr_ahandle))) {
> +		if (!acpi_has_method(handle, "_LPI"))
> +			continue;
> +		acpi_bus_get_device(handle, &d);
> +		if (!strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
> +			break;
> +		max_leaf_depth++;
> +		handle = pr_ahandle;
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
> +		status = acpi_get_parent(handle, &pr_ahandle);
> +	}
> +
> +	/* flatten all the LPI states in the entire hierarchy */
> +	flatten_lpi_states(pr, info, NULL, max_leaf_depth);
> +
> +	pr->power.count = fl_scnt;
> +	for (i = 0; i <= max_leaf_depth; i++)
> +		kfree(info[i].lpix);
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
> +int __weak acpi_processor_ffh_lpi_enter(struct acpi_processor_lpi *lpi, int idx)
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
> +	struct acpi_processor_lpi *lpi;
> +
> +	pr = __this_cpu_read(processors);
> +
> +	if (unlikely(!pr))
> +		return -EINVAL;
> +
> +	lpi = &pr->power.lpi_states[index];
> +	if (lpi->entry_method == ACPI_CSTATE_FFH)
> +		/* Call into architectural FFH based C-state */

The comment is not necessary here.

> +		return acpi_processor_ffh_lpi_enter(lpi, index);
> +	return -EINVAL;
> +}
> +
> +static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
> +{
> +	int i;
> +	struct acpi_processor_lpi *lpi;
> +	struct cpuidle_state *state;
> +	struct cpuidle_driver *drv = &acpi_idle_driver;
> +
> +	if (!pr->flags.has_lpi)
> +		return -EOPNOTSUPP;
> +
> +	for (i = 0; i < fl_scnt && i < CPUIDLE_STATE_MAX; i++) {
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

No ->enter_freeze ?

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
> +
> +	drv->safe_state_index = -1;
> +	for (i = CPUIDLE_DRIVER_STATE_START; i < CPUIDLE_STATE_MAX; i++) {
> +		drv->states[i].name[0] = '\0';
> +		drv->states[i].desc[0] = '\0';
> +	}
> +
> +	if (pr->flags.has_lpi)
> +		return acpi_processor_setup_lpi_states(pr);
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
> +	dev->cpu = pr->id;
> +	if (pr->flags.has_lpi)
> +		return acpi_processor_ffh_lpi_probe(pr->id);
> +	return acpi_processor_setup_cpuidle_cx(pr, dev);
> +}
> +
> +static int acpi_processor_get_power_info(struct acpi_processor *pr)
> +{
> +	if (acpi_processor_get_lpi_info(pr))
> +		return acpi_processor_get_cstate_info(pr);
> +	return 0;

ret = acpi_processor_get_lpi_info(pr);
if (ret)
	ret = acpi_processor_get_cstate_info(pr);

return ret;

> +}
> +
>  int acpi_processor_hotplug(struct acpi_processor *pr)
>  {
>  	int ret = 0;
> @@ -977,18 +1313,15 @@ int acpi_processor_hotplug(struct acpi_processor *pr)
>  	if (disabled_by_idle_boot_param())
>  		return 0;
>  
> -	if (nocst)
> -		return -ENODEV;
> -
>  	if (!pr->flags.power_setup_done)
>  		return -ENODEV;
>  
>  	dev = per_cpu(acpi_cpuidle_device, pr->id);
>  	cpuidle_pause_and_lock();
>  	cpuidle_disable_device(dev);
> -	acpi_processor_get_power_info(pr);
> -	if (pr->flags.power) {
> -		acpi_processor_setup_cpuidle_cx(pr, dev);
> +	ret = acpi_processor_get_power_info(pr);
> +	if (!ret && pr->flags.power) {
> +		acpi_processor_setup_cpuidle_dev(pr, dev);
>  		ret = cpuidle_enable_device(dev);
>  	}
>  	cpuidle_resume_and_unlock();
> @@ -996,7 +1329,7 @@ int acpi_processor_hotplug(struct acpi_processor *pr)
>  	return ret;
>  }
>  
> -int acpi_processor_cst_has_changed(struct acpi_processor *pr)
> +int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>  {
>  	int cpu;
>  	struct acpi_processor *_pr;
> @@ -1005,9 +1338,6 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>  	if (disabled_by_idle_boot_param())
>  		return 0;
>  
> -	if (nocst)
> -		return -ENODEV;
> -
>  	if (!pr->flags.power_setup_done)
>  		return -ENODEV;
>  
> @@ -1044,7 +1374,7 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>  			acpi_processor_get_power_info(_pr);
>  			if (_pr->flags.power) {
>  				dev = per_cpu(acpi_cpuidle_device, cpu);
> -				acpi_processor_setup_cpuidle_cx(_pr, dev);
> +				acpi_processor_setup_cpuidle_dev(_pr, dev);
>  				cpuidle_enable_device(dev);
>  			}
>  		}
> @@ -1059,7 +1389,6 @@ static int acpi_processor_registered;
>  
>  int acpi_processor_power_init(struct acpi_processor *pr)
>  {
> -	acpi_status status;
>  	int retval;
>  	struct cpuidle_device *dev;
>  
> @@ -1092,7 +1421,7 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>  			return -ENOMEM;
>  		per_cpu(acpi_cpuidle_device, pr->id) = dev;
>  
> -		acpi_processor_setup_cpuidle_cx(pr, dev);
> +		acpi_processor_setup_cpuidle_dev(pr, dev);
>  
>  		/* Register per-cpu cpuidle_device. Cpuidle driver
>  		 * must already be registered before registering device
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 50f2423d31fa..7dd1e63199ed 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -39,6 +39,7 @@
>  #define ACPI_CSTATE_SYSTEMIO	0
>  #define ACPI_CSTATE_FFH		1
>  #define ACPI_CSTATE_HALT	2
> +#define ACPI_CSTATE_INTEGER	3
>  
>  #define ACPI_CX_DESC_LEN	32
>  
> @@ -67,9 +68,25 @@ struct acpi_processor_cx {
>  	char desc[ACPI_CX_DESC_LEN];
>  };
>  
> +struct acpi_processor_lpi {

As I said above, I'd call this

struct acpi_lpi_state {

because (a) it represents a state and (b) that doesn't have to be a state
of a processor.

> +	u32 min_residency;
> +	u32 wake_latency; /* worst case */
> +	u32 flags;
> +	u32 arch_flags;
> +	u32 res_cnt_freq;
> +	u32 enable_parent_state;
> +	u64 address;
> +	u8 index;
> +	u8 entry_method;
> +	char desc[ACPI_CX_DESC_LEN];
> +};
> +
>  struct acpi_processor_power {
>  	int count;
> -	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
> +	union {
> +		struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
> +		struct acpi_processor_lpi lpi_states[ACPI_PROCESSOR_MAX_POWER];
> +	};
>  	int timer_broadcast_on_state;
>  };
>  
> @@ -189,6 +206,7 @@ struct acpi_processor_flags {
>  	u8 bm_control:1;
>  	u8 bm_check:1;
>  	u8 has_cst:1;
> +	u8 has_lpi:1;
>  	u8 power_setup_done:1;
>  	u8 bm_rld_set:1;
>  	u8 need_hotplug_init:1;
> @@ -372,7 +390,7 @@ extern struct cpuidle_driver acpi_idle_driver;
>  #ifdef CONFIG_ACPI_PROCESSOR_IDLE
>  int acpi_processor_power_init(struct acpi_processor *pr);
>  int acpi_processor_power_exit(struct acpi_processor *pr);
> -int acpi_processor_cst_has_changed(struct acpi_processor *pr);
> +int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
>  int acpi_processor_hotplug(struct acpi_processor *pr);
>  #else
>  static inline int acpi_processor_power_init(struct acpi_processor *pr)
> @@ -385,7 +403,8 @@ static inline int acpi_processor_power_exit(struct acpi_processor *pr)
>  	return -ENODEV;
>  }
>  
> -static inline int acpi_processor_cst_has_changed(struct acpi_processor *pr)
> +static inline int
> +acpi_processor_power_state_has_changed(struct acpi_processor *pr)

Please don't break lines like this.  It doesn't hurt if it is longer that 80 chars.

>  {
>  	return -ENODEV;
>  }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 06ed7e54033e..127fdc04e2b5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -452,8 +452,12 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>  #define OSC_SB_HOTPLUG_OST_SUPPORT		0x00000008
>  #define OSC_SB_APEI_SUPPORT			0x00000010
>  #define OSC_SB_CPC_SUPPORT			0x00000020
> +#define OSC_SB_CPCV2_SUPPORT			0x00000040
> +#define OSC_SB_PCLPI_SUPPORT			0x00000080
> +#define OSC_SB_OSLPI_SUPPORT			0x00000100
>  
>  extern bool osc_sb_apei_support_acked;
> +extern bool osc_pc_lpi_support_confirmed;
>  
>  /* PCI Host Bridge _OSC: Capabilities DWORD 2: Support Field */
>  #define OSC_PCI_EXT_CONFIG_SUPPORT		0x00000001
> 

Thanks,
Rafael
