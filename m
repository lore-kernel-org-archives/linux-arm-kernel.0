From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 22:42:51 +0100
Subject: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
In-Reply-To: <201303262115.41200.arnd@arndb.de>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303262115.41200.arnd@arndb.de>
Message-ID: <20130326224251.6a925892@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 26 Mar 2013 21:15:40 +0000, Arnd Bergmann wrote:
> On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> > +                       msimask = readl_relaxed(per_cpu_int_base +
> > +                                       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
> > +                               & PCI_MSI_DOORBELL_MASK;
> > +
> > +                       writel(~PCI_MSI_DOORBELL_MASK, per_cpu_int_base +
> > +                              ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
> > +
> 
> Upon reading this code again, I stumbled over the barriers. You use
> a readl_relaxed() without barrier but a writel() with barrier. Is
> that intentional? Are you sure that you don't need a full readl()
> to guarantee that all inbound DMA that was sent by the device before
> the MSI message has arrived by the time the interrupt handler function
> is called? It depends on the implementation of the MSI controller whether
> that guarantee is already made by the fact that you are handling the
> interrupt.

This question I will have to raise to the Marvell HW engineers, the
datasheet does not go into these considerations. For now, I'm rather
trying to validate the 'architecture' of the code: DT binding,
interaction between the IRQ controller driver and the PCIe driver, etc.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
