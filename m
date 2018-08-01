From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  1 Aug 2018 12:00:23 +0200
Subject: [PATCH 5/5] meson: pinctrl-axg: add support for TEST_N pin
In-Reply-To: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1533117623-27856-6-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson AXG SoCs needs a Secure Monitor call to set the TEST_N
direction, add a special bank to support this pin.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-axg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 46a0918..12615d8 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/meson-axg-gpio.h>
 #include "pinctrl-meson.h"
 #include "pinctrl-meson-axg-pmx.h"
+#include <linux/firmware/meson/meson_sm.h>
 
 static const struct pinctrl_pin_desc meson_axg_periphs_pins[] = {
 	MESON_PIN(GPIOZ_0),
@@ -1006,6 +1007,9 @@ static struct meson_bank meson_axg_periphs_banks[] = {
 static struct meson_bank meson_axg_aobus_banks[] = {
 	/*   name    first      last      irq	pullen  pull    dir     out     in  */
 	BANK("AO",   GPIOAO_0,  GPIOAO_13, 0, 13, 0,  16,  0, 0,  0,  0,  0, 16,  1,  0),
+	/* This PIN Direction must be set using a SMC call, so dir reg offset is the sm call */
+	BANK_SMC("TEST", GPIO_TEST_N, GPIO_TEST_N,
+					 -1, -1, 0, 30,  0, 14, SM_TEST_N_DIR, 1, 0, 31, 1, 31),
 };
 
 static struct meson_pmx_bank meson_axg_periphs_pmx_banks[] = {
-- 
2.7.4
