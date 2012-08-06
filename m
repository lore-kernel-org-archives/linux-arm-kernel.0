From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Aug 2012 23:42:47 +0800
Subject: [PATCH 4/6] ARM: mxs: remove non-DT core functions
In-Reply-To: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
References: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344267769-31166-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With all board files removed, those core functions used for non-DT
boot only can be removed now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/common.h |    9 -------
 arch/arm/mach-mxs/mm.c                  |   39 -------------------------------
 2 files changed, 0 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
index de6c7ba..4dec795 100644
--- a/arch/arm/mach-mxs/include/mach/common.h
+++ b/arch/arm/mach-mxs/include/mach/common.h
@@ -17,21 +17,12 @@ extern void mxs_timer_init(int);
 extern void mxs_restart(char, const char *);
 extern int mxs_saif_clkmux_select(unsigned int clkmux);
 
-extern void mx23_soc_init(void);
 extern int mx23_clocks_init(void);
 extern void mx23_map_io(void);
-extern void mx23_init_irq(void);
 
-extern void mx28_soc_init(void);
 extern int mx28_clocks_init(void);
 extern void mx28_map_io(void);
-extern void mx28_init_irq(void);
 
 extern void icoll_init_irq(void);
 
-extern struct platform_device *mxs_add_dma(const char *devid,
-						resource_size_t base);
-extern struct platform_device *mxs_add_gpio(char *name, int id,
-					    resource_size_t iobase, int irq);
-
 #endif /* __MACH_MXS_COMMON_H__ */
diff --git a/arch/arm/mach-mxs/mm.c b/arch/arm/mach-mxs/mm.c
index dccb67a..a4294aa 100644
--- a/arch/arm/mach-mxs/mm.c
+++ b/arch/arm/mach-mxs/mm.c
@@ -13,14 +13,11 @@
 
 #include <linux/mm.h>
 #include <linux/init.h>
-#include <linux/pinctrl/machine.h>
 
 #include <asm/mach/map.h>
 
 #include <mach/mx23.h>
 #include <mach/mx28.h>
-#include <mach/common.h>
-#include <mach/iomux.h>
 
 /*
  * Define the MX23 memory map.
@@ -48,43 +45,7 @@ void __init mx23_map_io(void)
 	iotable_init(mx23_io_desc, ARRAY_SIZE(mx23_io_desc));
 }
 
-void __init mx23_init_irq(void)
-{
-	icoll_init_irq();
-}
-
 void __init mx28_map_io(void)
 {
 	iotable_init(mx28_io_desc, ARRAY_SIZE(mx28_io_desc));
 }
-
-void __init mx28_init_irq(void)
-{
-	icoll_init_irq();
-}
-
-void __init mx23_soc_init(void)
-{
-	pinctrl_provide_dummies();
-
-	mxs_add_dma("imx23-dma-apbh", MX23_APBH_DMA_BASE_ADDR);
-	mxs_add_dma("imx23-dma-apbx", MX23_APBX_DMA_BASE_ADDR);
-
-	mxs_add_gpio("imx23-gpio", 0, MX23_PINCTRL_BASE_ADDR, MX23_INT_GPIO0);
-	mxs_add_gpio("imx23-gpio", 1, MX23_PINCTRL_BASE_ADDR, MX23_INT_GPIO1);
-	mxs_add_gpio("imx23-gpio", 2, MX23_PINCTRL_BASE_ADDR, MX23_INT_GPIO2);
-}
-
-void __init mx28_soc_init(void)
-{
-	pinctrl_provide_dummies();
-
-	mxs_add_dma("imx28-dma-apbh", MX23_APBH_DMA_BASE_ADDR);
-	mxs_add_dma("imx28-dma-apbx", MX23_APBX_DMA_BASE_ADDR);
-
-	mxs_add_gpio("imx28-gpio", 0, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO0);
-	mxs_add_gpio("imx28-gpio", 1, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO1);
-	mxs_add_gpio("imx28-gpio", 2, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO2);
-	mxs_add_gpio("imx28-gpio", 3, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO3);
-	mxs_add_gpio("imx28-gpio", 4, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO4);
-}
-- 
1.7.5.4
