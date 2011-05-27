From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 May 2011 17:38:29 +0100
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <201105271816.10191.arnd@arndb.de>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<C832F8F5D375BD43BFA11E82E0FE9FE00AFDABA5E2@EXDCVYMBSTM005.EQ1STM.local>
	<20110527150242.GB14035@e102109-lin.cambridge.arm.com>
	<201105271816.10191.arnd@arndb.de>
Message-ID: <20110527163827.GF14035@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 05:16:09PM +0100, Arnd Bergmann wrote:
> On Friday 27 May 2011, Catalin Marinas wrote:
> > > Here we have another problem.  Since it's a cryptographic device
> > > some registers on the hardware are write-only, and some registers
> > > are actually implemented as a stack in the hardware itself. If you
> > > write a value to a register it will be pushed onto a stack in the
> > > hardware and if you read the same register you pop the value from
> > > the stack in the hardware.
> >
> > As I said above, you don't need to do this. The read back is usually
> > needed for things like clearing an error state at the device and
> > then enabling the IRQ for that device at the GIC level (though this
> > particular case isn't that simple).
> 
> To give yet another example: consider a device that has a register to
> enable level triggered interrupts. You may want to disable the
> interrupt by writing to the register during the interrupt handler.
> When you return from the interrupt handler, the CPU's IRQ mask is
> opened while the write may be still in flight. The only way to avoid
> that is to read back the interrupt mask from the device to flush out
> the write and make sure it's actually disabled before you reopen the
> irqs at the CPU.

As I said above, that's not a simple case and you could still get a
spurious interrupt. Based on feedback from the hw people, even if you
lower the interrupt level at the device (by writing and reading back
from the device), there is a delay in the signal propagation and
enabling the interrupts at the CPU level (or interrupt controller level)
could still trigger the interrupt. You can add extra delay to reduce the
chances but that's SoC specific. Anyway, reading back from the device
makes the likelihood much smaller.

-- 
Catalin
