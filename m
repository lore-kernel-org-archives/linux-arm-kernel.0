From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 28 Jun 2013 20:27:04 +0900
Subject: [PATCH 01/04] ARM: shmobile: Add r8a7790 CMT00 clock event
In-Reply-To: <20130628112655.23809.39115.sendpatchset@w520>
References: <20130628112655.23809.39115.sendpatchset@w520>
Message-ID: <20130628112704.23809.81183.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add clock event support for CMT0 timer channel 0
to the r8a7790 SoC code. On most ARM mach-shmobile
the CMT is hooked up to a 32KHz clock but on r8a7790
a 31.7KHz clock is instead used.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a7790.c |    4 ++++
 arch/arm/mach-shmobile/setup-r8a7790.c |   21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

--- 0002/arch/arm/mach-shmobile/clock-r8a7790.c
+++ work/arch/arm/mach-shmobile/clock-r8a7790.c	2013-06-28 15:23:13.000000000 +0900
@@ -47,6 +47,7 @@
 #define CPG_BASE 0xe6150000
 #define CPG_LEN 0x1000
 
+#define SMSTPCR1 0xe6150134
 #define SMSTPCR2 0xe6150138
 #define SMSTPCR3 0xe615013c
 #define SMSTPCR5 0xe6150144
@@ -186,6 +187,7 @@ enum {
 	MSTP522,
 	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
+	MSTP124,
 	MSTP_NR
 };
 
@@ -208,6 +210,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP204] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
 	[MSTP203] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 3, 0), /* SCIFA1 */
 	[MSTP202] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 2, 0), /* SCIFA2 */
+	[MSTP124] = SH_CLK_MSTP32(&rclk_clk, SMSTPCR1, 24, 0), /* CMT0 */
 };
 
 static struct clk_lookup lookups[] = {
@@ -270,6 +273,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP311]),
 	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
+	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 };
 
 #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-06-28 15:21:02.000000000 +0900
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_timer.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
 #include <mach/common.h>
@@ -160,6 +161,25 @@ static struct resource thermal_resources
 					thermal_resources,		\
 					ARRAY_SIZE(thermal_resources))
 
+static struct sh_timer_config cmt00_platform_data = {
+	.name = "CMT00",
+	.timer_bit = 0,
+	.clockevent_rating = 80,
+};
+
+static struct resource cmt00_resources[] = {
+	DEFINE_RES_MEM(0xffca0510, 0x0c),
+	DEFINE_RES_MEM(0xffca0500, 0x04),
+	DEFINE_RES_IRQ(gic_spi(142)), /* CMT0_0 */
+};
+
+#define r8a7790_register_cmt(idx)					\
+	platform_device_register_resndata(&platform_bus, "sh_cmt",	\
+					  idx, cmt##idx##_resources,	\
+					  ARRAY_SIZE(cmt##idx##_resources), \
+					  &cmt##idx##_platform_data,	\
+					  sizeof(struct sh_timer_config))
+
 void __init r8a7790_add_standard_devices(void)
 {
 	r8a7790_register_scif(SCIFA0);
@@ -174,6 +194,7 @@ void __init r8a7790_add_standard_devices
 	r8a7790_register_scif(HSCIF1);
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
+	r8a7790_register_cmt(00);
 }
 
 void __init r8a7790_timer_init(void)
