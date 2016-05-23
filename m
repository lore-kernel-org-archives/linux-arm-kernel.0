From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 May 2016 12:09:40 +0100
Subject: [PATCH] arm: Enable interrupts before calling schedule()
In-Reply-To: <20160523105420.GE4892@e104818-lin.cambridge.arm.com>
References: <alpine.DEB.2.11.1605201740320.3639@nanos>
 <20160523105420.GE4892@e104818-lin.cambridge.arm.com>
Message-ID: <20160523110940.GX19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 11:54:20AM +0100, Catalin Marinas wrote:
> We may have the same bug on arm64 (arch/arm64/kernel/entry.S). Is there
> a more fundamental problem with calling schedule() with IRQs off? The
> __schedule() function disables the IRQs shortly after it is entered.

schedule() does other stuff before entering __schedule() though, such
as calling into the block layer.  This code may have the expectation
that interrupts are enabled.

However, having interrupts enabled in this path (which I'd argue is
special in respect of the "thou shalt not enter schedule() with IRQs
off" rule) opens up the possibility to call into schedule() with the
need_resched flag cleared:

- need_resched was set when returning to userspace, we enter
  do_work_pending().
- do_work_pending() enables IRQs, and an IRQ was pending.
- IRQ is processed, and during that kernel preemption happens, clearing
  this thread's need_resched flag.
- we return to this thread, and now we will enter schedule() with
  need_resched clear.

Whether that matters or not is a different question - and I guess
is a question for scheduler people.

The likelyhood of this happening depends on the IRQ load, but the
requirements are quite simple: need_resched set while returning to
userspace with a pending IRQ.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
