From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 15 Feb 2011 22:51:09 +0100
Subject: BUG: ARM: MMP and PXA: nr_irqs > NR_IRQS
Message-ID: <4D5AF54D.3020208@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I stumbled upon this while looking through the existing archs using SPARSE_IRQ.
Even with SPARSE_IRQ the NR_IRQS is still the upper limit for the number of IRQs.

Both PXA and MMP set NR_IRQS to IRQ_BOARD_START, with IRQ_BOARD_START being the
number of IRQs used by the core.
In various machine files the nr_irqs field of the ARM machine defintion struct
is then set to "IRQ_BOARD_START + NR_BOARD_IRQS".
As a result "nr_irqs" will greater then NR_IRQS which then again causes the
"allocated_irqs" bitmap in the core irq code to be accessed beyond its size
overwriting unrelated data.

So as a fix I suggest setting NR_IRQS to a large a enough value like 1024 or
something.

- Lars
