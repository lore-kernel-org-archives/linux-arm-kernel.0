From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 12:50:02 +0200
Subject: [GIT PULL] at91: soc for 3.18 #2
In-Reply-To: <1411391733-28891-1-git-send-email-nicolas.ferre@atmel.com>
References: <1411391733-28891-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201409261250.02565.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 September 2014, Nicolas Ferre wrote:

> Nicolas Ferre (4):
>       ARM: at91: introduce basic SAMA5D4 support
>       ARM: at91: SAMA5D4 SoC detection code and low level routines

This resulted in build failures both in at91x40_defconfig and some
randconfigs with MMU disabled. I've applied the patch below on top
to fix it.

I'm not exactly happy about the soc detection code anyway after I
had to look at that. Why do you even hardcode the physical register
location rather than getting it from DT?

Also, why do you care about which SoC version you have for the
modern SAMA5 chips? All I see is a sama5d4_map_io() callback
that maps a lot of completely unused registers along with
the uart that you normally get from the implicit debug_ll_io_init,
and the SRAM that should probably be turned into a normal driver.

	Arnd
8<-------
>From 45aeea29c360551519edd8e041b36d8a4d5f6a23 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 26 Sep 2014 12:27:00 +0200
Subject: [PATCH] ARM: at91: fix nommu build regression

The newly introduced support for SAMA5D4 added access to the
'AT91_ALT_BASE_SYS' register area, but failed to define the
symbols in the case when CONFIG_MMU is disabled.

We really should not hardwire addresses like this any more,
but as a small fixup, this patch just adds the missing
definitions for the nommu case, which gets at91x40_defconfig
and any configuration of sam9 and sama5 with MMU disabled
back to work.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 726d32bf79ef4 ("ARM: at91: SAMA5D4 SoC detection code and low ...")

diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index d84776f6b8ac..c13797352688 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -51,11 +51,12 @@
  */
 #define AT91_BASE_SYS	0xffffc000
 
+#endif
+
 /*
  * On sama5d4 there is no system controller, we map some needed peripherals
  */
 #define AT91_ALT_BASE_SYS	0xfc069000
-#endif
 
 /*
  * On all at91 have the Advanced Interrupt Controller starts at address
@@ -90,6 +91,9 @@
  */
 #define AT91_IO_PHYS_BASE	AT91_BASE_SYS
 #define AT91_IO_VIRT_BASE	IOMEM(AT91_IO_PHYS_BASE)
+
+#define AT91_ALT_IO_PHYS_BASE	AT91_ALT_BASE_SYS
+#define AT91_ALT_IO_VIRT_BASE	IOMEM(AT91_ALT_BASE_SYS)
 #endif
 
 #define AT91_IO_SIZE		(0xFFFFFFFF - AT91_IO_PHYS_BASE + 1)
