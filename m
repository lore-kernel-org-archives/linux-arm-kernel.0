From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Jan 2013 17:00:34 +0000
Subject: [PATCH] hardlockup: detect hard lockups without NMIs using
 secondary cpus
In-Reply-To: <CAFTL4hw_aRB8837stPgABFwHd9ifVqtV5Z5zX9MJ8rSFTSPNog@mail.gmail.com>
References: <1357783059-13923-1-git-send-email-ccross@android.com>
 <20130110140215.GP88797@redhat.com>
 <20130110142245.GE19944@n2100.arm.linux.org.uk>
 <CAFTL4hw_aRB8837stPgABFwHd9ifVqtV5Z5zX9MJ8rSFTSPNog@mail.gmail.com>
Message-ID: <20130110170034.GG19944@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 05:18:40PM +0100, Frederic Weisbecker wrote:
> 2013/1/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Thu, Jan 10, 2013 at 09:02:15AM -0500, Don Zickus wrote:
> >> On Wed, Jan 09, 2013 at 05:57:39PM -0800, Colin Cross wrote:
> >> > Emulate NMIs on systems where they are not available by using timer
> >> > interrupts on other cpus.  Each cpu will use its softlockup hrtimer
> >> > to check that the next cpu is processing hrtimer interrupts by
> >> > verifying that a counter is increasing.
> >> >
> >> > This patch is useful on systems where the hardlockup detector is not
> >> > available due to a lack of NMIs, for example most ARM SoCs.
> >>
> >> I have seen other cpus, like Sparc I think, create a 'virtual NMI' by
> >> reserving an IRQ line as 'special' (can not be masked).  Not sure if that
> >> is something worth looking at here (or even possible).
> >
> > No it isn't, because that assumes that things like spin_lock_irqsave()
> > won't mask that interrupt.  We don't have the facility to do that.
> 
> I believe sparc is doing something like this though. Look at
> arch/sparc/include/asm/irqflags_64.h, it seems NMIs are implemented
> there using an irq number that is not masked by this function.

As I said, we don't have a facility to do that.

The CPU doesn't know about interrupt levels.  It's either all-IRQs-masked
or no-IRQs-masked.  If you want anything inbetween, you have to go outside
the CPU and fiddle with the IRQ controller, which may be one of _many_
different types, and some platforms even have a shadow IRQ controller.
Plus, doing such manipulation may in itself also require locking.
