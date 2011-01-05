From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  5 Jan 2011 14:06:38 +0000
Subject: [PATCH 6/8] ARM: Integrator/CP: Use physmap driver instead of
	integrator-flash
In-Reply-To: <1294236400-22477-1-git-send-email-marc.zyngier@arm.com>
References: <1294236400-22477-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1294236400-22477-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested with an ARM-1136 core tile.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-integrator/integrator_cp.c |   35 +++++------------------------
 1 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 6258c90..cf67c69 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -21,6 +21,7 @@
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
 #include <linux/gfp.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/clkdev.h>
 #include <mach/clkdev.h>
@@ -36,7 +37,6 @@
 #include <mach/lm.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -317,43 +317,20 @@ static struct clk_lookup cp_lookups[] = {
 /*
  * Flash handling.
  */
-static int intcp_flash_init(void)
-{
-	u32 val;
-
-	val = readl(INTCP_VA_CTRL_BASE + INTCP_FLASHPROG);
-	val |= CINTEGRATOR_FLASHPROG_FLWREN;
-	writel(val, INTCP_VA_CTRL_BASE + INTCP_FLASHPROG);
-
-	return 0;
-}
-
-static void intcp_flash_exit(void)
-{
-	u32 val;
-
-	val = readl(INTCP_VA_CTRL_BASE + INTCP_FLASHPROG);
-	val &= ~(CINTEGRATOR_FLASHPROG_FLVPPEN|CINTEGRATOR_FLASHPROG_FLWREN);
-	writel(val, INTCP_VA_CTRL_BASE + INTCP_FLASHPROG);
-}
-
-static void intcp_flash_set_vpp(int on)
+static void intcp_flash_set_vpp(struct map_info *map, int on)
 {
 	u32 val;
 
 	val = readl(INTCP_VA_CTRL_BASE + INTCP_FLASHPROG);
 	if (on)
-		val |= CINTEGRATOR_FLASHPROG_FLVPPEN;
+		val |= CINTEGRATOR_FLASHPROG_FLVPPEN | CINTEGRATOR_FLASHPROG_FLWREN;
 	else
-		val &= ~CINTEGRATOR_FLASHPROG_FLVPPEN;
+		val &= ~(CINTEGRATOR_FLASHPROG_FLVPPEN | CINTEGRATOR_FLASHPROG_FLWREN);
 	writel(val, INTCP_VA_CTRL_BASE + INTCP_FLASHPROG);
 }
 
-static struct flash_platform_data intcp_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data intcp_flash_data = {
 	.width		= 4,
-	.init		= intcp_flash_init,
-	.exit		= intcp_flash_exit,
 	.set_vpp	= intcp_flash_set_vpp,
 };
 
@@ -364,7 +341,7 @@ static struct resource intcp_flash_resource = {
 };
 
 static struct platform_device intcp_flash_device = {
-	.name		= "armflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &intcp_flash_data,
-- 
1.7.0.4
