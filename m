From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jan 2015 15:17:58 +0900
Subject: [PATCH 01/14 v2] ARM: shmobile: mackerel: Remove ZBOOT code
In-Reply-To: <20150126061747.6848.9708.sendpatchset@little-apple>
References: <20150126061747.6848.9708.sendpatchset@little-apple>
Message-ID: <20150126061758.6848.22708.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove ZBOOT support code for Mackerel. With this patch in place
it is no longer possible to boot a self-contained kernel directly
from the reset vector. ZBOOT is still supported on kzm9g.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V1:
 - Rebased and resolved conflicts

 arch/arm/mach-shmobile/include/mach/head-mackerel.txt |   93 -----------------
 arch/arm/mach-shmobile/include/mach/mmc-mackerel.h    |   38 ------
 arch/arm/mach-shmobile/include/mach/mmc.h             |    5 
 arch/arm/mach-shmobile/include/mach/zboot.h           |    5 
 4 files changed, 1 insertion(+), 140 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
+++ /dev/null	2015-01-13 15:44:39.280208949 +0900
@@ -1,93 +0,0 @@
-LIST "partner-jet-setup.txt"
-LIST "(C) Copyright 2010 Renesas Solutions Corp"
-LIST "Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>"
-
-LIST "RWT Setting"
-EW 0xE6020004, 0xA500
-EW 0xE6030004, 0xA500
-
-LIST "GPIO Setting"
-EB 0xE6051013, 0xA2
-
-LIST "CPG"
-ED 0xE61500C0, 0x00000002
-
-WAIT 1, 0xFE40009C
-
-LIST "FRQCR"
-ED 0xE6150000, 0x2D1305C3
-ED 0xE61500E0, 0x9E40358E
-ED 0xE6150004, 0x80331050
-
-WAIT 1, 0xFE40009C
-
-ED 0xE61500E4, 0x00002000
-
-WAIT 1, 0xFE40009C
-
-LIST "PLL"
-ED 0xE6150028, 0x00004000
-
-WAIT 1, 0xFE40009C
-
-ED 0xE615002C, 0x93000040
-
-WAIT 1, 0xFE40009C
-
-LIST "SUB/USBClk"
-ED 0xE6150080, 0x00000180
-
-LIST "BSC"
-ED 0xFEC10000, 0x00E0001B
-
-LIST "SBSC1"
-ED 0xFE400354, 0x01AD8000
-ED 0xFE400354, 0x01AD8001
-
-WAIT 5, 0xFE40009C
-
-ED 0xFE400008, 0xBCC90151
-ED 0xFE400040, 0x41774113
-ED 0xFE400044, 0x2712E229
-ED 0xFE400048, 0x20C18505
-ED 0xFE40004C, 0x00110209
-ED 0xFE400010, 0x00000087
-
-WAIT 30, 0xFE40009C
-
-ED 0xFE400084, 0x0000003F
-EB 0xFE500000, 0x00
-
-WAIT 5, 0xFE40009C
-
-ED 0xFE400084, 0x0000FF0A
-EB 0xFE500000, 0x00
-
-WAIT 1, 0xFE40009C
-
-ED 0xFE400084, 0x00002201
-EB 0xFE500000, 0x00
-ED 0xFE400084, 0x00000302
-EB 0xFE500000, 0x00
-EB 0xFE5C0000, 0x00
-ED 0xFE400008, 0xBCC90159
-ED 0xFE40008C, 0x88800004
-ED 0xFE400094, 0x00000004
-ED 0xFE400028, 0xA55A0032
-ED 0xFE40002C, 0xA55A000C
-ED 0xFE400020, 0xA55A2048
-ED 0xFE400008, 0xBCC90959
-
-LIST "Change CPGA setting"
-ED 0xE61500E0, 0x9E40352E
-ED 0xE6150004, 0x80331050
-
-WAIT 1, 0xFE40009C
-
-ED 0xFE400354, 0x01AD8002
-
-LIST "SCIF0 - Serial port for earlyprintk"
-EB 0xE6053098, 0xe1
-EW 0xE6C40000, 0x0000
-EB 0xE6C40004, 0x19
-EW 0xE6C40008, 0x0030
--- 0001/arch/arm/mach-shmobile/include/mach/mmc-mackerel.h
+++ /dev/null	2015-01-13 15:44:39.280208949 +0900
@@ -1,38 +0,0 @@
-#ifndef MMC_MACKEREL_H
-#define MMC_MACKEREL_H
-
-#define PORT0CR      (void __iomem *)0xe6051000
-#define PORT1CR      (void __iomem *)0xe6051001
-#define PORT2CR      (void __iomem *)0xe6051002
-#define PORT159CR    (void __iomem *)0xe605009f
-
-#define PORTR031_000DR (void __iomem *)0xe6055000
-#define PORTL159_128DR (void __iomem *)0xe6054010
-
-static inline void mmc_init_progress(void)
-{
-       /* Initialise LEDS0-3
-        * registers: PORT0CR-PORT2CR,PORT159CR (LED0-LED3 Control)
-        * value:     0x10 - enable output
-        */
-       __raw_writeb(0x10, PORT0CR);
-       __raw_writeb(0x10, PORT1CR);
-       __raw_writeb(0x10, PORT2CR);
-       __raw_writeb(0x10, PORT159CR);
-}
-
-static inline void mmc_update_progress(int n)
-{
-	unsigned a = 0, b = 0;
-
-	if (n < 3)
-		a = 1 << n;
-	else
-		b = 1 << 31;
-
-	__raw_writel((__raw_readl(PORTR031_000DR) & ~0x7) | a,
-		     PORTR031_000DR);
-	__raw_writel((__raw_readl(PORTL159_128DR) & ~(1 << 31)) | b,
-		     PORTL159_128DR);
-}
-#endif /* MMC_MACKEREL_H */
--- 0001/arch/arm/mach-shmobile/include/mach/mmc.h
+++ work/arch/arm/mach-shmobile/include/mach/mmc.h	2015-01-26 13:25:56.975993591 +0900
@@ -7,10 +7,5 @@
  *
  **************************************************/
 
-#ifdef CONFIG_MACH_MACKEREL
-#include "mach/mmc-mackerel.h"
-#else
 #error "unsupported board."
-#endif
-
 #endif /* MMC_H */
--- 0001/arch/arm/mach-shmobile/include/mach/zboot.h
+++ work/arch/arm/mach-shmobile/include/mach/zboot.h	2015-01-26 13:26:47.145993411 +0900
@@ -9,10 +9,7 @@
  *
  **************************************************/
 
-#ifdef CONFIG_MACH_MACKEREL
-#define MEMORY_START	0x40000000
-#include "mach/head-mackerel.txt"
-#elif defined(CONFIG_MACH_KZM9G) || defined(CONFIG_MACH_KZM9G_REFERENCE)
+#if defined(CONFIG_MACH_KZM9G) || defined(CONFIG_MACH_KZM9G_REFERENCE)
 #define MEMORY_START	0x43000000
 #include "mach/head-kzm9g.txt"
 #else
