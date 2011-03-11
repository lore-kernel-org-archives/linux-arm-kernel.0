From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 11 Mar 2011 12:23:37 +0200
Subject: [PATCH 2/8] ARM: PXA: Z2: Enable OHCI on Zipit Z2
In-Reply-To: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1299839023-16601-2-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch is based on mozzwald's work.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 7bad4f7..dde3f1c 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -40,6 +40,8 @@
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
 #include <plat/pxa27x_keypad.h>
+#include <mach/pxa27x-udc.h>
+#include <mach/ohci.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -679,6 +681,27 @@ static inline void z2_pmic_init(void) {}
 #endif
 
 /******************************************************************************
+ * USB Host (OHCI)
+ ******************************************************************************/
+static int z2_ohci_init(struct device *dev)
+{
+	/* Only Port 2 is connected
+	 * Setup USB Port 2 Output Control Register
+	*/
+	UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
+
+	return 0;
+}
+
+static struct pxaohci_platform_data z2_ohci_platform_data = {
+	.port_mode	= PMM_PERPORT_MODE,
+	.init		= z2_ohci_init,
+	.flags		= ENABLE_PORT2 | NO_OC_PROTECTION,
+	.power_on_delay	= 10,
+	.power_budget	= 500,
+};
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void __init z2_init(void)
@@ -688,6 +711,7 @@ static void __init z2_init(void)
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
+	pxa_set_ohci_info(&z2_ohci_platform_data);
 
 	z2_lcd_init();
 	z2_mmc_init();
-- 
1.7.4.1
