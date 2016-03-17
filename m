From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Mar 2016 22:48:49 +0100
Subject: [PATCH v14 04/17] drm: bridge: analogix/dp: fix some obvious code
 style
In-Reply-To: <1455534599-1636-1-git-send-email-ykk@rock-chips.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <1455534599-1636-1-git-send-email-ykk@rock-chips.com>
Message-ID: <5288069.sdD3NZfROG@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix some obvious alignment problems, like alignment and line
over 80 characters problems, make this easy to be maintained
later.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
Changes in v14.1:
- Rebase against drm-next from 2016-03-17

Changes in v14: None
Changes in v13: None
Changes in v12:
- Add the ack from Jingoo

Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5:
- Resequence this patch after analogix_dp driver have been split
  from exynos_dp code, and rephrase reasonable commit message, and
  remove some controversial style (Krzysztof)
    -           analogix_dp_write_byte_to_dpcd(
    -                           dp, DP_TEST_RESPONSE,
    +           analogix_dp_write_byte_to_dpcd(dp,
    +                           DP_TEST_RESPONSE,
                                DP_TEST_EDID_CHECKSUM_WRITE);

Changes in v4: None
Changes in v3: None
Changes in v2:
- Improved commit message more readable, and avoid using some
  uncommon style like bellow: (Joe Preches)
    -  retval = exynos_dp_read_bytes_from_i2c(...
                                  ...);
    +  retval =
    +  exynos_dp_read_bytes_from_i2c(......);

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 129 ++++++++++-----------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  72 ++++++------
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 124 ++++++++++----------
 drivers/gpu/drm/exynos/exynos_dp.c                 |   4 +-
 4 files changed, 165 insertions(+), 164 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 392c296..6901a6f 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -64,7 +64,7 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
 
 	while (analogix_dp_get_plug_in_status(dp) != 0) {
 		timeout_loop++;
-		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
+		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
 			dev_err(dp->dev, "failed to get hpd plug status\n");
 			return -ETIMEDOUT;
 		}
@@ -101,8 +101,8 @@ static int analogix_dp_read_edid(struct analogix_dp_device *dp)
 
 	/* Read Extension Flag, Number of 128-byte EDID extension blocks */
 	retval = analogix_dp_read_byte_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
-				EDID_EXTENSION_FLAG,
-				&extend_block);
+						EDID_EXTENSION_FLAG,
+						&extend_block);
 	if (retval)
 		return retval;
 
@@ -110,7 +110,8 @@ static int analogix_dp_read_edid(struct analogix_dp_device *dp)
 		dev_dbg(dp->dev, "EDID data includes a single extension!\n");
 
 		/* Read EDID data */
-		retval = analogix_dp_read_bytes_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
+		retval = analogix_dp_read_bytes_from_i2c(dp,
+						I2C_EDID_DEVICE_ADDR,
 						EDID_HEADER_PATTERN,
 						EDID_BLOCK_LENGTH,
 						&edid[EDID_HEADER_PATTERN]);
@@ -141,7 +142,7 @@ static int analogix_dp_read_edid(struct analogix_dp_device *dp)
 		}
 
 		analogix_dp_read_byte_from_dpcd(dp, DP_TEST_REQUEST,
-					&test_vector);
+						&test_vector);
 		if (test_vector & DP_TEST_LINK_EDID_READ) {
 			analogix_dp_write_byte_to_dpcd(dp,
 				DP_TEST_EDID_CHECKSUM,
@@ -155,10 +156,8 @@ static int analogix_dp_read_edid(struct analogix_dp_device *dp)
 
 		/* Read EDID data */
 		retval = analogix_dp_read_bytes_from_i2c(dp,
-				I2C_EDID_DEVICE_ADDR,
-				EDID_HEADER_PATTERN,
-				EDID_BLOCK_LENGTH,
-				&edid[EDID_HEADER_PATTERN]);
+				I2C_EDID_DEVICE_ADDR, EDID_HEADER_PATTERN,
+				EDID_BLOCK_LENGTH, &edid[EDID_HEADER_PATTERN]);
 		if (retval != 0) {
 			dev_err(dp->dev, "EDID Read failed!\n");
 			return -EIO;
@@ -169,16 +168,13 @@ static int analogix_dp_read_edid(struct analogix_dp_device *dp)
 			return -EIO;
 		}
 
-		analogix_dp_read_byte_from_dpcd(dp,
-			DP_TEST_REQUEST,
-			&test_vector);
+		analogix_dp_read_byte_from_dpcd(dp, DP_TEST_REQUEST,
+						&test_vector);
 		if (test_vector & DP_TEST_LINK_EDID_READ) {
 			analogix_dp_write_byte_to_dpcd(dp,
-				DP_TEST_EDID_CHECKSUM,
-				edid[EDID_CHECKSUM]);
+				DP_TEST_EDID_CHECKSUM, edid[EDID_CHECKSUM]);
 			analogix_dp_write_byte_to_dpcd(dp,
-				DP_TEST_RESPONSE,
-				DP_TEST_EDID_CHECKSUM_WRITE);
+				DP_TEST_RESPONSE, DP_TEST_EDID_CHECKSUM_WRITE);
 		}
 	}
 
@@ -193,8 +189,7 @@ static int analogix_dp_handle_edid(struct analogix_dp_device *dp)
 	int retval;
 
 	/* Read DPCD DP_DPCD_REV~RECEIVE_PORT1_CAP_1 */
-	retval = analogix_dp_read_bytes_from_dpcd(dp, DP_DPCD_REV,
-				12, buf);
+	retval = analogix_dp_read_bytes_from_dpcd(dp, DP_DPCD_REV, 12, buf);
 	if (retval)
 		return retval;
 
@@ -208,8 +203,9 @@ static int analogix_dp_handle_edid(struct analogix_dp_device *dp)
 	return retval;
 }
 
-static void analogix_dp_enable_rx_to_enhanced_mode(struct analogix_dp_device *dp,
-						bool enable)
+static void
+analogix_dp_enable_rx_to_enhanced_mode(struct analogix_dp_device *dp,
+				       bool enable)
 {
 	u8 data;
 
@@ -217,11 +213,11 @@ static void analogix_dp_enable_rx_to_enhanced_mode(struct analogix_dp_device *dp
 
 	if (enable)
 		analogix_dp_write_byte_to_dpcd(dp, DP_LANE_COUNT_SET,
-			DP_LANE_COUNT_ENHANCED_FRAME_EN |
-			DPCD_LANE_COUNT_SET(data));
+					       DP_LANE_COUNT_ENHANCED_FRAME_EN |
+					       DPCD_LANE_COUNT_SET(data));
 	else
 		analogix_dp_write_byte_to_dpcd(dp, DP_LANE_COUNT_SET,
-			DPCD_LANE_COUNT_SET(data));
+					       DPCD_LANE_COUNT_SET(data));
 }
 
 static int analogix_dp_is_enhanced_mode_available(struct analogix_dp_device *dp)
@@ -248,13 +244,13 @@ static void analogix_dp_training_pattern_dis(struct analogix_dp_device *dp)
 {
 	analogix_dp_set_training_pattern(dp, DP_NONE);
 
-	analogix_dp_write_byte_to_dpcd(dp,
-		DP_TRAINING_PATTERN_SET,
-		DP_TRAINING_PATTERN_DISABLE);
+	analogix_dp_write_byte_to_dpcd(dp, DP_TRAINING_PATTERN_SET,
+				       DP_TRAINING_PATTERN_DISABLE);
 }
 
-static void analogix_dp_set_lane_lane_pre_emphasis(struct analogix_dp_device *dp,
-					int pre_emphasis, int lane)
+static void
+analogix_dp_set_lane_lane_pre_emphasis(struct analogix_dp_device *dp,
+				       int pre_emphasis, int lane)
 {
 	switch (lane) {
 	case 0:
@@ -294,8 +290,7 @@ static int analogix_dp_link_start(struct analogix_dp_device *dp)
 	/* Setup RX configuration */
 	buf[0] = dp->link_train.link_rate;
 	buf[1] = dp->link_train.lane_count;
-	retval = analogix_dp_write_bytes_to_dpcd(dp, DP_LINK_BW_SET,
-				2, buf);
+	retval = analogix_dp_write_bytes_to_dpcd(dp, DP_LINK_BW_SET, 2, buf);
 	if (retval)
 		return retval;
 
@@ -331,7 +326,7 @@ static int analogix_dp_link_start(struct analogix_dp_device *dp)
 			    DP_TRAIN_VOLTAGE_SWING_LEVEL_0;
 
 	retval = analogix_dp_write_bytes_to_dpcd(dp, DP_TRAINING_LANE0_SET,
-			lane_count, buf);
+						 lane_count, buf);
 
 	return retval;
 }
@@ -339,7 +334,7 @@ static int analogix_dp_link_start(struct analogix_dp_device *dp)
 static unsigned char analogix_dp_get_lane_status(u8 link_status[2], int lane)
 {
 	int shift = (lane & 1) * 4;
-	u8 link_value = link_status[lane>>1];
+	u8 link_value = link_status[lane >> 1];
 
 	return (link_value >> shift) & 0xf;
 }
@@ -358,7 +353,7 @@ static int analogix_dp_clock_recovery_ok(u8 link_status[2], int lane_count)
 }
 
 static int analogix_dp_channel_eq_ok(u8 link_status[2], u8 link_align,
-				int lane_count)
+				     int lane_count)
 {
 	int lane;
 	u8 lane_status;
@@ -376,11 +371,11 @@ static int analogix_dp_channel_eq_ok(u8 link_status[2], u8 link_align,
 	return 0;
 }
 
-static unsigned char analogix_dp_get_adjust_request_voltage(u8 adjust_request[2],
-							int lane)
+static unsigned char
+analogix_dp_get_adjust_request_voltage(u8 adjust_request[2], int lane)
 {
 	int shift = (lane & 1) * 4;
-	u8 link_value = adjust_request[lane>>1];
+	u8 link_value = adjust_request[lane >> 1];
 
 	return (link_value >> shift) & 0x3;
 }
@@ -390,13 +385,13 @@ static unsigned char analogix_dp_get_adjust_request_pre_emphasis(
 					int lane)
 {
 	int shift = (lane & 1) * 4;
-	u8 link_value = adjust_request[lane>>1];
+	u8 link_value = adjust_request[lane >> 1];
 
 	return ((link_value >> shift) & 0xc) >> 2;
 }
 
 static void analogix_dp_set_lane_link_training(struct analogix_dp_device *dp,
-					u8 training_lane_set, int lane)
+					       u8 training_lane_set, int lane)
 {
 	switch (lane) {
 	case 0:
@@ -416,9 +411,9 @@ static void analogix_dp_set_lane_link_training(struct analogix_dp_device *dp,
 	}
 }
 
-static unsigned int analogix_dp_get_lane_link_training(
-				struct analogix_dp_device *dp,
-				int lane)
+static unsigned int
+analogix_dp_get_lane_link_training(struct analogix_dp_device *dp,
+				   int lane)
 {
 	u32 reg;
 
@@ -452,7 +447,7 @@ static void analogix_dp_reduce_link_rate(struct analogix_dp_device *dp)
 }
 
 static void analogix_dp_get_adjust_training_lane(struct analogix_dp_device *dp,
-					u8 adjust_request[2])
+						 u8 adjust_request[2])
 {
 	int lane, lane_count;
 	u8 voltage_swing, pre_emphasis, training_lane;
@@ -625,7 +620,7 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 }
 
 static void analogix_dp_get_max_rx_bandwidth(struct analogix_dp_device *dp,
-					u8 *bandwidth)
+					     u8 *bandwidth)
 {
 	u8 data;
 
@@ -638,7 +633,7 @@ static void analogix_dp_get_max_rx_bandwidth(struct analogix_dp_device *dp,
 }
 
 static void analogix_dp_get_max_rx_lane_count(struct analogix_dp_device *dp,
-					u8 *lane_count)
+					      u8 *lane_count)
 {
 	u8 data;
 
@@ -651,8 +646,8 @@ static void analogix_dp_get_max_rx_lane_count(struct analogix_dp_device *dp,
 }
 
 static void analogix_dp_init_training(struct analogix_dp_device *dp,
-			enum link_lane_count_type max_lane,
-			enum link_rate_type max_rate)
+				      enum link_lane_count_type max_lane,
+				      enum link_rate_type max_rate)
 {
 	/*
 	 * MACRO_RST must be applied after the PLL_LOCK to avoid
@@ -665,7 +660,7 @@ static void analogix_dp_init_training(struct analogix_dp_device *dp,
 	analogix_dp_get_max_rx_lane_count(dp, &dp->link_train.lane_count);
 
 	if ((dp->link_train.link_rate != LINK_RATE_1_62GBPS) &&
-	   (dp->link_train.link_rate != LINK_RATE_2_70GBPS)) {
+	    (dp->link_train.link_rate != LINK_RATE_2_70GBPS)) {
 		dev_err(dp->dev, "Rx Max Link Rate is abnormal :%x !\n",
 			dp->link_train.link_rate);
 		dp->link_train.link_rate = LINK_RATE_1_62GBPS;
@@ -725,8 +720,7 @@ static int analogix_dp_sw_link_training(struct analogix_dp_device *dp)
 }
 
 static int analogix_dp_set_link_train(struct analogix_dp_device *dp,
-				u32 count,
-				u32 bwtype)
+				      u32 count, u32 bwtype)
 {
 	int i;
 	int retval;
@@ -762,7 +756,7 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
 		timeout_loop++;
 		if (analogix_dp_is_slave_video_stream_clock_on(dp) == 0)
 			break;
-		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
+		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
 			dev_err(dp->dev, "Timeout of video streamclk ok\n");
 			return -ETIMEDOUT;
 		}
@@ -793,7 +787,7 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
 		} else if (done_count) {
 			done_count = 0;
 		}
-		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
+		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
 			dev_err(dp->dev, "Timeout of video streamclk ok\n");
 			return -ETIMEDOUT;
 		}
@@ -807,25 +801,24 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
 	return retval;
 }
 
-static void analogix_dp_enable_scramble(struct analogix_dp_device *dp, bool enable)
+static void analogix_dp_enable_scramble(struct analogix_dp_device *dp,
+					bool enable)
 {
 	u8 data;
 
 	if (enable) {
 		analogix_dp_enable_scrambling(dp);
 
-		analogix_dp_read_byte_from_dpcd(dp,
-			DP_TRAINING_PATTERN_SET,
-			&data);
+		analogix_dp_read_byte_from_dpcd(dp, DP_TRAINING_PATTERN_SET,
+						&data);
 		analogix_dp_write_byte_to_dpcd(dp,
 			DP_TRAINING_PATTERN_SET,
 			(u8)(data & ~DP_LINK_SCRAMBLING_DISABLE));
 	} else {
 		analogix_dp_disable_scrambling(dp);
 
-		analogix_dp_read_byte_from_dpcd(dp,
-			DP_TRAINING_PATTERN_SET,
-			&data);
+		analogix_dp_read_byte_from_dpcd(dp, DP_TRAINING_PATTERN_SET,
+						&data);
 		analogix_dp_write_byte_to_dpcd(dp,
 			DP_TRAINING_PATTERN_SET,
 			(u8)(data | DP_LINK_SCRAMBLING_DISABLE));
@@ -898,7 +891,7 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 	}
 
 	ret = analogix_dp_set_link_train(dp, dp->video_info->lane_count,
-					dp->video_info->link_rate);
+					 dp->video_info->link_rate);
 	if (ret) {
 		dev_err(dp->dev, "unable to do link train\n");
 		return;
@@ -1130,8 +1123,8 @@ static struct video_info *analogix_dp_dt_parse_pdata(struct device *dev)
 	struct device_node *dp_node = dev->of_node;
 	struct video_info *dp_video_config;
 
-	dp_video_config = devm_kzalloc(dev,
-				sizeof(*dp_video_config), GFP_KERNEL);
+	dp_video_config = devm_kzalloc(dev, sizeof(*dp_video_config),
+				       GFP_KERNEL);
 	if (!dp_video_config)
 		return ERR_PTR(-ENOMEM);
 
@@ -1145,37 +1138,37 @@ static struct video_info *analogix_dp_dt_parse_pdata(struct device *dev)
 		of_property_read_bool(dp_node, "interlaced");
 
 	if (of_property_read_u32(dp_node, "samsung,color-space",
-				&dp_video_config->color_space)) {
+				 &dp_video_config->color_space)) {
 		dev_err(dev, "failed to get color-space\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (of_property_read_u32(dp_node, "samsung,dynamic-range",
-				&dp_video_config->dynamic_range)) {
+				 &dp_video_config->dynamic_range)) {
 		dev_err(dev, "failed to get dynamic-range\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (of_property_read_u32(dp_node, "samsung,ycbcr-coeff",
-				&dp_video_config->ycbcr_coeff)) {
+				 &dp_video_config->ycbcr_coeff)) {
 		dev_err(dev, "failed to get ycbcr-coeff\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (of_property_read_u32(dp_node, "samsung,color-depth",
-				&dp_video_config->color_depth)) {
+				 &dp_video_config->color_depth)) {
 		dev_err(dev, "failed to get color-depth\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (of_property_read_u32(dp_node, "samsung,link-rate",
-				&dp_video_config->link_rate)) {
+				 &dp_video_config->link_rate)) {
 		dev_err(dev, "failed to get link-rate\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (of_property_read_u32(dp_node, "samsung,lane-count",
-				&dp_video_config->lane_count)) {
+				 &dp_video_config->lane_count)) {
 		dev_err(dev, "failed to get lane-count\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -1284,7 +1277,7 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 	pm_runtime_enable(dev);
 
 	ret = devm_request_irq(&pdev->dev, dp->irq, analogix_dp_irq_handler,
-			irq_flags, "analogix-dp", dp);
+			       irq_flags, "analogix-dp", dp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
 		goto err_disable_pm_runtime;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 0fff745..d4c4ae2 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -187,50 +187,55 @@ int analogix_dp_get_plug_in_status(struct analogix_dp_device *dp);
 void analogix_dp_enable_sw_function(struct analogix_dp_device *dp);
 int analogix_dp_start_aux_transaction(struct analogix_dp_device *dp);
 int analogix_dp_write_byte_to_dpcd(struct analogix_dp_device *dp,
-				unsigned int reg_addr,
-				unsigned char data);
+				   unsigned int reg_addr,
+				   unsigned char data);
 int analogix_dp_read_byte_from_dpcd(struct analogix_dp_device *dp,
-				unsigned int reg_addr,
-				unsigned char *data);
+				    unsigned int reg_addr,
+				    unsigned char *data);
 int analogix_dp_write_bytes_to_dpcd(struct analogix_dp_device *dp,
-				unsigned int reg_addr,
-				unsigned int count,
-				unsigned char data[]);
+				    unsigned int reg_addr,
+				    unsigned int count,
+				    unsigned char data[]);
 int analogix_dp_read_bytes_from_dpcd(struct analogix_dp_device *dp,
-				unsigned int reg_addr,
-				unsigned int count,
-				unsigned char data[]);
+				     unsigned int reg_addr,
+				     unsigned int count,
+				     unsigned char data[]);
 int analogix_dp_select_i2c_device(struct analogix_dp_device *dp,
-				unsigned int device_addr,
-				unsigned int reg_addr);
+				  unsigned int device_addr,
+				  unsigned int reg_addr);
 int analogix_dp_read_byte_from_i2c(struct analogix_dp_device *dp,
-				unsigned int device_addr,
-				unsigned int reg_addr,
-				unsigned int *data);
+				   unsigned int device_addr,
+				   unsigned int reg_addr,
+				   unsigned int *data);
 int analogix_dp_read_bytes_from_i2c(struct analogix_dp_device *dp,
-				unsigned int device_addr,
-				unsigned int reg_addr,
-				unsigned int count,
-				unsigned char edid[]);
+				    unsigned int device_addr,
+				    unsigned int reg_addr,
+				    unsigned int count,
+				    unsigned char edid[]);
 void analogix_dp_set_link_bandwidth(struct analogix_dp_device *dp, u32 bwtype);
 void analogix_dp_get_link_bandwidth(struct analogix_dp_device *dp, u32 *bwtype);
 void analogix_dp_set_lane_count(struct analogix_dp_device *dp, u32 count);
 void analogix_dp_get_lane_count(struct analogix_dp_device *dp, u32 *count);
-void analogix_dp_enable_enhanced_mode(struct analogix_dp_device *dp, bool enable);
+void analogix_dp_enable_enhanced_mode(struct analogix_dp_device *dp,
+				      bool enable);
 void analogix_dp_set_training_pattern(struct analogix_dp_device *dp,
-				enum pattern_set pattern);
-void analogix_dp_set_lane0_pre_emphasis(struct analogix_dp_device *dp, u32 level);
-void analogix_dp_set_lane1_pre_emphasis(struct analogix_dp_device *dp, u32 level);
-void analogix_dp_set_lane2_pre_emphasis(struct analogix_dp_device *dp, u32 level);
-void analogix_dp_set_lane3_pre_emphasis(struct analogix_dp_device *dp, u32 level);
+				      enum pattern_set pattern);
+void analogix_dp_set_lane0_pre_emphasis(struct analogix_dp_device *dp,
+					u32 level);
+void analogix_dp_set_lane1_pre_emphasis(struct analogix_dp_device *dp,
+					u32 level);
+void analogix_dp_set_lane2_pre_emphasis(struct analogix_dp_device *dp,
+					u32 level);
+void analogix_dp_set_lane3_pre_emphasis(struct analogix_dp_device *dp,
+					u32 level);
 void analogix_dp_set_lane0_link_training(struct analogix_dp_device *dp,
-				u32 training_lane);
+					 u32 training_lane);
 void analogix_dp_set_lane1_link_training(struct analogix_dp_device *dp,
-				u32 training_lane);
+					 u32 training_lane);
 void analogix_dp_set_lane2_link_training(struct analogix_dp_device *dp,
-				u32 training_lane);
+					 u32 training_lane);
 void analogix_dp_set_lane3_link_training(struct analogix_dp_device *dp,
-				u32 training_lane);
+					 u32 training_lane);
 u32 analogix_dp_get_lane0_link_training(struct analogix_dp_device *dp);
 u32 analogix_dp_get_lane1_link_training(struct analogix_dp_device *dp);
 u32 analogix_dp_get_lane2_link_training(struct analogix_dp_device *dp);
@@ -241,11 +246,12 @@ void analogix_dp_init_video(struct analogix_dp_device *dp);
 void analogix_dp_set_video_color_format(struct analogix_dp_device *dp);
 int analogix_dp_is_slave_video_stream_clock_on(struct analogix_dp_device *dp);
 void analogix_dp_set_video_cr_mn(struct analogix_dp_device *dp,
-			enum clock_recovery_m_value_type type,
-			u32 m_value,
-			u32 n_value);
+				 enum clock_recovery_m_value_type type,
+				 u32 m_value,
+				 u32 n_value);
 void analogix_dp_set_video_timing_mode(struct analogix_dp_device *dp, u32 type);
-void analogix_dp_enable_video_master(struct analogix_dp_device *dp, bool enable);
+void analogix_dp_enable_video_master(struct analogix_dp_device *dp,
+				     bool enable);
 void analogix_dp_start_video(struct analogix_dp_device *dp);
 int analogix_dp_is_video_stream_on(struct analogix_dp_device *dp);
 void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 442cc66..a388c0a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -54,10 +54,10 @@ void analogix_dp_lane_swap(struct analogix_dp_device *dp, bool enable)
 
 	if (enable)
 		reg = LANE3_MAP_LOGIC_LANE_0 | LANE2_MAP_LOGIC_LANE_1 |
-			LANE1_MAP_LOGIC_LANE_2 | LANE0_MAP_LOGIC_LANE_3;
+		      LANE1_MAP_LOGIC_LANE_2 | LANE0_MAP_LOGIC_LANE_3;
 	else
 		reg = LANE3_MAP_LOGIC_LANE_3 | LANE2_MAP_LOGIC_LANE_2 |
-			LANE1_MAP_LOGIC_LANE_1 | LANE0_MAP_LOGIC_LANE_0;
+		      LANE1_MAP_LOGIC_LANE_1 | LANE0_MAP_LOGIC_LANE_0;
 
 	writel(reg, dp->reg_base + ANALOGIX_DP_LANE_MAP);
 }
@@ -202,8 +202,8 @@ void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable)
 }
 
 void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
-				enum analog_power_block block,
-				bool enable)
+				       enum analog_power_block block,
+				       bool enable)
 {
 	u32 reg;
 
@@ -399,8 +399,8 @@ void analogix_dp_init_aux(struct analogix_dp_device *dp)
 	analogix_dp_reset_aux(dp);
 
 	/* Disable AUX transaction H/W retry */
-	reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3) | AUX_HW_RETRY_COUNT_SEL(0)|
-		AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
+	reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3) | AUX_HW_RETRY_COUNT_SEL(0) |
+	      AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
 	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_HW_RETRY_CTL);
 
 	/* Receive AUX Channel DEFER commands equal to DEFFER_COUNT*64 */
@@ -483,8 +483,8 @@ int analogix_dp_start_aux_transaction(struct analogix_dp_device *dp)
 }
 
 int analogix_dp_write_byte_to_dpcd(struct analogix_dp_device *dp,
-				unsigned int reg_addr,
-				unsigned char data)
+				   unsigned int reg_addr,
+				   unsigned char data)
 {
 	u32 reg;
 	int i;
@@ -519,17 +519,16 @@ int analogix_dp_write_byte_to_dpcd(struct analogix_dp_device *dp,
 		retval = analogix_dp_start_aux_transaction(dp);
 		if (retval == 0)
 			break;
-		else
-			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
-				__func__);
+
+		dev_dbg(dp->dev, "%s: Aux Transaction fail!\n", __func__);
 	}
 
 	return retval;
 }
 
 int analogix_dp_read_byte_from_dpcd(struct analogix_dp_device *dp,
-				unsigned int reg_addr,
-				unsigned char *data)
+				    unsigned int reg_addr,
+				    unsigned char *data)
 {
 	u32 reg;
 	int i;
@@ -560,9 +559,8 @@ int analogix_dp_read_byte_from_dpcd(struct analogix_dp_device *dp,
 		retval = analogix_dp_start_aux_transaction(dp);
 		if (retval == 0)
 			break;
-		else
-			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
-				__func__);
+
+		dev_dbg(dp->dev, "%s: Aux Transaction fail!\n", __func__);
 	}
 
 	/* Read data buffer */
@@ -573,9 +571,9 @@ int analogix_dp_read_byte_from_dpcd(struct analogix_dp_device *dp,
 }
 
 int analogix_dp_write_bytes_to_dpcd(struct analogix_dp_device *dp,
-				unsigned int reg_addr,
-				unsigned int count,
-				unsigned char data[])
+				    unsigned int reg_addr,
+				    unsigned int count,
+				    unsigned char data[])
 {
 	u32 reg;
 	unsigned int start_offset;
@@ -608,8 +606,9 @@ int analogix_dp_write_bytes_to_dpcd(struct analogix_dp_device *dp,
 			for (cur_data_idx = 0; cur_data_idx < cur_data_count;
 			     cur_data_idx++) {
 				reg = data[start_offset + cur_data_idx];
-				writel(reg, dp->reg_base + ANALOGIX_DP_BUF_DATA_0
-							  + 4 * cur_data_idx);
+				writel(reg, dp->reg_base +
+				       ANALOGIX_DP_BUF_DATA_0 +
+				       4 * cur_data_idx);
 			}
 
 			/*
@@ -625,9 +624,9 @@ int analogix_dp_write_bytes_to_dpcd(struct analogix_dp_device *dp,
 			retval = analogix_dp_start_aux_transaction(dp);
 			if (retval == 0)
 				break;
-			else
-				dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
-					__func__);
+
+			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
+				__func__);
 		}
 
 		start_offset += cur_data_count;
@@ -637,9 +636,9 @@ int analogix_dp_write_bytes_to_dpcd(struct analogix_dp_device *dp,
 }
 
 int analogix_dp_read_bytes_from_dpcd(struct analogix_dp_device *dp,
-				unsigned int reg_addr,
-				unsigned int count,
-				unsigned char data[])
+				     unsigned int reg_addr,
+				     unsigned int count,
+				     unsigned char data[])
 {
 	u32 reg;
 	unsigned int start_offset;
@@ -683,9 +682,9 @@ int analogix_dp_read_bytes_from_dpcd(struct analogix_dp_device *dp,
 			retval = analogix_dp_start_aux_transaction(dp);
 			if (retval == 0)
 				break;
-			else
-				dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
-					__func__);
+
+			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
+				__func__);
 		}
 
 		for (cur_data_idx = 0; cur_data_idx < cur_data_count;
@@ -703,8 +702,8 @@ int analogix_dp_read_bytes_from_dpcd(struct analogix_dp_device *dp,
 }
 
 int analogix_dp_select_i2c_device(struct analogix_dp_device *dp,
-				unsigned int device_addr,
-				unsigned int reg_addr)
+				  unsigned int device_addr,
+				  unsigned int reg_addr)
 {
 	u32 reg;
 	int retval;
@@ -736,9 +735,9 @@ int analogix_dp_select_i2c_device(struct analogix_dp_device *dp,
 }
 
 int analogix_dp_read_byte_from_i2c(struct analogix_dp_device *dp,
-				unsigned int device_addr,
-				unsigned int reg_addr,
-				unsigned int *data)
+				   unsigned int device_addr,
+				   unsigned int reg_addr,
+				   unsigned int *data)
 {
 	u32 reg;
 	int i;
@@ -750,7 +749,8 @@ int analogix_dp_read_byte_from_i2c(struct analogix_dp_device *dp,
 		writel(reg, dp->reg_base + ANALOGIX_DP_BUFFER_DATA_CTL);
 
 		/* Select EDID device */
-		retval = analogix_dp_select_i2c_device(dp, device_addr, reg_addr);
+		retval = analogix_dp_select_i2c_device(dp, device_addr,
+						       reg_addr);
 		if (retval != 0)
 			continue;
 
@@ -767,9 +767,8 @@ int analogix_dp_read_byte_from_i2c(struct analogix_dp_device *dp,
 		retval = analogix_dp_start_aux_transaction(dp);
 		if (retval == 0)
 			break;
-		else
-			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
-				__func__);
+
+		dev_dbg(dp->dev, "%s: Aux Transaction fail!\n", __func__);
 	}
 
 	/* Read data */
@@ -780,10 +779,10 @@ int analogix_dp_read_byte_from_i2c(struct analogix_dp_device *dp,
 }
 
 int analogix_dp_read_bytes_from_i2c(struct analogix_dp_device *dp,
-				unsigned int device_addr,
-				unsigned int reg_addr,
-				unsigned int count,
-				unsigned char edid[])
+				    unsigned int device_addr,
+				    unsigned int reg_addr,
+				    unsigned int count,
+				    unsigned char edid[])
 {
 	u32 reg;
 	unsigned int i, j;
@@ -828,15 +827,14 @@ int analogix_dp_read_bytes_from_i2c(struct analogix_dp_device *dp,
 				retval = analogix_dp_start_aux_transaction(dp);
 				if (retval == 0)
 					break;
-				else
-					dev_dbg(dp->dev,
-						"%s: Aux Transaction fail!\n",
-						__func__);
+
+				dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
+					__func__);
 			}
 			/* Check if Rx sends defer */
 			reg = readl(dp->reg_base + ANALOGIX_DP_AUX_RX_COMM);
 			if (reg == AUX_RX_COMM_AUX_DEFER ||
-				reg == AUX_RX_COMM_I2C_DEFER) {
+			    reg == AUX_RX_COMM_I2C_DEFER) {
 				dev_err(dp->dev, "Defer: %d\n\n", reg);
 				defer = 1;
 			}
@@ -885,7 +883,8 @@ void analogix_dp_get_lane_count(struct analogix_dp_device *dp, u32 *count)
 	*count = reg;
 }
 
-void analogix_dp_enable_enhanced_mode(struct analogix_dp_device *dp, bool enable)
+void analogix_dp_enable_enhanced_mode(struct analogix_dp_device *dp,
+				      bool enable)
 {
 	u32 reg;
 
@@ -901,7 +900,7 @@ void analogix_dp_enable_enhanced_mode(struct analogix_dp_device *dp, bool enable
 }
 
 void analogix_dp_set_training_pattern(struct analogix_dp_device *dp,
-				enum pattern_set pattern)
+				      enum pattern_set pattern)
 {
 	u32 reg;
 
@@ -933,7 +932,8 @@ void analogix_dp_set_training_pattern(struct analogix_dp_device *dp,
 	}
 }
 
-void analogix_dp_set_lane0_pre_emphasis(struct analogix_dp_device *dp, u32 level)
+void analogix_dp_set_lane0_pre_emphasis(struct analogix_dp_device *dp,
+					u32 level)
 {
 	u32 reg;
 
@@ -943,7 +943,8 @@ void analogix_dp_set_lane0_pre_emphasis(struct analogix_dp_device *dp, u32 level
 	writel(reg, dp->reg_base + ANALOGIX_DP_LN0_LINK_TRAINING_CTL);
 }
 
-void analogix_dp_set_lane1_pre_emphasis(struct analogix_dp_device *dp, u32 level)
+void analogix_dp_set_lane1_pre_emphasis(struct analogix_dp_device *dp,
+					u32 level)
 {
 	u32 reg;
 
@@ -953,7 +954,8 @@ void analogix_dp_set_lane1_pre_emphasis(struct analogix_dp_device *dp, u32 level
 	writel(reg, dp->reg_base + ANALOGIX_DP_LN1_LINK_TRAINING_CTL);
 }
 
-void analogix_dp_set_lane2_pre_emphasis(struct analogix_dp_device *dp, u32 level)
+void analogix_dp_set_lane2_pre_emphasis(struct analogix_dp_device *dp,
+					u32 level)
 {
 	u32 reg;
 
@@ -963,7 +965,8 @@ void analogix_dp_set_lane2_pre_emphasis(struct analogix_dp_device *dp, u32 level
 	writel(reg, dp->reg_base + ANALOGIX_DP_LN2_LINK_TRAINING_CTL);
 }
 
-void analogix_dp_set_lane3_pre_emphasis(struct analogix_dp_device *dp, u32 level)
+void analogix_dp_set_lane3_pre_emphasis(struct analogix_dp_device *dp,
+					u32 level)
 {
 	u32 reg;
 
@@ -974,7 +977,7 @@ void analogix_dp_set_lane3_pre_emphasis(struct analogix_dp_device *dp, u32 level
 }
 
 void analogix_dp_set_lane0_link_training(struct analogix_dp_device *dp,
-					u32 training_lane)
+					 u32 training_lane)
 {
 	u32 reg;
 
@@ -983,7 +986,7 @@ void analogix_dp_set_lane0_link_training(struct analogix_dp_device *dp,
 }
 
 void analogix_dp_set_lane1_link_training(struct analogix_dp_device *dp,
-					u32 training_lane)
+					 u32 training_lane)
 {
 	u32 reg;
 
@@ -1001,7 +1004,7 @@ void analogix_dp_set_lane2_link_training(struct analogix_dp_device *dp,
 }
 
 void analogix_dp_set_lane3_link_training(struct analogix_dp_device *dp,
-					u32 training_lane)
+					 u32 training_lane)
 {
 	u32 reg;
 
@@ -1125,9 +1128,8 @@ int analogix_dp_is_slave_video_stream_clock_on(struct analogix_dp_device *dp)
 }
 
 void analogix_dp_set_video_cr_mn(struct analogix_dp_device *dp,
-		enum clock_recovery_m_value_type type,
-		u32 m_value,
-		u32 n_value)
+				 enum clock_recovery_m_value_type type,
+				 u32 m_value, u32 n_value)
 {
 	u32 reg;
 
@@ -1221,7 +1223,7 @@ void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp)
 	u32 reg;
 
 	reg = readl(dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
-	reg &= ~(MASTER_VID_FUNC_EN_N|SLAVE_VID_FUNC_EN_N);
+	reg &= ~(MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N);
 	reg |= MASTER_VID_FUNC_EN_N;
 	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
 
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index 8456794..8ae3d51 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -204,7 +204,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 }
 
 static void exynos_dp_unbind(struct device *dev, struct device *master,
-				void *data)
+			     void *data)
 {
 	return analogix_dp_unbind(dev, master, data);
 }
@@ -221,7 +221,7 @@ static int exynos_dp_probe(struct platform_device *pdev)
 	struct exynos_dp_device *dp;
 
 	dp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
-				GFP_KERNEL);
+			  GFP_KERNEL);
 	if (!dp)
 		return -ENOMEM;
 
-- 
2.6.4
