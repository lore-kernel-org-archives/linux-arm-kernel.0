From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 03 May 2012 11:19:52 -0700
Subject: [PATCH] ARM: OMAP2+: watchdog: fix !PM boot crash, disarm timer
 after hwmod reset
In-Reply-To: <alpine.DEB.2.00.1204201451510.11306@utopia.booyaka.com>
References: <1334353873-15972-1-git-send-email-khilman@ti.com>
 <alpine.DEB.2.00.1204201451510.11306@utopia.booyaka.com>
Message-ID: <4FA2CC48.8020302@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 04/20/2012 01:59 PM, Paul Walmsley wrote:

[...]

> This looks great, looks like it will finally fix this longstanding bug.  I
> think Santosh hit it too a long time ago, so I suspect he will be happy
> too.
>
> One comment: I think that omap2_wd_timer_reset() needs to be updated in
> light of commit 3c55c1baffa5f719eb2ae9729088bc867f972f53 ("ARM: OMAP2+:
> hwmod: Revert "ARM: OMAP2+: hwmod: Make omap_hwmod_softreset wait for
> reset status"").  I did this here.  It's passed basic build testing but
> haven't tried booting it yet.  Care to take a look and see if you have any
> comments?  It's also available in the 'hwmod_devel_a_3.5' branch of
> git://git.pwsan.com/linux-2.6

I just noticed a compile warning with your updated version:

/work/kernel/omap/pm/arch/arm/mach-omap2/wd_timer.c: In function 
'omap2_wd_timer_reset':
/work/kernel/omap/pm/arch/arm/mach-omap2/wd_timer.c:78:6: warning: 
unused variable 'v' [-Wunused-variable]

The diff below on top of your patch fixes it.

Kevin


diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
index fcbb663..b2f1c67 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -75,7 +75,6 @@ int omap2_wd_timer_disable(struct omap_hwmod *oh)
   */
  int omap2_wd_timer_reset(struct omap_hwmod *oh)
  {
-	u32 v;
  	int c = 0;

  	/* Write to the SOFTRESET bit */
