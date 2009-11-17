From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:53:38 +0100
Subject: IXP4xx: unneeded #include platform-specific include files?
In-Reply-To: <op.u3j6cak02s3iss@richese> (Imre Kaloz's message of "Tue, 17 Nov
	2009 22:37:13 +0100")
References: <m3fx8fso72.fsf@intrepid.localdomain>
	<19200.18453.644399.845601@pilspetsen.it.uu.se>
	<op.u3gddjdi2s3iss@ecaz> <m3y6m7qylr.fsf@intrepid.localdomain>
	<op.u3j6cak02s3iss@richese>
Message-ID: <m3ws1o4y3h.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Imre Kaloz" <kaloz@openwrt.org> writes:

> Ok, I should be completely missing the point here, but could someone enlighten
> me why would the following make sense? (nslu2 example)
>
> #define NSLU2_PCI_INTA_PIN	11
> #define NSLU2_PCI_INTB_PIN	10
> #define NSLU2_PCI_INTC_PIN	9
> #define NSLU2_PCI_INTD_PIN	8
>
> #define        IRQ_NSLU2_PCI_INTA      IRQ_IXP4XX_GPIO11
> #define        IRQ_NSLU2_PCI_INTB      IRQ_IXP4XX_GPIO10
> #define        IRQ_NSLU2_PCI_INTC      IRQ_IXP4XX_GPIO9

Well, this isn't something I really like because it duplicates the
assignments.

> Then do all the "fun" in the setup code, instead of simply using
> The already defined (and hardware wise more logical) IRQ_IXP4XX_GPIOx values like
> I do in arch/arch/mach-ixp4xx/wg302v2-pci.c for example?

void __init wg302v2_pci_preinit(void)
{
        set_irq_type(IRQ_IXP4XX_GPIO8, IRQ_TYPE_LEVEL_LOW);
        set_irq_type(IRQ_IXP4XX_GPIO9, IRQ_TYPE_LEVEL_LOW);

        ixp4xx_pci_preinit();
}

static int __init wg302v2_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
{
        if (slot == 1)
                return IRQ_IXP4XX_GPIO8;
        else if (slot == 2)
                return IRQ_IXP4XX_GPIO9;
        else return -1;
}

Not very different from what other platforms have, except that you have
to remember the assignment. When the code gets more complicated you
really don't want to remember that INTA is GPIO8, INTB is GPIO9, INTC,
INTD, IDE_IRQ, USB_IRQ etc. And this gets even more complicated when the
platform code supports more than one version of hw.
-- 
Krzysztof Halasa
