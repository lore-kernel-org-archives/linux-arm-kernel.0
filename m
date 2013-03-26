From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 21:15:40 +0000
Subject: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
In-Reply-To: <1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201303262115.41200.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> +                       msimask = readl_relaxed(per_cpu_int_base +
> +                                       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
> +                               & PCI_MSI_DOORBELL_MASK;
> +
> +                       writel(~PCI_MSI_DOORBELL_MASK, per_cpu_int_base +
> +                              ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
> +

Upon reading this code again, I stumbled over the barriers. You use
a readl_relaxed() without barrier but a writel() with barrier. Is
that intentional? Are you sure that you don't need a full readl()
to guarantee that all inbound DMA that was sent by the device before
the MSI message has arrived by the time the interrupt handler function
is called? It depends on the implementation of the MSI controller whether
that guarantee is already made by the fact that you are handling the
interrupt.

	Arnd
