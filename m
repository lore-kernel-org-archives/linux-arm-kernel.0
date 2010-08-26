From: mark.brown314@gmail.com (Mark F. Brown)
Date: Wed, 25 Aug 2010 23:51:54 -0400
Subject: [PATCH v3 1/2] pxa168: added framebuffer support code.
In-Reply-To: <1282794715-28640-1-git-send-email-mark.brown314@gmail.com>
References: <1282794715-28640-1-git-send-email-mark.brown314@gmail.com>
Message-ID: <1282794715-28640-2-git-send-email-mark.brown314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
---
 arch/arm/mach-mmp/include/mach/pxa168.h |    8 ++++++++
 arch/arm/mach-mmp/pxa168.c              |    3 +++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 27e1bc7..220738f 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -10,6 +10,7 @@ extern void __init pxa168_init_irq(void);
 #include <mach/devices.h>
 #include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
+#include <video/pxa168fb.h>
 
 extern struct pxa_device_desc pxa168_device_uart1;
 extern struct pxa_device_desc pxa168_device_uart2;
@@ -25,6 +26,7 @@ extern struct pxa_device_desc pxa168_device_ssp3;
 extern struct pxa_device_desc pxa168_device_ssp4;
 extern struct pxa_device_desc pxa168_device_ssp5;
 extern struct pxa_device_desc pxa168_device_nand;
+extern struct pxa_device_desc pxa168_device_fb;
 
 static inline int pxa168_add_uart(int id)
 {
@@ -97,4 +99,10 @@ static inline int pxa168_add_nand(struct pxa3xx_nand_platform_data *info)
 {
 	return pxa_register_device(&pxa168_device_nand, info, sizeof(*info));
 }
+
+static inline int pxa168_add_fb(struct pxa168fb_mach_info *mi)
+{
+	return pxa_register_device(&pxa168_device_fb, mi, sizeof(*mi));
+}
+
 #endif /* __ASM_MACH_PXA168_H */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 652ae66..eaebf66 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -79,6 +79,7 @@ static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
 static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);
 
 static APMU_CLK(nand, NAND, 0x01db, 208000000);
+static APMU_CLK(lcd, LCD, 0x7f, 312000000);
 
 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] = {
@@ -96,6 +97,7 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_ssp4, "pxa168-ssp.3", NULL),
 	INIT_CLKREG(&clk_ssp5, "pxa168-ssp.4", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_lcd, "pxa168-fb", NULL),
 };
 
 static int __init pxa168_init(void)
@@ -147,3 +149,4 @@ PXA168_DEVICE(ssp2, "pxa168-ssp", 1, SSP2, 0xd401c000, 0x40, 54, 55);
 PXA168_DEVICE(ssp3, "pxa168-ssp", 2, SSP3, 0xd401f000, 0x40, 56, 57);
 PXA168_DEVICE(ssp4, "pxa168-ssp", 3, SSP4, 0xd4020000, 0x40, 58, 59);
 PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
+PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
-- 
1.7.0.4
