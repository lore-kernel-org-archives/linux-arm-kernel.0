From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Jul 2016 18:49:06 +0100
Subject: [PATCH v6 3/4] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <1467139845-29753-4-git-send-email-ttnguyen@apm.com>
References: <1467139845-29753-1-git-send-email-ttnguyen@apm.com>
 <1467139845-29753-4-git-send-email-ttnguyen@apm.com>
Message-ID: <20160706174905.GA6523@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This looks mostly good now, though there are some remaining issues that
I've commented on below.

On Tue, Jun 28, 2016 at 11:50:44AM -0700, Tai Nguyen wrote:
> Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
> ---
>  Documentation/perf/xgene-pmu.txt |   48 ++
>  drivers/perf/Kconfig             |    7 +
>  drivers/perf/Makefile            |    1 +
>  drivers/perf/xgene_pmu.c         | 1360 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1416 insertions(+)
>  create mode 100644 Documentation/perf/xgene-pmu.txt
>  create mode 100644 drivers/perf/xgene_pmu.c

> +static const struct attribute *xgene_pmu_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group pmu_cpumask_attr_group = {
> +	.attrs = (struct attribute **) xgene_pmu_cpumask_attrs,
> +};

As mentioned previously, we shouldn't cast away constness.

Please remove the const from the definition of xgene_pmu_cpumask_attrs,
and remove the cast.

[...]

> +static int xgene_perf_event_init(struct perf_event *event)
> +{
> +	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> +	struct hw_perf_event *hw = &event->hw;
> +
> +	/* Test the event attr type check for PMU enumeration */
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/*
> +	 * SOC PMU counters are shared across all cores.
> +	 * Therefore, it does not support per-process mode.
> +	 * Also, it does not support event sampling mode.
> +	 */
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +		return -EINVAL;
> +
> +	/* SOC counters do not have usr/os/guest/host bits */
> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> +	    event->attr.exclude_host || event->attr.exclude_guest)
> +		return -EINVAL;
> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +	/*
> +	 * Many perf core operations (eg. events rotation) operate on a
> +	 * single CPU context. This is obvious for CPU PMUs, where one
> +	 * expects the same sets of events being observed on all CPUs,
> +	 * but can lead to issues for off-core PMUs, where each
> +	 * event could be theoretically assigned to a different CPU. To
> +	 * mitigate this, we enforce CPU assignment to one, selected
> +	 * processor (the one described in the "cpumask" attribute).
> +	 */
> +	event->cpu = cpumask_first(&pmu_dev->parent->cpu);
> +
> +	hw->config = event->attr.config;
> +	/*
> +	 * Each bit of the config1 field represents an agent from which the
> +	 * request of the event come. The event is counted only if it's caused
> +	 * by a request of an agent has the bit cleared.
> +	 * By default, the event is counted for all agents.
> +	 */
> +	hw->config_base = event->attr.config1;
> +
> +	return 0;
> +}

You also need to validate the event group as a whole. See the end of
arm_ccn_pmu_event_init() in drivers/bus/arm-ccn.c for an example, where
we check the leader and sibling list.

> +static void xgene_perf_enable_event(struct perf_event *event)
> +{
> +	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> +
> +	xgene_pmu_write_evttype(pmu_dev, GET_CNTR(event), GET_EVENTID(event));
> +	xgene_pmu_write_agentmsk(pmu_dev, ~((u32)GET_AGENTID(event)));
> +	if (pmu_dev->inf->type == PMU_TYPE_IOB)
> +		xgene_pmu_write_agent1msk(pmu_dev, ~((u32)GET_AGENT1ID(event)));
> +
> +	xgene_pmu_start_counters(pmu_dev);

This call to xgene_pmu_start_counters should be moved out into
pmu::pmu_enable(), which the core code will call for you. Similarly, you
should implement pmu::pmu_disable() using xgene_pmu_stop_counters().

That avoids poking the HW repeatedly to enable/disable all counters,
ensures that event groups count for the same time, etc.

In your pmu::pmu_enable() implementation you should probably check
whether you have any events (e.g. by looking at the counter bitmap). If
there are no events, you can avoid pointlessly enabling the PMU HW.

> +	xgene_pmu_enable_counter(pmu_dev, GET_CNTR(event));
> +	xgene_pmu_enable_counter_int(pmu_dev, GET_CNTR(event));
> +}

[...]

> +static irqreturn_t xgene_pmu_isr(int irq, void *dev_id)
> +{
> +	struct xgene_pmu_dev_ctx *ctx, *temp_ctx;
> +	struct xgene_pmu *xgene_pmu = dev_id;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&xgene_pmu->lock, flags);
> +
> +	/* Get Interrupt PMU source */
> +	val = readl(xgene_pmu->pcppmu_csr + PCPPMU_INTSTATUS_REG);
> +	if (val & PCPPMU_INT_MCU) {
> +		list_for_each_entry_safe(ctx, temp_ctx,
> +				&xgene_pmu->mcpmus, next) {
> +			_xgene_pmu_isr(irq, ctx->pmu_dev);
> +		}
> +	}

No handlers modify the list, so there's no need to use
list_for_each_entry_safe, and you don't need the tmp_ctx variable.

> +	if (val & PCPPMU_INT_MCB) {
> +		list_for_each_entry_safe(ctx, temp_ctx,
> +				&xgene_pmu->mcbpmus, next) {
> +			_xgene_pmu_isr(irq, ctx->pmu_dev);
> +		}
> +	}
> +	if (val & PCPPMU_INT_L3C) {
> +		list_for_each_entry_safe(ctx, temp_ctx,
> +				&xgene_pmu->l3cpmus, next) {
> +			_xgene_pmu_isr(irq, ctx->pmu_dev);
> +		}
> +	}
> +	if (val & PCPPMU_INT_IOB) {
> +		list_for_each_entry_safe(ctx, temp_ctx,
> +				&xgene_pmu->iobpmus, next) {
> +			_xgene_pmu_isr(irq, ctx->pmu_dev);
> +		}
> +	}
> +
> +	raw_spin_unlock_irqrestore(&xgene_pmu->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}

[...]

> +static struct
> +xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
> +				       struct acpi_device *adev, u32 type)
> +{
> +	struct device *dev = xgene_pmu->dev;
> +	struct list_head resource_list;
> +	struct xgene_pmu_dev_ctx *ctx;
> +	const union acpi_object *obj;
> +	struct hw_pmu_info *inf;
> +	void __iomem *dev_csr;
> +	struct resource res;
> +	int enable_bit;
> +	int rc;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&resource_list);
> +	rc = acpi_dev_get_resources(adev, &resource_list,
> +				    acpi_pmu_dev_add_resource, &res);
> +	acpi_dev_free_resource_list(&resource_list);
> +	if (rc < 0 || IS_ERR(&res)) {
> +		dev_err(dev, "PMU type %d: No resource address found\n", type);
> +		goto err;
> +	}
> +
> +	dev_csr = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(dev_csr)) {
> +		dev_err(dev, "PMU type %d: Fail to map resource\n", type);
> +		rc = PTR_ERR(dev_csr);
> +		goto err;
> +	}
> +
> +	/* A PMU device node without enable-bit-index is always enabled */
> +	rc = acpi_dev_get_property(adev, "enable-bit-index",
> +				   ACPI_TYPE_INTEGER, &obj);
> +	if (rc < 0)
> +		enable_bit = 0;
> +	else
> +		enable_bit = (int) obj->integer.value;
> +
> +	ctx->name = xgene_pmu_dev_name(type, enable_bit);
> +	inf = &ctx->inf;
> +	inf->type = type;
> +	inf->csr = dev_csr;
> +	inf->enable_mask = 1 << enable_bit;
> +
> +	return ctx;
> +err:
> +	devm_kfree(dev, ctx);
> +	return NULL;
> +}
> +
> +static acpi_status acpi_pmu_dev_add(acpi_handle handle, u32 level,
> +				    void *data, void **return_value)
> +{
> +	struct xgene_pmu *xgene_pmu = data;
> +	struct xgene_pmu_dev_ctx *ctx;
> +	struct acpi_device *adev;
> +
> +	if (acpi_bus_get_device(handle, &adev))
> +		return AE_OK;
> +	if (acpi_bus_get_status(adev) || !adev->status.present)
> +		return AE_OK;
> +
> +	if (!strcmp(acpi_device_hid(adev), "APMC0D5D"))
> +		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_L3C);
> +	else if (!strcmp(acpi_device_hid(adev), "APMC0D5E"))
> +		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_IOB);
> +	else if (!strcmp(acpi_device_hid(adev), "APMC0D5F"))
> +		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MCB);
> +	else if (!strcmp(acpi_device_hid(adev), "APMC0D60"))
> +		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MC);
> +	else
> +		ctx = NULL;
> +
> +	if (!ctx)
> +		return AE_OK;
> +
> +	if (xgene_pmu_dev_add(xgene_pmu, ctx))
> +		return AE_OK;

Given that xgene_pmu_dev_add() failed, don't we leak resources allocated
in acpi_get_pmu_hw_inf(), e.g. ctx?

I don't think returning AE_OK is correct here.

Why do we not fail to probe if this occurs?

> +
> +	switch (ctx->inf.type) {
> +	case PMU_TYPE_L3C:
> +		list_add(&ctx->next, &xgene_pmu->l3cpmus);
> +		break;
> +	case PMU_TYPE_IOB:
> +		list_add(&ctx->next, &xgene_pmu->iobpmus);
> +		break;
> +	case PMU_TYPE_MCB:
> +		list_add(&ctx->next, &xgene_pmu->mcbpmus);
> +		break;
> +	case PMU_TYPE_MC:
> +		list_add(&ctx->next, &xgene_pmu->mcpmus);
> +		break;
> +	}
> +	return AE_OK;
> +}
> +
> +static int acpi_pmu_probe_pmu_dev(struct xgene_pmu *xgene_pmu,
> +				  struct platform_device *pdev)
> +{
> +	struct device *dev = xgene_pmu->dev;
> +	acpi_handle handle;
> +	acpi_status status;
> +
> +	handle = ACPI_HANDLE(dev);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +				     acpi_pmu_dev_add, NULL, xgene_pmu, NULL);
> +	if (ACPI_FAILURE(status))
> +		dev_err(dev, "failed to probe PMU devices\n");
> +	return 0;
> +}

Surely we should pass on an error?

> +static struct
> +xgene_pmu_dev_ctx *fdt_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
> +				      struct device_node *np, u32 type)
> +{
> +	struct device *dev = xgene_pmu->dev;
> +	struct xgene_pmu_dev_ctx *ctx;
> +	struct hw_pmu_info *inf;
> +	void __iomem *dev_csr;
> +	struct resource res;
> +	int enable_bit;
> +	int rc;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return NULL;
> +	rc = of_address_to_resource(np, 0, &res);
> +	if (rc < 0) {
> +		dev_err(dev, "PMU type %d: No resource address found\n", type);
> +		goto err;
> +	}
> +	dev_csr = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(dev_csr)) {
> +		dev_err(dev, "PMU type %d: Fail to map resource\n", type);
> +		rc = PTR_ERR(dev_csr);
> +		goto err;
> +	}
> +
> +	/* A PMU device node without enable-bit-index is always enabled */
> +	if (of_property_read_u32(np, "enable-bit-index", &enable_bit))
> +		enable_bit = 0;
> +
> +	ctx->name = xgene_pmu_dev_name(type, enable_bit);
> +	inf = &ctx->inf;
> +	inf->type = type;
> +	inf->csr = dev_csr;
> +	inf->enable_mask = 1 << enable_bit;
> +
> +	return ctx;
> +err:
> +	devm_kfree(dev, ctx);
> +	return NULL;
> +}
> +
> +static int fdt_pmu_probe_pmu_dev(struct xgene_pmu *xgene_pmu,
> +				 struct platform_device *pdev)
> +{
> +	struct xgene_pmu_dev_ctx *ctx;
> +	struct device_node *np;
> +
> +	for_each_child_of_node(pdev->dev.of_node, np) {
> +		if (!of_device_is_available(np))
> +			continue;
> +
> +		if (of_device_is_compatible(np, "apm,xgene-pmu-l3c"))
> +			ctx = fdt_get_pmu_hw_inf(xgene_pmu, np, PMU_TYPE_L3C);
> +		else if (of_device_is_compatible(np, "apm,xgene-pmu-iob"))
> +			ctx = fdt_get_pmu_hw_inf(xgene_pmu, np, PMU_TYPE_IOB);
> +		else if (of_device_is_compatible(np, "apm,xgene-pmu-mcb"))
> +			ctx = fdt_get_pmu_hw_inf(xgene_pmu, np, PMU_TYPE_MCB);
> +		else if (of_device_is_compatible(np, "apm,xgene-pmu-mc"))
> +			ctx = fdt_get_pmu_hw_inf(xgene_pmu, np, PMU_TYPE_MC);
> +		else
> +			ctx = NULL;
> +
> +		if (!ctx)
> +			continue;
> +
> +		if (xgene_pmu_dev_add(xgene_pmu, ctx))
> +			continue;

As with acpi_pmu_dev_add, doesn't this leak the contexts allocated in
fdt_get_pmu_hw_inf? 

Why do we not fail to probe if this occurs?

> +
> +		switch (ctx->inf.type) {
> +		case PMU_TYPE_L3C:
> +			list_add(&ctx->next, &xgene_pmu->l3cpmus);
> +			break;
> +		case PMU_TYPE_IOB:
> +			list_add(&ctx->next, &xgene_pmu->iobpmus);
> +			break;
> +		case PMU_TYPE_MCB:
> +			list_add(&ctx->next, &xgene_pmu->mcbpmus);
> +			break;
> +		case PMU_TYPE_MC:
> +			list_add(&ctx->next, &xgene_pmu->mcpmus);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int xgene_pmu_probe_pmu_dev(struct xgene_pmu *xgene_pmu,
> +				   struct platform_device *pdev)
> +{
> +	if (has_acpi_companion(&pdev->dev))
> +		return acpi_pmu_probe_pmu_dev(xgene_pmu, pdev);
> +	return fdt_pmu_probe_pmu_dev(xgene_pmu, pdev);
> +}
> +

[...]

> +static const struct xgene_pmu_data xgene_pmu_data = {
> +	.id   = PCP_PMU_V1,
> +	.data = 0,
> +};
> +
> +static const struct xgene_pmu_data xgene_pmu_v2_data = {
> +	.id   = PCP_PMU_V2,
> +	.data = 0,
> +};

The data field on either of these is never used. I think you can remove
it.

> +static int xgene_pmu_probe(struct platform_device *pdev)
> +{
> +	const struct xgene_pmu_data *dev_data;
> +	const struct of_device_id *of_id;
> +	struct xgene_pmu *xgene_pmu;
> +	struct resource *res;
> +	int irq, rc;
> +	int version;
> +
> +	xgene_pmu = devm_kzalloc(&pdev->dev, sizeof(*xgene_pmu), GFP_KERNEL);
> +	if (!xgene_pmu)
> +		return -ENOMEM;
> +	xgene_pmu->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, xgene_pmu);
> +
> +	version = -EINVAL;
> +	of_id = of_match_device(xgene_pmu_of_match, &pdev->dev);
> +	if (of_id) {
> +		dev_data = (const struct xgene_pmu_data *) of_id->data;
> +		version = dev_data->id;
> +	}
> +
> +#ifdef CONFIG_ACPI
> +	if (ACPI_COMPANION(&pdev->dev)) {
> +		const struct acpi_device_id *acpi_id;
> +
> +		acpi_id = acpi_match_device(xgene_pmu_acpi_match, &pdev->dev);
> +		if (acpi_id)
> +			version = (int) acpi_id->driver_data;
> +	}
> +#endif
> +	if (version < 0)
> +		return -ENODEV;
> +
> +	INIT_LIST_HEAD(&xgene_pmu->l3cpmus);
> +	INIT_LIST_HEAD(&xgene_pmu->iobpmus);
> +	INIT_LIST_HEAD(&xgene_pmu->mcbpmus);
> +	INIT_LIST_HEAD(&xgene_pmu->mcpmus);
> +
> +	xgene_pmu->version = version;
> +	dev_info(&pdev->dev, "X-Gene PMU version %d\n", xgene_pmu->version);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	xgene_pmu->pcppmu_csr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(xgene_pmu->pcppmu_csr)) {
> +		dev_err(&pdev->dev, "ioremap failed for PCP PMU resource\n");
> +		rc = PTR_ERR(xgene_pmu->pcppmu_csr);
> +		goto err;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "No IRQ resource\n");
> +		rc = -EINVAL;
> +		goto err;
> +	}
> +	rc = devm_request_irq(&pdev->dev, irq, xgene_pmu_isr,
> +				IRQF_NOBALANCING | IRQF_NO_THREAD,
> +				dev_name(&pdev->dev), xgene_pmu);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Could not request IRQ %d\n", irq);
> +		goto err;
> +	}
> +
> +	raw_spin_lock_init(&xgene_pmu->lock);
> +
> +	/* Check for active MCBs and MCUs */
> +	rc = xgene_pmu_probe_active_mcb_mcu(xgene_pmu, pdev);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "Unknown MCB/MCU active status\n");
> +		xgene_pmu->mcb_active_mask = 0x1;
> +		xgene_pmu->mc_active_mask = 0x1;
> +	}
> +
> +	/* Pick one core to use for cpumask attributes */
> +	cpumask_set_cpu(smp_processor_id(), &xgene_pmu->cpu);
> +
> +	/* Make sure that the overflow interrupt is handled by this CPU */
> +	rc = irq_set_affinity(irq, &xgene_pmu->cpu);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to set interrupt affinity!\n");
> +		goto err;
> +	}
> +
> +	/* Enable interrupt */
> +	xgene_pmu_unmask_int(xgene_pmu);

It's probably better to do this after probing the sub-devices.

> +
> +	/* Walk through the tree for all PMU perf devices */
> +	rc = xgene_pmu_probe_pmu_dev(xgene_pmu, pdev);
> +	if (rc) {
> +		dev_err(&pdev->dev, "No PMU perf devices found!\n");
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	if (xgene_pmu->pcppmu_csr)
> +		devm_iounmap(&pdev->dev, xgene_pmu->pcppmu_csr);
> +	devm_kfree(&pdev->dev, xgene_pmu);
> +
> +	return rc;
> +}

Thanks,
Mark.
