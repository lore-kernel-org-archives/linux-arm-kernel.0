From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat,  9 Mar 2013 18:39:38 +1300
Subject: [PATCH 6/6] arm: vt8500: Remove pinmux configuration from
 mach-vt8500/vt8500.c
In-Reply-To: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1362807578-23089-7-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new pinctrl driver and wm,pinmux property the configuration
code required for initializing the framebuffer hardware can be removed
from vt8500.c and configured in devicetree with pinctrl driver properties.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/mach-vt8500/vt8500.c |   70 +----------------------------------------
 1 file changed, 1 insertion(+), 69 deletions(-)

diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index 49e8005..b06b7fc 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -34,12 +34,8 @@
 
 #include "common.h"
 
-#define LEGACY_GPIO_BASE	0xD8110000
 #define LEGACY_PMC_BASE		0xD8130000
 
-/* Registers in GPIO Controller */
-#define VT8500_GPIO_MUX_REG	0x200
-
 /* Registers in Power Management Controller */
 #define VT8500_HCR_REG		0x12
 #define VT8500_PMSR_REG		0x60
@@ -77,71 +73,6 @@ static void vt8500_power_off(void)
 void __init vt8500_init(void)
 {
 	struct device_node *np;
-#if defined(CONFIG_FB_VT8500) || defined(CONFIG_FB_WM8505)
-	struct device_node *fb;
-	void __iomem *gpio_base;
-#endif
-
-#ifdef CONFIG_FB_VT8500
-	fb = of_find_compatible_node(NULL, NULL, "via,vt8500-fb");
-	if (fb) {
-		np = of_find_compatible_node(NULL, NULL, "via,vt8500-gpio");
-		if (np) {
-			gpio_base = of_iomap(np, 0);
-
-			if (!gpio_base)
-				pr_err("%s: of_iomap(gpio_mux) failed\n",
-								__func__);
-
-			of_node_put(np);
-		} else {
-			gpio_base = ioremap(LEGACY_GPIO_BASE, 0x1000);
-			if (!gpio_base)
-				pr_err("%s: ioremap(legacy_gpio_mux) failed\n",
-								__func__);
-		}
-		if (gpio_base) {
-			writel(readl(gpio_base + VT8500_GPIO_MUX_REG) | 1,
-				gpio_base + VT8500_GPIO_MUX_REG);
-			iounmap(gpio_base);
-		} else
-			pr_err("%s: Could not remap GPIO mux\n", __func__);
-
-		of_node_put(fb);
-	}
-#endif
-
-#ifdef CONFIG_FB_WM8505
-	fb = of_find_compatible_node(NULL, NULL, "wm,wm8505-fb");
-	if (fb) {
-		np = of_find_compatible_node(NULL, NULL, "wm,wm8505-gpio");
-		if (!np)
-			np = of_find_compatible_node(NULL, NULL,
-							"wm,wm8650-gpio");
-		if (np) {
-			gpio_base = of_iomap(np, 0);
-
-			if (!gpio_base)
-				pr_err("%s: of_iomap(gpio_mux) failed\n",
-								__func__);
-
-			of_node_put(np);
-		} else {
-			gpio_base = ioremap(LEGACY_GPIO_BASE, 0x1000);
-			if (!gpio_base)
-				pr_err("%s: ioremap(legacy_gpio_mux) failed\n",
-								__func__);
-		}
-		if (gpio_base) {
-			writel(readl(gpio_base + VT8500_GPIO_MUX_REG) |
-				0x80000000, gpio_base + VT8500_GPIO_MUX_REG);
-			iounmap(gpio_base);
-		} else
-			pr_err("%s: Could not remap GPIO mux\n", __func__);
-
-		of_node_put(fb);
-	}
-#endif
 
 	np = of_find_compatible_node(NULL, NULL, "via,vt8500-pmc");
 	if (np) {
@@ -156,6 +87,7 @@ void __init vt8500_init(void)
 		if (!pmc_base)
 			pr_err("%s:ioremap(power_off) failed\n", __func__);
 	}
+
 	if (pmc_base)
 		pm_power_off = &vt8500_power_off;
 	else
-- 
1.7.9.5
