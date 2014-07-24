From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jul 2014 15:24:17 +0100
Subject: arm64 flushing 255GB of vmalloc space takes too long
In-Reply-To: <1406150734.12484.79.camel@deneb.redhat.com>
References: <CAMPhdO-j5SfHexP8hafB2EQVs91TOqp_k_SLwWmo9OHVEvNWiQ@mail.gmail.com>
 <20140709174055.GC2814@arm.com>
 <CAMPhdO_XqAL4oXcuJkp2PTQ-J07sGG4Nm5HjHO=yGqS+KuWQzg@mail.gmail.com>
 <53BF3D58.2010900@codeaurora.org> <20140711124553.GG11473@arm.com>
 <1406150734.12484.79.camel@deneb.redhat.com>
Message-ID: <20140724142417.GE13371@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 10:25:34PM +0100, Mark Salter wrote:
> On Fri, 2014-07-11 at 13:45 +0100, Catalin Marinas wrote:
> > On Fri, Jul 11, 2014 at 02:26:48AM +0100, Laura Abbott wrote:
> > > Mark Salter actually proposed a fix to this back in May 
> > > 
> > > https://lkml.org/lkml/2014/5/2/311
> > > 
> > > I never saw any further comments on it though. It also matches what x86
> > > does with their TLB flushing. It fixes the problem for me and the threshold
> > > seems to be the best we can do unless we want to introduce options per
> > > platform. It will need to be rebased to the latest tree though.
> > 
> > There were other patches in this area and I forgot about this. The
> > problem is that the ARM architecture does not define the actual
> > micro-architectural implementation of the TLBs (and it shouldn't), so
> > there is no way to guess how many TLB entries there are. It's not an
> > easy figure to get either since there are multiple levels of caching for
> > the TLBs.
> > 
> > So we either guess some value here (we may not always be optimal) or we
> > put some time bound (e.g. based on sched_clock()) on how long to loop.
> > The latter is not optimal either, the only aim being to avoid
> > soft-lockups.
> 
> Sorry for the late reply...
> 
> So, what would you like to see wrt this, Catalin? A reworked patch based
> on time? IMO, something based on loop count or time seems better than
> the status quo of a CPU potentially wasting 10s of seconds flushing the
> tlb.

I think we could go with a loop for simplicity but with a larger number
of iterations only to avoid the lock-up (e.g. 1024, this would be 4MB
range). My concern is that for a few global mappings that may or may not
be in the TLB we nuke both the L1 and L2 TLBs (the latter can have over
1K entries). As for optimisation, I think we should look at the original
code generating such big ranges.

Would you mind posting a patch against the latest kernel?

-- 
Catalin
