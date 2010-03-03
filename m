From: saaguirre@ti.com (Sergio Aguirre)
Date: Wed, 3 Mar 2010 16:21:08 +0000
Subject: [PATCH] omap: Fix gpio_resume_after_retention
Message-ID: <mailman.233.1268351726.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For omap4 case, this was wrongly writing GPIO_LEVELDETECTx
registers with OMAP24XX_ offset and OMAP4_ offset.

Bug introduced in commit:

  commit 3f1686a9bfe74979c6ad538c78039730f665f77e
  Author: Tony Lindgren <tony@atomide.com>
  Date:   Mon Feb 15 09:27:25 2010 -0800

      omap: Fix gpio.c for multi-omap for omap4

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 337199e..76a347b 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2140,18 +2140,18 @@ void omap2_gpio_resume_after_retention(void)
 		if (gen) {
 			u32 old0, old1;
 
-			if (cpu_is_omap24xx() || cpu_is_omap44xx()) {
+			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 				old0 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
 				old1 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-			__raw_writel(old0 | gen, bank->base +
+				__raw_writel(old0 | gen, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
-			__raw_writel(old1 | gen, bank->base +
+				__raw_writel(old1 | gen, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-			__raw_writel(old0, bank->base +
+				__raw_writel(old0, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
-			__raw_writel(old1, bank->base +
+				__raw_writel(old1, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
 			}
 

--xkXJwpr35CY/Lc3I--
