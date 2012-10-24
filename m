From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Oct 2012 15:45:21 +0100
Subject: [PATCH 1/6] mfd: ab8500-core: Remove unused ab8500-gpio IRQ ranges
In-Reply-To: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
References: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1351089926-32161-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ ranges provided in ab8500-core to be passed on to the
ab8500-gpio driver are not only redundant, but they are also
causing a warning in the boot log. These IRQ ranges, like any
other MFD related IRQ resource are passed though MFD core for
automatic conversion to virtual IRQs; however, MFD core does
not support IRQ mapping of IRQ ranges. Let's just remove them.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c |   36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index d4008db..2a69dc2 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -591,38 +591,6 @@ int ab8500_suspend(struct ab8500 *ab8500)
 		return 0;
 }
 
-/* AB8500 GPIO Resources */
-static struct resource __devinitdata ab8500_gpio_resources[] = {
-	{
-		.name	= "GPIO_INT6",
-		.start	= AB8500_INT_GPIO6R,
-		.end	= AB8500_INT_GPIO41F,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-/* AB9540 GPIO Resources */
-static struct resource __devinitdata ab9540_gpio_resources[] = {
-	{
-		.name	= "GPIO_INT6",
-		.start	= AB8500_INT_GPIO6R,
-		.end	= AB8500_INT_GPIO41F,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.name	= "GPIO_INT14",
-		.start	= AB9540_INT_GPIO50R,
-		.end	= AB9540_INT_GPIO54R,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.name	= "GPIO_INT15",
-		.start	= AB9540_INT_GPIO50F,
-		.end	= AB9540_INT_GPIO54F,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
 static struct resource __devinitdata ab8500_gpadc_resources[] = {
 	{
 		.name	= "HW_CONV_END",
@@ -1065,8 +1033,6 @@ static struct mfd_cell __devinitdata ab8500_devs[] = {
 	{
 		.name = "ab8500-gpio",
 		.of_compatible = "stericsson,ab8500-gpio",
-		.num_resources = ARRAY_SIZE(ab8500_gpio_resources),
-		.resources = ab8500_gpio_resources,
 	},
 	{
 		.name = "ab8500-usb",
@@ -1083,8 +1049,6 @@ static struct mfd_cell __devinitdata ab8500_devs[] = {
 static struct mfd_cell __devinitdata ab9540_devs[] = {
 	{
 		.name = "ab8500-gpio",
-		.num_resources = ARRAY_SIZE(ab9540_gpio_resources),
-		.resources = ab9540_gpio_resources,
 	},
 	{
 		.name = "ab9540-usb",
-- 
1.7.9.5
