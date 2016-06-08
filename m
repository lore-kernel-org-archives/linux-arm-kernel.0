From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 8 Jun 2016 17:47:39 +0200
Subject: [PATCH 2/3] PCI: host: new PCI host controller driver for
 Marvell Armada 3700
In-Reply-To: <CAPv3WKcznGD4p-YO3QLLYw+y+7w4ha-d_Nt6FHue7d2_SiyK0w@mail.gmail.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAPv3WKcznGD4p-YO3QLLYw+y+7w4ha-d_Nt6FHue7d2_SiyK0w@mail.gmail.com>
Message-ID: <20160608174739.2e66943e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thanks for your feedback!

On Wed, 8 Jun 2016 17:15:08 +0200, Marcin Wojtas wrote:

> Have you checked my latest improvements of interrupt handling in this
> controller? As DEASSERT is polled in advk_pcie_handle_int() I don't
> think it should be able to trigger root complex interrupt at all.
> Hence I think it shouldn't be unmasked.

Correct. Makes sense. Though you are suggesting below to no longer poll
the DEASSERT signal in the interrupt handler, but you're instead saying
to ignore it entirely.


> > +       msi = &pcie->msi;  
> 
> Do we consciously resign from CONFIG_MSI dependency? I know it should
> always be enabled, but just making sure.

Yes, I discussed this with Arnd, and we decided to simply make MSI
support a hard dependency. You can always disable it by passing
pci=nomsi on the kernel command line (tested to be working).


> Below code will result in spurious interrupt flood (I can provide test
> details with SATA3.0 card). I know this part of specs very well, but
> expected EP operation flow should look like this:
> a. EP interrupt
> b. INTX_ASSERT signal
> c. root complex interrupt
> d. clear INTX_ASSERT bit
> e. execute EP handler
> f. INTX_DEASSERT signal
> g. clear INTX_DEASSERT bit
> h. exit interrupt
> 
> Now between d. and f., in case of any shortest delay we will force
> executing EP handler numerous of times, which IMO is not desired. All
> of them for e.g. the SATA3.0 card are registered as spurious
> interrupts, pretty quickly resulting in "switching to irq poll"
> failure after 100k of such happenings. Actually I think that after
> executing generic_handle_irq(virq); we should leave root complex isr
> asap, the polling for DEASSERT in such case is not resulting in any
> benefits. In my code I ignored DEASSERT signal existence - it neither
> triggers interrupt nor we don't poll for it. Under big stress nothing
> wrong happens. We rely only on interrupts triggered by INTX_ASSERT
> signal, so we care only for its status.

Thanks for the detailed explanation. So in practice, the code should be
just:

	for (i = 0; i < LEGACY_IRQ_NUM; i++) {
		int virq;

		if (!(status & PCIE_ISR0_INTX_ASSERT(i)))
			continue;

		advk_writel(pcie, PCIE_ISR0_INTX_ASSERT(i), PCIE_ISR0_REG);
		virq = irq_find_mapping(pcie->irq_domain, i);
		generic_handle_irq(virq);
	}

and that's it.

Is that what you suggest?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
