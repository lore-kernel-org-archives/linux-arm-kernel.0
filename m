From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Mar 2013 09:22:43 +0900
Subject: [PATCH 03/04] ARM: shmobile: Add EMEV2 TWD support
In-Reply-To: <20130306002214.5430.43766.sendpatchset@w520>
References: <20130306002214.5430.43766.sendpatchset@w520>
Message-ID: <20130306002243.5430.27806.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add TWD support for the EMEV2 SoC and the KZM9D board.
TWD data is added via C for the KZM9D board and also
via DT for the generic EMEV2 DT board support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/emev2.dtsi         |    6 ++++++
 arch/arm/mach-shmobile/clock-emev2.c |    5 ++++-
 arch/arm/mach-shmobile/setup-emev2.c |    4 ++++
 arch/arm/mach-shmobile/smp-emev2.c   |    9 +++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/emev2.dtsi
+++ work/arch/arm/boot/dts/emev2.dtsi	2013-03-05 18:37:48.000000000 +0900
@@ -30,6 +30,12 @@
 		};
 	};
 
+	timer at e0030600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0xe0030600 0x20>;
+		interrupts = <1 1 0xf04>;
+	};
+
 	gic: interrupt-controller at e0020000 {
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
--- 0001/arch/arm/mach-shmobile/clock-emev2.c
+++ work/arch/arm/mach-shmobile/clock-emev2.c	2013-03-05 18:37:30.000000000 +0900
@@ -31,6 +31,7 @@
 #define USIBU2_RSTCTRL 0x0b0
 #define USIBU3_RSTCTRL 0x0b4
 #define STI_RSTCTRL 0x124
+#define INTAGCLKCTRL 0x40c
 #define USIAU0GCLKCTRL 0x4a0
 #define USIBU1GCLKCTRL 0x4b8
 #define USIBU2GCLKCTRL 0x4bc
@@ -105,7 +106,7 @@ static struct clk sclkdiv_clks[SCLKDIV_N
 };
 
 enum { GCLK_USIAU0_SCLK, GCLK_USIBU1_SCLK, GCLK_USIBU2_SCLK, GCLK_USIBU3_SCLK,
-	GCLK_STI_SCLK,
+	GCLK_STI_SCLK, GCLK_INTA_CLK,
 	GCLK_NR };
 
 #define GCLK_SCLK(_parent, _reg) \
@@ -125,6 +126,7 @@ static struct clk gclk_clks[GCLK_NR] = {
 	[GCLK_USIBU3_SCLK] = GCLK_SCLK(&sclkdiv_clks[SCLKDIV_USIBU3],
 				       USIBU3GCLKCTRL),
 	[GCLK_STI_SCLK] = GCLK_SCLK(&c32k_clk, STIGCLKCTRL),
+	[GCLK_INTA_CLK] = GCLK_SCLK(&c32k_clk, INTAGCLKCTRL),
 };
 
 static int emev2_gclk_enable(struct clk *clk)
@@ -200,6 +202,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e1050000.uart", &gclk_clks[GCLK_USIBU3_SCLK]),
 	CLKDEV_DEV_ID("em_sti.0", &gclk_clks[GCLK_STI_SCLK]),
 	CLKDEV_DEV_ID("e0180000.sti", &gclk_clks[GCLK_STI_SCLK]),
+	CLKDEV_DEV_ID("smp_twd", &gclk_clks[GCLK_INTA_CLK]),
 };
 
 void __init emev2_clock_init(void)
--- 0006/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-03-05 18:37:30.000000000 +0900
@@ -402,10 +402,14 @@ void __init emev2_add_standard_devices(v
 			     ARRAY_SIZE(emev2_late_devices));
 }
 
+/* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
+void __init __weak emev2_register_twd(void) { }
+
 void __init emev2_timer_init(void)
 {
 	emev2_clock_init();
 	shmobile_timer_init();
+	emev2_register_twd();
 }
 
 static void __init emev2_init_delay(void)
--- 0001/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2013-03-05 18:37:30.000000000 +0900
@@ -28,9 +28,18 @@
 #include <mach/emev2.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
+#include <asm/smp_twd.h>
 
 #define EMEV2_SCU_BASE 0x1e000000
 
+#ifdef CONFIG_HAVE_ARM_TWD
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, 0xe0030600, 17);
+void __init emev2_register_twd(void)
+{
+	twd_local_timer_register(&twd_local_timer);
+}
+#endif
+
 static void __cpuinit emev2_secondary_init(unsigned int cpu)
 {
 	gic_secondary_init(0);
