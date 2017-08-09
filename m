From: jun.gao@mediatek.com (Jun Gao)
Date: Wed, 9 Aug 2017 15:43:51 +0800
Subject: [PATCH 2/2] i2c: mediatek: Add i2c compatible for MediaTek MT7622
In-Reply-To: <1502264631-12572-1-git-send-email-jun.gao@mediatek.com>
References: <1502264631-12572-1-git-send-email-jun.gao@mediatek.com>
Message-ID: <1502264631-12572-3-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Gao <jun.gao@mediatek.com>

Add i2c compatible for MT7622. Compare to MT8173 i2c controller,
MT7622 limit message size to 255, and not support 4GB DMA mode.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 9bedf0b..2c7f847 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -172,6 +172,14 @@ struct mtk_i2c {
 	.max_comb_2nd_msg_len = 31,
 };
 
+static const struct i2c_adapter_quirks mt7622_i2c_quirks = {
+	.max_num_msgs = 255,
+	.max_write_len = 65535,
+	.max_read_len = 65535,
+	.max_comb_1st_msg_len = 65535,
+	.max_comb_2nd_msg_len = 65535,
+};
+
 static const struct mtk_i2c_compatible mt6577_compat = {
 	.quirks = &mt6577_i2c_quirks,
 	.pmic_i2c = 0,
@@ -190,6 +198,15 @@ struct mtk_i2c {
 	.support_33bits = 0,
 };
 
+static const struct mtk_i2c_compatible mt7622_compat = {
+	.quirks = &mt7622_i2c_quirks,
+	.pmic_i2c = 0,
+	.dcm = 1,
+	.auto_restart = 1,
+	.aux_len_reg = 1,
+	.support_33bits = 0,
+};
+
 static const struct mtk_i2c_compatible mt8173_compat = {
 	.pmic_i2c = 0,
 	.dcm = 1,
@@ -201,6 +218,7 @@ struct mtk_i2c {
 static const struct of_device_id mtk_i2c_of_match[] = {
 	{ .compatible = "mediatek,mt6577-i2c", .data = &mt6577_compat },
 	{ .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
+	{ .compatible = "mediatek,mt7622-i2c", .data = &mt7622_compat },
 	{ .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
 	{}
 };
-- 
1.8.1.1
