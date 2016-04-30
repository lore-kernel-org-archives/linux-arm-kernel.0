From: carlo@caione.org (Carlo Caione)
Date: Sat, 30 Apr 2016 19:21:14 +0200
Subject: [PATCH 1/2] pinctrl: amlogic: Add support for Amlogic Meson GXBB SoC
In-Reply-To: <1462036875-22625-1-git-send-email-carlo@caione.org>
References: <1462036875-22625-1-git-send-email-carlo@caione.org>
Message-ID: <1462036875-22625-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This patch adds the basic platform file to support the pin controller
found on the Amlogic Meson GXBB SoCs.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   2 +
 arch/arm64/Kconfig.platforms                       |   2 +
 drivers/pinctrl/meson/Makefile                     |   2 +-
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c         | 432 +++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.c              |   8 +
 drivers/pinctrl/meson/pinctrl-meson.h              |   2 +
 include/dt-bindings/gpio/meson-gxbb-gpio.h         | 154 ++++++++
 7 files changed, 601 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-gxbb.c
 create mode 100644 include/dt-bindings/gpio/meson-gxbb-gpio.h

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index 32f4a2d..fe7fe0b 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -5,6 +5,8 @@ Required properties for the root node:
 		      "amlogic,meson8b-cbus-pinctrl"
 		      "amlogic,meson8-aobus-pinctrl"
 		      "amlogic,meson8b-aobus-pinctrl"
+		      "amlogic,meson-gxbb-periphs-pinctrl"
+		      "amlogic,meson-gxbb-aobus-pinctrl"
  - reg: address and size of registers controlling irq functionality
 
 === GPIO sub-nodes ===
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 9fbc3e6..21e26e6 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -58,6 +58,8 @@ config ARCH_MEDIATEK
 
 config ARCH_MESON
 	bool "Amlogic Platforms"
+	select PINCTRL
+	select PINCTRL_MESON
 	help
 	  This enables support for the Amlogic S905 SoCs.
 
diff --git a/drivers/pinctrl/meson/Makefile b/drivers/pinctrl/meson/Makefile
index c751d22..24434f1 100644
--- a/drivers/pinctrl/meson/Makefile
+++ b/drivers/pinctrl/meson/Makefile
@@ -1,2 +1,2 @@
-obj-y	+= pinctrl-meson8.o pinctrl-meson8b.o
+obj-y	+= pinctrl-meson8.o pinctrl-meson8b.o pinctrl-meson-gxbb.o
 obj-y	+= pinctrl-meson.o
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
new file mode 100644
index 0000000..eeabafb
--- /dev/null
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -0,0 +1,432 @@
+/*
+ * Pin controller and GPIO driver for Amlogic Meson GXBB.
+ *
+ * Copyright (C) 2016 Endless Mobile, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <dt-bindings/gpio/meson-gxbb-gpio.h>
+#include "pinctrl-meson.h"
+
+#define EE_OFF	14
+
+static const struct pinctrl_pin_desc meson_gxbb_periphs_pins[] = {
+	MESON_PIN(GPIOZ_0, EE_OFF),
+	MESON_PIN(GPIOZ_1, EE_OFF),
+	MESON_PIN(GPIOZ_2, EE_OFF),
+	MESON_PIN(GPIOZ_3, EE_OFF),
+	MESON_PIN(GPIOZ_4, EE_OFF),
+	MESON_PIN(GPIOZ_5, EE_OFF),
+	MESON_PIN(GPIOZ_6, EE_OFF),
+	MESON_PIN(GPIOZ_7, EE_OFF),
+	MESON_PIN(GPIOZ_8, EE_OFF),
+	MESON_PIN(GPIOZ_9, EE_OFF),
+	MESON_PIN(GPIOZ_10, EE_OFF),
+	MESON_PIN(GPIOZ_11, EE_OFF),
+	MESON_PIN(GPIOZ_12, EE_OFF),
+	MESON_PIN(GPIOZ_13, EE_OFF),
+	MESON_PIN(GPIOZ_14, EE_OFF),
+	MESON_PIN(GPIOZ_15, EE_OFF),
+
+	MESON_PIN(GPIOH_0, EE_OFF),
+	MESON_PIN(GPIOH_1, EE_OFF),
+	MESON_PIN(GPIOH_2, EE_OFF),
+	MESON_PIN(GPIOH_3, EE_OFF),
+
+	MESON_PIN(BOOT_0, EE_OFF),
+	MESON_PIN(BOOT_1, EE_OFF),
+	MESON_PIN(BOOT_2, EE_OFF),
+	MESON_PIN(BOOT_3, EE_OFF),
+	MESON_PIN(BOOT_4, EE_OFF),
+	MESON_PIN(BOOT_5, EE_OFF),
+	MESON_PIN(BOOT_6, EE_OFF),
+	MESON_PIN(BOOT_7, EE_OFF),
+	MESON_PIN(BOOT_8, EE_OFF),
+	MESON_PIN(BOOT_9, EE_OFF),
+	MESON_PIN(BOOT_10, EE_OFF),
+	MESON_PIN(BOOT_11, EE_OFF),
+	MESON_PIN(BOOT_12, EE_OFF),
+	MESON_PIN(BOOT_13, EE_OFF),
+	MESON_PIN(BOOT_14, EE_OFF),
+	MESON_PIN(BOOT_15, EE_OFF),
+	MESON_PIN(BOOT_16, EE_OFF),
+	MESON_PIN(BOOT_17, EE_OFF),
+
+	MESON_PIN(CARD_0, EE_OFF),
+	MESON_PIN(CARD_1, EE_OFF),
+	MESON_PIN(CARD_2, EE_OFF),
+	MESON_PIN(CARD_3, EE_OFF),
+	MESON_PIN(CARD_4, EE_OFF),
+	MESON_PIN(CARD_5, EE_OFF),
+	MESON_PIN(CARD_6, EE_OFF),
+
+	MESON_PIN(GPIODV_0, EE_OFF),
+	MESON_PIN(GPIODV_1, EE_OFF),
+	MESON_PIN(GPIODV_2, EE_OFF),
+	MESON_PIN(GPIODV_3, EE_OFF),
+	MESON_PIN(GPIODV_4, EE_OFF),
+	MESON_PIN(GPIODV_5, EE_OFF),
+	MESON_PIN(GPIODV_6, EE_OFF),
+	MESON_PIN(GPIODV_7, EE_OFF),
+	MESON_PIN(GPIODV_8, EE_OFF),
+	MESON_PIN(GPIODV_9, EE_OFF),
+	MESON_PIN(GPIODV_10, EE_OFF),
+	MESON_PIN(GPIODV_11, EE_OFF),
+	MESON_PIN(GPIODV_12, EE_OFF),
+	MESON_PIN(GPIODV_13, EE_OFF),
+	MESON_PIN(GPIODV_14, EE_OFF),
+	MESON_PIN(GPIODV_15, EE_OFF),
+	MESON_PIN(GPIODV_16, EE_OFF),
+	MESON_PIN(GPIODV_17, EE_OFF),
+	MESON_PIN(GPIODV_19, EE_OFF),
+	MESON_PIN(GPIODV_20, EE_OFF),
+	MESON_PIN(GPIODV_21, EE_OFF),
+	MESON_PIN(GPIODV_22, EE_OFF),
+	MESON_PIN(GPIODV_23, EE_OFF),
+	MESON_PIN(GPIODV_24, EE_OFF),
+	MESON_PIN(GPIODV_25, EE_OFF),
+	MESON_PIN(GPIODV_26, EE_OFF),
+	MESON_PIN(GPIODV_27, EE_OFF),
+	MESON_PIN(GPIODV_28, EE_OFF),
+	MESON_PIN(GPIODV_29, EE_OFF),
+
+	MESON_PIN(GPIOY_0, EE_OFF),
+	MESON_PIN(GPIOY_1, EE_OFF),
+	MESON_PIN(GPIOY_2, EE_OFF),
+	MESON_PIN(GPIOY_3, EE_OFF),
+	MESON_PIN(GPIOY_4, EE_OFF),
+	MESON_PIN(GPIOY_5, EE_OFF),
+	MESON_PIN(GPIOY_6, EE_OFF),
+	MESON_PIN(GPIOY_7, EE_OFF),
+	MESON_PIN(GPIOY_8, EE_OFF),
+	MESON_PIN(GPIOY_9, EE_OFF),
+	MESON_PIN(GPIOY_10, EE_OFF),
+	MESON_PIN(GPIOY_11, EE_OFF),
+	MESON_PIN(GPIOY_12, EE_OFF),
+	MESON_PIN(GPIOY_13, EE_OFF),
+	MESON_PIN(GPIOY_14, EE_OFF),
+	MESON_PIN(GPIOY_15, EE_OFF),
+	MESON_PIN(GPIOY_16, EE_OFF),
+
+	MESON_PIN(GPIOX_0, EE_OFF),
+	MESON_PIN(GPIOX_1, EE_OFF),
+	MESON_PIN(GPIOX_2, EE_OFF),
+	MESON_PIN(GPIOX_3, EE_OFF),
+	MESON_PIN(GPIOX_4, EE_OFF),
+	MESON_PIN(GPIOX_5, EE_OFF),
+	MESON_PIN(GPIOX_6, EE_OFF),
+	MESON_PIN(GPIOX_7, EE_OFF),
+	MESON_PIN(GPIOX_8, EE_OFF),
+	MESON_PIN(GPIOX_9, EE_OFF),
+	MESON_PIN(GPIOX_10, EE_OFF),
+	MESON_PIN(GPIOX_11, EE_OFF),
+	MESON_PIN(GPIOX_12, EE_OFF),
+	MESON_PIN(GPIOX_13, EE_OFF),
+	MESON_PIN(GPIOX_14, EE_OFF),
+	MESON_PIN(GPIOX_15, EE_OFF),
+	MESON_PIN(GPIOX_16, EE_OFF),
+	MESON_PIN(GPIOX_17, EE_OFF),
+	MESON_PIN(GPIOX_18, EE_OFF),
+	MESON_PIN(GPIOX_19, EE_OFF),
+	MESON_PIN(GPIOX_20, EE_OFF),
+	MESON_PIN(GPIOX_21, EE_OFF),
+	MESON_PIN(GPIOX_22, EE_OFF),
+
+	MESON_PIN(GPIOCLK_0, EE_OFF),
+	MESON_PIN(GPIOCLK_1, EE_OFF),
+	MESON_PIN(GPIOCLK_2, EE_OFF),
+	MESON_PIN(GPIOCLK_3, EE_OFF),
+
+	MESON_PIN(GPIO_TEST_N, EE_OFF),
+};
+
+static const struct pinctrl_pin_desc meson_gxbb_aobus_pins[] = {
+	MESON_PIN(GPIOAO_0, 0),
+	MESON_PIN(GPIOAO_1, 0),
+	MESON_PIN(GPIOAO_2, 0),
+	MESON_PIN(GPIOAO_3, 0),
+	MESON_PIN(GPIOAO_4, 0),
+	MESON_PIN(GPIOAO_5, 0),
+	MESON_PIN(GPIOAO_6, 0),
+	MESON_PIN(GPIOAO_7, 0),
+	MESON_PIN(GPIOAO_8, 0),
+	MESON_PIN(GPIOAO_9, 0),
+	MESON_PIN(GPIOAO_10, 0),
+	MESON_PIN(GPIOAO_11, 0),
+	MESON_PIN(GPIOAO_12, 0),
+	MESON_PIN(GPIOAO_13, 0),
+};
+
+static const unsigned int uart_tx_ao_a_pins[]	= { PIN(GPIOAO_0, 0) };
+static const unsigned int uart_rx_ao_a_pins[]	= { PIN(GPIOAO_1, 0) };
+static const unsigned int uart_cts_ao_a_pins[]	= { PIN(GPIOAO_2, 0) };
+static const unsigned int uart_rts_ao_a_pins[]	= { PIN(GPIOAO_3, 0) };
+
+static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
+	GPIO_GROUP(GPIOZ_0, EE_OFF),
+	GPIO_GROUP(GPIOZ_1, EE_OFF),
+	GPIO_GROUP(GPIOZ_2, EE_OFF),
+	GPIO_GROUP(GPIOZ_3, EE_OFF),
+	GPIO_GROUP(GPIOZ_4, EE_OFF),
+	GPIO_GROUP(GPIOZ_5, EE_OFF),
+	GPIO_GROUP(GPIOZ_6, EE_OFF),
+	GPIO_GROUP(GPIOZ_7, EE_OFF),
+	GPIO_GROUP(GPIOZ_8, EE_OFF),
+	GPIO_GROUP(GPIOZ_9, EE_OFF),
+	GPIO_GROUP(GPIOZ_10, EE_OFF),
+	GPIO_GROUP(GPIOZ_11, EE_OFF),
+	GPIO_GROUP(GPIOZ_12, EE_OFF),
+	GPIO_GROUP(GPIOZ_13, EE_OFF),
+	GPIO_GROUP(GPIOZ_14, EE_OFF),
+	GPIO_GROUP(GPIOZ_15, EE_OFF),
+
+	GPIO_GROUP(GPIOH_0, EE_OFF),
+	GPIO_GROUP(GPIOH_1, EE_OFF),
+	GPIO_GROUP(GPIOH_2, EE_OFF),
+	GPIO_GROUP(GPIOH_3, EE_OFF),
+
+	GPIO_GROUP(BOOT_0, EE_OFF),
+	GPIO_GROUP(BOOT_1, EE_OFF),
+	GPIO_GROUP(BOOT_2, EE_OFF),
+	GPIO_GROUP(BOOT_3, EE_OFF),
+	GPIO_GROUP(BOOT_4, EE_OFF),
+	GPIO_GROUP(BOOT_5, EE_OFF),
+	GPIO_GROUP(BOOT_6, EE_OFF),
+	GPIO_GROUP(BOOT_7, EE_OFF),
+	GPIO_GROUP(BOOT_8, EE_OFF),
+	GPIO_GROUP(BOOT_9, EE_OFF),
+	GPIO_GROUP(BOOT_10, EE_OFF),
+	GPIO_GROUP(BOOT_11, EE_OFF),
+	GPIO_GROUP(BOOT_12, EE_OFF),
+	GPIO_GROUP(BOOT_13, EE_OFF),
+	GPIO_GROUP(BOOT_14, EE_OFF),
+	GPIO_GROUP(BOOT_15, EE_OFF),
+	GPIO_GROUP(BOOT_16, EE_OFF),
+	GPIO_GROUP(BOOT_17, EE_OFF),
+
+	GPIO_GROUP(CARD_0, EE_OFF),
+	GPIO_GROUP(CARD_1, EE_OFF),
+	GPIO_GROUP(CARD_2, EE_OFF),
+	GPIO_GROUP(CARD_3, EE_OFF),
+	GPIO_GROUP(CARD_4, EE_OFF),
+	GPIO_GROUP(CARD_5, EE_OFF),
+	GPIO_GROUP(CARD_6, EE_OFF),
+
+	GPIO_GROUP(GPIODV_0, EE_OFF),
+	GPIO_GROUP(GPIODV_1, EE_OFF),
+	GPIO_GROUP(GPIODV_2, EE_OFF),
+	GPIO_GROUP(GPIODV_3, EE_OFF),
+	GPIO_GROUP(GPIODV_4, EE_OFF),
+	GPIO_GROUP(GPIODV_5, EE_OFF),
+	GPIO_GROUP(GPIODV_6, EE_OFF),
+	GPIO_GROUP(GPIODV_7, EE_OFF),
+	GPIO_GROUP(GPIODV_8, EE_OFF),
+	GPIO_GROUP(GPIODV_9, EE_OFF),
+	GPIO_GROUP(GPIODV_10, EE_OFF),
+	GPIO_GROUP(GPIODV_11, EE_OFF),
+	GPIO_GROUP(GPIODV_12, EE_OFF),
+	GPIO_GROUP(GPIODV_13, EE_OFF),
+	GPIO_GROUP(GPIODV_14, EE_OFF),
+	GPIO_GROUP(GPIODV_15, EE_OFF),
+	GPIO_GROUP(GPIODV_16, EE_OFF),
+	GPIO_GROUP(GPIODV_17, EE_OFF),
+	GPIO_GROUP(GPIODV_19, EE_OFF),
+	GPIO_GROUP(GPIODV_20, EE_OFF),
+	GPIO_GROUP(GPIODV_21, EE_OFF),
+	GPIO_GROUP(GPIODV_22, EE_OFF),
+	GPIO_GROUP(GPIODV_23, EE_OFF),
+	GPIO_GROUP(GPIODV_24, EE_OFF),
+	GPIO_GROUP(GPIODV_25, EE_OFF),
+	GPIO_GROUP(GPIODV_26, EE_OFF),
+	GPIO_GROUP(GPIODV_27, EE_OFF),
+	GPIO_GROUP(GPIODV_28, EE_OFF),
+	GPIO_GROUP(GPIODV_29, EE_OFF),
+
+	GPIO_GROUP(GPIOY_0, EE_OFF),
+	GPIO_GROUP(GPIOY_1, EE_OFF),
+	GPIO_GROUP(GPIOY_2, EE_OFF),
+	GPIO_GROUP(GPIOY_3, EE_OFF),
+	GPIO_GROUP(GPIOY_4, EE_OFF),
+	GPIO_GROUP(GPIOY_5, EE_OFF),
+	GPIO_GROUP(GPIOY_6, EE_OFF),
+	GPIO_GROUP(GPIOY_7, EE_OFF),
+	GPIO_GROUP(GPIOY_8, EE_OFF),
+	GPIO_GROUP(GPIOY_9, EE_OFF),
+	GPIO_GROUP(GPIOY_10, EE_OFF),
+	GPIO_GROUP(GPIOY_11, EE_OFF),
+	GPIO_GROUP(GPIOY_12, EE_OFF),
+	GPIO_GROUP(GPIOY_13, EE_OFF),
+	GPIO_GROUP(GPIOY_14, EE_OFF),
+	GPIO_GROUP(GPIOY_15, EE_OFF),
+	GPIO_GROUP(GPIOY_16, EE_OFF),
+
+	GPIO_GROUP(GPIOX_0, EE_OFF),
+	GPIO_GROUP(GPIOX_1, EE_OFF),
+	GPIO_GROUP(GPIOX_2, EE_OFF),
+	GPIO_GROUP(GPIOX_3, EE_OFF),
+	GPIO_GROUP(GPIOX_4, EE_OFF),
+	GPIO_GROUP(GPIOX_5, EE_OFF),
+	GPIO_GROUP(GPIOX_6, EE_OFF),
+	GPIO_GROUP(GPIOX_7, EE_OFF),
+	GPIO_GROUP(GPIOX_8, EE_OFF),
+	GPIO_GROUP(GPIOX_9, EE_OFF),
+	GPIO_GROUP(GPIOX_10, EE_OFF),
+	GPIO_GROUP(GPIOX_11, EE_OFF),
+	GPIO_GROUP(GPIOX_12, EE_OFF),
+	GPIO_GROUP(GPIOX_13, EE_OFF),
+	GPIO_GROUP(GPIOX_14, EE_OFF),
+	GPIO_GROUP(GPIOX_15, EE_OFF),
+	GPIO_GROUP(GPIOX_16, EE_OFF),
+	GPIO_GROUP(GPIOX_17, EE_OFF),
+	GPIO_GROUP(GPIOX_18, EE_OFF),
+	GPIO_GROUP(GPIOX_19, EE_OFF),
+	GPIO_GROUP(GPIOX_20, EE_OFF),
+	GPIO_GROUP(GPIOX_21, EE_OFF),
+	GPIO_GROUP(GPIOX_22, EE_OFF),
+
+	GPIO_GROUP(GPIOCLK_0, EE_OFF),
+	GPIO_GROUP(GPIOCLK_1, EE_OFF),
+	GPIO_GROUP(GPIOCLK_2, EE_OFF),
+	GPIO_GROUP(GPIOCLK_3, EE_OFF),
+
+	GPIO_GROUP(GPIO_TEST_N, EE_OFF),
+};
+
+static struct meson_pmx_group meson_gxbb_aobus_groups[] = {
+	GPIO_GROUP(GPIOAO_0, 0),
+	GPIO_GROUP(GPIOAO_1, 0),
+	GPIO_GROUP(GPIOAO_2, 0),
+	GPIO_GROUP(GPIOAO_3, 0),
+	GPIO_GROUP(GPIOAO_4, 0),
+	GPIO_GROUP(GPIOAO_5, 0),
+	GPIO_GROUP(GPIOAO_6, 0),
+	GPIO_GROUP(GPIOAO_7, 0),
+	GPIO_GROUP(GPIOAO_8, 0),
+	GPIO_GROUP(GPIOAO_9, 0),
+	GPIO_GROUP(GPIOAO_10, 0),
+	GPIO_GROUP(GPIOAO_11, 0),
+	GPIO_GROUP(GPIOAO_12, 0),
+	GPIO_GROUP(GPIOAO_13, 0),
+
+	/* bank AO */
+	GROUP(uart_tx_ao_a,	0,	12),
+	GROUP(uart_rx_ao_a,	0,	11),
+	GROUP(uart_cts_ao_a,	0,	10),
+	GROUP(uart_rts_ao_a,	0,	9),
+};
+
+static const char * const gpio_periphs_groups[] = {
+	"GPIOZ_0", "GPIOZ_1", "GPIOZ_2", "GPIOZ_3", "GPIOZ_4",
+	"GPIOZ_5", "GPIOZ_6", "GPIOZ_7", "GPIOZ_8", "GPIOZ_9",
+	"GPIOZ_10", "GPIOZ_11", "GPIOZ_12", "GPIOZ_13", "GPIOZ_14",
+	"GPIOZ_15",
+
+	"GPIOH_0", "GPIOH_1", "GPIOH_2", "GPIOH_3",
+
+	"BOOT_0", "BOOT_1", "BOOT_2", "BOOT_3", "BOOT_4",
+	"BOOT_5", "BOOT_6", "BOOT_7", "BOOT_8", "BOOT_9",
+	"BOOT_10", "BOOT_11", "BOOT_12", "BOOT_13", "BOOT_14",
+	"BOOT_15", "BOOT_16", "BOOT_17",
+
+	"CARD_0", "CARD_1", "CARD_2", "CARD_3", "CARD_4",
+	"CARD_5", "CARD_6",
+
+	"GPIODV_0", "GPIODV_1", "GPIODV_2", "GPIODV_3", "GPIODV_4",
+	"GPIODV_5", "GPIODV_6", "GPIODV_7", "GPIODV_8", "GPIODV_9",
+	"GPIODV_10", "GPIODV_11", "GPIODV_12", "GPIODV_13", "GPIODV_14",
+	"GPIODV_15", "GPIODV_16", "GPIODV_17", "GPIODV_18", "GPIODV_19",
+	"GPIODV_20", "GPIODV_21", "GPIODV_22", "GPIODV_23", "GPIODV_24",
+	"GPIODV_25", "GPIODV_26", "GPIODV_27", "GPIODV_28", "GPIODV_29",
+
+	"GPIOY_0", "GPIOY_1", "GPIOY_2", "GPIOY_3", "GPIOY_4",
+	"GPIOY_5", "GPIOY_6", "GPIOY_7", "GPIOY_8", "GPIOY_9",
+	"GPIOY_10", "GPIOY_11", "GPIOY_12", "GPIOY_13", "GPIOY_14",
+	"GPIOY_15", "GPIOY_16",
+
+	"GPIOX_0", "GPIOX_1", "GPIOX_2", "GPIOX_3", "GPIOX_4",
+	"GPIOX_5", "GPIOX_6", "GPIOX_7", "GPIOX_8", "GPIOX_9",
+	"GPIOX_10", "GPIOX_11", "GPIOX_12", "GPIOX_13", "GPIOX_14",
+	"GPIOX_15", "GPIOX_16", "GPIOX_17", "GPIOX_18", "GPIOX_19",
+	"GPIOX_20", "GPIOX_21", "GPIOX_22",
+
+	"GPIO_TEST_N",
+};
+
+static const char * const gpio_aobus_groups[] = {
+	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
+	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
+	"GPIOAO_10", "GPIOAO_11", "GPIOAO_12", "GPIOAO_13",
+};
+
+static const char * const uart_ao_groups[] = {
+	"uart_tx_ao_a", "uart_rx_ao_a", "uart_cts_ao_a", "uart_rts_ao_a"
+};
+
+static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
+	FUNCTION(gpio_periphs),
+};
+
+static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
+	FUNCTION(gpio_aobus),
+	FUNCTION(uart_ao),
+};
+
+static struct meson_bank meson_gxbb_periphs_banks[] = {
+	/*   name    first                      last                    pullen  pull    dir     out     in  */
+	BANK("X",    PIN(GPIOX_0, EE_OFF),	PIN(GPIOX_22, EE_OFF),  4,  0,  4,  0,  12, 0,  13, 0,  14, 0),
+	BANK("Y",    PIN(GPIOY_0, EE_OFF),	PIN(GPIOY_16, EE_OFF),  1,  0,  1,  0,  3,  0,  4,  0,  5,  0),
+	BANK("DV",   PIN(GPIODV_0, EE_OFF),	PIN(GPIODV_29, EE_OFF), 0,  0,  0,  0,  0,  0,  1,  0,  2,  0),
+	BANK("H",    PIN(GPIOH_0, EE_OFF),	PIN(GPIOH_3, EE_OFF),   1, 20,  1, 20,  3, 20,  4, 20,  5, 20),
+	BANK("Z",    PIN(GPIOZ_0, EE_OFF),	PIN(GPIOZ_15, EE_OFF),  3,  0,  3,  0,  9,  0,  10, 0, 11,  0),
+	BANK("CARD", PIN(CARD_0, EE_OFF),	PIN(CARD_6, EE_OFF),    2, 20,  2, 20,  6, 20,  7, 20,  8, 20),
+	BANK("BOOT", PIN(BOOT_0, EE_OFF),	PIN(BOOT_17, EE_OFF),   2,  0,  2,  0,  6,  0,  7,  0,  8,  0),
+	BANK("CLK",  PIN(GPIOCLK_0, EE_OFF),	PIN(GPIOCLK_3, EE_OFF), 3, 28,  3, 28,  9, 28, 10, 28, 11, 28),
+};
+
+static struct meson_bank meson_gxbb_aobus_banks[] = {
+	/*   name    first              last               pullen  pull    dir     out     in  */
+	BANK("AO",   PIN(GPIOAO_0, 0),  PIN(GPIOAO_13, 0), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+};
+
+static struct meson_domain_data meson_gxbb_periphs_domain_data = {
+	.name		= "periphs-banks",
+	.banks		= meson_gxbb_periphs_banks,
+	.num_banks	= ARRAY_SIZE(meson_gxbb_periphs_banks),
+	.pin_base	= 14,
+	.num_pins	= 120,
+};
+
+static struct meson_domain_data meson_gxbb_aobus_domain_data = {
+	.name		= "aobus-banks",
+	.banks		= meson_gxbb_aobus_banks,
+	.num_banks	= ARRAY_SIZE(meson_gxbb_aobus_banks),
+	.pin_base	= 0,
+	.num_pins	= 14,
+};
+
+struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data = {
+	.pins		= meson_gxbb_periphs_pins,
+	.groups		= meson_gxbb_periphs_groups,
+	.funcs		= meson_gxbb_periphs_functions,
+	.domain_data	= &meson_gxbb_periphs_domain_data,
+	.num_pins	= ARRAY_SIZE(meson_gxbb_periphs_pins),
+	.num_groups	= ARRAY_SIZE(meson_gxbb_periphs_groups),
+	.num_funcs	= ARRAY_SIZE(meson_gxbb_periphs_functions),
+};
+
+struct meson_pinctrl_data meson_gxbb_aobus_pinctrl_data = {
+	.pins		= meson_gxbb_aobus_pins,
+	.groups		= meson_gxbb_aobus_groups,
+	.funcs		= meson_gxbb_aobus_functions,
+	.domain_data	= &meson_gxbb_aobus_domain_data,
+	.num_pins	= ARRAY_SIZE(meson_gxbb_aobus_pins),
+	.num_groups	= ARRAY_SIZE(meson_gxbb_aobus_groups),
+	.num_funcs	= ARRAY_SIZE(meson_gxbb_aobus_functions),
+};
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 0bdb8fd..cefb8cf 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -549,6 +549,14 @@ static const struct of_device_id meson_pinctrl_dt_match[] = {
 		.compatible = "amlogic,meson8b-aobus-pinctrl",
 		.data = &meson8b_aobus_pinctrl_data,
 	},
+	{
+		.compatible = "amlogic,meson-gxbb-periphs-pinctrl",
+		.data = &meson_gxbb_periphs_pinctrl_data,
+	},
+	{
+		.compatible = "amlogic,meson-gxbb-aobus-pinctrl",
+		.data = &meson_gxbb_aobus_pinctrl_data,
+	},
 	{ },
 };
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 9c93e0d..d89442e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -199,3 +199,5 @@ extern struct meson_pinctrl_data meson8_cbus_pinctrl_data;
 extern struct meson_pinctrl_data meson8_aobus_pinctrl_data;
 extern struct meson_pinctrl_data meson8b_cbus_pinctrl_data;
 extern struct meson_pinctrl_data meson8b_aobus_pinctrl_data;
+extern struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data;
+extern struct meson_pinctrl_data meson_gxbb_aobus_pinctrl_data;
diff --git a/include/dt-bindings/gpio/meson-gxbb-gpio.h b/include/dt-bindings/gpio/meson-gxbb-gpio.h
new file mode 100644
index 0000000..58654fd
--- /dev/null
+++ b/include/dt-bindings/gpio/meson-gxbb-gpio.h
@@ -0,0 +1,154 @@
+/*
+ * GPIO definitions for Amlogic Meson GXBB SoCs
+ *
+ * Copyright (C) 2016 Endless Mobile, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _DT_BINDINGS_MESON_GXBB_GPIO_H
+#define _DT_BINDINGS_MESON_GXBB_GPIO_H
+
+#define	GPIOAO_0	0
+#define	GPIOAO_1	1
+#define	GPIOAO_2	2
+#define	GPIOAO_3	3
+#define	GPIOAO_4	4
+#define	GPIOAO_5	5
+#define	GPIOAO_6	6
+#define	GPIOAO_7	7
+#define	GPIOAO_8	8
+#define	GPIOAO_9	9
+#define	GPIOAO_10	10
+#define	GPIOAO_11	11
+#define	GPIOAO_12	12
+#define	GPIOAO_13	13
+
+#define	GPIOZ_0		0
+#define	GPIOZ_1		1
+#define	GPIOZ_2		2
+#define	GPIOZ_3		3
+#define	GPIOZ_4		4
+#define	GPIOZ_5		5
+#define	GPIOZ_6		6
+#define	GPIOZ_7		7
+#define	GPIOZ_8		8
+#define	GPIOZ_9		9
+#define	GPIOZ_10	10
+#define	GPIOZ_11	11
+#define	GPIOZ_12	12
+#define	GPIOZ_13	13
+#define	GPIOZ_14	14
+#define	GPIOZ_15	15
+#define	GPIOH_0		16
+#define	GPIOH_1		17
+#define	GPIOH_2		18
+#define	GPIOH_3		19
+#define	BOOT_0		20
+#define	BOOT_1		21
+#define	BOOT_2		22
+#define	BOOT_3		23
+#define	BOOT_4		24
+#define	BOOT_5		25
+#define	BOOT_6		26
+#define	BOOT_7		27
+#define	BOOT_8		28
+#define	BOOT_9		29
+#define	BOOT_10		30
+#define	BOOT_11		31
+#define	BOOT_12		32
+#define	BOOT_13		33
+#define	BOOT_14		34
+#define	BOOT_15		35
+#define	BOOT_16		36
+#define	BOOT_17		37
+#define	CARD_0		38
+#define	CARD_1		39
+#define	CARD_2		40
+#define	CARD_3		41
+#define	CARD_4		42
+#define	CARD_5		43
+#define	CARD_6		44
+#define	GPIODV_0	45
+#define	GPIODV_1	46
+#define	GPIODV_2	47
+#define	GPIODV_3	48
+#define	GPIODV_4	49
+#define	GPIODV_5	50
+#define	GPIODV_6	51
+#define	GPIODV_7	52
+#define	GPIODV_8	53
+#define	GPIODV_9	54
+#define	GPIODV_10	55
+#define	GPIODV_11	56
+#define	GPIODV_12	57
+#define	GPIODV_13	58
+#define	GPIODV_14	59
+#define	GPIODV_15	60
+#define	GPIODV_16	61
+#define	GPIODV_17	62
+#define	GPIODV_18	63
+#define	GPIODV_19	64
+#define	GPIODV_20	65
+#define	GPIODV_21	66
+#define	GPIODV_22	67
+#define	GPIODV_23	68
+#define	GPIODV_24	69
+#define	GPIODV_25	70
+#define	GPIODV_26	71
+#define	GPIODV_27	72
+#define	GPIODV_28	73
+#define	GPIODV_29	74
+#define	GPIOY_0		75
+#define	GPIOY_1		76
+#define	GPIOY_2		77
+#define	GPIOY_3		78
+#define	GPIOY_4		79
+#define	GPIOY_5		80
+#define	GPIOY_6		81
+#define	GPIOY_7		82
+#define	GPIOY_8		83
+#define	GPIOY_9		84
+#define	GPIOY_10	85
+#define	GPIOY_11	86
+#define	GPIOY_12	87
+#define	GPIOY_13	88
+#define	GPIOY_14	89
+#define	GPIOY_15	90
+#define	GPIOY_16	91
+#define	GPIOX_0		92
+#define	GPIOX_1		93
+#define	GPIOX_2		94
+#define	GPIOX_3		95
+#define	GPIOX_4		96
+#define	GPIOX_5		97
+#define	GPIOX_6		98
+#define	GPIOX_7		99
+#define	GPIOX_8		100
+#define	GPIOX_9		101
+#define	GPIOX_10	102
+#define	GPIOX_11	103
+#define	GPIOX_12	104
+#define	GPIOX_13	105
+#define	GPIOX_14	106
+#define	GPIOX_15	107
+#define	GPIOX_16	108
+#define	GPIOX_17	109
+#define	GPIOX_18	110
+#define	GPIOX_19	111
+#define	GPIOX_20	112
+#define	GPIOX_21	113
+#define	GPIOX_22	114
+#define	GPIOCLK_0	115
+#define	GPIOCLK_1	116
+#define	GPIOCLK_2	117
+#define	GPIOCLK_3	118
+#define	GPIO_TEST_N	119
+
+#endif
-- 
2.7.4
