From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 01 Oct 2011 18:45:04 +0200
Subject: [GIT PULL] dmtimer changes for v3.2 merge window
In-Reply-To: <201109302213.42435.arnd@arndb.de>
References: <20110928220237.GE6324@atomide.com>
	<201109302213.42435.arnd@arndb.de>
Message-ID: <2793025.zWgRvMbLEl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 September 2011 22:13:42 Arnd Bergmann wrote:
> On Thursday 29 September 2011, Tony Lindgren wrote:
> > Please pull omap dmtimer changes from:
> > 
> > git://github.com/tmlind/linux.git dmtimer
> > 
> > This series completes the system timer separation from the
> > driver like features. It also adds support for v2 ip that is
> > available for some timers starting with omap4.
> > 
> > After this series arch/arm/plat-omap/dmtimer.c could be
> > moved to live under drivers somewhere, but there is still
> > discussion going on which features should be supported in
> > a generic way.
> > 
> > This series depends on the cleanup you pulled earlier.
> > As this series adds some new features like runtime PM suppport,
> > I've kept it separate from cleanup.
> 
> Looks really nice. I've put it into another top-level branch
> named next/dmtimer for now. I'm open for suggestions on whether
> I should generally push branches like this separately Linuswards
> or better aggregate multiple standalone features into a single
> branch. 

I'm adding the patch below to fix a trivial randconfig build regression
in this series.

	Arnd

8<---

Subject: [PATCH] ARM: omap: use __devexit_p in dmtimer driver

The omap_dm_timer_remove function gets discarded when
CONFIG_HOTPLUG is not set, so we must not reference it
unconditionally.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index de7896f..2def4e1 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -723,7 +723,7 @@ static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
 
 static struct platform_driver omap_dm_timer_driver = {
 	.probe  = omap_dm_timer_probe,
-	.remove = omap_dm_timer_remove,
+	.remove = __devexit_p(omap_dm_timer_remove),
 	.driver = {
 		.name   = "omap_timer",
 	},
