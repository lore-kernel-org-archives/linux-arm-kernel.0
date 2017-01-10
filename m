From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jan 2017 22:53:28 +0000
Subject: [PATCH] gpio: mvebu: fix warning when building on 64-bit
Message-ID: <E1cR5IG-0008Gw-HV@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Casting a pointer to an int is not portable, and provokes a compiler
warning.  Cast to unsigned long instead to avoid the warning.

drivers/gpio/gpio-mvebu.c: In function 'mvebu_gpio_probe':
drivers/gpio/gpio-mvebu.c:662:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
   soc_variant = (int) match->data;
                 ^

This will be needed when building gpio-mvebu for Armada 7k/8k ARM64
SoCs.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Linus,

I don't think this is necessary to push into -rc, as its not yet used
on ARM64 - GPIO support is not yet present in the DTS files, and the
Kconfig doesn't allow the driver to be built on ARM64.  Hence, please
queue for the next merge window as a low priority fix.

Thanks.

 drivers/gpio/gpio-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 1ed6132b993c..a649556ac3ca 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -659,7 +659,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 
 	match = of_match_device(mvebu_gpio_of_match, &pdev->dev);
 	if (match)
-		soc_variant = (int) match->data;
+		soc_variant = (unsigned long) match->data;
 	else
 		soc_variant = MVEBU_GPIO_SOC_VARIANT_ORION;
 
-- 
2.7.4
