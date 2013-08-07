From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:34:08 +0200
Subject: [PATCH 19/20] ARM: mmp: register static mmp_pdma device
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-20-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the init call to the properietary dma subsystem and register
the mmp_pdma device.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-mmp/mmp2.c   | 11 +++++++++--
 arch/arm/mach-mmp/pxa168.c | 11 +++++++++--
 arch/arm/mach-mmp/pxa910.c | 11 +++++++++--
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index c7592f1..b027c83 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/mmp_dma.h>
 
 #include <asm/hardware/cache-tauros2.h>
 
@@ -22,7 +23,6 @@
 #include <mach/regs-apbc.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
-#include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
 #include <mach/mmp2.h>
@@ -96,6 +96,12 @@ void __init mmp2_init_irq(void)
 	mmp2_init_icu();
 }
 
+static struct mmp_dma_platdata mmp2_dma_data __initdata = {
+	.dma_channels   = 16,
+};
+
+MMP2_DEVICE(dma, "mmp-pdma", 0, DMA_RIQ, 0x40000000, 0x2000);
+
 static int __init mmp2_init(void)
 {
 	if (cpu_is_mmp2()) {
@@ -104,7 +110,8 @@ static int __init mmp2_init(void)
 #endif
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(mmp2_addr_map);
-		pxa_init_dma(IRQ_MMP2_DMA_RIQ, 16);
+		pxa_register_device(&mmp2_device_dma, &mmp2_dma_data,
+				    sizeof(mmp2_dma_data));
 		mmp2_clk_init();
 	}
 
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 144e997..0573697 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/mv_usb.h>
+#include <linux/platform_data/mmp_dma.h>
 
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
@@ -23,7 +24,6 @@
 #include <mach/regs-apbc.h>
 #include <mach/regs-apmu.h>
 #include <mach/irqs.h>
-#include <mach/dma.h>
 #include <mach/devices.h>
 #include <mach/mfp.h>
 #include <linux/dma-mapping.h>
@@ -50,12 +50,19 @@ void __init pxa168_init_irq(void)
 	icu_init_irq();
 }
 
+static struct mmp_dma_platdata pxa168_dma_data __initdata = {
+	.dma_channels   = 32,
+};
+
+PXA168_DEVICE(dma, "mmp-pdma", 0, DMA_INT0, 0x40000000, 0x2000);
+
 static int __init pxa168_init(void)
 {
 	if (cpu_is_pxa168()) {
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(pxa168_mfp_addr_map);
-		pxa_init_dma(IRQ_PXA168_DMA_INT0, 32);
+		pxa_register_device(&pxa168_device_dma, &pxa168_dma_data,
+				    sizeof(pxa168_dma_data));
 		pxa168_clk_init();
 	}
 
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index ce6393a..69b112f 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/mmp_dma.h>
 
 #include <asm/hardware/cache-tauros2.h>
 #include <asm/mach/time.h>
@@ -20,7 +21,6 @@
 #include <mach/regs-apbc.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
-#include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
 
@@ -81,6 +81,12 @@ void __init pxa910_init_irq(void)
 	icu_init_irq();
 }
 
+static struct mmp_dma_platdata pxa910_dma_data __initdata = {
+	.dma_channels   = 32,
+};
+
+PXA910_DEVICE(dma, "mmp-pdma", 0, DMA_INT0, 0x40000000, 0x2000);
+
 static int __init pxa910_init(void)
 {
 	if (cpu_is_pxa910()) {
@@ -89,7 +95,8 @@ static int __init pxa910_init(void)
 #endif
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(pxa910_mfp_addr_map);
-		pxa_init_dma(IRQ_PXA910_DMA_INT0, 32);
+		pxa_register_device(&pxa910_device_dma, &pxa910_dma_data,
+				    sizeof(pxa910_dma_data));
 		pxa910_clk_init();
 	}
 
-- 
1.8.3.1
