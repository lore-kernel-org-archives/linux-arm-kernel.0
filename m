From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Dec 2016 11:54:13 +0000
Subject: [PATCH 3/4] iommu/arm-smmu: Disable stalling faults for all
 endpoints
In-Reply-To: <CAF6AEGujUb37qagBZK1T13eAh=50zy0z5HpFF9FsuvkZZ7c5qw@mail.gmail.com>
References: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
 <1471525542-14969-4-git-send-email-will.deacon@arm.com>
 <CAF6AEGujUb37qagBZK1T13eAh=50zy0z5HpFF9FsuvkZZ7c5qw@mail.gmail.com>
Message-ID: <20161216115413.GE13191@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Dec 06, 2016 at 06:30:21PM -0500, Rob Clark wrote:
> On Thu, Aug 18, 2016 at 9:05 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Enabling stalling faults can result in hardware deadlock on poorly
> > designed systems, particularly those with a PCI root complex upstream of
> > the SMMU.
> >
> > Although it's not really Linux's job to save hardware integrators from
> > their own misfortune, it *is* our job to stop userspace (e.g. VFIO
> > clients) from hosing the system for everybody else, even if they might
> > already be required to have elevated privileges.
> >
> > Given that the fault handling code currently executes entirely in IRQ
> > context, there is nothing that can sensibly be done to recover from
> > things like page faults anyway, so let's rip this code out for now and
> > avoid the potential for deadlock.
> 
> so, I'd like to re-introduce this feature, I *guess* as some sort of
> opt-in quirk (ie. disabled by default unless something in DT tells you
> otherwise??  But I'm open to suggestions.  I'm not entirely sure what
> hw was having problems due to this feature.)
> 
> On newer snapdragon devices we are using arm-smmu for the GPU, and
> halting the GPU so the driver's fault handler can dump some GPU state
> on faults is enormously helpful for debugging and tracking down where
> in the gpu cmdstream the fault was triggered.  In addition, we will
> eventually want the ability to update pagetables from fault handler
> and resuming the faulting transition.

I'm not against reintroducing this, but it would certainly need to be
opt-in, as you suggest. If we want to try to use stall faults to enable
demand paging for DMA, then that means running core mm code to resolve
the fault and we can't do that in irq context. Consequently, we have to
hand this off to a thread, which means the hardware must allow the SS
bit to remain set without immediately reasserting the interrupt line.
Furthermore, we can't handle multiple faults on a context-bank, so we'd
need to restrict ourselves to one device (i.e. faulting stream) per
domain (CB).

I think that means we want both specific compatible strings to identify
the SS bit behaviour, but also a way to opt-in for the stall model as a
separate property to indicate that the SoC integration can support this
without e.g. deadlocking.

Will
