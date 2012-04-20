From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Apr 2012 17:37:58 +0000
Subject: New ARM build coverage (was: linux-next: triage for April 18,
 2012)
In-Reply-To: <CAP=VYLrNpskLQDAw3Udnq7grddi-uD6TDjQQoZUd+FVg2rXPnA@mail.gmail.com>
References: <CAP=VYLrNpskLQDAw3Udnq7grddi-uD6TDjQQoZUd+FVg2rXPnA@mail.gmail.com>
Message-ID: <201204201737.58922.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 April 2012, Paul Gortmaker wrote:
> ARM folks,
> 
> Just a heads up that Stephen expanded the linux-next ARM coverage
> today to add a whole bunch more builds.
> 
> Possibly "new" build fails were detected in these configs:
> 
> ARM:mackerel_defconfig,ag5evm_defconfig
> ARM:ezx_defconfig
> ARM:mini2440_defconfig
> ARM:spear6xx_defconfig

This is what I've come up with for the latter one. CONFIG_MACH_SPEAR600
was not getting selected in spear6xx_defconfig, and we should not really
allow it to be deselected.

---
>From d06bce2084e946c3ae4dc3011032d0c23b7cd815 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2012 19:33:55 +0200
Subject: [PATCH] ARM: spear6xx: remove board selection options

There are no board specific configurations that need user
intervention, so just make MACH_SPEAR600 the silent default
for ARCH_SPEAR6XX to prevent users from turning it off, which
would result in a build error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-spear6xx/Kconfig b/arch/arm/mach-spear6xx/Kconfig
index fbe298b..339f397 100644
--- a/arch/arm/mach-spear6xx/Kconfig
+++ b/arch/arm/mach-spear6xx/Kconfig
@@ -2,21 +2,9 @@
 # SPEAr6XX Machine configuration file
 #
 
-if ARCH_SPEAR6XX
-
-menu "SPEAr6xx Implementations"
-config BOARD_SPEAR600_DT
-	bool "SPEAr600 generic board configured via device-tree"
-	select MACH_SPEAR600
+config MACH_SPEAR600
+	def_bool y
+	depends on ARCH_SPEAR6XX
 	select USE_OF
 	help
 	  Supports ST SPEAr600 boards configured via the device-tree
-
-endmenu
-
-config MACH_SPEAR600
-	bool "SPEAr600"
-	help
-	  Supports ST SPEAr600 Machine
-
-endif #ARCH_SPEAR6XX
