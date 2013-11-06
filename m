From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Nov 2013 19:43:32 +0900
Subject: [PATCH] ARM: shmobile: Enable MTU2 on r7s72100
Message-ID: <20131106104332.6327.73303.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add MTU2 as r7s72100 system timer.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Built on top of "renesas-devel-v3.12-rc7-20131101"

 arch/arm/mach-shmobile/clock-r7s72100.c |    1 +
 arch/arm/mach-shmobile/setup-r7s72100.c |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

--- 0001/arch/arm/mach-shmobile/clock-r7s72100.c
+++ work/arch/arm/mach-shmobile/clock-r7s72100.c	2013-11-05 21:07:13.000000000 +0900
@@ -178,6 +178,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP42]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.6", &mstp_clks[MSTP41]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.7", &mstp_clks[MSTP40]),
+	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
 };
 
 void __init r7s72100_clock_init(void)
--- 0001/arch/arm/mach-shmobile/setup-r7s72100.c
+++ work/arch/arm/mach-shmobile/setup-r7s72100.c	2013-11-05 21:07:13.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_timer.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r7s72100.h>
@@ -58,6 +59,26 @@ static inline void r7s72100_register_sci
 				      sizeof(struct plat_sci_port));
 }
 
+
+static struct sh_timer_config mtu2_0_platform_data __initdata = {
+	.name = "MTU2_0",
+	.timer_bit = 0,
+	.channel_offset = -0x80,
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_0_resources[] __initdata = {
+	DEFINE_RES_MEM(0xfcff0300, 0x27),
+	DEFINE_RES_IRQ(gic_iid(139)), /* MTU2 TGI0A */
+};
+
+#define r7s72100_register_mtu2(idx)					\
+	platform_device_register_resndata(&platform_bus, "sh_mtu2",	\
+					  idx, mtu2_##idx##_resources,	\
+					  ARRAY_SIZE(mtu2_##idx##_resources), \
+					  &mtu2_##idx##_platform_data,	\
+					  sizeof(struct sh_timer_config))
+
 void __init r7s72100_add_dt_devices(void)
 {
 	r7s72100_register_scif(SCIF0);
@@ -68,6 +89,7 @@ void __init r7s72100_add_dt_devices(void
 	r7s72100_register_scif(SCIF5);
 	r7s72100_register_scif(SCIF6);
 	r7s72100_register_scif(SCIF7);
+	r7s72100_register_mtu2(0);
 }
 
 void __init r7s72100_init_early(void)
