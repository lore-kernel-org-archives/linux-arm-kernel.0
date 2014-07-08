From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  8 Jul 2014 17:11:43 +0200
Subject: [PATCH 3/3] ARM: msm: delete dangling debug UART code
In-Reply-To: <1404832303-14850-1-git-send-email-linus.walleij@linaro.org>
References: <1404832303-14850-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1404832303-14850-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config symbols CONFIG_MSM_DEBUG_UART1 and *UART3 are used
in the Trout board code, but these symbols are not defined anywhere
in the kernel so cleaning them out.

This is not to be confused with CONFIG_DEBUG_MSM_UART1 and
CONFIG_DEBUG_MSM_UART2 which do exist.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-msm/board-trout-gpio.c | 5 -----
 arch/arm/mach-msm/board-trout.c      | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-msm/board-trout-gpio.c b/arch/arm/mach-msm/board-trout-gpio.c
index 2c25050209ce..cc3f26a64f81 100644
--- a/arch/arm/mach-msm/board-trout-gpio.c
+++ b/arch/arm/mach-msm/board-trout-gpio.c
@@ -94,13 +94,8 @@ static int trout_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	}
 
 static struct msm_gpio_chip msm_gpio_banks[] = {
-#if defined(CONFIG_MSM_DEBUG_UART1)
-	/* H2W pins <-> UART1 */
-	TROUT_GPIO_BANK("MISC2", 0x00,   TROUT_GPIO_MISC2_BASE, 0x40),
-#else
 	/* H2W pins <-> UART3, Bluetooth <-> UART1 */
 	TROUT_GPIO_BANK("MISC2", 0x00,   TROUT_GPIO_MISC2_BASE, 0x80),
-#endif
 	/* I2C pull */
 	TROUT_GPIO_BANK("MISC3", 0x02,   TROUT_GPIO_MISC3_BASE, 0x04),
 	TROUT_GPIO_BANK("MISC4", 0x04,   TROUT_GPIO_MISC4_BASE, 0),
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index f72b07de2152..96226570715f 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -87,11 +87,6 @@ static void __init trout_map_io(void)
 {
 	msm_map_common_io();
 	iotable_init(trout_io_desc, ARRAY_SIZE(trout_io_desc));
-
-#ifdef CONFIG_MSM_DEBUG_UART3
-	/* route UART3 to the "H2W" extended usb connector */
-	writeb(0x80, TROUT_CPLD_BASE + 0x00);
-#endif
 }
 
 static void __init trout_init_late(void)
-- 
1.9.3
