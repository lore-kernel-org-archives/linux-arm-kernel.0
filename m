From: njaigane@codeaurora.org (njaigane at codeaurora.org)
Date: Fri, 15 Jul 2016 12:37:05 +0530
Subject: [PATCH 3/4] qcom: ipq4019: ASoC tlmm/pinctrl support
In-Reply-To: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
References: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
Message-ID: <1468566426-19598-4-git-send-email-njaigane@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaiganesh Narayanan <njaigane@codeaurora.org>

This patch adds the tlmm/pinctrl support for IPQ4019 ASoC.

Signed-off-by: Jaiganesh Narayanan <njaigane@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-ipq4019.c | 116 +++++++++++++++++++++++++--------
 1 file changed, 88 insertions(+), 28 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
index b68ae42..bc22597 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -283,6 +283,18 @@ enum ipq4019_functions {
 	qca_mux_blsp_uart0,
 	qca_mux_blsp_spi1,
 	qca_mux_blsp_spi0,
+	qca_mux_i2s_rx_mclk,
+	qca_mux_i2s_rx_bclk,
+	qca_mux_i2s_rx_fsync,
+	qca_mux_i2s_rxd,
+	qca_mux_i2s_tx_mclk,
+	qca_mux_i2s_tx_bclk,
+	qca_mux_i2s_tx_fsync,
+	qca_mux_i2s_txd1,
+	qca_mux_i2s_txd2,
+	qca_mux_i2s_txd3,
+	qca_mux_i2s_spdif_out,
+	qca_mux_i2s_spdif_in,
 	qca_mux_NA,
 };
 
@@ -304,6 +316,42 @@ static const char * const gpio_groups[] = {
 	"gpio99",
 };
 
+static const char * const i2s_rx_bclk_groups[] = {
+	"gpio0", "gpio21", "gpio60",
+};
+static const char * const i2s_rx_mclk_groups[] = {
+	"gpio20", "gpio58",
+};
+static const char * const i2s_rx_fsync_groups[] = {
+	"gpio1", "gpio22", "gpio61",
+};
+static const char * const i2s_rxd_groups[] = {
+	"gpio2", "gpio23", "gpio63",
+};
+static const char * const i2s_tx_bclk_groups[] = {
+	"gpio25", "gpio53", "gpio60",
+};
+static const char * const i2s_tx_mclk_groups[] = {
+	"gpio24", "gpio52",
+};
+static const char * const i2s_tx_fsync_groups[] = {
+	"gpio26", "gpio57", "gpio61",
+};
+static const char * const i2s_txd1_groups[] = {
+	"gpio27", "gpio54", "gpio63",
+};
+static const char * const i2s_txd2_groups[] = {
+	"gpio28", "gpio55",
+};
+static const char * const i2s_txd3_groups[] = {
+	"gpio29", "gpio56",
+};
+static const char * const i2s_spdif_out_groups[] = {
+	"gpio35", "gpio62", "gpio63",
+};
+static const char * const i2s_spdif_in_groups[] = {
+	"gpio34", "gpio59", "gpio63",
+};
 static const char * const blsp_uart1_groups[] = {
 	"gpio8", "gpio9", "gpio10", "gpio11",
 };
@@ -332,12 +380,24 @@ static const struct msm_function ipq4019_functions[] = {
 	FUNCTION(blsp_uart0),
 	FUNCTION(blsp_spi1),
 	FUNCTION(blsp_spi0),
+	FUNCTION(i2s_rx_mclk),
+	FUNCTION(i2s_rx_bclk),
+	FUNCTION(i2s_rx_fsync),
+	FUNCTION(i2s_rxd),
+	FUNCTION(i2s_tx_mclk),
+	FUNCTION(i2s_tx_bclk),
+	FUNCTION(i2s_tx_fsync),
+	FUNCTION(i2s_txd1),
+	FUNCTION(i2s_txd2),
+	FUNCTION(i2s_txd3),
+	FUNCTION(i2s_spdif_out),
+	FUNCTION(i2s_spdif_in),
 };
 
 static const struct msm_pingroup ipq4019_groups[] = {
-	PINGROUP(0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(1, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(2, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(0, NA, NA, i2s_rx_bclk, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(1, NA, NA, i2s_rx_fsync, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(2, NA, NA, i2s_rxd, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(3, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(4, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(5, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
@@ -355,22 +415,22 @@ static const struct msm_pingroup ipq4019_groups[] = {
 	PINGROUP(17, blsp_uart0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(18, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(19, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(20, blsp_i2c0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(21, blsp_i2c0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(22, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(23, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(24, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(25, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(26, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(27, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(28, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(29, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(20, blsp_i2c0, i2s_rx_mclk, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(21, blsp_i2c0, i2s_rx_bclk, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(22, NA, i2s_rx_fsync, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(23, NA, NA, i2s_rxd, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(24, NA, NA, i2s_tx_mclk, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(25, NA, NA, i2s_tx_bclk, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(26, NA, NA, i2s_tx_fsync, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(27, NA, NA, i2s_txd1, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(28, NA, NA, i2s_txd2, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(29, NA, NA, i2s_txd3, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(30, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(31, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(32, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(33, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(34, blsp_i2c1, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(35, blsp_i2c1, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(34, blsp_i2c1, i2s_spdif_in, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(35, blsp_i2c1, i2s_spdif_out, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(36, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(37, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(38, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
@@ -387,18 +447,18 @@ static const struct msm_pingroup ipq4019_groups[] = {
 	PINGROUP(49, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(50, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(51, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(52, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(53, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(54, NA, blsp_spi0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(55, NA, blsp_spi0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(56, NA, blsp_spi0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(57, NA, blsp_spi0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(58, NA, NA, blsp_i2c0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(59, NA, blsp_i2c0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(60, NA, blsp_uart0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(61, NA, blsp_uart0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(62, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(63, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(52, NA, NA, NA, i2s_tx_mclk, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(53, NA, NA, i2s_tx_bclk, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(54, NA, blsp_spi0, i2s_txd1, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(55, NA, blsp_spi0, i2s_txd2, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(56, NA, blsp_spi0, i2s_txd3, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(57, NA, blsp_spi0, i2s_tx_fsync, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(58, NA, NA, blsp_i2c0, NA, NA, i2s_rx_mclk, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(59, NA, blsp_i2c0, NA, NA, i2s_spdif_in, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(60, NA, blsp_uart0, NA, NA, NA, i2s_tx_bclk, i2s_rx_bclk, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(61, NA, blsp_uart0, NA, NA, NA, i2s_tx_fsync, i2s_rx_fsync, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(62, NA, NA, NA, NA, i2s_spdif_out, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(63, NA, NA, NA, NA, i2s_txd1, i2s_rxd, i2s_spdif_out, i2s_spdif_in, NA, NA, NA, NA, NA, NA),
 	PINGROUP(64, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(65, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(66, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
