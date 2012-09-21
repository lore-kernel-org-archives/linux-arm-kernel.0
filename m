From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Sep 2012 09:29:16 +0100
Subject: [PATCH 1/2] arm: Add ARM ERRATA 775420 workaround
In-Reply-To: <20120921010404.GJ21660@verge.net.au>
References: <1347434097-7924-1-git-send-email-horms@verge.net.au>
 <1347434097-7924-2-git-send-email-horms@verge.net.au>
 <CAHkRjk6vbM8f=bK_GkgpDmnYh-UU_M3T9TeOj6Ti7UZB-5U2cg@mail.gmail.com>
 <20120921010404.GJ21660@verge.net.au>
Message-ID: <20120921082915.GA21464@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 02:04:04AM +0100, Simon Horman wrote:
> On Thu, Sep 20, 2012 at 10:58:53AM +0100, Catalin Marinas wrote:
> > On 12 September 2012 08:14, Simon Horman <horms@verge.net.au> wrote:
> > > +config ARM_ERRATA_775420
> > > +       bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
> > > +       depends on CPU_V7
> > > +       help
> > > +         This option enables the workaround for the 775420 Cortex-A9 (r2p2,
> > > +         r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
> > > +         operation aborts with MMU exception, it might cause the processor
> > > +         deadlock. This workaround puts DSB before executing ISB at the
> > > +         beginning of the abort exception handler.
> > > +
> > >  endmenu
> > 
> > The only case where we can get an abort on cache maintenance is
> > v7_coherent_user_range(). I don't think we have any ISB on the
> > exception handling path for this function, so we could just add the
> > DSB there:
> 
> I think that an advantage of Abe-san's implementation is that
> it might to be a bit more robust. But your proposal is certainly
> much cleaner and for that reason I agree it is a good option.

It is more robust but I'm not sure it's worth putting a DSB a any data
abort.

> I've updated the patch, but since the code is now all yours
> I'm unsure if the author should be changed or not.

But the Kconfig entry is yours and it has more lines :)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
