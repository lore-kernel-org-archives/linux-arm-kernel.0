From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  1 Aug 2018 12:00:21 +0200
Subject: [PATCH 3/5] meson: pinctrl-gxbb: add support for TEST_N pin
In-Reply-To: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1533117623-27856-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GXBB SoCs needs a Secure Monitor call to set the TEST_N
direction, add a special bank to support this pin.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 2c97a2e0..c0954be 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -15,6 +15,7 @@
 #include <dt-bindings/gpio/meson-gxbb-gpio.h>
 #include "pinctrl-meson.h"
 #include "pinctrl-meson8-pmx.h"
+#include <linux/firmware/meson/meson_sm.h>
 
 static const struct pinctrl_pin_desc meson_gxbb_periphs_pins[] = {
 	MESON_PIN(GPIOZ_0),
@@ -823,6 +824,9 @@ static struct meson_bank meson_gxbb_periphs_banks[] = {
 static struct meson_bank meson_gxbb_aobus_banks[] = {
 	/*   name    first      last       irq    pullen  pull    dir     out     in  */
 	BANK("AO",   GPIOAO_0,  GPIOAO_13, 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/* This PIN Direction must be set using a SMC call, so dir reg offset is the sm call */
+	BANK_SMC("TEST", GPIO_TEST_N, GPIO_TEST_N,
+					 -1, -1, 0, 30,  0, 14, SM_TEST_N_DIR, 1, 0, 31, 1, 31),
 };
 
 static struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data = {
-- 
2.7.4
