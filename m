From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Feb 2014 01:59:56 +0100
Subject: [PATCH 18/27] ARM: shmobile: r8a73a4: Switch to new style CMT device
In-Reply-To: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1392339605-20691-19-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CMT (Compare Match Timer) driver implements a new style of platform
data that handles the timer as a single device with multiple channel.
Switch from the old-style platform data to the new-style platform data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c |  2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 7348d58..cd75821 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -597,7 +597,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6560000.i2c", &mstp_clks[MSTP317]),
 	CLKDEV_DEV_ID("e6500000.i2c", &mstp_clks[MSTP318]),
 	CLKDEV_DEV_ID("e6510000.i2c", &mstp_clks[MSTP323]),
-	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]),
+	CLKDEV_DEV_ID("sh-cmt-48-gen2.1", &mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("e60b0000.i2c", &mstp_clks[MSTP409]),
 	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP410]),
 	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP411]),
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index cd36f80..5794229 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -169,20 +169,25 @@ static const struct resource thermal0_resources[] = {
 					thermal0_resources,		\
 					ARRAY_SIZE(thermal0_resources))
 
-static struct sh_timer_config cmt10_platform_data = {
-	.name = "CMT10",
-	.timer_bit = 0,
-	.clockevent_rating = 80,
+static struct sh_timer_channel_config cmt1_channels[] = {
+	{
+		.index = 0,
+		.clockevent_rating = 80,
+	},
+};
+
+static struct sh_timer_config cmt1_platform_data = {
+	.channels = cmt1_channels,
+	.num_channels = ARRAY_SIZE(cmt1_channels),
 };
 
-static struct resource cmt10_resources[] = {
-	DEFINE_RES_MEM(0xe6130010, 0x0c),
-	DEFINE_RES_MEM(0xe6130000, 0x04),
-	DEFINE_RES_IRQ(gic_spi(120)), /* CMT1_0 */
+static struct resource cmt1_resources[] = {
+	DEFINE_RES_MEM(0xe6130000, 0x1004),
+	DEFINE_RES_IRQ(gic_spi(120)),
 };
 
 #define r8a7790_register_cmt(idx)					\
-	platform_device_register_resndata(&platform_bus, "sh_cmt",	\
+	platform_device_register_resndata(&platform_bus, "sh-cmt-48-gen2", \
 					  idx, cmt##idx##_resources,	\
 					  ARRAY_SIZE(cmt##idx##_resources), \
 					  &cmt##idx##_platform_data,	\
@@ -196,7 +201,7 @@ void __init r8a73a4_add_dt_devices(void)
 	r8a73a4_register_scif(3);
 	r8a73a4_register_scif(4);
 	r8a73a4_register_scif(5);
-	r8a7790_register_cmt(10);
+	r8a7790_register_cmt(1);
 }
 
 /* DMA */
-- 
1.8.3.2
