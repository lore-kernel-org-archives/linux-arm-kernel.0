From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 May 2011 18:16:09 +0200
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <20110527150242.GB14035@e102109-lin.cambridge.arm.com>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<C832F8F5D375BD43BFA11E82E0FE9FE00AFDABA5E2@EXDCVYMBSTM005.EQ1STM.local>
	<20110527150242.GB14035@e102109-lin.cambridge.arm.com>
Message-ID: <201105271816.10191.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 May 2011, Catalin Marinas wrote:

> I think Arnd's point was that the writel_relaxed() variant may be even
> more relaxed on other architectures than it is on ARM. I can't talk
> about them.

Right. In general, you should write device drivers as portable as
possible, so don't rely on architecture specific behavior.
 
> > In my particular setup I'm writing a driver that is talking to a crypto
> > hardware and the architecture is ARM. The hardware is mapped as io-mapped
> > memory in our driver. Our main problem is to program the hardware, by
> > writing to certain registers in order and when the hardware is ready to
> > accept input, we will write the bulk-data to the same register over and over
> > again until there is no more data. I.e. in principle we do like this (a bit
> > simplified).
> > 
> > write(a, reg1); // Setup hardware
> > write(a, reg2); // Setup hardware
> > write(a, reg3); // Write bulk data
> > write(a, reg3); // Write bulk data ...
> > 
> > Some of you wrote that the only way to be sure that the data has been
> > written is to read the value after writing it.
> 
> The question is - why do you need to make sure that the data has been
> written? To me it looks like you only care about register access
> ordering.
> 
> Writing the device registers will always be done in program order, so
> your data in reg3 will be written after you set up the hardware via reg1
> and reg2. The reading back isn't needed and you could even use the
> relaxed accessors.

... as long as it is the same device. But that seems to be the case
here. Only if the registers are in two separate areas of MMIO space,
e.g the same device attached to two buses, ordering may not
be what you expect by the time the data arrives at the device.

> > Here we have another problem.
> > Since it's a cryptographic device some registers on the hardware are
> > write-only, and some registers are actually implemented as a stack in the
> > hardware itself. If you write a value to a register it will be pushed onto a
> > stack in the hardware and if you read the same register you pop the value
> > from the stack in the hardware.
> 
> As I said above, you don't need to do this. The read back is usually
> needed for things like clearing an error state at the device and then
> enabling the IRQ for that device at the GIC level (though this
> particular case isn't that simple).

To give yet another example: consider a device that has a register to
enable level triggered interrupts. You may want to disable the
interrupt by writing to the register during the interrupt handler.
When you return from the interrupt handler, the CPU's IRQ mask
is opened while the write may be still in flight. The only way
to avoid that is to read back the interrupt mask from the device
to flush out the write and make sure it's actually disabled before
you reopen the irqs at the CPU.

> > Do you understand my problems and do you have any suggestions for me how to
> > handle it? The initial problem, looking at using __raw_writel, was actually
> > to improve performance. I noticed about 50% better throughput when I was
> > using __raw_writel/readl instead writel/readl, but Linus warned me about the
> > problems he mentioned in the initial message in this thread.
> 
> I would say just use the writel_relaxed/readl_relaxed variants unless
> you have DMA transfers (but it looks more like PIO from your example).

When you use the *_relaxed variants, you also need to add explicit
barriers (wmb() and rmb()) to make synchronize with spinlocks. Otherwise,
an out-of-order CPU might move the MMIO access outside of the critical
section.

	Arnd
