From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 17:01:36 +0100
Subject: [PATCH 23/62] ARM: omap1: fix building without 32K_TIMER
In-Reply-To: <20140319203431.GA8333@atomide.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <20140319200100.GB4271@saruman.home> <20140319203431.GA8333@atomide.com>
Message-ID: <201403211701.36846.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140319 13:06]:
> > On Wed, Mar 19, 2014 at 02:59:13PM -0500, Felipe Balbi wrote:
> > > I had sent a fix for months and months ago, what happened to it ?
> > 
> > Here
> > 
> > http://marc.info/?l=linux-omap&m=138963632408031&w=2
> > 
> > Tony, did you forget to send a pull request ?
> 
> Hmm yes weird, can't see it in my omap-for-v3.14/fixes branch.
> 
> I must have gotten interrupted while applying and then probably
> ran git reset --hard before committing.
> 
> Arnd, maybe pick up Felipe's earlier patch instead?
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Ok, using this version now, thanks!

	Arnd

>From 64cdcf550319a37d1419aa6a87903e67b9d3d031 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Sun, 16 Mar 2014 17:57:55 +0100
Subject: [PATCH] ARM: omap1: fix build when !CONFIG_OMAP_32K_TIMER

If CONFIG_OMAP_32K_TIMER isn't enabled, we will
try to use enable_dyn_sleep which wasn't defined
anywhere.

In order to fix the problem, we always define
enable_dyn_sleep as 0 when !CONFIG_OMAP_32K_TIMER.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 40a1ae3..dbee729 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -71,7 +71,11 @@ static unsigned int mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_SIZE];
 static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
 static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
 
-#ifdef CONFIG_OMAP_32K_TIMER
+#ifndef CONFIG_OMAP_32K_TIMER
+
+static unsigned short enable_dyn_sleep = 0;
+
+#else
 
 static unsigned short enable_dyn_sleep = 1;
 
