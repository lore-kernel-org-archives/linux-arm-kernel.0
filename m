From: chao.xie@marvell.com (Chao Xie)
Date: Wed, 26 Mar 2014 12:52:42 +0800
Subject: [PATCH 3/4] arm: mmp: make SOCes with DT use new timer driver
In-Reply-To: <1395809563-31872-1-git-send-email-chao.xie@marvell.com>
References: <1395809563-31872-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1395809563-31872-4-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Change the dtsi and DT support for mmp SOCes to make them
use the new timer driver.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/boot/dts/mmp2.dtsi   | 25 ++++++++++++++++++++++---
 arch/arm/boot/dts/pxa168.dtsi | 32 ++++++++++++++++++++++----------
 arch/arm/boot/dts/pxa910.dtsi | 32 ++++++++++++++++++++++----------
 arch/arm/mach-mmp/Kconfig     |  2 ++
 arch/arm/mach-mmp/mmp-dt.c    | 11 +++++++++--
 arch/arm/mach-mmp/mmp2-dt.c   | 11 ++++++++++-
 6 files changed, 87 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 4e8b08c..1ffd884 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -126,9 +126,28 @@
 			ranges;
 
 			timer0: timer at d4014000 {
-				compatible = "mrvl,mmp-timer";
-				reg = <0xd4014000 0x100>;
-				interrupts = <13>;
+				compatible = "marvell,mmp-timer";
+				reg = <0xd4014000 0xc8>;
+				marvell,timer-id = <0>;
+				marvell,timer-fastclk-frequency = <6500000>;
+				marvell,timer-apb-frequency = <26000000>;
+                                status = "okay";
+
+				counter0 {
+					compatible = "marvell,timer-counter-clkevt";
+					interrupts = <13>;
+					marvell,timer-counter-id = <0>;
+					marvell,timer-counter-cpu = <0>;
+					marvell,timer-counter-frequency = <32768>;
+					marvell,timer-counter-rating = <200>;
+                                };
+
+                                counter1 {
+					compatible = "marvell,timer-counter-clksrc";
+					marvell,timer-counter-id = <1>;
+					marvell,timer-counter-frequency = <32768>;
+					marvell,timer-counter-rating = <200>;
+                                };
 			};
 
 			uart1: uart at d4030000 {
diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
index 975dad2..abcde10 100644
--- a/arch/arm/boot/dts/pxa168.dtsi
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -50,16 +50,28 @@
 			ranges;
 
 			timer0: timer at d4014000 {
-				compatible = "mrvl,mmp-timer";
-				reg = <0xd4014000 0x100>;
-				interrupts = <13>;
-			};
-
-			uart1: uart at d4017000 {
-				compatible = "mrvl,mmp-uart";
-				reg = <0xd4017000 0x1000>;
-				interrupts = <27>;
-				status = "disabled";
+				compatible = "marvell,mmp-timer";
+				reg = <0xd4014000 0xc8>;
+				marvell,timer-id = <0>;
+				marvell,timer-fastclk-frequency = <3250000>;
+				marvell,timer-apb-frequency = <26000000>;
+                                status = "okay";
+
+				counter0 {
+					compatible = "marvell,timer-counter-clkevt";
+					interrupts = <13>;
+					marvell,timer-counter-id = <0>;
+					marvell,timer-counter-cpu = <0>;
+					marvell,timer-counter-frequency = <32768>;
+					marvell,timer-counter-rating = <200>;
+                                };
+
+                                counter1 {
+					compatible = "marvell,timer-counter-clksrc";
+					marvell,timer-counter-id = <1>;
+					marvell,timer-counter-frequency = <32768>;
+					marvell,timer-counter-rating = <200>;
+                                };
 			};
 
 			uart2: uart at d4018000 {
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index 0247c62..83d5e04 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -55,16 +55,28 @@
 			ranges;
 
 			timer0: timer at d4014000 {
-				compatible = "mrvl,mmp-timer";
-				reg = <0xd4014000 0x100>;
-				interrupts = <13>;
-			};
-
-			timer1: timer at d4016000 {
-				compatible = "mrvl,mmp-timer";
-				reg = <0xd4016000 0x100>;
-				interrupts = <29>;
-				status = "disabled";
+				compatible = "marvell,mmp-timer";
+				reg = <0xd4014000 0xc8>;
+				marvell,timer-id = <0>;
+				marvell,timer-fastclk-frequency = <3250000>;
+				marvell,timer-apb-frequency = <26000000>;
+                                status = "okay";
+
+				counter0 {
+					compatible = "marvell,timer-counter-clkevt";
+					interrupts = <13>;
+					marvell,timer-counter-id = <0>;
+					marvell,timer-counter-cpu = <0>;
+					marvell,timer-counter-frequency = <32768>;
+					marvell,timer-counter-rating = <200>;
+                                };
+
+                                counter1 {
+					compatible = "marvell,timer-counter-clksrc";
+					marvell,timer-counter-id = <1>;
+					marvell,timer-counter-frequency = <32768>;
+					marvell,timer-counter-rating = <200>;
+                                };
 			};
 
 			uart1: uart at d4017000 {
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index ebdba87..8828f61 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -89,6 +89,7 @@ config MACH_MMP_DT
 	select CPU_PXA168
 	select CPU_PXA910
 	select USE_OF
+	select CLKSRC_OF
 	select PINCTRL
 	select PINCTRL_SINGLE
 	help
@@ -101,6 +102,7 @@ config MACH_MMP2_DT
 	depends on !CPU_MOHAWK
 	select CPU_MMP2
 	select USE_OF
+	select CLKSRC_OF
 	select PINCTRL
 	select PINCTRL_SINGLE
 	help
diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index cca529c..c729e46 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -11,13 +11,12 @@
 
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
+#include <linux/clocksource.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
 #include "common.h"
 
-extern void __init mmp_dt_init_timer(void);
-
 static const struct of_dev_auxdata pxa168_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4017000, "pxa2xx-uart.0", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4018000, "pxa2xx-uart.1", NULL),
@@ -52,6 +51,14 @@ static void __init pxa910_dt_init(void)
 			     pxa910_auxdata_lookup, NULL);
 }
 
+static void __init mmp_dt_init_timer(void)
+{
+	/* TODO: clock framework initialization. */
+
+	/* Initialize timers. */
+	clocksource_of_init();
+}
+
 static const char *mmp_dt_board_compat[] __initdata = {
 	"mrvl,pxa168-aspenite",
 	"mrvl,pxa910-dkb",
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 023cb45..fa57341 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
+#include <linux/clocksource.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
@@ -37,6 +38,14 @@ static void __init mmp2_dt_init(void)
 			     mmp2_auxdata_lookup, NULL);
 }
 
+static void __init mmp2_dt_init_timer(void)
+{
+	/* TODO: clock framework initialization. */
+
+	/* Initialize timers. */
+	clocksource_of_init();
+}
+
 static const char *mmp2_dt_board_compat[] __initdata = {
 	"mrvl,mmp2-brownstone",
 	NULL,
@@ -44,7 +53,7 @@ static const char *mmp2_dt_board_compat[] __initdata = {
 
 DT_MACHINE_START(MMP2_DT, "Marvell MMP2 (Device Tree Support)")
 	.map_io		= mmp_map_io,
-	.init_time	= mmp_dt_init_timer,
+	.init_time	= mmp2_dt_init_timer,
 	.init_machine	= mmp2_dt_init,
 	.dt_compat	= mmp2_dt_board_compat,
 MACHINE_END
-- 
1.8.3.2
