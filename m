From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Mar 2012 04:21:29 +0000
Subject: [PATCH 9/9] ARM: kirkwood: use devicetree for rtc-mv
In-Reply-To: <cover.1331868507.git.jason@lakedaemon.net>
References: <cover.1331868507.git.jason@lakedaemon.net>
Message-ID: <ed16b33e93ffe131e6cfd1d2baab6168a0b6bdbd.1331868507.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/kirkwood.dtsi   |    6 ++++++
 arch/arm/mach-kirkwood/board-dt.c |    1 -
 arch/arm/mach-kirkwood/common.c   |    2 +-
 arch/arm/mach-kirkwood/common.h   |    1 -
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 825310b..3474ef8 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -26,5 +26,11 @@
 			/* set clock-frequency in board dts */
 			status = "disabled";
 		};
+
+		rtc at 10300 {
+			compatible = "mrvl,kirkwood-rtc", "mrvl,orion-rtc";
+			reg = <0x10300 0x20>;
+			interrupts = <53>;
+		};
 	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 975ad01..1c672d9 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -43,7 +43,6 @@ static void __init kirkwood_dt_init(void)
 #endif
 
 	/* internal devices that every board has */
-	kirkwood_rtc_init();
 	kirkwood_wdt_init();
 	kirkwood_xor0_init();
 	kirkwood_xor1_init();
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 04a7eb9..a02cae8 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -163,7 +163,7 @@ void __init kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts,
 /*****************************************************************************
  * SoC RTC
  ****************************************************************************/
-void __init kirkwood_rtc_init(void)
+static void __init kirkwood_rtc_init(void)
 {
 	orion_rtc_init(RTC_PHYS_BASE, IRQ_KIRKWOOD_RTC);
 }
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 4737578..fa8e768 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -61,7 +61,6 @@ static inline void dreamplug_init(void) {};
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
-void kirkwood_rtc_init(void);
 void kirkwood_wdt_init(void);
 void kirkwood_xor0_init(void);
 void kirkwood_xor1_init(void);
-- 
1.7.3.4
