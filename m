From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 20 Jun 2017 13:41:27 +0200
Subject: [PATCH v2 2/5] i2c: i2c-stm32f4: use generic definition of speed enum
In-Reply-To: <1497958890-5530-1-git-send-email-pierre-yves.mordret@st.com>
References: <1497958890-5530-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1497958890-5530-3-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses a more generic definition of speed enum for i2c-stm32f4
driver.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Reviewed-by: Ludovic BARRE <ludovic.barre@st.com>
---
 drivers/i2c/busses/i2c-stm32.h   | 20 ++++++++++++++++++++
 drivers/i2c/busses/i2c-stm32f4.c | 18 +++++++-----------
 2 files changed, 27 insertions(+), 11 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stm32.h

diff --git a/drivers/i2c/busses/i2c-stm32.h b/drivers/i2c/busses/i2c-stm32.h
new file mode 100644
index 0000000..dab5176
--- /dev/null
+++ b/drivers/i2c/busses/i2c-stm32.h
@@ -0,0 +1,20 @@
+/*
+ * i2c-stm32.h
+ *
+ * Copyright (C) M'boumba Cedric Madianga 2017
+ * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#ifndef _I2C_STM32_H
+#define _I2C_STM32_H
+
+enum stm32_i2c_speed {
+	STM32_I2C_SPEED_STANDARD, /* 100 kHz */
+	STM32_I2C_SPEED_FAST, /* 400 kHz */
+	STM32_I2C_SPEED_FAST_PLUS, /* 1 MHz */
+	STM32_I2C_SPEED_END,
+};
+
+#endif /* _I2C_STM32_H */
diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index f9dd7e8..b81557d 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -27,6 +27,8 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
+#include "i2c-stm32.h"
+
 /* STM32F4 I2C offset registers */
 #define STM32F4_I2C_CR1			0x00
 #define STM32F4_I2C_CR2			0x04
@@ -90,12 +92,6 @@
 #define STM32F4_I2C_MAX_FREQ		46U
 #define HZ_TO_MHZ			1000000
 
-enum stm32f4_i2c_speed {
-	STM32F4_I2C_SPEED_STANDARD, /* 100 kHz */
-	STM32F4_I2C_SPEED_FAST, /* 400 kHz */
-	STM32F4_I2C_SPEED_END,
-};
-
 /**
  * struct stm32f4_i2c_msg - client specific data
  * @addr: 8-bit slave addr, including r/w bit
@@ -159,7 +155,7 @@ static int stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_dev)
 	i2c_dev->parent_rate = clk_get_rate(i2c_dev->clk);
 	freq = DIV_ROUND_UP(i2c_dev->parent_rate, HZ_TO_MHZ);
 
-	if (i2c_dev->speed == STM32F4_I2C_SPEED_STANDARD) {
+	if (i2c_dev->speed == STM32_I2C_SPEED_STANDARD) {
 		/*
 		 * To reach 100 kHz, the parent clk frequency should be between
 		 * a minimum value of 2 MHz and a maximum value of 46 MHz due
@@ -216,7 +212,7 @@ static void stm32f4_i2c_set_rise_time(struct stm32f4_i2c_dev *i2c_dev)
 	 * is not higher than 46 MHz . As a result trise is at most 4 bits wide
 	 * and so fits into the TRISE bits [5:0].
 	 */
-	if (i2c_dev->speed == STM32F4_I2C_SPEED_STANDARD)
+	if (i2c_dev->speed == STM32_I2C_SPEED_STANDARD)
 		trise = freq + 1;
 	else
 		trise = freq * 3 / 10 + 1;
@@ -230,7 +226,7 @@ static void stm32f4_i2c_set_speed_mode(struct stm32f4_i2c_dev *i2c_dev)
 	u32 val;
 	u32 ccr = 0;
 
-	if (i2c_dev->speed == STM32F4_I2C_SPEED_STANDARD) {
+	if (i2c_dev->speed == STM32_I2C_SPEED_STANDARD) {
 		/*
 		 * In standard mode:
 		 * t_scl_high = t_scl_low = CCR * I2C parent clk period
@@ -808,10 +804,10 @@ static int stm32f4_i2c_probe(struct platform_device *pdev)
 	udelay(2);
 	reset_control_deassert(rst);
 
-	i2c_dev->speed = STM32F4_I2C_SPEED_STANDARD;
+	i2c_dev->speed = STM32_I2C_SPEED_STANDARD;
 	ret = of_property_read_u32(np, "clock-frequency", &clk_rate);
 	if (!ret && clk_rate >= 400000)
-		i2c_dev->speed = STM32F4_I2C_SPEED_FAST;
+		i2c_dev->speed = STM32_I2C_SPEED_FAST;
 
 	i2c_dev->dev = &pdev->dev;
 
-- 
1.9.1
