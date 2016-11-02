From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 03 Nov 2016 05:09:40 +0800
Subject: [PATCH v3 11/14] ACPI: irq: introduce interrupt producer
In-Reply-To: <c403c4099fd5dcfcebb6b7ff5a51b915@codeaurora.org>
References: <1477408169-22217-1-git-send-email-guohanjun@huawei.com>
 <1477408169-22217-12-git-send-email-guohanjun@huawei.com>
 <c403c4099fd5dcfcebb6b7ff5a51b915@codeaurora.org>
Message-ID: <581A5614.4000306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Agustin,

Sorry for the late reply, on travailing for now.

On 10/29/2016 03:32 AM, agustinv at codeaurora.org wrote:
> Hey Hanjun,
>
> On 2016-10-25 11:09, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> In ACPI 6.1 spec, section 19.6.62, Interrupt Resource Descriptor Macro,
>>
>> Interrupt (ResourceUsage, EdgeLevel, ActiveLevel, Shared,
>> ResourceSourceIndex, ResourceSource, DescriptorName)
>> { InterruptList } => Buffer
>>
>> For the arguement ResourceUsage and DescriptorName, which means:
>>
>> ResourceUsage describes whether the device consumes the specified
>> interrupt ( ResourceConsumer ) or produces it for use by a child
>> device ( ResourceProducer ).
>> If nothing is specified, then ResourceConsumer is assumed.
>>
>> DescriptorName evaluates to a name string which refers to the
>> entire resource descriptor.
>>
>> So it can be used for devices connecting to a specific interrupt
>> prodcucer instead of the main interrupt controller in MADT. In the
>> real world, we have irqchip such as mbi-gen which connecting to
>> a group of wired interrupts and then issue msi to the ITS, devices
>> connecting to such interrupt controller fit this scope.
>>
>> For now the irq for ACPI only pointer to the main interrupt
>> controller's irqdomain, for devices not connecting to those
>> irqdomains, which need to present its irq parent, we can use
>> following ASL code to represent it:
>>
>> Interrupt(ResourceConsumer,..., "\_SB.IRQP") {12,14,....}
>>
>> then we can parse the interrupt producer with the full
>> path name "\_SB.IRQP".
>>
>> In order to do that, we introduce a pointer interrupt_producer
>> in struct acpi_device, and fill it when scanning irq resources
>> for acpi device if it specifies the interrupt producer.
>>
>> But for now when parsing the resources for acpi devices, we don't
>> pass the acpi device for acpi_walk_resoures() in drivers/acpi/resource.c,
>> so introduce a adev in struct res_proc_context to pass it as a context
>> to scan the interrupt resources, then finally pass to acpi_register_gsi()
>> to find its interrupt producer to get the virq from diffrent domains.
>>
>> With steps above ready, rework acpi_register_gsi() to get other
>> interrupt producer if devices not connecting to main interrupt
>> controller.
>>
>> Since we often pass NULL to acpi_register_gsi() and there is no interrupt
>> producer for devices connect to gicd on ARM or io-apic on X86, so it will
>> use the default irqdomain for those deivces and no functional changes to
>> those devices.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Agustin Vega-Frias <agustinv@codeaurora.org>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> ---
>>  drivers/acpi/gsi.c      | 10 ++++--
>>  drivers/acpi/resource.c | 85
>> ++++++++++++++++++++++++++++++++++---------------
>>  include/acpi/acpi_bus.h |  1 +
>>  3 files changed, 68 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
>> index ee9e0f2..29ee547 100644
>> --- a/drivers/acpi/gsi.c
>> +++ b/drivers/acpi/gsi.c
>> @@ -55,13 +55,19 @@ int acpi_register_gsi(struct device *dev, u32 gsi,
>> int trigger,
>>                int polarity)
>>  {
>>      struct irq_fwspec fwspec;
>> +    struct acpi_device *adev = dev ? to_acpi_device(dev) : NULL;
>>
>> -    if (WARN_ON(!acpi_gsi_domain_id)) {
>> +    if (adev && &adev->fwnode && adev->interrupt_producer)
>> +        /* devices in DSDT connecting to spefic interrupt producer */
>> +        fwspec.fwnode = adev->interrupt_producer;
>> +    else if (acpi_gsi_domain_id)
>> +        /* devices connecting to gicd in default */
>> +        fwspec.fwnode = acpi_gsi_domain_id;
>> +    else {
>>          pr_warn("GSI: No registered irqchip, giving up\n");
>>          return -EINVAL;
>>      }
>>
>> -    fwspec.fwnode = acpi_gsi_domain_id;
>>      fwspec.param[0] = gsi;
>>      fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
>>      fwspec.param_count = 2;
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 56241eb..f1371cf 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -381,7 +381,7 @@ static void acpi_dev_irqresource_disabled(struct
>> resource *res, u32 gsi)
>>      res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED |
>> IORESOURCE_UNSET;
>>  }
>>
>> -static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>> +static void acpi_dev_get_irqresource(struct acpi_device *adev, struct
>> resource *res, u32 gsi,
>>                       u8 triggering, u8 polarity, u8 shareable,
>>                       bool legacy)
>>  {
>> @@ -415,7 +415,7 @@ static void acpi_dev_get_irqresource(struct
>> resource *res, u32 gsi,
>>      }
>>
>>      res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
>> -    irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
>> +    irq = acpi_register_gsi(&adev->dev, gsi, triggering, polarity);
>>      if (irq >= 0) {
>>          res->start = irq;
>>          res->end = irq;
>> @@ -424,27 +424,9 @@ static void acpi_dev_get_irqresource(struct
>> resource *res, u32 gsi,
>>      }
>>  }
>>
>> -/**
>> - * acpi_dev_resource_interrupt - Extract ACPI interrupt resource
>> information.
>> - * @ares: Input ACPI resource object.
>> - * @index: Index into the array of GSIs represented by the resource.
>> - * @res: Output generic resource object.
>> - *
>> - * Check if the given ACPI resource object represents an interrupt
>> resource
>> - * and @index does not exceed the resource's interrupt count (true is
>> returned
>> - * in that case regardless of the results of the other checks)).  If
>> that's the
>> - * case, register the GSI corresponding to @index from the array of
>> interrupts
>> - * represented by the resource and populate the generic resource
>> object pointed
>> - * to by @res accordingly.  If the registration of the GSI is not
>> successful,
>> - * IORESOURCE_DISABLED will be set it that object's flags.
>> - *
>> - * Return:
>> - * 1) false with res->flags setting to zero: not the expected
>> resource type
>> - * 2) false with IORESOURCE_DISABLED in res->flags: valid unassigned
>> resource
>> - * 3) true: valid assigned resource
>> - */
>> -bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>> -                 struct resource *res)
>> +static bool __acpi_dev_resource_interrupt(struct acpi_device *adev,
>> +                      struct acpi_resource *ares, int index,
>> +                      struct resource *res)
>>  {
>>      struct acpi_resource_irq *irq;
>>      struct acpi_resource_extended_irq *ext_irq;
>> @@ -460,7 +442,7 @@ bool acpi_dev_resource_interrupt(struct
>> acpi_resource *ares, int index,
>>              acpi_dev_irqresource_disabled(res, 0);
>>              return false;
>>          }
>> -        acpi_dev_get_irqresource(res, irq->interrupts[index],
>> +        acpi_dev_get_irqresource(adev, res, irq->interrupts[index],
>>                       irq->triggering, irq->polarity,
>>                       irq->sharable, true);
>>          break;
>> @@ -470,7 +452,31 @@ bool acpi_dev_resource_interrupt(struct
>> acpi_resource *ares, int index,
>>              acpi_dev_irqresource_disabled(res, 0);
>>              return false;
>>          }
>> -        acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
>> +
>> +        /*
>> +         * It's a interrupt consumer device and connecting to specfic
>> +         * interrupt controller. For now, we only support connecting
>> +         * interrupts to one irq controller for a single device
>> +         */
>> +        if (ext_irq->producer_consumer == ACPI_CONSUMER
>> +            && ext_irq->resource_source.string_length != 0
>> +            && !adev->interrupt_producer) {
>> +            acpi_status status;
>> +            acpi_handle handle;
>> +            struct acpi_device *device;
>> +
>> +            status = acpi_get_handle(NULL,
>> ext_irq->resource_source.string_ptr, &handle);
>> +            if (ACPI_FAILURE(status))
>> +                return false;
>> +
>> +            device = acpi_bus_get_acpi_device(handle);
>> +            if (!device)
>> +                return false;
>> +
>> +            adev->interrupt_producer = &device->fwnode;
>
> You are missing an 'acpi_bus_put_acpi_device(device)' call here.

good catch!

>
> Besides that, this approach will not work in the case where a device
> wants to consume interrupts from multiple controllers since you are
> forcing adev->interrupt_producer to be the first resource_source
> found.

Yes, you are right, and it's in the comment of the code, we
can fix that to add some extra code.

>
> That's the reason I was advocating dynamic lookup (see [1]).
>
> I am about to submit V6 of my series where I also address the probe
> ordering issues by enabling re-initialization of platform_device
> resources when the resource was marked disabled due to the domain
> nor being there during ACPI bus scan.

I will take a deep look for your v6 patch set, probably we can
work together to get things down.

Thanks
Hanjun
