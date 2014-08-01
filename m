From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Fri, 1 Aug 2014 11:29:40 -0500
Subject: [PATCH 3/4 V3] irqchip: gic: Add supports for ARM GICv2m MSI(-X)
In-Reply-To: <53DBB562.5020003@amd.com>
References: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1404947104-21345-4-git-send-email-suravee.suthikulpanit@amd.com>
 <87zjfqj3mc.fsf@approximate.cambridge.arm.com> <53DBB562.5020003@amd.com>
Message-ID: <53DBC074.3030309@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/1/2014 10:42 AM, Suravee Suthikulanit wrote:
>>> +#ifdef CONFIG_SMP
>>> +       .irq_set_affinity       = gic_set_affinity,
>>> +#endif
>>> +#ifdef CONFIG_PM
>>> +       .irq_set_wake           = gic_set_wake,
>>> +#endif
>>> +};
>>> +
>>> +#ifdef CONFIG_OF
>>> +static int __init
>>> +gicv2m_of_init(struct device_node *node, struct device_node *parent)
>>> +{
>>> +       struct gic_chip_data *gic;
>>> +       int ret;
>>> +
>>> +       ret = _gic_of_init(node, parent, &gicv2m_chip, &gic);
>>> +       if (ret) {
>>> +               pr_err("GICv2m: Failed to initialize GIC\n");
>>> +               return ret;
>>> +       }
>>> +
>>> +       gic->msi_chip.owner = THIS_MODULE;
>>> +       gic->msi_chip.of_node = node;
>>> +       gic->msi_chip.setup_irq = gicv2m_setup_msi_irq;
>>> +       gic->msi_chip.teardown_irq = gicv2m_teardown_msi_irq;
>>> +       ret = of_pci_msi_chip_add(&gic->msi_chip);
>>> +       if (ret) {
>>> +               /* MSI is optional and not supported here */
>>> +               pr_info("GICv2m: MSI is not supported.\n");
>>> +               return 0;
>>> +       }
>>> +
>>> +       ret = gicv2m_msi_init(node, &gic->v2m_data);
>>> +       if (ret)
>>> +               return ret;
>>> +       return ret;
>>> +}
>>> +
>>> +IRQCHIP_DECLARE(arm_gic_400_v2m, "arm,gic-400-v2m", gicv2m_of_init);
>>
>> So if you follow my advise of reversing your probing and call into the
>> v2m init from the main GIC driver, you could take a irq_chip as a
>> parameter, and use it to populate the v2m irq_chip, only overriding the
>> two methods that actually differ.
>>
>> This would have the net effect of completely dropping patch #2, which
>> becomes effectively useless.
>>
>
> [Suravee] Ok, lemme look into this.

So, in previous revision, you mentioned that we should have a separate 
irq_chip for gicv2m stuff, is that is still the case here?

Thanks,

Suravee
