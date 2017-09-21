From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Thu, 21 Sep 2017 15:30:09 +0200
Subject: [PATCH v1] i2c:i2c-stm32f7: fix setup structure
Message-ID: <1506000609-27409-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2C drive setup structure is not properly allocated.
Make it static instead of pointer to store driver data.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 47c67b0..42ebdb1 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -215,7 +215,7 @@ struct stm32f7_i2c_dev {
 	unsigned int msg_num;
 	unsigned int msg_id;
 	struct stm32f7_i2c_msg f7_msg;
-	struct stm32f7_i2c_setup *setup;
+	struct stm32f7_i2c_setup setup;
 	struct stm32f7_i2c_timings timing;
 };
 
@@ -537,7 +537,7 @@ static void stm32f7_i2c_hw_config(struct stm32f7_i2c_dev *i2c_dev)
 	writel_relaxed(timing, i2c_dev->base + STM32F7_I2C_TIMINGR);
 
 	/* Enable I2C */
-	if (i2c_dev->setup->analog_filter)
+	if (i2c_dev->setup.analog_filter)
 		stm32f7_i2c_clr_bits(i2c_dev->base + STM32F7_I2C_CR1,
 				     STM32F7_I2C_CR1_ANFOFF);
 	else
@@ -887,22 +887,19 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	}
 
 	setup = of_device_get_match_data(&pdev->dev);
-	i2c_dev->setup->rise_time = setup->rise_time;
-	i2c_dev->setup->fall_time = setup->fall_time;
-	i2c_dev->setup->dnf = setup->dnf;
-	i2c_dev->setup->analog_filter = setup->analog_filter;
+	i2c_dev->setup = *setup;
 
 	ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-rising-time-ns",
 				       &rise_time);
 	if (!ret)
-		i2c_dev->setup->rise_time = rise_time;
+		i2c_dev->setup.rise_time = rise_time;
 
 	ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-falling-time-ns",
 				       &fall_time);
 	if (!ret)
-		i2c_dev->setup->fall_time = fall_time;
+		i2c_dev->setup.fall_time = fall_time;
 
-	ret = stm32f7_i2c_setup_timing(i2c_dev, i2c_dev->setup);
+	ret = stm32f7_i2c_setup_timing(i2c_dev, &i2c_dev->setup);
 	if (ret)
 		goto clk_free;
 
-- 
2.7.4
