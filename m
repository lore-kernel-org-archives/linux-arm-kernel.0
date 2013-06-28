From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 28 Jun 2013 20:27:23 +0900
Subject: [PATCH 03/04] ARM: shmobile: Add r8a73a4 CMT10 clock event
In-Reply-To: <20130628112655.23809.39115.sendpatchset@w520>
References: <20130628112655.23809.39115.sendpatchset@w520>
Message-ID: <20130628112723.23809.15876.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add clock event support for CMT1 timer channel 0
to the r8a73a4 SoC code. The CMT is used together
with a 32KHz clock in this case.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a73a4.c |    4 +++-
 arch/arm/mach-shmobile/setup-r8a73a4.c |   21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ work/arch/arm/mach-shmobile/clock-r8a73a4.c	2013-06-28 19:52:50.000000000 +0900
@@ -505,7 +505,7 @@ static struct clk div6_clks[DIV6_NR] = {
 /* MSTP */
 enum {
 	MSTP217, MSTP216, MSTP207, MSTP206, MSTP204, MSTP203,
-	MSTP323, MSTP318, MSTP317, MSTP316,
+	MSTP329, MSTP323, MSTP318, MSTP317, MSTP316,
 	MSTP315, MSTP314, MSTP313, MSTP312, MSTP305, MSTP300,
 	MSTP411, MSTP410, MSTP409,
 	MSTP522, MSTP515,
@@ -529,6 +529,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP317] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 17, 0), /* IIC7 */
 	[MSTP318] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 18, 0), /* IIC0 */
 	[MSTP323] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 23, 0), /* IIC1 */
+	[MSTP329] = SH_CLK_MSTP32(&extalr_clk, SMSTPCR3, 29, 0), /* CMT10 */
 	[MSTP409] = SH_CLK_MSTP32(&main_div2_clk,	SMSTPCR4, 9, 0), /* IIC5 */
 	[MSTP410] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 10, 0), /* IIC4 */
 	[MSTP411] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 11, 0), /* IIC3 */
@@ -593,6 +594,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6560000.i2c", &mstp_clks[MSTP317]),
 	CLKDEV_DEV_ID("e6500000.i2c", &mstp_clks[MSTP318]),
 	CLKDEV_DEV_ID("e6510000.i2c", &mstp_clks[MSTP323]),
+	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("e60b0000.i2c", &mstp_clks[MSTP409]),
 	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP410]),
 	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP411]),
--- 0001/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2013-06-28 19:50:40.000000000 +0900
@@ -23,6 +23,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_timer.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a73a4.h>
@@ -169,6 +170,25 @@ static const struct resource thermal0_re
 					thermal0_resources,		\
 					ARRAY_SIZE(thermal0_resources))
 
+static struct sh_timer_config cmt10_platform_data = {
+	.name = "CMT10",
+	.timer_bit = 0,
+	.clockevent_rating = 80,
+};
+
+static struct resource cmt10_resources[] = {
+	DEFINE_RES_MEM(0xe6130010, 0x0c),
+	DEFINE_RES_MEM(0xe6130000, 0x04),
+	DEFINE_RES_IRQ(gic_spi(120)), /* CMT1_0 */
+};
+
+#define r8a7790_register_cmt(idx)					\
+	platform_device_register_resndata(&platform_bus, "sh_cmt",	\
+					  idx, cmt##idx##_resources,	\
+					  ARRAY_SIZE(cmt##idx##_resources), \
+					  &cmt##idx##_platform_data,	\
+					  sizeof(struct sh_timer_config))
+
 void __init r8a73a4_add_standard_devices(void)
 {
 	r8a73a4_register_scif(SCIFA0);
@@ -180,6 +200,7 @@ void __init r8a73a4_add_standard_devices
 	r8a73a4_register_irqc(0);
 	r8a73a4_register_irqc(1);
 	r8a73a4_register_thermal();
+	r8a7790_register_cmt(10);
 }
 
 #ifdef CONFIG_USE_OF
