From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Aug 2013 12:48:05 +0100
Subject: [PATCH v3 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <20130823113225.GF2389@localhost>
References: <1377253445-2842-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377253445-2842-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130823103802.GO4600@tarshish> <20130823110748.GD2389@localhost>
 <20130823113225.GF2389@localhost>
Message-ID: <20130823114805.GF10971@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 12:32:26PM +0100, Ezequiel Garcia wrote:
> On Fri, Aug 23, 2013 at 08:07:50AM -0300, Ezequiel Garcia wrote:
> > On Fri, Aug 23, 2013 at 01:38:02PM +0300, Baruch Siach wrote:
> > > On Fri, Aug 23, 2013 at 07:24:03AM -0300, Ezequiel Garcia wrote:
> > > > Some SoC have MMIO regions that are shared across orthogonal
> > > > subsystems. This commit implements a possible solution for the
> > > > thread-safe access of such regions through a spinlock-protected API.
> > > > 
> > > > Concurrent access is protected with a single spinlock for the
> > > > entire MMIO address space. While this protects shared-registers,
> > > > it also serializes access to unrelated/unshared registers.
> > > > 
> > > > We add relaxed and non-relaxed variants, by using writel_relaxed and writel,
> > > > respectively. The rationale for this is that some users may not require
> > > > register write completion but only thread-safe access to a register.
> > > > 
> > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > 
> > > Is there a reason why this should be limited to ARM? I haven't found anything 
> > > ARM specific in the code.
> > 
> > I guess not.
> 
> ... or maybe yes. I'm not seeing {readl,writel}_relaxed as guaranteed
> to exist in every architecture. So, indeed, this seems to be ARM-dependent.

There was a discussion couple of years ago to make these part of the IO
specification since many architectures define them:

http://thread.gmane.org/gmane.linux.ports.arm.kernel/117626

(and some older threads on linux-arch which I haven't searched)

We could have some default implementation pointing to readl/writel while
letting the arch code to define more optimised variants.

-- 
Catalin
