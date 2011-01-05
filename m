From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  5 Jan 2011 14:06:37 +0000
Subject: [PATCH 5/8] ARM: Integrator/AP: Use physmap driver instead of
	integrator-flash
In-Reply-To: <1294236400-22477-1-git-send-email-marc.zyngier@arm.com>
References: <1294236400-22477-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1294236400-22477-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-integrator/integrator_ap.c |   46 ++++++++++-------------------
 1 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 548208f..cd71e9a 100644
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
@@ -247,51 +247,37 @@ device_initcall(irq_init_sysfs);
 #define EBI_CSR1 (VA_EBI_BASE + INTEGRATOR_EBI_CSR1_OFFSET)
 #define EBI_LOCK (VA_EBI_BASE + INTEGRATOR_EBI_LOCK_OFFSET)
 
-static int ap_flash_init(void)
+static void ap_flash_set_vpp(struct map_info *map, int on)
 {
+	unsigned long reg;
+	int needs_lock;
 	u32 tmp;
 
 	writel(INTEGRATOR_SC_CTRL_nFLVPPEN | INTEGRATOR_SC_CTRL_nFLWP, SC_CTRLC);
-
-	tmp = readl(EBI_CSR1) | INTEGRATOR_EBI_WRITE_ENABLE;
-	writel(tmp, EBI_CSR1);
-
-	if (!(readl(EBI_CSR1) & INTEGRATOR_EBI_WRITE_ENABLE)) {
-		writel(0xa05f, EBI_LOCK);
-		writel(tmp, EBI_CSR1);
-		writel(0, EBI_LOCK);
+	tmp = readl(EBI_CSR1);
+
+	if (on) {
+		reg = SC_CTRLS;
+		tmp |= INTEGRATOR_EBI_WRITE_ENABLE;
+	} else {
+		reg = SC_CTRLC;
+		tmp &= ~INTEGRATOR_EBI_WRITE_ENABLE;
 	}
-	return 0;
-}
 
-static void ap_flash_exit(void)
-{
-	u32 tmp;
-
-	writel(INTEGRATOR_SC_CTRL_nFLVPPEN | INTEGRATOR_SC_CTRL_nFLWP, SC_CTRLC);
-
-	tmp = readl(EBI_CSR1) & ~INTEGRATOR_EBI_WRITE_ENABLE;
 	writel(tmp, EBI_CSR1);
 
-	if (readl(EBI_CSR1) & INTEGRATOR_EBI_WRITE_ENABLE) {
+	needs_lock = !!on ^ !!(readl(EBI_CSR1) & INTEGRATOR_EBI_WRITE_ENABLE);
+	if (needs_lock) {
 		writel(0xa05f, EBI_LOCK);
 		writel(tmp, EBI_CSR1);
 		writel(0, EBI_LOCK);
 	}
-}
-
-static void ap_flash_set_vpp(int on)
-{
-	unsigned long reg = on ? SC_CTRLS : SC_CTRLC;
 
 	writel(INTEGRATOR_SC_CTRL_nFLVPPEN, reg);
 }
 
-static struct flash_platform_data ap_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data ap_flash_data = {
 	.width		= 4,
-	.init		= ap_flash_init,
-	.exit		= ap_flash_exit,
 	.set_vpp	= ap_flash_set_vpp,
 };
 
@@ -302,7 +288,7 @@ static struct resource cfi_flash_resource = {
 };
 
 static struct platform_device cfi_flash_device = {
-	.name		= "armflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &ap_flash_data,
-- 
1.7.0.4
