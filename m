From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 18 Oct 2017 16:28:44 +0800
Subject: [PATCH v6 3/7] soc: mediatek: pwrap: add pwrap_write32 for writing in
 32-bit mode
In-Reply-To: <cover.1508313105.git.sean.wang@mediatek.com>
References: <cover.1508313105.git.sean.wang@mediatek.com>
Message-ID: <d472e89001ea1539ac1d09924661d394c9bea1d6.1508313105.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Some regulators such as MediaTek MT6380 also has to be written in
32-bit mode. So the patch adds pwrap_write32, rename old pwrap_write
into pwrap_write16 and one additional function pointer is introduced
for increasing flexibility allowing the determination which mode is
used by the pwrap slave detection through device tree.

Signed-off-by: Chenglin Xu <chenglin.xu@mediatek.com>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 70 +++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 06930e2..2d3a8fa 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -507,6 +507,7 @@ struct pwrap_slv_type {
 	 * which type is used by the detection through device tree.
 	 */
 	int (*pwrap_read)(struct pmic_wrapper *wrp, u32 adr, u32 *rdata);
+	int (*pwrap_write)(struct pmic_wrapper *wrp, u32 adr, u32 wdata);
 };
 
 struct pmic_wrapper {
@@ -601,22 +602,6 @@ static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
 	} while (1);
 }
 
-static int pwrap_write(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
-{
-	int ret;
-
-	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
-	if (ret) {
-		pwrap_leave_fsm_vldclr(wrp);
-		return ret;
-	}
-
-	pwrap_writel(wrp, (1 << 31) | ((adr >> 1) << 16) | wdata,
-			PWRAP_WACS2_CMD);
-
-	return 0;
-}
-
 static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 {
 	int ret;
@@ -673,6 +658,56 @@ static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 	return wrp->slave->pwrap_read(wrp, adr, rdata);
 }
 
+static int pwrap_write16(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
+{
+	int ret;
+
+	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
+	if (ret) {
+		pwrap_leave_fsm_vldclr(wrp);
+		return ret;
+	}
+
+	pwrap_writel(wrp, (1 << 31) | ((adr >> 1) << 16) | wdata,
+		     PWRAP_WACS2_CMD);
+
+	return 0;
+}
+
+static int pwrap_write32(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
+{
+	int ret, msb, rdata;
+
+	for (msb = 0; msb < 2; msb++) {
+		ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
+		if (ret) {
+			pwrap_leave_fsm_vldclr(wrp);
+			return ret;
+		}
+
+		pwrap_writel(wrp, (1 << 31) | (msb << 30) | (adr << 16) |
+			     ((wdata >> (msb * 16)) & 0xffff),
+			     PWRAP_WACS2_CMD);
+
+		/*
+		 * The pwrap_read operation is the requirement of hardware used
+		 * for the synchronization between two successive 16-bit
+		 * pwrap_writel operations composing one 32-bit bus writing.
+		 * Otherwise, we'll find the result fails on the lower 16-bit
+		 * pwrap writing.
+		 */
+		if (!msb)
+			pwrap_read(wrp, adr, &rdata);
+	}
+
+	return 0;
+}
+
+static int pwrap_write(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
+{
+	return wrp->slave->pwrap_write(wrp, adr, wdata);
+}
+
 static int pwrap_regmap_read(void *context, u32 adr, u32 *rdata)
 {
 	return pwrap_read(context, adr, rdata);
@@ -1082,18 +1117,21 @@ static const struct pwrap_slv_type pmic_mt6323 = {
 	.dew_regs = mt6323_regs,
 	.type = PMIC_MT6323,
 	.pwrap_read = pwrap_read16,
+	.pwrap_write = pwrap_write16,
 };
 
 static const struct pwrap_slv_type pmic_mt6380 = {
 	.dew_regs = NULL,
 	.type = PMIC_MT6380,
 	.pwrap_read = pwrap_read32,
+	.pwrap_write = pwrap_write32,
 };
 
 static const struct pwrap_slv_type pmic_mt6397 = {
 	.dew_regs = mt6397_regs,
 	.type = PMIC_MT6397,
 	.pwrap_read = pwrap_read16,
+	.pwrap_write = pwrap_write16,
 };
 
 static const struct of_device_id of_slave_match_tbl[] = {
-- 
2.7.4
