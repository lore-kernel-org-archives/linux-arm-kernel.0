From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Sep 2012 19:16:58 +0100
Subject: [PATCH] ARM: avoid undef on ARCH_HAS_READ_CURRENT_TIMER
In-Reply-To: <20120911180100.GS13739@n2100.arm.linux.org.uk>
References: <1347380341-28145-1-git-send-email-cyril@ti.com>
 <20120911180100.GS13739@n2100.arm.linux.org.uk>
Message-ID: <20120911181658.GJ32234@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 07:01:00PM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 11, 2012 at 12:19:00PM -0400, Cyril Chemparathy wrote:
> > With the inclusion of asm-generic/timex.h, the ARM arch timer implementation
> > breaks on build.  This is because asm/arch_timer.h now defines
> > ARCH_HAS_READ_CURRENT_TIMER, only to have this macro undefined by the
> > subsequent inclusion of asm-generic/timex.h.
> > 
> > This patch fixes the problem in asm/timex.h by including asm-generic/timex.h
> > early, and by defining get_cycles even earlier.
> > 
> > This patch has been tested against linux-next-20120910, both with and without
> > arch timer support.
> 
> Given the complexity this introduces, just for the sake of using one
> thing from asm-generic/timex.h:
> 
> typedef unsigned long cycles_t;
> 
> it seems utterly pointless to use the asm-generic version at all,
> especially if we have to play games to work around what it's doing.
> What this means is one of two things.  Either we should not be using
> asm-generic/timex.h, or asm-generic/timex.h as currently exists is
> broken.

Given that we have to have our own asm/timex.h anyway, I'd be happier not
using the generic version for ARM. That said, it's sitting in your for-next
tree so I thought I'd better work with it.

If you drop the change, then 7530/1 (the original patch) should be fine,
otherwise 7533/1 caters for the generic code.

Will
