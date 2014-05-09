From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 9 May 2014 16:59:04 +0530
Subject: [PATCH 05/17] pci: host: pcie-dra7xx: add support for pcie-dra7xx
 controller
In-Reply-To: <6485683.q96o7U6vf8@wuerfel>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
 <4300084.bc6ByDTk7W@wuerfel> <5369F287.6000103@ti.com>
 <6485683.q96o7U6vf8@wuerfel>
Message-ID: <536CBC00.6000709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wednesday 07 May 2014 03:00 PM, Arnd Bergmann wrote:
> On Wednesday 07 May 2014 14:14:55 Kishon Vijay Abraham I wrote:
>>>> +static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
>>>> +{
>>>> +    struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
>>>> +
>>>> +    dra7xx_pcie_writel(dra7xx->base, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
>>>> +                       ~INTERRUPTS);
>>>> +    dra7xx_pcie_writel(dra7xx->base,
>>>> +                       PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN, INTERRUPTS);
>>>> +    dra7xx_pcie_writel(dra7xx->base, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
>>>> +                       ~LEG_EP_INTERRUPTS & ~MSI);
>>>> +
>>>> +    if (IS_ENABLED(CONFIG_PCI_MSI))
>>>> +            dra7xx_pcie_writel(dra7xx->base,
>>>> +                               PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI, MSI);
>>>> +    else
>>>> +            dra7xx_pcie_writel(dra7xx->base,
>>>> +                               PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
>>>> +                               LEG_EP_INTERRUPTS);
>>>
>>> Doesn't this just enable one or the other? In general I'd assume you need
>>> both INTx and MSI, at least if MSI is available.
>>
>> Not sure since the programming sequence in the TRM explicitly states either
>> legacy interrupts or MSI interrupts should be enabled but not both.
> 
> Hmm, I think that means you can't have MSI at all. You have to support
> legacy PCI devices that can't do MSI.
> 
> Do you know if you have a modern GIC implementation with MSI support
> in these SoCs? It would be better anyway to use the GIC for doing

In DRA7 it is not there. I'm not sure in other platforms.
> MSI, so you can just ignore the internal MSI controller here.
> 
>>>> +static int add_pcie_port(struct dra7xx_pcie *dra7xx,
>>>> +                      struct platform_device *pdev)
>>>> +{
>>>> +    int ret;
>>>> +    struct pcie_port *pp;
>>>> +    struct resource *res;
>>>> +    struct device *dev = &pdev->dev;
>>>> +
>>>> +    pp = &dra7xx->pp;
>>>> +    pp->dev = dev;
>>>> +    pp->ops = &dra7xx_pcie_host_ops;
>>>> +
>>>> +    spin_lock_init(&pp->conf_lock);
>>>> +
>>>> +    pp->irq = platform_get_irq(pdev, 1);
>>>> +    if (pp->irq < 0) {
>>>> +            dev_err(dev, "missing IRQ resource\n");
>>>> +            return -EINVAL;
>>>> +    }
>>>>
>>>
>>> The binding does not list a mandatory "interrupts" property, so
>>> this should not be treated as an error.
>>
>> actually the 'interrupts' property is documented in pci/designware-pcie.txt.
> 
> Hmm, but you don't seem to use it the same way as documented there.
> I'm not sure what 'level interrupt, pulse interrupt, special interrupt'
> in the parent binding are, but they don't seem to be the ones you use
> here.

Yeah. I'll update my Documentation. Thanks for pointing this out.

Thanks
Kishon
