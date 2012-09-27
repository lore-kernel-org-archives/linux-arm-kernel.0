From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 27 Sep 2012 17:15:52 +0100
Subject: [GIT PULL] ARM: cache flushing LoUIS API
In-Reply-To: <20120927114805.GC14358@n2100.arm.linux.org.uk>
References: <20120925125758.GA16842@e102568-lin.cambridge.arm.com>
 <20120927114805.GC14358@n2100.arm.linux.org.uk>
Message-ID: <20120927161552.GA5001@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC'ed Shawn to test T2 on iMX]

On Thu, Sep 27, 2012 at 12:48:05PM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 25, 2012 at 01:57:58PM +0100, Lorenzo Pieralisi wrote:
> > Hi Russell,
> > 
> > I know it is coming quite late in the cycle but please consider pulling
> > the patch series implementing the new cache maintenance LoUIS API, since
> > it provides a stepping stone to implementing power management on upcoming
> > A15 and A7 based platforms, leaving functionality for earlier processor
> > versions unchanged.
> > 
> > It has been tested on:
> > 
> > - OMAP4/5
> >   # suspend/hotplug and CPU idle
> > - iMX6q
> >   # suspend and hotplug
> > - TC2 big.LITTLE testchip
> >   # CPU idle
> 
> Ok, last night's PXA build regressed with this:
> 
> arch/arm/mm/built-in.o: In function `xscale_dma_unmap_area':
> cache-xsc3l2.c:(.text+0x4194): undefined reference to `xscale_80200_A0_A1_flush_kern_cache_louis'
> 
> That's because we missed that proc-xscale.S aliases a bunch of functions to
> xscale_80200_A0_A1_xxx from xscale_xxx.  And looking at that, it seems that
> we also .type equivalent symbols - have you tested this on T2 builds to
> check whether it works correctly there?

Tested T2 build on TC2 testchip and everything seems to be working fine.

Santosh, Shawn, can you give T2 a go on OMAP and iMX6 please ?

As for the xscale (and feroceon I think as well) regressions, I had a look
and put together this patch, following the pattern in the respective .S files.
It is true that we end up having a chain of equivalent symbols.

Russell,

Do you think it is sufficient/proper or you see other issues ?

If it is ok I can fold it into the series and prepare a new pull request.

Thanks a lot for your help and sorry again.
Lorenzo

-- >8 --
Subject: [PATCH] ARM: mm: fix cache LoUIS API for xscale and feroceon

Some architectures like xscale and feroceon have cache API variants that
map cache flushing functions as aliases to the base architecture.
This patch adds the required aliases to complete the implementation of
cache flushing LoUIS API.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mm/proc-feroceon.S | 1 +
 arch/arm/mm/proc-xscale.S   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 85e5e3b..4106b09 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -434,6 +434,7 @@ ENDPROC(feroceon_dma_unmap_area)
 	range_alias flush_icache_all
 	range_alias flush_user_cache_all
 	range_alias flush_kern_cache_all
+	range_alias flush_kern_cache_louis
 	range_alias flush_user_cache_range
 	range_alias coherent_kern_range
 	range_alias coherent_user_range
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index b5ea31d..2551036 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -442,6 +442,7 @@ ENDPROC(xscale_dma_unmap_area)
 	a0_alias flush_icache_all
 	a0_alias flush_user_cache_all
 	a0_alias flush_kern_cache_all
+	a0_alias flush_kern_cache_louis
 	a0_alias flush_user_cache_range
 	a0_alias coherent_kern_range
 	a0_alias coherent_user_range
-- 
1.7.12
