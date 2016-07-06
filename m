From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Wed, 6 Jul 2016 14:43:58 -0700
Subject: [PATCH v6 3/4] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <20160706174905.GA6523@leverpostej>
References: <1467139845-29753-1-git-send-email-ttnguyen@apm.com>
 <1467139845-29753-4-git-send-email-ttnguyen@apm.com>
 <20160706174905.GA6523@leverpostej>
Message-ID: <CACgAJHwBQ2zkmDMjdQRbhnTcJMne0VhLevaJSPhC4mDPtirfUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks.

On Wed, Jul 6, 2016 at 10:49 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> This looks mostly good now, though there are some remaining issues that
> I've commented on below.
>
> On Tue, Jun 28, 2016 at 11:50:44AM -0700, Tai Nguyen wrote:
>> Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
>> ---
>>  Documentation/perf/xgene-pmu.txt |   48 ++
>>  drivers/perf/Kconfig             |    7 +
>>  drivers/perf/Makefile            |    1 +
>>  drivers/perf/xgene_pmu.c         | 1360 ++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 1416 insertions(+)
>>  create mode 100644 Documentation/perf/xgene-pmu.txt
>>  create mode 100644 drivers/perf/xgene_pmu.c
>
>> +static const struct attribute *xgene_pmu_cpumask_attrs[] = {
>> +     &dev_attr_cpumask.attr,
>> +     NULL,
>> +};
>> +
>> +static const struct attribute_group pmu_cpumask_attr_group = {
>> +     .attrs = (struct attribute **) xgene_pmu_cpumask_attrs,
>> +};
>
> As mentioned previously, we shouldn't cast away constness.
>
> Please remove the const from the definition of xgene_pmu_cpumask_attrs,
> and remove the cast.
>

Yes, my bad.
I changed the others but missed it for cpumark attr group.

[...]
>> +
>> +     hw->config = event->attr.config;
>> +     /*
>> +      * Each bit of the config1 field represents an agent from which the
>> +      * request of the event come. The event is counted only if it's caused
>> +      * by a request of an agent has the bit cleared.
>> +      * By default, the event is counted for all agents.
>> +      */
>> +     hw->config_base = event->attr.config1;
>> +
>> +     return 0;
>> +}
>
> You also need to validate the event group as a whole. See the end of
> arm_ccn_pmu_event_init() in drivers/bus/arm-ccn.c for an example, where
> we check the leader and sibling list.

Okay thanks, I'll refer to the arm-ccn.c

>
>> +static void xgene_perf_enable_event(struct perf_event *event)
>> +{
>> +     struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
>> +
>> +     xgene_pmu_write_evttype(pmu_dev, GET_CNTR(event), GET_EVENTID(event));
>> +     xgene_pmu_write_agentmsk(pmu_dev, ~((u32)GET_AGENTID(event)));
>> +     if (pmu_dev->inf->type == PMU_TYPE_IOB)
>> +             xgene_pmu_write_agent1msk(pmu_dev, ~((u32)GET_AGENT1ID(event)));
>> +
>> +     xgene_pmu_start_counters(pmu_dev);
>
> This call to xgene_pmu_start_counters should be moved out into
> pmu::pmu_enable(), which the core code will call for you. Similarly, you
> should implement pmu::pmu_disable() using xgene_pmu_stop_counters().
>
> That avoids poking the HW repeatedly to enable/disable all counters,
> ensures that event groups count for the same time, etc.
>
> In your pmu::pmu_enable() implementation you should probably check
> whether you have any events (e.g. by looking at the counter bitmap). If
> there are no events, you can avoid pointlessly enabling the PMU HW.

Okay, I'll implement pmu::pmu_enable() and pmu::pmu_disable() as per
your suggestion.

>
>> +     xgene_pmu_enable_counter(pmu_dev, GET_CNTR(event));
>> +     xgene_pmu_enable_counter_int(pmu_dev, GET_CNTR(event));
>> +}
>
> [...]
>
>> +static irqreturn_t xgene_pmu_isr(int irq, void *dev_id)
>> +{
>> +     struct xgene_pmu_dev_ctx *ctx, *temp_ctx;
>> +     struct xgene_pmu *xgene_pmu = dev_id;
>> +     unsigned long flags;
>> +     u32 val;
>> +
>> +     raw_spin_lock_irqsave(&xgene_pmu->lock, flags);
>> +
>> +     /* Get Interrupt PMU source */
>> +     val = readl(xgene_pmu->pcppmu_csr + PCPPMU_INTSTATUS_REG);
>> +     if (val & PCPPMU_INT_MCU) {
>> +             list_for_each_entry_safe(ctx, temp_ctx,
>> +                             &xgene_pmu->mcpmus, next) {
>> +                     _xgene_pmu_isr(irq, ctx->pmu_dev);
>> +             }
>> +     }
>
> No handlers modify the list, so there's no need to use
> list_for_each_entry_safe, and you don't need the tmp_ctx variable.

Right, I will use list_for_each_entry instead.

>
>> +     if (val & PCPPMU_INT_MCB) {
>> +             list_for_each_entry_safe(ctx, temp_ctx,
>> +                             &xgene_pmu->mcbpmus, next) {
>> +                     _xgene_pmu_isr(irq, ctx->pmu_dev);
>> +             }
>> +     }
>> +     if (val & PCPPMU_INT_L3C) {
>> +             list_for_each_entry_safe(ctx, temp_ctx,
>> +                             &xgene_pmu->l3cpmus, next) {
>> +                     _xgene_pmu_isr(irq, ctx->pmu_dev);
>> +             }
>> +     }
>> +     if (val & PCPPMU_INT_IOB) {
>> +             list_for_each_entry_safe(ctx, temp_ctx,
>> +                             &xgene_pmu->iobpmus, next) {
>> +                     _xgene_pmu_isr(irq, ctx->pmu_dev);
>> +             }
>> +     }
>> +
>> +     raw_spin_unlock_irqrestore(&xgene_pmu->lock, flags);
>> +
>> +     return IRQ_HANDLED;
>> +}

[...]

>> +
>> +static acpi_status acpi_pmu_dev_add(acpi_handle handle, u32 level,
>> +                                 void *data, void **return_value)
>> +{
>> +     struct xgene_pmu *xgene_pmu = data;
>> +     struct xgene_pmu_dev_ctx *ctx;
>> +     struct acpi_device *adev;
>> +
>> +     if (acpi_bus_get_device(handle, &adev))
>> +             return AE_OK;
>> +     if (acpi_bus_get_status(adev) || !adev->status.present)
>> +             return AE_OK;
>> +
>> +     if (!strcmp(acpi_device_hid(adev), "APMC0D5D"))
>> +             ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_L3C);
>> +     else if (!strcmp(acpi_device_hid(adev), "APMC0D5E"))
>> +             ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_IOB);
>> +     else if (!strcmp(acpi_device_hid(adev), "APMC0D5F"))
>> +             ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MCB);
>> +     else if (!strcmp(acpi_device_hid(adev), "APMC0D60"))
>> +             ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MC);
>> +     else
>> +             ctx = NULL;
>> +
>> +     if (!ctx)
>> +             return AE_OK;
>> +
>> +     if (xgene_pmu_dev_add(xgene_pmu, ctx))
>> +             return AE_OK;
>
> Given that xgene_pmu_dev_add() failed, don't we leak resources allocated
> in acpi_get_pmu_hw_inf(), e.g. ctx?
>
> I don't think returning AE_OK is correct here.
>
> Why do we not fail to probe if this occurs?

I'll fix the ctx resource leakage if xgene_pmu_dev_add() fails.
However, I still need to return AE_OK for skipping the device.
Otherwise the whole acpi_walk_namespace() returns error and terminates
the search.
The problem is that MC PMUs mayn't be enabled if the DIMM doesn't exist.
Other common ACPI failures are still properly returned here.

[...]

>> +static int acpi_pmu_probe_pmu_dev(struct xgene_pmu *xgene_pmu,
>> +                               struct platform_device *pdev)
>> +{
>> +     struct device *dev = xgene_pmu->dev;
>> +     acpi_handle handle;
>> +     acpi_status status;
>> +
>> +     handle = ACPI_HANDLE(dev);
>> +     if (!handle)
>> +             return -EINVAL;
>> +
>> +     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
>> +                                  acpi_pmu_dev_add, NULL, xgene_pmu, NULL);
>> +     if (ACPI_FAILURE(status))
>> +             dev_err(dev, "failed to probe PMU devices\n");
>> +     return 0;
>> +}
>
> Surely we should pass on an error?

I'll fix it.

[...]

>> +static int fdt_pmu_probe_pmu_dev(struct xgene_pmu *xgene_pmu,
>> +                              struct platform_device *pdev)
>> +{
>> +     struct xgene_pmu_dev_ctx *ctx;
>> +     struct device_node *np;
>> +
>> +     for_each_child_of_node(pdev->dev.of_node, np) {
>> +             if (!of_device_is_available(np))
>> +                     continue;
>> +
>> +             if (of_device_is_compatible(np, "apm,xgene-pmu-l3c"))
>> +                     ctx = fdt_get_pmu_hw_inf(xgene_pmu, np, PMU_TYPE_L3C);
>> +             else if (of_device_is_compatible(np, "apm,xgene-pmu-iob"))
>> +                     ctx = fdt_get_pmu_hw_inf(xgene_pmu, np, PMU_TYPE_IOB);
>> +             else if (of_device_is_compatible(np, "apm,xgene-pmu-mcb"))
>> +                     ctx = fdt_get_pmu_hw_inf(xgene_pmu, np, PMU_TYPE_MCB);
>> +             else if (of_device_is_compatible(np, "apm,xgene-pmu-mc"))
>> +                     ctx = fdt_get_pmu_hw_inf(xgene_pmu, np, PMU_TYPE_MC);
>> +             else
>> +                     ctx = NULL;
>> +
>> +             if (!ctx)
>> +                     continue;
>> +
>> +             if (xgene_pmu_dev_add(xgene_pmu, ctx))
>> +                     continue;
>
> As with acpi_pmu_dev_add, doesn't this leak the contexts allocated in
> fdt_get_pmu_hw_inf?
>
> Why do we not fail to probe if this occurs?
>

I'll fix the resource leakage in case of failure.

[...]

>
>> +static const struct xgene_pmu_data xgene_pmu_data = {
>> +     .id   = PCP_PMU_V1,
>> +     .data = 0,
>> +};
>> +
>> +static const struct xgene_pmu_data xgene_pmu_v2_data = {
>> +     .id   = PCP_PMU_V2,
>> +     .data = 0,
>> +};
>
> The data field on either of these is never used. I think you can remove
> it.

Sure, will remove it.

>
>> +static int xgene_pmu_probe(struct platform_device *pdev)
>> +{
>> +     const struct xgene_pmu_data *dev_data;
>> +     const struct of_device_id *of_id;
>> +     struct xgene_pmu *xgene_pmu;
>> +     struct resource *res;
>> +     int irq, rc;
>> +     int version;
>> +
>> +     xgene_pmu = devm_kzalloc(&pdev->dev, sizeof(*xgene_pmu), GFP_KERNEL);
>> +     if (!xgene_pmu)
>> +             return -ENOMEM;
>> +     xgene_pmu->dev = &pdev->dev;
>> +     platform_set_drvdata(pdev, xgene_pmu);
>> +
>> +     version = -EINVAL;
>> +     of_id = of_match_device(xgene_pmu_of_match, &pdev->dev);
>> +     if (of_id) {
>> +             dev_data = (const struct xgene_pmu_data *) of_id->data;
>> +             version = dev_data->id;
>> +     }
>> +
>> +#ifdef CONFIG_ACPI
>> +     if (ACPI_COMPANION(&pdev->dev)) {
>> +             const struct acpi_device_id *acpi_id;
>> +
>> +             acpi_id = acpi_match_device(xgene_pmu_acpi_match, &pdev->dev);
>> +             if (acpi_id)
>> +                     version = (int) acpi_id->driver_data;
>> +     }
>> +#endif
>> +     if (version < 0)
>> +             return -ENODEV;
>> +
>> +     INIT_LIST_HEAD(&xgene_pmu->l3cpmus);
>> +     INIT_LIST_HEAD(&xgene_pmu->iobpmus);
>> +     INIT_LIST_HEAD(&xgene_pmu->mcbpmus);
>> +     INIT_LIST_HEAD(&xgene_pmu->mcpmus);
>> +
>> +     xgene_pmu->version = version;
>> +     dev_info(&pdev->dev, "X-Gene PMU version %d\n", xgene_pmu->version);
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     xgene_pmu->pcppmu_csr = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(xgene_pmu->pcppmu_csr)) {
>> +             dev_err(&pdev->dev, "ioremap failed for PCP PMU resource\n");
>> +             rc = PTR_ERR(xgene_pmu->pcppmu_csr);
>> +             goto err;
>> +     }
>> +
>> +     irq = platform_get_irq(pdev, 0);
>> +     if (irq < 0) {
>> +             dev_err(&pdev->dev, "No IRQ resource\n");
>> +             rc = -EINVAL;
>> +             goto err;
>> +     }
>> +     rc = devm_request_irq(&pdev->dev, irq, xgene_pmu_isr,
>> +                             IRQF_NOBALANCING | IRQF_NO_THREAD,
>> +                             dev_name(&pdev->dev), xgene_pmu);
>> +     if (rc) {
>> +             dev_err(&pdev->dev, "Could not request IRQ %d\n", irq);
>> +             goto err;
>> +     }
>> +
>> +     raw_spin_lock_init(&xgene_pmu->lock);
>> +
>> +     /* Check for active MCBs and MCUs */
>> +     rc = xgene_pmu_probe_active_mcb_mcu(xgene_pmu, pdev);
>> +     if (rc) {
>> +             dev_warn(&pdev->dev, "Unknown MCB/MCU active status\n");
>> +             xgene_pmu->mcb_active_mask = 0x1;
>> +             xgene_pmu->mc_active_mask = 0x1;
>> +     }
>> +
>> +     /* Pick one core to use for cpumask attributes */
>> +     cpumask_set_cpu(smp_processor_id(), &xgene_pmu->cpu);
>> +
>> +     /* Make sure that the overflow interrupt is handled by this CPU */
>> +     rc = irq_set_affinity(irq, &xgene_pmu->cpu);
>> +     if (rc) {
>> +             dev_err(&pdev->dev, "Failed to set interrupt affinity!\n");
>> +             goto err;
>> +     }
>> +
>> +     /* Enable interrupt */
>> +     xgene_pmu_unmask_int(xgene_pmu);
>
> It's probably better to do this after probing the sub-devices.
>

Okay, I'll move it after the sub-devices probing below.

>> +
>> +     /* Walk through the tree for all PMU perf devices */
>> +     rc = xgene_pmu_probe_pmu_dev(xgene_pmu, pdev);
>> +     if (rc) {
>> +             dev_err(&pdev->dev, "No PMU perf devices found!\n");
>> +             goto err;
>> +     }
>> +
>> +     return 0;

Thanks,
-- 
Tai
