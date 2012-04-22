From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Sun, 22 Apr 2012 14:17:55 -0400
Subject: irqdomains and irq_domain_add_linear
Message-ID: <CAKON4OyceFFfSqJ+fSvBWQURkqyyL=azdNjDbCJgQ5ZLfU=tFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM with the current Linus tree the irqdomain code doesn't work if
you have multiple linear domains. In my case I have two interrupt
controllers. As the device tree is parsed interrupts get randomly
assigned from each of the two domains. These IRQs get assigned
sequentially ascending VIRQ numbers and sequentially ascending
descriptors.

But then when an interrupt happens, the ARM interrupt handler looks
the interrupt up in the descriptor array. This array is based on virq,
not hwirq. As soon as the 1:1 relationship of virq to hwirq is broken
(it got broken by alternating assignments to the interrupt
controllers) the descriptor lookup stops working since it retrieves
the wrong descriptor. In my case it made the console fail making it
difficult to debug what was happening. I reverted back to
irq_domain_add_legacy() which keeps the 1:1 mapping and everything
started working again.

My initial through to fix this was to add a revmap look up in the
interrupt handler. But a better way might be to keep the descriptor
array corresponding to hwirq instead of virq.

-- 
Jon Smirl
jonsmirl at gmail.com
