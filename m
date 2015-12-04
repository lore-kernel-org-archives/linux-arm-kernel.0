From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  4 Dec 2015 18:56:02 +0100
Subject: [PATCH v2] ARM: at91: fix pinctrl driver selection
Message-ID: <1449251762-11666-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Move the selection of the pinctrl driver to SoC family level since we
have two pinctrl drivers. It is useless to select one which is not
compatible with the SoC.

[abelloni: fixed pm.c when only sama2d2 is selected]
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Changes in v2:
 - use CONFIG_PINCTRL_AT91 properly


 arch/arm/mach-at91/Kconfig | 6 +++++-
 arch/arm/mach-at91/pm.c    | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 92673006e55c..28656c2b54a0 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -4,7 +4,6 @@ menuconfig ARCH_AT91
 	select ARCH_REQUIRE_GPIOLIB
 	select COMMON_CLK_AT91
 	select PINCTRL
-	select PINCTRL_AT91
 	select SOC_BUS
 
 if ARCH_AT91
@@ -17,6 +16,7 @@ config SOC_SAMA5D2
 	select HAVE_AT91_USB_CLK
 	select HAVE_AT91_H32MX
 	select HAVE_AT91_GENERATED_CLK
+	select PINCTRL_AT91PIO4
 	help
 	  Select this if ou are using one of Atmel's SAMA5D2 family SoC.
 
@@ -27,6 +27,7 @@ config SOC_SAMA5D3
 	select HAVE_AT91_UTMI
 	select HAVE_AT91_SMD
 	select HAVE_AT91_USB_CLK
+	select PINCTRL_AT91
 	help
 	  Select this if you are using one of Atmel's SAMA5D3 family SoC.
 	  This support covers SAMA5D31, SAMA5D33, SAMA5D34, SAMA5D35, SAMA5D36.
@@ -40,6 +41,7 @@ config SOC_SAMA5D4
 	select HAVE_AT91_SMD
 	select HAVE_AT91_USB_CLK
 	select HAVE_AT91_H32MX
+	select PINCTRL_AT91
 	help
 	  Select this if you are using one of Atmel's SAMA5D4 family SoC.
 
@@ -50,6 +52,7 @@ config SOC_AT91RM9200
 	select CPU_ARM920T
 	select HAVE_AT91_USB_CLK
 	select MIGHT_HAVE_PCI
+	select PINCTRL_AT91
 	select SOC_SAM_V4_V5
 	select SRAM if PM
 	help
@@ -65,6 +68,7 @@ config SOC_AT91SAM9
 	select HAVE_AT91_UTMI
 	select HAVE_FB_ATMEL
 	select MEMORY
+	select PINCTRL_AT91
 	select SOC_SAM_V4_V5
 	select SRAM if PM
 	help
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 80e277cfcc8b..23726fb31741 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -41,8 +41,10 @@
  * implementation should be moved down into the pinctrl driver and get
  * called as part of the generic suspend/resume path.
  */
+#ifdef CONFIG_PINCTRL_AT91
 extern void at91_pinctrl_gpio_suspend(void);
 extern void at91_pinctrl_gpio_resume(void);
+#endif
 
 static struct {
 	unsigned long uhp_udp_mask;
@@ -151,8 +153,9 @@ static void at91_pm_suspend(suspend_state_t state)
 
 static int at91_pm_enter(suspend_state_t state)
 {
+#ifdef CONFIG_PINCTRL_AT91
 	at91_pinctrl_gpio_suspend();
-
+#endif
 	switch (state) {
 	/*
 	 * Suspend-to-RAM is like STANDBY plus slow clock mode, so
@@ -192,7 +195,9 @@ static int at91_pm_enter(suspend_state_t state)
 error:
 	target_state = PM_SUSPEND_ON;
 
+#ifdef CONFIG_PINCTRL_AT91
 	at91_pinctrl_gpio_resume();
+#endif
 	return 0;
 }
 
-- 
2.5.0
