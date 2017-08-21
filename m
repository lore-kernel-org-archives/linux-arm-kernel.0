From: jun.gao@mediatek.com (Jun Gao)
Date: Mon, 21 Aug 2017 11:36:54 +0800
Subject: [PATCH v4 3/3] i2c: mediatek: Add i2c compatible for MediaTek MT7622
In-Reply-To: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
References: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
Message-ID: <1503286614-17670-4-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Gao <jun.gao@mediatek.com>

Add i2c compatible for MT7622. Compare to MT8173 i2c controller,
MT7622 limits message numbers to 255, and does not support 4GB
DMA mode.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 9bedf0b..09d288c 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -172,6 +172,10 @@ struct mtk_i2c {
 	.max_comb_2nd_msg_len = 31,
 };
 
+static const struct i2c_adapter_quirks mt7622_i2c_quirks = {
+	.max_num_msgs = 255,
+};
+
 static const struct mtk_i2c_compatible mt6577_compat = {
 	.quirks = &mt6577_i2c_quirks,
 	.pmic_i2c = 0,
@@ -190,6 +194,15 @@ struct mtk_i2c {
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
@@ -201,6 +214,7 @@ struct mtk_i2c {
 static const struct of_device_id mtk_i2c_of_match[] = {
 	{ .compatible = "mediatek,mt6577-i2c", .data = &mt6577_compat },
 	{ .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
+	{ .compatible = "mediatek,mt7622-i2c", .data = &mt7622_compat },
 	{ .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
 	{}
 };
-- 
1.8.1.1
