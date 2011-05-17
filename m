From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 May 2011 14:11:14 +0100
Subject: [PATCH v6 5/8] ARM: Integrator/AP: Use physmap driver instead of
	integrator-flash
In-Reply-To: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
References: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1305637877-24436-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 arch/arm/mach-integrator/integrator_ap.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 980803f..11bd49e 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -31,6 +31,7 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
@@ -43,7 +44,6 @@
 #include <mach/lm.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -230,7 +230,7 @@ device_initcall(irq_init_sysfs);
 #define EBI_CSR1 (VA_EBI_BASE + INTEGRATOR_EBI_CSR1_OFFSET)
 #define EBI_LOCK (VA_EBI_BASE + INTEGRATOR_EBI_LOCK_OFFSET)
 
-static int ap_flash_init(void)
+static int ap_flash_init(struct platform_device *dev)
 {
 	u32 tmp;
 
@@ -247,7 +247,7 @@ static int ap_flash_init(void)
 	return 0;
 }
 
-static void ap_flash_exit(void)
+static void ap_flash_exit(struct platform_device *dev)
 {
 	u32 tmp;
 
@@ -263,15 +263,14 @@ static void ap_flash_exit(void)
 	}
 }
 
-static void ap_flash_set_vpp(int on)
+static void ap_flash_set_vpp(struct map_info *map, int on)
 {
 	void __iomem *reg = on ? SC_CTRLS : SC_CTRLC;
 
 	writel(INTEGRATOR_SC_CTRL_nFLVPPEN, reg);
 }
 
-static struct flash_platform_data ap_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data ap_flash_data = {
 	.width		= 4,
 	.init		= ap_flash_init,
 	.exit		= ap_flash_exit,
@@ -285,7 +284,7 @@ static struct resource cfi_flash_resource = {
 };
 
 static struct platform_device cfi_flash_device = {
-	.name		= "armflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &ap_flash_data,
-- 
1.7.0.4
