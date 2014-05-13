From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 13 May 2014 17:03:29 +0900
Subject: [PATCH 02/15] ARM: shmobile: sh7372: Switch to new style CMT device
In-Reply-To: <cover.1399967755.git.horms+renesas@verge.net.au>
References: <cover.1399967755.git.horms+renesas@verge.net.au>
Message-ID: <386f60aae35271efa4dc7c407f65269b7cb71edb.1399967755.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The CMT (Compare Match Timer) driver implements a new style of platform
data that handles the timer as a single device with multiple channel.
Switch from the old-style platform data to the new-style platform data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh7372.c |  6 +++---
 arch/arm/mach-shmobile/setup-sh7372.c | 20 ++++----------------
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 2848997..c622b49 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -565,10 +565,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a66597_hcd.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("r8a66597_udc.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("renesas_usbhs.1", &mstp_clks[MSTP406]), /* USB1 */
-	CLKDEV_DEV_ID("sh_cmt.4", &mstp_clks[MSTP405]), /* CMT4 */
-	CLKDEV_DEV_ID("sh_cmt.3", &mstp_clks[MSTP404]), /* CMT3 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
-	CLKDEV_DEV_ID("sh_cmt.2", &mstp_clks[MSTP400]), /* CMT2 */
 
 	/* ICK */
 	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSIT]),
@@ -581,6 +578,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("icka", "sh_fsi2", &div6_reparent_clks[DIV6_FSIA]),
 	CLKDEV_ICK_ID("ickb", "sh_fsi2", &div6_reparent_clks[DIV6_FSIB]),
 	CLKDEV_ICK_ID("spu2", "sh_fsi2", &mstp_clks[MSTP223]),
+	CLKDEV_ICK_ID("fck", "sh-cmt-32-fast.4", &mstp_clks[MSTP405]), /* CMT4 */
+	CLKDEV_ICK_ID("fck", "sh-cmt-32-fast.3", &mstp_clks[MSTP404]), /* CMT3 */
+	CLKDEV_ICK_ID("fck", "sh-cmt-32-fast.2", &mstp_clks[MSTP400]), /* CMT2 */
 	CLKDEV_ICK_ID("diva", "sh_fsi2", &fsidivs[FSIDIV_A]),
 	CLKDEV_ICK_ID("divb", "sh_fsi2", &fsidivs[FSIDIV_B]),
 	CLKDEV_ICK_ID("xcka", "sh_fsi2", &fsiack_clk),
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 2730127..4c0e943 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -119,28 +119,16 @@ SH7372_SCIF(PORT_SCIFB, 6, 0xe6c30000, evt2irq(0x0d60));
 
 /* CMT */
 static struct sh_timer_config cmt2_platform_data = {
-	.name = "CMT2",
-	.channel_offset = 0x40,
-	.timer_bit = 5,
-	.clockevent_rating = 125,
-	.clocksource_rating = 125,
+	.channels_mask = 0x20,
 };
 
 static struct resource cmt2_resources[] = {
-	[0] = {
-		.name	= "CMT2",
-		.start	= 0xe6130040,
-		.end	= 0xe613004b,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= evt2irq(0x0b80), /* CMT2 */
-		.flags	= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(0xe6130000, 0x50),
+	DEFINE_RES_IRQ(evt2irq(0x0b80)),
 };
 
 static struct platform_device cmt2_device = {
-	.name		= "sh_cmt",
+	.name		= "sh-cmt-32-fast",
 	.id		= 2,
 	.dev = {
 		.platform_data	= &cmt2_platform_data,
-- 
1.8.5.2
