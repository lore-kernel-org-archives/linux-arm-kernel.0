From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Apr 2014 10:21:28 +0100
Subject: [PATCH] ARM: prima2: remove L2 cache size override
In-Reply-To: <6113510.ZYPB60x7iK@wuerfel>
References: <1397555342-25644-1-git-send-email-21cnbao@gmail.com>
 <CAGsJ_4zt4KMLk7v93e40Zj1A7fHBnvE2_c94nAbGAr9xcCFnwg@mail.gmail.com>
 <20140415215615.GZ24070@n2100.arm.linux.org.uk> <6113510.ZYPB60x7iK@wuerfel>
Message-ID: <20140416092128.GE24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 10:52:27AM +0200, Arnd Bergmann wrote:
> On Tuesday 15 April 2014 22:56:15 Russell King - ARM Linux wrote:
> > On Tue, Apr 15, 2014 at 06:13:27PM +0800, Barry Song wrote:
> > > 
> > > ok, it seems we still need to hook this into the callback of this
> > > specific machine instead of using a global early_initcall(). since now
> > > the dt compatible field has been generic enough, it will cause other
> > > platforms to execute l2x0_of_init() too.
> > 
> > What I did for Versatile Express was to move it to the init_irq stage.
> > I'm not condoning using init_irq() for non-IRQ stuff, but that was
> > just to see whether it was possible (the .init_early is too early for
> > it.)  Let me put it another way: I'm not thrilled by the idea of
> > having it in init_irq() but that's a better location to call L2 cache
> > initialisation than half-way through the kernel's initialisation.
> 
> Would it help to introduce a new .init_l2_cache() callback? That
> way, the architecture code can default to initializing any l2x0
> that it finds in DT, and have give platforms the option of
> overriding the call if they need to, and we can do it at the
> same point during early boot for everyone.

As my ideal target is to remove l2x0_*init from platforms, I'd rather
not do that unless we have a clear idea that we are going to keep this
around.

Another potential solution would be to have the two auxctl values
specified, and do nothing if they're both zero.

First though, we really need to work out what each platform requires
from these, and turn everything else into either something the core
code handles, or if there is no good reason for it, it is simply
removed.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
