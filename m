From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 Sep 2016 17:50:28 +0200
Subject: [PATCH 3/3] PCI: Xilinx NWL PCIe: Fix Error for multi function
 device for legacy interrupts.
In-Reply-To: <20160913153402.GA4138@localhost>
References: <1472553558-27215-3-git-send-email-bharatku@xilinx.com>
 <57C57975.7040306@arm.com>
 <8520D5D51A55D047800579B094147198258D239D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57C59FE8.30307@arm.com>
 <8520D5D51A55D047800579B094147198258D28AF@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57C6B7F1.5000001@arm.com>
 <8520D5D51A55D047800579B094147198258D2C99@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160912220241.GG23532@localhost> <57D7ADA8.5060201@arm.com>
 <20160913150511.GC27748@localhost>
 <20160913153402.GA4138@localhost>
Message-ID: <20160913175028.0642d82f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 13 Sep 2016 10:34:02 -0500, Bjorn Helgaas wrote:

> > After looking at this myself, I'm not happy with this either.  It feels
> > like there are bugs lurking here and we're just hiding one of them.
> > 
> > Here are the callers of irq_domain_add_linear() for legacy INTx in
> > drivers/pci/host:
> > 
> >   advk_pcie_init_irq_domain    LEGACY_IRQ_NUM   (4)
> >   dra7xx_pcie_init_irq_domain  4
> >   ks_dw_pcie_host_init         MAX_LEGACY_IRQS  (4)
> >   altera_pcie_init_irq_domain  INTX_NUM + 1     (5)
> >   nwl_pcie_init_irq_domain     INTX_NUM + 1     (5)
> >   xilinx_pcie_init_irq_domain  4  
> 
> The altera change corresponding to this was 99496bd2971f ("PCI: altera: Fix
> error when INTx is 4").  I should have noticed this inconsistency back
> then.
> 
> Are aardvark, dra7xx, keystone, and xilinx (non-NWL) broken because they
> only request 4 IRQs and only INTA, INTB, and INTC work?
> 
> > I think all of these use the of_irq_parse_and_map_pci() path you
> > mentioned, so if the problem is in the way that path works, I would
> > think these should *all* be requesting the same number of interrupts
> > in the domain.
> > 
> > I agree with Marc that we should request 4 IRQs, because that's what
> > we need.  If we can't do that for some reason, we ought to at least
> > make all these callers the same.

Thanks for Cc'ing about this issue. Indeed, the Aardvark driver
supports all of INT{A,B,C,D}, so the current situation doesn't work. As
suggested, the simplest solution is to just allocate an irq domain with
5 IRQs, like is done in the Altera driver.

However, my feeling is that a more correct solution would be to have a
translation between the PCI_INTERRUPT_PIN value (in the range 0x1 to
0x4) to the hwirq value (in the range 0x0 to 0x3).

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
