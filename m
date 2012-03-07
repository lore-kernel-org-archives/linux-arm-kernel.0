From: jason@lakedaemon.net (Jason Cooper)
Date: Wed,  7 Mar 2012 03:44:49 +0000
Subject: [PATCH 08/14] ARM: kirkwood: use devicetree for rtc-mv
In-Reply-To: <cover.1331090356.git.jason@lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
Message-ID: <146e96ef8a8649767b3beb49ff39a260e75f234a.1331090356.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---

Changes from previous version:

* s/marvell,/mrvl,/g for compatible properties
* split into binding patch and a use patch.

 arch/arm/boot/dts/kirkwood.dtsi   |    6 ++++++
 arch/arm/mach-kirkwood/board-dt.c |    1 -
 arch/arm/mach-kirkwood/common.c   |    2 +-
 arch/arm/mach-kirkwood/common.h   |    1 -
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 7896a1d..5960a8e 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -10,4 +10,10 @@
 		#interrupt-cells = <1>;
 		reg = <0xfed20200 0x20>;
 	};
+
+	rtc at f1010300 {
+		compatible = "mrvl,kirkwood-rtc", "mrvl,orion-rtc";
+		reg = <0xf1010300 0x1f>;
+		interrupts = <53>;
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index b55d25b..deea565 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -181,7 +181,6 @@ static void __init kirkwood_dt_init(void)
 		irq_domain_add_simple(node, 0);
 
 	/* internal devices that every board has */
-	kirkwood_rtc_init();
 	kirkwood_wdt_init();
 	kirkwood_xor0_init();
 	kirkwood_xor1_init();
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index ae90f60..ef45244 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -162,7 +162,7 @@ void __init kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts,
 /*****************************************************************************
  * SoC RTC
  ****************************************************************************/
-void __init kirkwood_rtc_init(void)
+static void __init kirkwood_rtc_init(void)
 {
 	orion_rtc_init(RTC_PHYS_BASE, IRQ_KIRKWOOD_RTC);
 }
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index c382447..ca08826 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -53,7 +53,6 @@ void kirkwood_restart(char, const char *);
 
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
-void kirkwood_rtc_init(void);
 void kirkwood_wdt_init(void);
 void kirkwood_xor0_init(void);
 void kirkwood_xor1_init(void);
-- 
1.7.3.4
