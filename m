From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  1 Aug 2018 12:00:22 +0200
Subject: [PATCH 4/5] meson: pinctrl-gxl: add support for TEST_N pin
In-Reply-To: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1533117623-27856-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GXL & GXM SoCs needs a Secure Monitor call to set the TEST_N
direction, add a special bank to support this pin.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 7dae1d7..d4dc42f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -15,6 +15,7 @@
 #include <dt-bindings/gpio/meson-gxl-gpio.h>
 #include "pinctrl-meson.h"
 #include "pinctrl-meson8-pmx.h"
+#include <linux/firmware/meson/meson_sm.h>
 
 static const struct pinctrl_pin_desc meson_gxl_periphs_pins[] = {
 	MESON_PIN(GPIOZ_0),
@@ -808,6 +809,9 @@ static struct meson_bank meson_gxl_periphs_banks[] = {
 static struct meson_bank meson_gxl_aobus_banks[] = {
 	/*   name    first      last      irq	pullen  pull    dir     out     in  */
 	BANK("AO",   GPIOAO_0,  GPIOAO_9, 0, 9, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/* This PIN Direction must be set using a SMC call, so dir reg offset is the sm call */
+	BANK_SMC("TEST", GPIO_TEST_N, GPIO_TEST_N,
+					 -1, -1, 0, 30,  0, 14, SM_TEST_N_DIR, 1, 0, 31, 1, 31),
 };
 
 static struct meson_pinctrl_data meson_gxl_periphs_pinctrl_data = {
-- 
2.7.4
