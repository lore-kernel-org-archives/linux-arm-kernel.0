From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 May 2011 15:59:35 +0100
Subject: [PATCH v5 6/8] ARM: Integrator/CP: Use physmap driver instead of
	integrator-flash
In-Reply-To: <1305557977-16871-1-git-send-email-marc.zyngier@arm.com>
References: <1305557977-16871-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1305557977-16871-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested with an ARM-1136 core tile.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 arch/arm/mach-integrator/integrator_cp.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 9e3ce26..ec9628f 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/gfp.h>
 #include <linux/clkdev.h>
+#include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
@@ -35,7 +36,6 @@
 #include <mach/lm.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -239,7 +239,7 @@ static struct clk_lookup cp_lookups[] = {
 /*
  * Flash handling.
  */
-static int intcp_flash_init(void)
+static int intcp_flash_init(struct platform_device *dev)
 {
 	u32 val;
 
@@ -250,7 +250,7 @@ static int intcp_flash_init(void)
 	return 0;
 }
 
-static void intcp_flash_exit(void)
+static void intcp_flash_exit(struct platform_device *dev)
 {
 	u32 val;
 
@@ -259,7 +259,7 @@ static void intcp_flash_exit(void)
 	writel(val, INTCP_VA_CTRL_BASE + INTCP_FLASHPROG);
 }
 
-static void intcp_flash_set_vpp(int on)
+static void intcp_flash_set_vpp(struct map_info *map, int on)
 {
 	u32 val;
 
@@ -271,8 +271,7 @@ static void intcp_flash_set_vpp(int on)
 	writel(val, INTCP_VA_CTRL_BASE + INTCP_FLASHPROG);
 }
 
-static struct flash_platform_data intcp_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data intcp_flash_data = {
 	.width		= 4,
 	.init		= intcp_flash_init,
 	.exit		= intcp_flash_exit,
@@ -286,7 +285,7 @@ static struct resource intcp_flash_resource = {
 };
 
 static struct platform_device intcp_flash_device = {
-	.name		= "armflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &intcp_flash_data,
-- 
1.7.0.4
