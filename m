From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 15 Apr 2013 23:14:39 +0200
Subject: [PATCH v5 2/6] ARM: s3c64xx: Skip legacy EINT setup if
 pinctrl-s3c64xx driver is present
In-Reply-To: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1366060483-20342-3-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new pinctrl-s3c64xx is responsible for EINT handling on DT-enabled
platforms.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/common.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index e79ca92..866be9e 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -365,7 +365,25 @@ static void s3c_irq_demux_eint20_27(unsigned int irq, struct irq_desc *desc)
 static int __init s3c64xx_init_irq_eint(void)
 {
 	int irq;
-
+#if defined(CONFIG_PINCTRL_S3C64XX)
+	/*
+	* This gpio driver includes support for device tree support and there
+	* are platforms using it. In order to maintain compatibility with those
+	* platforms, and to allow non-dt Exynos4210 platforms to use this
+	* gpiolib support, a check is added to find out if there is a active
+	* pin-controller driver support available. If it is available, this
+	* gpiolib support is ignored and the gpiolib support available in
+	* pin-controller driver is used. This is a temporary check and will go
+	* away when all of the Exynos4210 platforms have switched to using
+	* device tree and the pin-ctrl driver.
+	*/
+	struct device_node *pctrl_np;
+
+	pctrl_np = of_find_compatible_node(NULL, NULL,
+						"samsung,s3c64xx-pinctrl");
+	if (pctrl_np && of_device_is_available(pctrl_np))
+		return -ENODEV;
+#endif
 	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(27); irq++) {
 		irq_set_chip_and_handler(irq, &s3c_irq_eint, handle_level_irq);
 		irq_set_chip_data(irq, (void *)eint_irq_to_bit(irq));
-- 
1.8.1.5
