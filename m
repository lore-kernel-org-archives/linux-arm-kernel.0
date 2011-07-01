From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 1 Jul 2011 22:41:36 +0200
Subject: [PATCH v2 13/18] OMAP4: hwmod data: Fix L3 interconnect data order
	and alignement
In-Reply-To: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Message-ID: <1309552901-8944-14-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the position of the ocp_if structure to match the template.

Remove unneeded comma at the end of address space flag field.

Remove USER_SDMA since this ocp link is only from the l3_main_1
path that is accessible only from the MPU in that case and not
the SDMA.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e1c69ff..58843df 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -264,17 +264,11 @@ static struct omap_hwmod_ocp_if omap44xx_mmc2__l3_main_1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* L3 target configuration and error log registers */
-static struct omap_hwmod_irq_info omap44xx_l3_targ_irqs[] = {
-	{ .irq = 9  + OMAP44XX_IRQ_GIC_START },
-	{ .irq = 10 + OMAP44XX_IRQ_GIC_START },
-};
-
 static struct omap_hwmod_addr_space omap44xx_l3_main_1_addrs[] = {
 	{
 		.pa_start	= 0x44000000,
 		.pa_end		= 0x44000fff,
-		.flags		= ADDR_TYPE_RT,
+		.flags		= ADDR_TYPE_RT
 	},
 };
 
@@ -285,7 +279,7 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {
 	.clk		= "l3_div_ck",
 	.addr		= omap44xx_l3_main_1_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.user		= OCP_USER_MPU,
 };
 
 /* l3_main_1 slave ports */
@@ -299,13 +293,18 @@ static struct omap_hwmod_ocp_if *omap44xx_l3_main_1_slaves[] = {
 	&omap44xx_mpu__l3_main_1,
 };
 
+static struct omap_hwmod_irq_info omap44xx_l3_main_1_irqs[] = {
+	{ .name = "dbg_err", .irq = 9 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "app_err", .irq = 10 + OMAP44XX_IRQ_GIC_START },
+};
+
 static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.name		= "l3_main_1",
 	.class		= &omap44xx_l3_hwmod_class,
-	.mpu_irqs	= omap44xx_l3_targ_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_l3_targ_irqs),
 	.slaves		= omap44xx_l3_main_1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_slaves),
+	.mpu_irqs	= omap44xx_l3_main_1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_irqs),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -354,7 +353,7 @@ static struct omap_hwmod_addr_space omap44xx_l3_main_2_addrs[] = {
 	{
 		.pa_start	= 0x44800000,
 		.pa_end		= 0x44801fff,
-		.flags		= ADDR_TYPE_RT,
+		.flags		= ADDR_TYPE_RT
 	},
 };
 
@@ -365,7 +364,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_2 = {
 	.clk		= "l3_div_ck",
 	.addr		= omap44xx_l3_main_2_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_l3_main_2_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.user		= OCP_USER_MPU,
 };
 
 /* l4_cfg -> l3_main_2 */
@@ -409,7 +408,7 @@ static struct omap_hwmod_addr_space omap44xx_l3_main_3_addrs[] = {
 	{
 		.pa_start	= 0x45000000,
 		.pa_end		= 0x45000fff,
-		.flags		= ADDR_TYPE_RT,
+		.flags		= ADDR_TYPE_RT
 	},
 };
 
@@ -420,7 +419,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_3 = {
 	.clk		= "l3_div_ck",
 	.addr		= omap44xx_l3_main_3_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_l3_main_3_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.user		= OCP_USER_MPU,
 };
 
 /* l3_main_2 -> l3_main_3 */
-- 
1.7.0.4
