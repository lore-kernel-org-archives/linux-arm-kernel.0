From: balbi@ti.com (Felipe Balbi)
Date: Wed, 30 Jul 2014 09:40:59 -0500
Subject: [PATCH 29/35] arm: omap: intc: switch over to linear irq domain
In-Reply-To: <20140730060420.GY29045@atomide.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-30-git-send-email-balbi@ti.com>
 <20140729121425.GR29045@atomide.com>
 <20140729141522.GB17808@saruman.home>
 <20140729152052.GV29045@atomide.com>
 <20140729154057.GE17808@saruman.home>
 <20140729163345.GF17808@saruman.home>
 <20140730060420.GY29045@atomide.com>
Message-ID: <20140730144059.GA7272@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Tue, Jul 29, 2014 at 11:04:21PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140729 09:36]:
> > Hi,
> > 
> > On Tue, Jul 29, 2014 at 10:40:57AM -0500, Felipe Balbi wrote:
> > > On Tue, Jul 29, 2014 at 08:20:52AM -0700, Tony Lindgren wrote:
> > > > * Felipe Balbi <balbi@ti.com> [140729 07:18]:
> > > > > Hi,
> > > > > 
> > > > > On Tue, Jul 29, 2014 at 05:14:25AM -0700, Tony Lindgren wrote:
> > > > > > * Felipe Balbi <balbi@ti.com> [140728 14:19]:
> > > > > > > now that we don't need to support legacy board-files,
> > > > > > > we can completely switch over to a linear irq domain
> > > > > > > and make use of irq_alloc_domain_generic_chips() to
> > > > > > > allocate all generic irq chips for us.
> > > > > > 
> > > > > > This patch seems to somehow break off-idle for omap3 
> > > > > > where it no longer wakes up.
> > > > > 
> > > > > Sure your bisection is correct ? This patch just switches from legacy
> > > > > irq domain to linear irq domain.
> > > > 
> > > > Yes, I tried it a few times. Just enabling
> > > > retention idle hangs too with this patch.
> > > > 
> > > > Maybe it's omap3_prcm_irq_setup that relies on
> > > > 11 + OMAP_INTC_START? There may be other such issues
> > > 
> > > lol.
> > > 
> > > OMAP4 has the same nonsense.
> > 
> > made me think why (if) OMAP4 works with that same setup. Does wake from
> > OFF work with OMAP4 ?
> 
> Not without similar changes, omap4+ has the same issue.. There's a RFC
> series from Nishant to fix some of this, and Tero is moving the PRCM
> into a driver.
>  
> > Anyway, here's a quick little hack to check if that's the reason for the
> > regression:
> 
> OK yeah that's along the same lines with Nishant's RFC series in thread
> "[RFC PATCH 0/7] ARM: OMAP4+: PRM: minor cleanups and dt support of
> interrupts"
> 
> FYI, it did not compile, needs to include linux/of_irq.h. But yes,

I might have sent the wrong version as I had that same build error and
fixed it localy.

> it fixes the regression for me, Also now the whole series works for
> me :)

good to know.

What do you want to do now ? Wait for PRCM to become a driver ? Wait for
Nishanth's series to get accepted ? I guess the same thing could be done
for OMAP3 and AM33, then we would have a chance of having working wake
from idle with the new irqchip.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/a1333957/attachment.sig>
