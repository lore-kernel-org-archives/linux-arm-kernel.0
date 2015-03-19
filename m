From: carlo@caione.org (Carlo Caione)
Date: Thu, 19 Mar 2015 22:34:10 +0100
Subject: [PATCH v3 1/3] pinctrl: Cleanup Meson8 driver
In-Reply-To: <1426800852-1235-1-git-send-email-carlo@caione.org>
References: <1426800852-1235-1-git-send-email-carlo@caione.org>
Message-ID: <1426800852-1235-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This patch introduces a new PIN macro and few small modifications to
simplify and shorten the Meson pinctrl drivers and cleanup the support
file for the AmLogic Meson8 SoC.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/pinctrl/meson/pinctrl-meson.h  |    8 +-
 drivers/pinctrl/meson/pinctrl-meson8.c | 1050 ++++++++++++++------------------
 2 files changed, 461 insertions(+), 597 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index bfea8ad..bc48c78 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -155,6 +155,8 @@ struct meson_pinctrl {
 	struct meson_domain *domains;
 };
 
+#define PIN(x, b)	(b + x)
+
 #define GROUP(grp, r, b)						\
 	{								\
 		.name = #grp,						\
@@ -165,10 +167,10 @@ struct meson_pinctrl {
 		.domain = 0,						\
 	 }
 
-#define GPIO_GROUP(gpio)						\
+#define GPIO_GROUP(gpio, b)						\
 	{								\
 		.name = #gpio,						\
-		.pins = (const unsigned int[]){ PIN_ ## gpio},		\
+		.pins = (const unsigned int[]){ PIN(gpio, b) },		\
 		.num_pins = 1,						\
 		.is_gpio = true,					\
 	 }
@@ -204,6 +206,6 @@ struct meson_pinctrl {
 		},							\
 	 }
 
-#define MESON_PIN(x) PINCTRL_PIN(PIN_ ## x, #x)
+#define MESON_PIN(x, b) PINCTRL_PIN(PIN(x, b), #x)
 
 extern struct meson_pinctrl_data meson8_pinctrl_data;
diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index f8aa3a2..7b1cc91 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -14,620 +14,482 @@
 #include <dt-bindings/gpio/meson8-gpio.h>
 #include "pinctrl-meson.h"
 
-#define AO_OFFSET	120
-
-#define PIN_GPIOX_0	GPIOX_0
-#define PIN_GPIOX_1	GPIOX_1
-#define PIN_GPIOX_2	GPIOX_2
-#define PIN_GPIOX_3	GPIOX_3
-#define PIN_GPIOX_4	GPIOX_4
-#define PIN_GPIOX_5	GPIOX_5
-#define PIN_GPIOX_6	GPIOX_6
-#define PIN_GPIOX_7	GPIOX_7
-#define PIN_GPIOX_8	GPIOX_8
-#define PIN_GPIOX_9	GPIOX_9
-#define PIN_GPIOX_10	GPIOX_10
-#define PIN_GPIOX_11	GPIOX_11
-#define PIN_GPIOX_12	GPIOX_12
-#define PIN_GPIOX_13	GPIOX_13
-#define PIN_GPIOX_14	GPIOX_14
-#define PIN_GPIOX_15	GPIOX_15
-#define PIN_GPIOX_16	GPIOX_16
-#define PIN_GPIOX_17	GPIOX_17
-#define PIN_GPIOX_18	GPIOX_18
-#define PIN_GPIOX_19	GPIOX_19
-#define PIN_GPIOX_20	GPIOX_20
-#define PIN_GPIOX_21	GPIOX_21
-#define PIN_GPIOY_0	GPIOY_0
-#define PIN_GPIOY_1	GPIOY_1
-#define PIN_GPIOY_2	GPIOY_2
-#define PIN_GPIOY_3	GPIOY_3
-#define PIN_GPIOY_4	GPIOY_4
-#define PIN_GPIOY_5	GPIOY_5
-#define PIN_GPIOY_6	GPIOY_6
-#define PIN_GPIOY_7	GPIOY_7
-#define PIN_GPIOY_8	GPIOY_8
-#define PIN_GPIOY_9	GPIOY_9
-#define PIN_GPIOY_10	GPIOY_10
-#define PIN_GPIOY_11	GPIOY_11
-#define PIN_GPIOY_12	GPIOY_12
-#define PIN_GPIOY_13	GPIOY_13
-#define PIN_GPIOY_14	GPIOY_14
-#define PIN_GPIOY_15	GPIOY_15
-#define PIN_GPIOY_16	GPIOY_16
-#define PIN_GPIODV_0	GPIODV_0
-#define PIN_GPIODV_1	GPIODV_1
-#define PIN_GPIODV_2	GPIODV_2
-#define PIN_GPIODV_3	GPIODV_3
-#define PIN_GPIODV_4	GPIODV_4
-#define PIN_GPIODV_5	GPIODV_5
-#define PIN_GPIODV_6	GPIODV_6
-#define PIN_GPIODV_7	GPIODV_7
-#define PIN_GPIODV_8	GPIODV_8
-#define PIN_GPIODV_9	GPIODV_9
-#define PIN_GPIODV_10	GPIODV_10
-#define PIN_GPIODV_11	GPIODV_11
-#define PIN_GPIODV_12	GPIODV_12
-#define PIN_GPIODV_13	GPIODV_13
-#define PIN_GPIODV_14	GPIODV_14
-#define PIN_GPIODV_15	GPIODV_15
-#define PIN_GPIODV_16	GPIODV_16
-#define PIN_GPIODV_17	GPIODV_17
-#define PIN_GPIODV_18	GPIODV_18
-#define PIN_GPIODV_19	GPIODV_19
-#define PIN_GPIODV_20	GPIODV_20
-#define PIN_GPIODV_21	GPIODV_21
-#define PIN_GPIODV_22	GPIODV_22
-#define PIN_GPIODV_23	GPIODV_23
-#define PIN_GPIODV_24	GPIODV_24
-#define PIN_GPIODV_25	GPIODV_25
-#define PIN_GPIODV_26	GPIODV_26
-#define PIN_GPIODV_27	GPIODV_27
-#define PIN_GPIODV_28	GPIODV_28
-#define PIN_GPIODV_29	GPIODV_29
-#define PIN_GPIOH_0	GPIOH_0
-#define PIN_GPIOH_1	GPIOH_1
-#define PIN_GPIOH_2	GPIOH_2
-#define PIN_GPIOH_3	GPIOH_3
-#define PIN_GPIOH_4	GPIOH_4
-#define PIN_GPIOH_5	GPIOH_5
-#define PIN_GPIOH_6	GPIOH_6
-#define PIN_GPIOH_7	GPIOH_7
-#define PIN_GPIOH_8	GPIOH_8
-#define PIN_GPIOH_9	GPIOH_9
-#define PIN_GPIOZ_0	GPIOZ_0
-#define PIN_GPIOZ_1	GPIOZ_1
-#define PIN_GPIOZ_2	GPIOZ_2
-#define PIN_GPIOZ_3	GPIOZ_3
-#define PIN_GPIOZ_4	GPIOZ_4
-#define PIN_GPIOZ_5	GPIOZ_5
-#define PIN_GPIOZ_6	GPIOZ_6
-#define PIN_GPIOZ_7	GPIOZ_7
-#define PIN_GPIOZ_8	GPIOZ_8
-#define PIN_GPIOZ_9	GPIOZ_9
-#define PIN_GPIOZ_10	GPIOZ_10
-#define PIN_GPIOZ_11	GPIOZ_11
-#define PIN_GPIOZ_12	GPIOZ_12
-#define PIN_GPIOZ_13	GPIOZ_13
-#define PIN_GPIOZ_14	GPIOZ_14
-#define PIN_CARD_0	CARD_0
-#define PIN_CARD_1	CARD_1
-#define PIN_CARD_2	CARD_2
-#define PIN_CARD_3	CARD_3
-#define PIN_CARD_4	CARD_4
-#define PIN_CARD_5	CARD_5
-#define PIN_CARD_6	CARD_6
-#define PIN_BOOT_0	BOOT_0
-#define PIN_BOOT_1	BOOT_1
-#define PIN_BOOT_2	BOOT_2
-#define PIN_BOOT_3	BOOT_3
-#define PIN_BOOT_4	BOOT_4
-#define PIN_BOOT_5	BOOT_5
-#define PIN_BOOT_6	BOOT_6
-#define PIN_BOOT_7	BOOT_7
-#define PIN_BOOT_8	BOOT_8
-#define PIN_BOOT_9	BOOT_9
-#define PIN_BOOT_10	BOOT_10
-#define PIN_BOOT_11	BOOT_11
-#define PIN_BOOT_12	BOOT_12
-#define PIN_BOOT_13	BOOT_13
-#define PIN_BOOT_14	BOOT_14
-#define PIN_BOOT_15	BOOT_15
-#define PIN_BOOT_16	BOOT_16
-#define PIN_BOOT_17	BOOT_17
-#define PIN_BOOT_18	BOOT_18
-
-#define PIN_GPIOAO_0	(AO_OFFSET + GPIOAO_0)
-#define PIN_GPIOAO_1	(AO_OFFSET + GPIOAO_1)
-#define PIN_GPIOAO_2	(AO_OFFSET + GPIOAO_2)
-#define PIN_GPIOAO_3	(AO_OFFSET + GPIOAO_3)
-#define PIN_GPIOAO_4	(AO_OFFSET + GPIOAO_4)
-#define PIN_GPIOAO_5	(AO_OFFSET + GPIOAO_5)
-#define PIN_GPIOAO_6	(AO_OFFSET + GPIOAO_6)
-#define PIN_GPIOAO_7	(AO_OFFSET + GPIOAO_7)
-#define PIN_GPIOAO_8	(AO_OFFSET + GPIOAO_8)
-#define PIN_GPIOAO_9	(AO_OFFSET + GPIOAO_9)
-#define PIN_GPIOAO_10	(AO_OFFSET + GPIOAO_10)
-#define PIN_GPIOAO_11	(AO_OFFSET + GPIOAO_11)
-#define PIN_GPIOAO_12	(AO_OFFSET + GPIOAO_12)
-#define PIN_GPIOAO_13	(AO_OFFSET + GPIOAO_13)
-#define PIN_GPIO_BSD_EN	(AO_OFFSET + GPIO_BSD_EN)
-#define PIN_GPIO_TEST_N	(AO_OFFSET + GPIO_TEST_N)
+#define AO_OFF	120
 
 static const struct pinctrl_pin_desc meson8_pins[] = {
-	MESON_PIN(GPIOX_0),
-	MESON_PIN(GPIOX_1),
-	MESON_PIN(GPIOX_2),
-	MESON_PIN(GPIOX_3),
-	MESON_PIN(GPIOX_4),
-	MESON_PIN(GPIOX_5),
-	MESON_PIN(GPIOX_6),
-	MESON_PIN(GPIOX_7),
-	MESON_PIN(GPIOX_8),
-	MESON_PIN(GPIOX_9),
-	MESON_PIN(GPIOX_10),
-	MESON_PIN(GPIOX_11),
-	MESON_PIN(GPIOX_12),
-	MESON_PIN(GPIOX_13),
-	MESON_PIN(GPIOX_14),
-	MESON_PIN(GPIOX_15),
-	MESON_PIN(GPIOX_16),
-	MESON_PIN(GPIOX_17),
-	MESON_PIN(GPIOX_18),
-	MESON_PIN(GPIOX_19),
-	MESON_PIN(GPIOX_20),
-	MESON_PIN(GPIOX_21),
-	MESON_PIN(GPIOY_0),
-	MESON_PIN(GPIOY_1),
-	MESON_PIN(GPIOY_2),
-	MESON_PIN(GPIOY_3),
-	MESON_PIN(GPIOY_4),
-	MESON_PIN(GPIOY_5),
-	MESON_PIN(GPIOY_6),
-	MESON_PIN(GPIOY_7),
-	MESON_PIN(GPIOY_8),
-	MESON_PIN(GPIOY_9),
-	MESON_PIN(GPIOY_10),
-	MESON_PIN(GPIOY_11),
-	MESON_PIN(GPIOY_12),
-	MESON_PIN(GPIOY_13),
-	MESON_PIN(GPIOY_14),
-	MESON_PIN(GPIOY_15),
-	MESON_PIN(GPIOY_16),
-	MESON_PIN(GPIODV_0),
-	MESON_PIN(GPIODV_1),
-	MESON_PIN(GPIODV_2),
-	MESON_PIN(GPIODV_3),
-	MESON_PIN(GPIODV_4),
-	MESON_PIN(GPIODV_5),
-	MESON_PIN(GPIODV_6),
-	MESON_PIN(GPIODV_7),
-	MESON_PIN(GPIODV_8),
-	MESON_PIN(GPIODV_9),
-	MESON_PIN(GPIODV_10),
-	MESON_PIN(GPIODV_11),
-	MESON_PIN(GPIODV_12),
-	MESON_PIN(GPIODV_13),
-	MESON_PIN(GPIODV_14),
-	MESON_PIN(GPIODV_15),
-	MESON_PIN(GPIODV_16),
-	MESON_PIN(GPIODV_17),
-	MESON_PIN(GPIODV_18),
-	MESON_PIN(GPIODV_19),
-	MESON_PIN(GPIODV_20),
-	MESON_PIN(GPIODV_21),
-	MESON_PIN(GPIODV_22),
-	MESON_PIN(GPIODV_23),
-	MESON_PIN(GPIODV_24),
-	MESON_PIN(GPIODV_25),
-	MESON_PIN(GPIODV_26),
-	MESON_PIN(GPIODV_27),
-	MESON_PIN(GPIODV_28),
-	MESON_PIN(GPIODV_29),
-	MESON_PIN(GPIOH_0),
-	MESON_PIN(GPIOH_1),
-	MESON_PIN(GPIOH_2),
-	MESON_PIN(GPIOH_3),
-	MESON_PIN(GPIOH_4),
-	MESON_PIN(GPIOH_5),
-	MESON_PIN(GPIOH_6),
-	MESON_PIN(GPIOH_7),
-	MESON_PIN(GPIOH_8),
-	MESON_PIN(GPIOH_9),
-	MESON_PIN(GPIOZ_0),
-	MESON_PIN(GPIOZ_1),
-	MESON_PIN(GPIOZ_2),
-	MESON_PIN(GPIOZ_3),
-	MESON_PIN(GPIOZ_4),
-	MESON_PIN(GPIOZ_5),
-	MESON_PIN(GPIOZ_6),
-	MESON_PIN(GPIOZ_7),
-	MESON_PIN(GPIOZ_8),
-	MESON_PIN(GPIOZ_9),
-	MESON_PIN(GPIOZ_10),
-	MESON_PIN(GPIOZ_11),
-	MESON_PIN(GPIOZ_12),
-	MESON_PIN(GPIOZ_13),
-	MESON_PIN(GPIOZ_14),
-	MESON_PIN(CARD_0),
-	MESON_PIN(CARD_1),
-	MESON_PIN(CARD_2),
-	MESON_PIN(CARD_3),
-	MESON_PIN(CARD_4),
-	MESON_PIN(CARD_5),
-	MESON_PIN(CARD_6),
-	MESON_PIN(BOOT_0),
-	MESON_PIN(BOOT_1),
-	MESON_PIN(BOOT_2),
-	MESON_PIN(BOOT_3),
-	MESON_PIN(BOOT_4),
-	MESON_PIN(BOOT_5),
-	MESON_PIN(BOOT_6),
-	MESON_PIN(BOOT_7),
-	MESON_PIN(BOOT_8),
-	MESON_PIN(BOOT_9),
-	MESON_PIN(BOOT_10),
-	MESON_PIN(BOOT_11),
-	MESON_PIN(BOOT_12),
-	MESON_PIN(BOOT_13),
-	MESON_PIN(BOOT_14),
-	MESON_PIN(BOOT_15),
-	MESON_PIN(BOOT_16),
-	MESON_PIN(BOOT_17),
-	MESON_PIN(BOOT_18),
-	MESON_PIN(GPIOAO_0),
-	MESON_PIN(GPIOAO_1),
-	MESON_PIN(GPIOAO_2),
-	MESON_PIN(GPIOAO_3),
-	MESON_PIN(GPIOAO_4),
-	MESON_PIN(GPIOAO_5),
-	MESON_PIN(GPIOAO_6),
-	MESON_PIN(GPIOAO_7),
-	MESON_PIN(GPIOAO_8),
-	MESON_PIN(GPIOAO_9),
-	MESON_PIN(GPIOAO_10),
-	MESON_PIN(GPIOAO_11),
-	MESON_PIN(GPIOAO_12),
-	MESON_PIN(GPIOAO_13),
-	MESON_PIN(GPIO_BSD_EN),
-	MESON_PIN(GPIO_TEST_N),
+	MESON_PIN(GPIOX_0, 0),
+	MESON_PIN(GPIOX_1, 0),
+	MESON_PIN(GPIOX_2, 0),
+	MESON_PIN(GPIOX_3, 0),
+	MESON_PIN(GPIOX_4, 0),
+	MESON_PIN(GPIOX_5, 0),
+	MESON_PIN(GPIOX_6, 0),
+	MESON_PIN(GPIOX_7, 0),
+	MESON_PIN(GPIOX_8, 0),
+	MESON_PIN(GPIOX_9, 0),
+	MESON_PIN(GPIOX_10, 0),
+	MESON_PIN(GPIOX_11, 0),
+	MESON_PIN(GPIOX_12, 0),
+	MESON_PIN(GPIOX_13, 0),
+	MESON_PIN(GPIOX_14, 0),
+	MESON_PIN(GPIOX_15, 0),
+	MESON_PIN(GPIOX_16, 0),
+	MESON_PIN(GPIOX_17, 0),
+	MESON_PIN(GPIOX_18, 0),
+	MESON_PIN(GPIOX_19, 0),
+	MESON_PIN(GPIOX_20, 0),
+	MESON_PIN(GPIOX_21, 0),
+	MESON_PIN(GPIOY_0, 0),
+	MESON_PIN(GPIOY_1, 0),
+	MESON_PIN(GPIOY_2, 0),
+	MESON_PIN(GPIOY_3, 0),
+	MESON_PIN(GPIOY_4, 0),
+	MESON_PIN(GPIOY_5, 0),
+	MESON_PIN(GPIOY_6, 0),
+	MESON_PIN(GPIOY_7, 0),
+	MESON_PIN(GPIOY_8, 0),
+	MESON_PIN(GPIOY_9, 0),
+	MESON_PIN(GPIOY_10, 0),
+	MESON_PIN(GPIOY_11, 0),
+	MESON_PIN(GPIOY_12, 0),
+	MESON_PIN(GPIOY_13, 0),
+	MESON_PIN(GPIOY_14, 0),
+	MESON_PIN(GPIOY_15, 0),
+	MESON_PIN(GPIOY_16, 0),
+	MESON_PIN(GPIODV_0, 0),
+	MESON_PIN(GPIODV_1, 0),
+	MESON_PIN(GPIODV_2, 0),
+	MESON_PIN(GPIODV_3, 0),
+	MESON_PIN(GPIODV_4, 0),
+	MESON_PIN(GPIODV_5, 0),
+	MESON_PIN(GPIODV_6, 0),
+	MESON_PIN(GPIODV_7, 0),
+	MESON_PIN(GPIODV_8, 0),
+	MESON_PIN(GPIODV_9, 0),
+	MESON_PIN(GPIODV_10, 0),
+	MESON_PIN(GPIODV_11, 0),
+	MESON_PIN(GPIODV_12, 0),
+	MESON_PIN(GPIODV_13, 0),
+	MESON_PIN(GPIODV_14, 0),
+	MESON_PIN(GPIODV_15, 0),
+	MESON_PIN(GPIODV_16, 0),
+	MESON_PIN(GPIODV_17, 0),
+	MESON_PIN(GPIODV_18, 0),
+	MESON_PIN(GPIODV_19, 0),
+	MESON_PIN(GPIODV_20, 0),
+	MESON_PIN(GPIODV_21, 0),
+	MESON_PIN(GPIODV_22, 0),
+	MESON_PIN(GPIODV_23, 0),
+	MESON_PIN(GPIODV_24, 0),
+	MESON_PIN(GPIODV_25, 0),
+	MESON_PIN(GPIODV_26, 0),
+	MESON_PIN(GPIODV_27, 0),
+	MESON_PIN(GPIODV_28, 0),
+	MESON_PIN(GPIODV_29, 0),
+	MESON_PIN(GPIOH_0, 0),
+	MESON_PIN(GPIOH_1, 0),
+	MESON_PIN(GPIOH_2, 0),
+	MESON_PIN(GPIOH_3, 0),
+	MESON_PIN(GPIOH_4, 0),
+	MESON_PIN(GPIOH_5, 0),
+	MESON_PIN(GPIOH_6, 0),
+	MESON_PIN(GPIOH_7, 0),
+	MESON_PIN(GPIOH_8, 0),
+	MESON_PIN(GPIOH_9, 0),
+	MESON_PIN(GPIOZ_0, 0),
+	MESON_PIN(GPIOZ_1, 0),
+	MESON_PIN(GPIOZ_2, 0),
+	MESON_PIN(GPIOZ_3, 0),
+	MESON_PIN(GPIOZ_4, 0),
+	MESON_PIN(GPIOZ_5, 0),
+	MESON_PIN(GPIOZ_6, 0),
+	MESON_PIN(GPIOZ_7, 0),
+	MESON_PIN(GPIOZ_8, 0),
+	MESON_PIN(GPIOZ_9, 0),
+	MESON_PIN(GPIOZ_10, 0),
+	MESON_PIN(GPIOZ_11, 0),
+	MESON_PIN(GPIOZ_12, 0),
+	MESON_PIN(GPIOZ_13, 0),
+	MESON_PIN(GPIOZ_14, 0),
+	MESON_PIN(CARD_0, 0),
+	MESON_PIN(CARD_1, 0),
+	MESON_PIN(CARD_2, 0),
+	MESON_PIN(CARD_3, 0),
+	MESON_PIN(CARD_4, 0),
+	MESON_PIN(CARD_5, 0),
+	MESON_PIN(CARD_6, 0),
+	MESON_PIN(BOOT_0, 0),
+	MESON_PIN(BOOT_1, 0),
+	MESON_PIN(BOOT_2, 0),
+	MESON_PIN(BOOT_3, 0),
+	MESON_PIN(BOOT_4, 0),
+	MESON_PIN(BOOT_5, 0),
+	MESON_PIN(BOOT_6, 0),
+	MESON_PIN(BOOT_7, 0),
+	MESON_PIN(BOOT_8, 0),
+	MESON_PIN(BOOT_9, 0),
+	MESON_PIN(BOOT_10, 0),
+	MESON_PIN(BOOT_11, 0),
+	MESON_PIN(BOOT_12, 0),
+	MESON_PIN(BOOT_13, 0),
+	MESON_PIN(BOOT_14, 0),
+	MESON_PIN(BOOT_15, 0),
+	MESON_PIN(BOOT_16, 0),
+	MESON_PIN(BOOT_17, 0),
+	MESON_PIN(BOOT_18, 0),
+	MESON_PIN(GPIOAO_0, AO_OFF),
+	MESON_PIN(GPIOAO_1, AO_OFF),
+	MESON_PIN(GPIOAO_2, AO_OFF),
+	MESON_PIN(GPIOAO_3, AO_OFF),
+	MESON_PIN(GPIOAO_4, AO_OFF),
+	MESON_PIN(GPIOAO_5, AO_OFF),
+	MESON_PIN(GPIOAO_6, AO_OFF),
+	MESON_PIN(GPIOAO_7, AO_OFF),
+	MESON_PIN(GPIOAO_8, AO_OFF),
+	MESON_PIN(GPIOAO_9, AO_OFF),
+	MESON_PIN(GPIOAO_10, AO_OFF),
+	MESON_PIN(GPIOAO_11, AO_OFF),
+	MESON_PIN(GPIOAO_12, AO_OFF),
+	MESON_PIN(GPIOAO_13, AO_OFF),
+	MESON_PIN(GPIO_BSD_EN, AO_OFF),
+	MESON_PIN(GPIO_TEST_N, AO_OFF),
 };
 
 /* bank X */
-static const unsigned int sd_d0_a_pins[] = { PIN_GPIOX_0 };
-static const unsigned int sd_d1_a_pins[] = { PIN_GPIOX_1 };
-static const unsigned int sd_d2_a_pins[] = { PIN_GPIOX_2 };
-static const unsigned int sd_d3_a_pins[] = { PIN_GPIOX_3 };
-static const unsigned int sd_clk_a_pins[] = { PIN_GPIOX_8 };
-static const unsigned int sd_cmd_a_pins[] = { PIN_GPIOX_9 };
-
-static const unsigned int sdxc_d0_a_pins[] = { PIN_GPIOX_0 };
-static const unsigned int sdxc_d13_a_pins[] = { PIN_GPIOX_1, PIN_GPIOX_2,
-						PIN_GPIOX_3 };
-static const unsigned int sdxc_d47_a_pins[] = { PIN_GPIOX_4, PIN_GPIOX_5,
-						PIN_GPIOX_6, PIN_GPIOX_7 };
-static const unsigned int sdxc_clk_a_pins[] = { PIN_GPIOX_8 };
-static const unsigned int sdxc_cmd_a_pins[] = { PIN_GPIOX_9 };
-
-static const unsigned int pcm_out_a_pins[] = { PIN_GPIOX_4 };
-static const unsigned int pcm_in_a_pins[] = { PIN_GPIOX_5 };
-static const unsigned int pcm_fs_a_pins[] = { PIN_GPIOX_6 };
-static const unsigned int pcm_clk_a_pins[] = { PIN_GPIOX_7 };
-
-static const unsigned int uart_tx_a0_pins[] = { PIN_GPIOX_4 };
-static const unsigned int uart_rx_a0_pins[] = { PIN_GPIOX_5 };
-static const unsigned int uart_cts_a0_pins[] = { PIN_GPIOX_6 };
-static const unsigned int uart_rts_a0_pins[] = { PIN_GPIOX_7 };
-
-static const unsigned int uart_tx_a1_pins[] = { PIN_GPIOX_12 };
-static const unsigned int uart_rx_a1_pins[] = { PIN_GPIOX_13 };
-static const unsigned int uart_cts_a1_pins[] = { PIN_GPIOX_14 };
-static const unsigned int uart_rts_a1_pins[] = { PIN_GPIOX_15 };
-
-static const unsigned int uart_tx_b0_pins[] = { PIN_GPIOX_16 };
-static const unsigned int uart_rx_b0_pins[] = { PIN_GPIOX_17 };
-static const unsigned int uart_cts_b0_pins[] = { PIN_GPIOX_18 };
-static const unsigned int uart_rts_b0_pins[] = { PIN_GPIOX_19 };
-
-static const unsigned int iso7816_det_pins[] = { PIN_GPIOX_16 };
-static const unsigned int iso7816_reset_pins[] = { PIN_GPIOX_17 };
-static const unsigned int iso7816_clk_pins[] = { PIN_GPIOX_18 };
-static const unsigned int iso7816_data_pins[] = { PIN_GPIOX_19 };
-
-static const unsigned int i2c_sda_d0_pins[] = { PIN_GPIOX_16 };
-static const unsigned int i2c_sck_d0_pins[] = { PIN_GPIOX_17 };
-
-static const unsigned int xtal_32k_out_pins[] = { PIN_GPIOX_10 };
-static const unsigned int xtal_24m_out_pins[] = { PIN_GPIOX_11 };
+static const unsigned int sd_d0_a_pins[] = { PIN(GPIOX_0, 0) };
+static const unsigned int sd_d1_a_pins[] = { PIN(GPIOX_1, 0) };
+static const unsigned int sd_d2_a_pins[] = { PIN(GPIOX_2, 0) };
+static const unsigned int sd_d3_a_pins[] = { PIN(GPIOX_3, 0) };
+static const unsigned int sd_clk_a_pins[] = { PIN(GPIOX_8, 0) };
+static const unsigned int sd_cmd_a_pins[] = { PIN(GPIOX_9, 0) };
+
+static const unsigned int sdxc_d0_a_pins[] = { PIN(GPIOX_0, 0) };
+static const unsigned int sdxc_d13_a_pins[] = { PIN(GPIOX_1, 0), PIN(GPIOX_2, 0),
+						PIN(GPIOX_3, 0) };
+static const unsigned int sdxc_d47_a_pins[] = { PIN(GPIOX_4, 0), PIN(GPIOX_5, 0),
+						PIN(GPIOX_6, 0), PIN(GPIOX_7, 0) };
+static const unsigned int sdxc_clk_a_pins[] = { PIN(GPIOX_8, 0) };
+static const unsigned int sdxc_cmd_a_pins[] = { PIN(GPIOX_9, 0) };
+
+static const unsigned int pcm_out_a_pins[] = { PIN(GPIOX_4, 0) };
+static const unsigned int pcm_in_a_pins[] = { PIN(GPIOX_5, 0) };
+static const unsigned int pcm_fs_a_pins[] = { PIN(GPIOX_6, 0) };
+static const unsigned int pcm_clk_a_pins[] = { PIN(GPIOX_7, 0) };
+
+static const unsigned int uart_tx_a0_pins[] = { PIN(GPIOX_4, 0) };
+static const unsigned int uart_rx_a0_pins[] = { PIN(GPIOX_5, 0) };
+static const unsigned int uart_cts_a0_pins[] = { PIN(GPIOX_6, 0) };
+static const unsigned int uart_rts_a0_pins[] = { PIN(GPIOX_7, 0) };
+
+static const unsigned int uart_tx_a1_pins[] = { PIN(GPIOX_12, 0) };
+static const unsigned int uart_rx_a1_pins[] = { PIN(GPIOX_13, 0) };
+static const unsigned int uart_cts_a1_pins[] = { PIN(GPIOX_14, 0) };
+static const unsigned int uart_rts_a1_pins[] = { PIN(GPIOX_15, 0) };
+
+static const unsigned int uart_tx_b0_pins[] = { PIN(GPIOX_16, 0) };
+static const unsigned int uart_rx_b0_pins[] = { PIN(GPIOX_17, 0) };
+static const unsigned int uart_cts_b0_pins[] = { PIN(GPIOX_18, 0) };
+static const unsigned int uart_rts_b0_pins[] = { PIN(GPIOX_19, 0) };
+
+static const unsigned int iso7816_det_pins[] = { PIN(GPIOX_16, 0) };
+static const unsigned int iso7816_reset_pins[] = { PIN(GPIOX_17, 0) };
+static const unsigned int iso7816_clk_pins[] = { PIN(GPIOX_18, 0) };
+static const unsigned int iso7816_data_pins[] = { PIN(GPIOX_19, 0) };
+
+static const unsigned int i2c_sda_d0_pins[] = { PIN(GPIOX_16, 0) };
+static const unsigned int i2c_sck_d0_pins[] = { PIN(GPIOX_17, 0) };
+
+static const unsigned int xtal_32k_out_pins[] = { PIN(GPIOX_10, 0) };
+static const unsigned int xtal_24m_out_pins[] = { PIN(GPIOX_11, 0) };
 
 /* bank Y */
-static const unsigned int uart_tx_c_pins[] = { PIN_GPIOY_0 };
-static const unsigned int uart_rx_c_pins[] = { PIN_GPIOY_1 };
-static const unsigned int uart_cts_c_pins[] = { PIN_GPIOY_2 };
-static const unsigned int uart_rts_c_pins[] = { PIN_GPIOY_3 };
+static const unsigned int uart_tx_c_pins[] = { PIN(GPIOY_0, 0) };
+static const unsigned int uart_rx_c_pins[] = { PIN(GPIOY_1, 0) };
+static const unsigned int uart_cts_c_pins[] = { PIN(GPIOY_2, 0) };
+static const unsigned int uart_rts_c_pins[] = { PIN(GPIOY_3, 0) };
 
-static const unsigned int pcm_out_b_pins[] = { PIN_GPIOY_4 };
-static const unsigned int pcm_in_b_pins[] = { PIN_GPIOY_5 };
-static const unsigned int pcm_fs_b_pins[] = { PIN_GPIOY_6 };
-static const unsigned int pcm_clk_b_pins[] = { PIN_GPIOY_7 };
+static const unsigned int pcm_out_b_pins[] = { PIN(GPIOY_4, 0) };
+static const unsigned int pcm_in_b_pins[] = { PIN(GPIOY_5, 0) };
+static const unsigned int pcm_fs_b_pins[] = { PIN(GPIOY_6, 0) };
+static const unsigned int pcm_clk_b_pins[] = { PIN(GPIOY_7, 0) };
 
-static const unsigned int i2c_sda_c0_pins[] = { PIN_GPIOY_0 };
-static const unsigned int i2c_sck_c0_pins[] = { PIN_GPIOY_1 };
+static const unsigned int i2c_sda_c0_pins[] = { PIN(GPIOY_0, 0) };
+static const unsigned int i2c_sck_c0_pins[] = { PIN(GPIOY_1, 0) };
 
 /* bank DV */
-static const unsigned int dvin_rgb_pins[] = { PIN_GPIODV_0, PIN_GPIODV_1,
-					      PIN_GPIODV_2, PIN_GPIODV_3,
-					      PIN_GPIODV_4, PIN_GPIODV_5,
-					      PIN_GPIODV_6, PIN_GPIODV_7,
-					      PIN_GPIODV_8, PIN_GPIODV_9,
-					      PIN_GPIODV_10, PIN_GPIODV_11,
-					      PIN_GPIODV_12, PIN_GPIODV_13,
-					      PIN_GPIODV_14, PIN_GPIODV_15,
-					      PIN_GPIODV_16, PIN_GPIODV_17,
-					      PIN_GPIODV_18, PIN_GPIODV_19,
-					      PIN_GPIODV_20, PIN_GPIODV_21,
-					      PIN_GPIODV_22, PIN_GPIODV_23 };
-static const unsigned int dvin_vs_pins[] = { PIN_GPIODV_24 };
-static const unsigned int dvin_hs_pins[] = { PIN_GPIODV_25 };
-static const unsigned int dvin_clk_pins[] = { PIN_GPIODV_26 };
-static const unsigned int dvin_de_pins[] = { PIN_GPIODV_27 };
-
-static const unsigned int enc_0_pins[] = { PIN_GPIODV_0 };
-static const unsigned int enc_1_pins[] = { PIN_GPIODV_1 };
-static const unsigned int enc_2_pins[] = { PIN_GPIODV_2 };
-static const unsigned int enc_3_pins[] = { PIN_GPIODV_3 };
-static const unsigned int enc_4_pins[] = { PIN_GPIODV_4 };
-static const unsigned int enc_5_pins[] = { PIN_GPIODV_5 };
-static const unsigned int enc_6_pins[] = { PIN_GPIODV_6 };
-static const unsigned int enc_7_pins[] = { PIN_GPIODV_7 };
-static const unsigned int enc_8_pins[] = { PIN_GPIODV_8 };
-static const unsigned int enc_9_pins[] = { PIN_GPIODV_9 };
-static const unsigned int enc_10_pins[] = { PIN_GPIODV_10 };
-static const unsigned int enc_11_pins[] = { PIN_GPIODV_11 };
-static const unsigned int enc_12_pins[] = { PIN_GPIODV_12 };
-static const unsigned int enc_13_pins[] = { PIN_GPIODV_13 };
-static const unsigned int enc_14_pins[] = { PIN_GPIODV_14 };
-static const unsigned int enc_15_pins[] = { PIN_GPIODV_15 };
-static const unsigned int enc_16_pins[] = { PIN_GPIODV_16 };
-static const unsigned int enc_17_pins[] = { PIN_GPIODV_17 };
-
-static const unsigned int uart_tx_b1_pins[] = { PIN_GPIODV_24 };
-static const unsigned int uart_rx_b1_pins[] = { PIN_GPIODV_25 };
-static const unsigned int uart_cts_b1_pins[] = { PIN_GPIODV_26 };
-static const unsigned int uart_rts_b1_pins[] = { PIN_GPIODV_27 };
-
-static const unsigned int vga_vs_pins[] = { PIN_GPIODV_24 };
-static const unsigned int vga_hs_pins[] = { PIN_GPIODV_25 };
+static const unsigned int dvin_rgb_pins[] = { PIN(GPIODV_0, 0), PIN(GPIODV_1, 0),
+					      PIN(GPIODV_2, 0), PIN(GPIODV_3, 0),
+					      PIN(GPIODV_4, 0), PIN(GPIODV_5, 0),
+					      PIN(GPIODV_6, 0), PIN(GPIODV_7, 0),
+					      PIN(GPIODV_8, 0), PIN(GPIODV_9, 0),
+					      PIN(GPIODV_10, 0), PIN(GPIODV_11, 0),
+					      PIN(GPIODV_12, 0), PIN(GPIODV_13, 0),
+					      PIN(GPIODV_14, 0), PIN(GPIODV_15, 0),
+					      PIN(GPIODV_16, 0), PIN(GPIODV_17, 0),
+					      PIN(GPIODV_18, 0), PIN(GPIODV_19, 0),
+					      PIN(GPIODV_20, 0), PIN(GPIODV_21, 0),
+					      PIN(GPIODV_22, 0), PIN(GPIODV_23, 0) };
+static const unsigned int dvin_vs_pins[] = { PIN(GPIODV_24, 0) };
+static const unsigned int dvin_hs_pins[] = { PIN(GPIODV_25, 0) };
+static const unsigned int dvin_clk_pins[] = { PIN(GPIODV_26, 0) };
+static const unsigned int dvin_de_pins[] = { PIN(GPIODV_27, 0) };
+
+static const unsigned int enc_0_pins[] = { PIN(GPIODV_0, 0) };
+static const unsigned int enc_1_pins[] = { PIN(GPIODV_1, 0) };
+static const unsigned int enc_2_pins[] = { PIN(GPIODV_2, 0) };
+static const unsigned int enc_3_pins[] = { PIN(GPIODV_3, 0) };
+static const unsigned int enc_4_pins[] = { PIN(GPIODV_4, 0) };
+static const unsigned int enc_5_pins[] = { PIN(GPIODV_5, 0) };
+static const unsigned int enc_6_pins[] = { PIN(GPIODV_6, 0) };
+static const unsigned int enc_7_pins[] = { PIN(GPIODV_7, 0) };
+static const unsigned int enc_8_pins[] = { PIN(GPIODV_8, 0) };
+static const unsigned int enc_9_pins[] = { PIN(GPIODV_9, 0) };
+static const unsigned int enc_10_pins[] = { PIN(GPIODV_10, 0) };
+static const unsigned int enc_11_pins[] = { PIN(GPIODV_11, 0) };
+static const unsigned int enc_12_pins[] = { PIN(GPIODV_12, 0) };
+static const unsigned int enc_13_pins[] = { PIN(GPIODV_13, 0) };
+static const unsigned int enc_14_pins[] = { PIN(GPIODV_14, 0) };
+static const unsigned int enc_15_pins[] = { PIN(GPIODV_15, 0) };
+static const unsigned int enc_16_pins[] = { PIN(GPIODV_16, 0) };
+static const unsigned int enc_17_pins[] = { PIN(GPIODV_17, 0) };
+
+static const unsigned int uart_tx_b1_pins[] = { PIN(GPIODV_24, 0) };
+static const unsigned int uart_rx_b1_pins[] = { PIN(GPIODV_25, 0) };
+static const unsigned int uart_cts_b1_pins[] = { PIN(GPIODV_26, 0) };
+static const unsigned int uart_rts_b1_pins[] = { PIN(GPIODV_27, 0) };
+
+static const unsigned int vga_vs_pins[] = { PIN(GPIODV_24, 0) };
+static const unsigned int vga_hs_pins[] = { PIN(GPIODV_25, 0) };
 
 /* bank H */
-static const unsigned int hdmi_hpd_pins[] = { PIN_GPIOH_0 };
-static const unsigned int hdmi_sda_pins[] = { PIN_GPIOH_1 };
-static const unsigned int hdmi_scl_pins[] = { PIN_GPIOH_2 };
-static const unsigned int hdmi_cec_pins[] = { PIN_GPIOH_3 };
+static const unsigned int hdmi_hpd_pins[] = { PIN(GPIOH_0, 0) };
+static const unsigned int hdmi_sda_pins[] = { PIN(GPIOH_1, 0) };
+static const unsigned int hdmi_scl_pins[] = { PIN(GPIOH_2, 0) };
+static const unsigned int hdmi_cec_pins[] = { PIN(GPIOH_3, 0) };
 
-static const unsigned int spi_ss0_0_pins[] = { PIN_GPIOH_3 };
-static const unsigned int spi_miso_0_pins[] = { PIN_GPIOH_4 };
-static const unsigned int spi_mosi_0_pins[] = { PIN_GPIOH_5 };
-static const unsigned int spi_sclk_0_pins[] = { PIN_GPIOH_6 };
+static const unsigned int spi_ss0_0_pins[] = { PIN(GPIOH_3, 0) };
+static const unsigned int spi_miso_0_pins[] = { PIN(GPIOH_4, 0) };
+static const unsigned int spi_mosi_0_pins[] = { PIN(GPIOH_5, 0) };
+static const unsigned int spi_sclk_0_pins[] = { PIN(GPIOH_6, 0) };
 
-static const unsigned int i2c_sda_d1_pins[] = { PIN_GPIOH_7 };
-static const unsigned int i2c_sck_d1_pins[] = { PIN_GPIOH_8 };
+static const unsigned int i2c_sda_d1_pins[] = { PIN(GPIOH_7, 0) };
+static const unsigned int i2c_sck_d1_pins[] = { PIN(GPIOH_8, 0) };
 
 /* bank Z */
-static const unsigned int spi_ss0_1_pins[] = { PIN_GPIOZ_9 };
-static const unsigned int spi_ss1_1_pins[] = { PIN_GPIOZ_10 };
-static const unsigned int spi_sclk_1_pins[] = { PIN_GPIOZ_11 };
-static const unsigned int spi_mosi_1_pins[] = { PIN_GPIOZ_12 };
-static const unsigned int spi_miso_1_pins[] = { PIN_GPIOZ_13 };
-static const unsigned int spi_ss2_1_pins[] = { PIN_GPIOZ_14 };
-
-static const unsigned int eth_tx_clk_50m_pins[] = { PIN_GPIOZ_4 };
-static const unsigned int eth_tx_en_pins[] = { PIN_GPIOZ_5 };
-static const unsigned int eth_txd1_pins[] = { PIN_GPIOZ_6 };
-static const unsigned int eth_txd0_pins[] = { PIN_GPIOZ_7 };
-static const unsigned int eth_rx_clk_in_pins[] = { PIN_GPIOZ_8 };
-static const unsigned int eth_rx_dv_pins[] = { PIN_GPIOZ_9 };
-static const unsigned int eth_rxd1_pins[] = { PIN_GPIOZ_10 };
-static const unsigned int eth_rxd0_pins[] = { PIN_GPIOZ_11 };
-static const unsigned int eth_mdio_pins[] = { PIN_GPIOZ_12 };
-static const unsigned int eth_mdc_pins[] = { PIN_GPIOZ_13 };
-
-static const unsigned int i2c_sda_a0_pins[] = { PIN_GPIOZ_0 };
-static const unsigned int i2c_sck_a0_pins[] = { PIN_GPIOZ_1 };
-
-static const unsigned int i2c_sda_b_pins[] = { PIN_GPIOZ_2 };
-static const unsigned int i2c_sck_b_pins[] = { PIN_GPIOZ_3 };
-
-static const unsigned int i2c_sda_c1_pins[] = { PIN_GPIOZ_4 };
-static const unsigned int i2c_sck_c1_pins[] = { PIN_GPIOZ_5 };
-
-static const unsigned int i2c_sda_a1_pins[] = { PIN_GPIOZ_0 };
-static const unsigned int i2c_sck_a1_pins[] = { PIN_GPIOZ_1 };
-
-static const unsigned int i2c_sda_a2_pins[] = { PIN_GPIOZ_0 };
-static const unsigned int i2c_sck_a2_pins[] = { PIN_GPIOZ_1 };
+static const unsigned int spi_ss0_1_pins[] = { PIN(GPIOZ_9, 0) };
+static const unsigned int spi_ss1_1_pins[] = { PIN(GPIOZ_10, 0) };
+static const unsigned int spi_sclk_1_pins[] = { PIN(GPIOZ_11, 0) };
+static const unsigned int spi_mosi_1_pins[] = { PIN(GPIOZ_12, 0) };
+static const unsigned int spi_miso_1_pins[] = { PIN(GPIOZ_13, 0) };
+static const unsigned int spi_ss2_1_pins[] = { PIN(GPIOZ_14, 0) };
+
+static const unsigned int eth_tx_clk_50m_pins[] = { PIN(GPIOZ_4, 0) };
+static const unsigned int eth_tx_en_pins[] = { PIN(GPIOZ_5, 0) };
+static const unsigned int eth_txd1_pins[] = { PIN(GPIOZ_6, 0) };
+static const unsigned int eth_txd0_pins[] = { PIN(GPIOZ_7, 0) };
+static const unsigned int eth_rx_clk_in_pins[] = { PIN(GPIOZ_8, 0) };
+static const unsigned int eth_rx_dv_pins[] = { PIN(GPIOZ_9, 0) };
+static const unsigned int eth_rxd1_pins[] = { PIN(GPIOZ_10, 0) };
+static const unsigned int eth_rxd0_pins[] = { PIN(GPIOZ_11, 0) };
+static const unsigned int eth_mdio_pins[] = { PIN(GPIOZ_12, 0) };
+static const unsigned int eth_mdc_pins[] = { PIN(GPIOZ_13, 0) };
+
+static const unsigned int i2c_sda_a0_pins[] = { PIN(GPIOZ_0, 0) };
+static const unsigned int i2c_sck_a0_pins[] = { PIN(GPIOZ_1, 0) };
+
+static const unsigned int i2c_sda_b_pins[] = { PIN(GPIOZ_2, 0) };
+static const unsigned int i2c_sck_b_pins[] = { PIN(GPIOZ_3, 0) };
+
+static const unsigned int i2c_sda_c1_pins[] = { PIN(GPIOZ_4, 0) };
+static const unsigned int i2c_sck_c1_pins[] = { PIN(GPIOZ_5, 0) };
+
+static const unsigned int i2c_sda_a1_pins[] = { PIN(GPIOZ_0, 0) };
+static const unsigned int i2c_sck_a1_pins[] = { PIN(GPIOZ_1, 0) };
+
+static const unsigned int i2c_sda_a2_pins[] = { PIN(GPIOZ_0, 0) };
+static const unsigned int i2c_sck_a2_pins[] = { PIN(GPIOZ_1, 0) };
 
 /* bank BOOT */
-static const unsigned int sd_d0_c_pins[] = { PIN_BOOT_0 };
-static const unsigned int sd_d1_c_pins[] = { PIN_BOOT_1 };
-static const unsigned int sd_d2_c_pins[] = { PIN_BOOT_2 };
-static const unsigned int sd_d3_c_pins[] = { PIN_BOOT_3 };
-static const unsigned int sd_cmd_c_pins[] = { PIN_BOOT_16 };
-static const unsigned int sd_clk_c_pins[] = { PIN_BOOT_17 };
-
-static const unsigned int sdxc_d0_c_pins[] = { PIN_BOOT_0};
-static const unsigned int sdxc_d13_c_pins[] = { PIN_BOOT_1, PIN_BOOT_2,
-						PIN_BOOT_3 };
-static const unsigned int sdxc_d47_c_pins[] = { PIN_BOOT_4, PIN_BOOT_5,
-						PIN_BOOT_6, PIN_BOOT_7 };
-static const unsigned int sdxc_cmd_c_pins[] = { PIN_BOOT_16 };
-static const unsigned int sdxc_clk_c_pins[] = { PIN_BOOT_17 };
-
-static const unsigned int nand_io_pins[] = { PIN_BOOT_0, PIN_BOOT_1,
-					     PIN_BOOT_2, PIN_BOOT_3,
-					     PIN_BOOT_4, PIN_BOOT_5,
-					     PIN_BOOT_6, PIN_BOOT_7 };
-static const unsigned int nand_io_ce0_pins[] = { PIN_BOOT_8 };
-static const unsigned int nand_io_ce1_pins[] = { PIN_BOOT_9 };
-static const unsigned int nand_io_rb0_pins[] = { PIN_BOOT_10 };
-static const unsigned int nand_ale_pins[] = { PIN_BOOT_11 };
-static const unsigned int nand_cle_pins[] = { PIN_BOOT_12 };
-static const unsigned int nand_wen_clk_pins[] = { PIN_BOOT_13 };
-static const unsigned int nand_ren_clk_pins[] = { PIN_BOOT_14 };
-static const unsigned int nand_dqs_pins[] = { PIN_BOOT_15 };
-static const unsigned int nand_ce2_pins[] = { PIN_BOOT_16 };
-static const unsigned int nand_ce3_pins[] = { PIN_BOOT_17 };
-
-static const unsigned int nor_d_pins[] = { PIN_BOOT_11 };
-static const unsigned int nor_q_pins[] = { PIN_BOOT_12 };
-static const unsigned int nor_c_pins[] = { PIN_BOOT_13 };
-static const unsigned int nor_cs_pins[] = { PIN_BOOT_18 };
+static const unsigned int sd_d0_c_pins[] = { PIN(BOOT_0, 0) };
+static const unsigned int sd_d1_c_pins[] = { PIN(BOOT_1, 0) };
+static const unsigned int sd_d2_c_pins[] = { PIN(BOOT_2, 0) };
+static const unsigned int sd_d3_c_pins[] = { PIN(BOOT_3, 0) };
+static const unsigned int sd_cmd_c_pins[] = { PIN(BOOT_16, 0) };
+static const unsigned int sd_clk_c_pins[] = { PIN(BOOT_17, 0) };
+
+static const unsigned int sdxc_d0_c_pins[] = { PIN(BOOT_0, 0)};
+static const unsigned int sdxc_d13_c_pins[] = { PIN(BOOT_1, 0), PIN(BOOT_2, 0),
+						PIN(BOOT_3, 0) };
+static const unsigned int sdxc_d47_c_pins[] = { PIN(BOOT_4, 0), PIN(BOOT_5, 0),
+						PIN(BOOT_6, 0), PIN(BOOT_7, 0) };
+static const unsigned int sdxc_cmd_c_pins[] = { PIN(BOOT_16, 0) };
+static const unsigned int sdxc_clk_c_pins[] = { PIN(BOOT_17, 0) };
+
+static const unsigned int nand_io_pins[] = { PIN(BOOT_0, 0), PIN(BOOT_1, 0),
+					     PIN(BOOT_2, 0), PIN(BOOT_3, 0),
+					     PIN(BOOT_4, 0), PIN(BOOT_5, 0),
+					     PIN(BOOT_6, 0), PIN(BOOT_7, 0) };
+static const unsigned int nand_io_ce0_pins[] = { PIN(BOOT_8, 0) };
+static const unsigned int nand_io_ce1_pins[] = { PIN(BOOT_9, 0) };
+static const unsigned int nand_io_rb0_pins[] = { PIN(BOOT_10, 0) };
+static const unsigned int nand_ale_pins[] = { PIN(BOOT_11, 0) };
+static const unsigned int nand_cle_pins[] = { PIN(BOOT_12, 0) };
+static const unsigned int nand_wen_clk_pins[] = { PIN(BOOT_13, 0) };
+static const unsigned int nand_ren_clk_pins[] = { PIN(BOOT_14, 0) };
+static const unsigned int nand_dqs_pins[] = { PIN(BOOT_15, 0) };
+static const unsigned int nand_ce2_pins[] = { PIN(BOOT_16, 0) };
+static const unsigned int nand_ce3_pins[] = { PIN(BOOT_17, 0) };
+
+static const unsigned int nor_d_pins[] = { PIN(BOOT_11, 0) };
+static const unsigned int nor_q_pins[] = { PIN(BOOT_12, 0) };
+static const unsigned int nor_c_pins[] = { PIN(BOOT_13, 0) };
+static const unsigned int nor_cs_pins[] = { PIN(BOOT_18, 0) };
 
 /* bank CARD */
-static const unsigned int sd_d1_b_pins[] = { PIN_CARD_0 };
-static const unsigned int sd_d0_b_pins[] = { PIN_CARD_1 };
-static const unsigned int sd_clk_b_pins[] = { PIN_CARD_2 };
-static const unsigned int sd_cmd_b_pins[] = { PIN_CARD_3 };
-static const unsigned int sd_d3_b_pins[] = { PIN_CARD_4 };
-static const unsigned int sd_d2_b_pins[] = { PIN_CARD_5 };
-
-static const unsigned int sdxc_d13_b_pins[] = { PIN_CARD_0, PIN_CARD_4,
-						PIN_CARD_5 };
-static const unsigned int sdxc_d0_b_pins[] = { PIN_CARD_1 };
-static const unsigned int sdxc_clk_b_pins[] = { PIN_CARD_2 };
-static const unsigned int sdxc_cmd_b_pins[] = { PIN_CARD_3 };
+static const unsigned int sd_d1_b_pins[] = { PIN(CARD_0, 0) };
+static const unsigned int sd_d0_b_pins[] = { PIN(CARD_1, 0) };
+static const unsigned int sd_clk_b_pins[] = { PIN(CARD_2, 0) };
+static const unsigned int sd_cmd_b_pins[] = { PIN(CARD_3, 0) };
+static const unsigned int sd_d3_b_pins[] = { PIN(CARD_4, 0) };
+static const unsigned int sd_d2_b_pins[] = { PIN(CARD_5, 0) };
+
+static const unsigned int sdxc_d13_b_pins[] = { PIN(CARD_0, 0), PIN(CARD_4, 0),
+						PIN(CARD_5, 0) };
+static const unsigned int sdxc_d0_b_pins[] = { PIN(CARD_1, 0) };
+static const unsigned int sdxc_clk_b_pins[] = { PIN(CARD_2, 0) };
+static const unsigned int sdxc_cmd_b_pins[] = { PIN(CARD_3, 0) };
 
 /* bank AO */
-static const unsigned int uart_tx_ao_a_pins[] = { PIN_GPIOAO_0 };
-static const unsigned int uart_rx_ao_a_pins[] = { PIN_GPIOAO_1 };
-static const unsigned int uart_cts_ao_a_pins[] = { PIN_GPIOAO_2 };
-static const unsigned int uart_rts_ao_a_pins[] = { PIN_GPIOAO_3 };
+static const unsigned int uart_tx_ao_a_pins[] = { PIN(GPIOAO_0, AO_OFF) };
+static const unsigned int uart_rx_ao_a_pins[] = { PIN(GPIOAO_1, AO_OFF) };
+static const unsigned int uart_cts_ao_a_pins[] = { PIN(GPIOAO_2, AO_OFF) };
+static const unsigned int uart_rts_ao_a_pins[] = { PIN(GPIOAO_3, AO_OFF) };
 
-static const unsigned int remote_input_pins[] = { PIN_GPIOAO_7 };
+static const unsigned int remote_input_pins[] = { PIN(GPIOAO_7, AO_OFF) };
 
-static const unsigned int i2c_slave_sck_ao_pins[] = { PIN_GPIOAO_4 };
-static const unsigned int i2c_slave_sda_ao_pins[] = { PIN_GPIOAO_5 };
+static const unsigned int i2c_slave_sck_ao_pins[] = { PIN(GPIOAO_4, AO_OFF) };
+static const unsigned int i2c_slave_sda_ao_pins[] = { PIN(GPIOAO_5, AO_OFF) };
 
-static const unsigned int uart_tx_ao_b0_pins[] = { PIN_GPIOAO_0 };
-static const unsigned int uart_rx_ao_b0_pins[] = { PIN_GPIOAO_1 };
+static const unsigned int uart_tx_ao_b0_pins[] = { PIN(GPIOAO_0, AO_OFF) };
+static const unsigned int uart_rx_ao_b0_pins[] = { PIN(GPIOAO_1, AO_OFF) };
 
-static const unsigned int uart_tx_ao_b1_pins[] = { PIN_GPIOAO_4 };
-static const unsigned int uart_rx_ao_b1_pins[] = { PIN_GPIOAO_5 };
+static const unsigned int uart_tx_ao_b1_pins[] = { PIN(GPIOAO_4, AO_OFF) };
+static const unsigned int uart_rx_ao_b1_pins[] = { PIN(GPIOAO_5, AO_OFF) };
 
-static const unsigned int i2c_mst_sck_ao_pins[] = { PIN_GPIOAO_4 };
-static const unsigned int i2c_mst_sda_ao_pins[] = { PIN_GPIOAO_5 };
+static const unsigned int i2c_mst_sck_ao_pins[] = { PIN(GPIOAO_4, AO_OFF) };
+static const unsigned int i2c_mst_sda_ao_pins[] = { PIN(GPIOAO_5, AO_OFF) };
 
 static struct meson_pmx_group meson8_groups[] = {
-	GPIO_GROUP(GPIOX_0),
-	GPIO_GROUP(GPIOX_1),
-	GPIO_GROUP(GPIOX_2),
-	GPIO_GROUP(GPIOX_3),
-	GPIO_GROUP(GPIOX_4),
-	GPIO_GROUP(GPIOX_5),
-	GPIO_GROUP(GPIOX_6),
-	GPIO_GROUP(GPIOX_7),
-	GPIO_GROUP(GPIOX_8),
-	GPIO_GROUP(GPIOX_9),
-	GPIO_GROUP(GPIOX_10),
-	GPIO_GROUP(GPIOX_11),
-	GPIO_GROUP(GPIOX_12),
-	GPIO_GROUP(GPIOX_13),
-	GPIO_GROUP(GPIOX_14),
-	GPIO_GROUP(GPIOX_15),
-	GPIO_GROUP(GPIOX_16),
-	GPIO_GROUP(GPIOX_17),
-	GPIO_GROUP(GPIOX_18),
-	GPIO_GROUP(GPIOX_19),
-	GPIO_GROUP(GPIOX_20),
-	GPIO_GROUP(GPIOX_21),
-	GPIO_GROUP(GPIOY_0),
-	GPIO_GROUP(GPIOY_1),
-	GPIO_GROUP(GPIOY_2),
-	GPIO_GROUP(GPIOY_3),
-	GPIO_GROUP(GPIOY_4),
-	GPIO_GROUP(GPIOY_5),
-	GPIO_GROUP(GPIOY_6),
-	GPIO_GROUP(GPIOY_7),
-	GPIO_GROUP(GPIOY_8),
-	GPIO_GROUP(GPIOY_9),
-	GPIO_GROUP(GPIOY_10),
-	GPIO_GROUP(GPIOY_11),
-	GPIO_GROUP(GPIOY_12),
-	GPIO_GROUP(GPIOY_13),
-	GPIO_GROUP(GPIOY_14),
-	GPIO_GROUP(GPIOY_15),
-	GPIO_GROUP(GPIOY_16),
-	GPIO_GROUP(GPIODV_0),
-	GPIO_GROUP(GPIODV_1),
-	GPIO_GROUP(GPIODV_2),
-	GPIO_GROUP(GPIODV_3),
-	GPIO_GROUP(GPIODV_4),
-	GPIO_GROUP(GPIODV_5),
-	GPIO_GROUP(GPIODV_6),
-	GPIO_GROUP(GPIODV_7),
-	GPIO_GROUP(GPIODV_8),
-	GPIO_GROUP(GPIODV_9),
-	GPIO_GROUP(GPIODV_10),
-	GPIO_GROUP(GPIODV_11),
-	GPIO_GROUP(GPIODV_12),
-	GPIO_GROUP(GPIODV_13),
-	GPIO_GROUP(GPIODV_14),
-	GPIO_GROUP(GPIODV_15),
-	GPIO_GROUP(GPIODV_16),
-	GPIO_GROUP(GPIODV_17),
-	GPIO_GROUP(GPIODV_18),
-	GPIO_GROUP(GPIODV_19),
-	GPIO_GROUP(GPIODV_20),
-	GPIO_GROUP(GPIODV_21),
-	GPIO_GROUP(GPIODV_22),
-	GPIO_GROUP(GPIODV_23),
-	GPIO_GROUP(GPIODV_24),
-	GPIO_GROUP(GPIODV_25),
-	GPIO_GROUP(GPIODV_26),
-	GPIO_GROUP(GPIODV_27),
-	GPIO_GROUP(GPIODV_28),
-	GPIO_GROUP(GPIODV_29),
-	GPIO_GROUP(GPIOH_0),
-	GPIO_GROUP(GPIOH_1),
-	GPIO_GROUP(GPIOH_2),
-	GPIO_GROUP(GPIOH_3),
-	GPIO_GROUP(GPIOH_4),
-	GPIO_GROUP(GPIOH_5),
-	GPIO_GROUP(GPIOH_6),
-	GPIO_GROUP(GPIOH_7),
-	GPIO_GROUP(GPIOH_8),
-	GPIO_GROUP(GPIOH_9),
-	GPIO_GROUP(GPIOZ_0),
-	GPIO_GROUP(GPIOZ_1),
-	GPIO_GROUP(GPIOZ_2),
-	GPIO_GROUP(GPIOZ_3),
-	GPIO_GROUP(GPIOZ_4),
-	GPIO_GROUP(GPIOZ_5),
-	GPIO_GROUP(GPIOZ_6),
-	GPIO_GROUP(GPIOZ_7),
-	GPIO_GROUP(GPIOZ_8),
-	GPIO_GROUP(GPIOZ_9),
-	GPIO_GROUP(GPIOZ_10),
-	GPIO_GROUP(GPIOZ_11),
-	GPIO_GROUP(GPIOZ_12),
-	GPIO_GROUP(GPIOZ_13),
-	GPIO_GROUP(GPIOZ_14),
-	GPIO_GROUP(GPIOAO_0),
-	GPIO_GROUP(GPIOAO_1),
-	GPIO_GROUP(GPIOAO_2),
-	GPIO_GROUP(GPIOAO_3),
-	GPIO_GROUP(GPIOAO_4),
-	GPIO_GROUP(GPIOAO_5),
-	GPIO_GROUP(GPIOAO_6),
-	GPIO_GROUP(GPIOAO_7),
-	GPIO_GROUP(GPIOAO_8),
-	GPIO_GROUP(GPIOAO_9),
-	GPIO_GROUP(GPIOAO_10),
-	GPIO_GROUP(GPIOAO_11),
-	GPIO_GROUP(GPIOAO_12),
-	GPIO_GROUP(GPIOAO_13),
-	GPIO_GROUP(GPIO_BSD_EN),
-	GPIO_GROUP(GPIO_TEST_N),
+	GPIO_GROUP(GPIOX_0, 0),
+	GPIO_GROUP(GPIOX_1, 0),
+	GPIO_GROUP(GPIOX_2, 0),
+	GPIO_GROUP(GPIOX_3, 0),
+	GPIO_GROUP(GPIOX_4, 0),
+	GPIO_GROUP(GPIOX_5, 0),
+	GPIO_GROUP(GPIOX_6, 0),
+	GPIO_GROUP(GPIOX_7, 0),
+	GPIO_GROUP(GPIOX_8, 0),
+	GPIO_GROUP(GPIOX_9, 0),
+	GPIO_GROUP(GPIOX_10, 0),
+	GPIO_GROUP(GPIOX_11, 0),
+	GPIO_GROUP(GPIOX_12, 0),
+	GPIO_GROUP(GPIOX_13, 0),
+	GPIO_GROUP(GPIOX_14, 0),
+	GPIO_GROUP(GPIOX_15, 0),
+	GPIO_GROUP(GPIOX_16, 0),
+	GPIO_GROUP(GPIOX_17, 0),
+	GPIO_GROUP(GPIOX_18, 0),
+	GPIO_GROUP(GPIOX_19, 0),
+	GPIO_GROUP(GPIOX_20, 0),
+	GPIO_GROUP(GPIOX_21, 0),
+	GPIO_GROUP(GPIOY_0, 0),
+	GPIO_GROUP(GPIOY_1, 0),
+	GPIO_GROUP(GPIOY_2, 0),
+	GPIO_GROUP(GPIOY_3, 0),
+	GPIO_GROUP(GPIOY_4, 0),
+	GPIO_GROUP(GPIOY_5, 0),
+	GPIO_GROUP(GPIOY_6, 0),
+	GPIO_GROUP(GPIOY_7, 0),
+	GPIO_GROUP(GPIOY_8, 0),
+	GPIO_GROUP(GPIOY_9, 0),
+	GPIO_GROUP(GPIOY_10, 0),
+	GPIO_GROUP(GPIOY_11, 0),
+	GPIO_GROUP(GPIOY_12, 0),
+	GPIO_GROUP(GPIOY_13, 0),
+	GPIO_GROUP(GPIOY_14, 0),
+	GPIO_GROUP(GPIOY_15, 0),
+	GPIO_GROUP(GPIOY_16, 0),
+	GPIO_GROUP(GPIODV_0, 0),
+	GPIO_GROUP(GPIODV_1, 0),
+	GPIO_GROUP(GPIODV_2, 0),
+	GPIO_GROUP(GPIODV_3, 0),
+	GPIO_GROUP(GPIODV_4, 0),
+	GPIO_GROUP(GPIODV_5, 0),
+	GPIO_GROUP(GPIODV_6, 0),
+	GPIO_GROUP(GPIODV_7, 0),
+	GPIO_GROUP(GPIODV_8, 0),
+	GPIO_GROUP(GPIODV_9, 0),
+	GPIO_GROUP(GPIODV_10, 0),
+	GPIO_GROUP(GPIODV_11, 0),
+	GPIO_GROUP(GPIODV_12, 0),
+	GPIO_GROUP(GPIODV_13, 0),
+	GPIO_GROUP(GPIODV_14, 0),
+	GPIO_GROUP(GPIODV_15, 0),
+	GPIO_GROUP(GPIODV_16, 0),
+	GPIO_GROUP(GPIODV_17, 0),
+	GPIO_GROUP(GPIODV_18, 0),
+	GPIO_GROUP(GPIODV_19, 0),
+	GPIO_GROUP(GPIODV_20, 0),
+	GPIO_GROUP(GPIODV_21, 0),
+	GPIO_GROUP(GPIODV_22, 0),
+	GPIO_GROUP(GPIODV_23, 0),
+	GPIO_GROUP(GPIODV_24, 0),
+	GPIO_GROUP(GPIODV_25, 0),
+	GPIO_GROUP(GPIODV_26, 0),
+	GPIO_GROUP(GPIODV_27, 0),
+	GPIO_GROUP(GPIODV_28, 0),
+	GPIO_GROUP(GPIODV_29, 0),
+	GPIO_GROUP(GPIOH_0, 0),
+	GPIO_GROUP(GPIOH_1, 0),
+	GPIO_GROUP(GPIOH_2, 0),
+	GPIO_GROUP(GPIOH_3, 0),
+	GPIO_GROUP(GPIOH_4, 0),
+	GPIO_GROUP(GPIOH_5, 0),
+	GPIO_GROUP(GPIOH_6, 0),
+	GPIO_GROUP(GPIOH_7, 0),
+	GPIO_GROUP(GPIOH_8, 0),
+	GPIO_GROUP(GPIOH_9, 0),
+	GPIO_GROUP(GPIOZ_0, 0),
+	GPIO_GROUP(GPIOZ_1, 0),
+	GPIO_GROUP(GPIOZ_2, 0),
+	GPIO_GROUP(GPIOZ_3, 0),
+	GPIO_GROUP(GPIOZ_4, 0),
+	GPIO_GROUP(GPIOZ_5, 0),
+	GPIO_GROUP(GPIOZ_6, 0),
+	GPIO_GROUP(GPIOZ_7, 0),
+	GPIO_GROUP(GPIOZ_8, 0),
+	GPIO_GROUP(GPIOZ_9, 0),
+	GPIO_GROUP(GPIOZ_10, 0),
+	GPIO_GROUP(GPIOZ_11, 0),
+	GPIO_GROUP(GPIOZ_12, 0),
+	GPIO_GROUP(GPIOZ_13, 0),
+	GPIO_GROUP(GPIOZ_14, 0),
+	GPIO_GROUP(GPIOAO_0, AO_OFF),
+	GPIO_GROUP(GPIOAO_1, AO_OFF),
+	GPIO_GROUP(GPIOAO_2, AO_OFF),
+	GPIO_GROUP(GPIOAO_3, AO_OFF),
+	GPIO_GROUP(GPIOAO_4, AO_OFF),
+	GPIO_GROUP(GPIOAO_5, AO_OFF),
+	GPIO_GROUP(GPIOAO_6, AO_OFF),
+	GPIO_GROUP(GPIOAO_7, AO_OFF),
+	GPIO_GROUP(GPIOAO_8, AO_OFF),
+	GPIO_GROUP(GPIOAO_9, AO_OFF),
+	GPIO_GROUP(GPIOAO_10, AO_OFF),
+	GPIO_GROUP(GPIOAO_11, AO_OFF),
+	GPIO_GROUP(GPIOAO_12, AO_OFF),
+	GPIO_GROUP(GPIOAO_13, AO_OFF),
+	GPIO_GROUP(GPIO_BSD_EN, AO_OFF),
+	GPIO_GROUP(GPIO_TEST_N, AO_OFF),
 
 	/* bank X */
 	GROUP(sd_d0_a,		8,	5),
@@ -1045,19 +907,19 @@ static struct meson_pmx_func meson8_functions[] = {
 };
 
 static struct meson_bank meson8_banks[] = {
-	/*   name    first         last             pullen  pull     dir     out     in  */
-	BANK("X",    PIN_GPIOX_0,  PIN_GPIOX_21,    4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
-	BANK("Y",    PIN_GPIOY_0,  PIN_GPIOY_16,    3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
-	BANK("DV",   PIN_GPIODV_0, PIN_GPIODV_29,   0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
-	BANK("H",    PIN_GPIOH_0,  PIN_GPIOH_9,     1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
-	BANK("Z",    PIN_GPIOZ_0,  PIN_GPIOZ_14,    1,  0,  1,  0,  3, 17,  4, 17,  5, 17),
-	BANK("CARD", PIN_CARD_0,   PIN_CARD_6,      2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
-	BANK("BOOT", PIN_BOOT_0,   PIN_BOOT_18,     2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
+	/*   name    first             last                 pullen  pull    dir     out     in  */
+	BANK("X",    PIN(GPIOX_0, 0),  PIN(GPIOX_21, 0),    4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
+	BANK("Y",    PIN(GPIOY_0, 0),  PIN(GPIOY_16, 0),    3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
+	BANK("DV",   PIN(GPIODV_0, 0), PIN(GPIODV_29, 0),   0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
+	BANK("H",    PIN(GPIOH_0, 0),  PIN(GPIOH_9, 0),     1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
+	BANK("Z",    PIN(GPIOZ_0, 0),  PIN(GPIOZ_14, 0),    1,  0,  1,  0,  3, 17,  4, 17,  5, 17),
+	BANK("CARD", PIN(CARD_0, 0),   PIN(CARD_6, 0),      2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
+	BANK("BOOT", PIN(BOOT_0, 0),   PIN(BOOT_18, 0),     2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
 };
 
 static struct meson_bank meson8_ao_banks[] = {
-	/*   name    first         last             pullen  pull     dir     out     in  */
-	BANK("AO",   PIN_GPIOAO_0, PIN_GPIO_TEST_N, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/*   name    first                  last                      pullen  pull    dir     out     in  */
+	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
 static struct meson_domain_data meson8_domain_data[] = {
-- 
1.9.1
