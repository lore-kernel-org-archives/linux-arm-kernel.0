From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 16 Oct 2017 15:07:39 +0800
Subject: [PATCH v5 2/7] soc: mediatek: pwrap: add pwrap_read32 for reading in
 32-bit mode
In-Reply-To: <cover.1508135937.git.sean.wang@mediatek.com>
References: <cover.1508135937.git.sean.wang@mediatek.com>
Message-ID: <7a67dca4843196941e5fc2e03a7f71199a9a32a9.1508135937.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Some regulators such as MediaTek MT6380 has to be read in 32-bit mode.
So the patch adds pwrap_read32, rename old pwrap_read into pwrap_read16
and one function pointer is introduced for increasing flexibility allowing
the determination which mode is used by the pwrap slave detection through
device tree.

Signed-off-by: Chenglin Xu <chenglin.xu@mediatek.com>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 54 +++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index c204838..db55f13 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -487,6 +487,7 @@ static int mt8135_regs[] = {
 
 enum pmic_type {
 	PMIC_MT6323,
+	PMIC_MT6380,
 	PMIC_MT6397,
 };
 
@@ -496,9 +497,15 @@ enum pwrap_type {
 	PWRAP_MT8173,
 };
 
+struct pmic_wrapper;
 struct pwrap_slv_type {
 	const u32 *dew_regs;
 	enum pmic_type type;
+	/* pwrap operations are highly associated with the PMIC types,
+	 * so the pointers added increases flexibility allowing determination
+	 * which type is used by the detection through device tree.
+	 */
+	int (*pwrap_read)(struct pmic_wrapper *wrp, u32 adr, u32 *rdata);
 };
 
 struct pmic_wrapper {
@@ -609,7 +616,7 @@ static int pwrap_write(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
 	return 0;
 }
 
-static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
+static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 {
 	int ret;
 
@@ -632,6 +639,39 @@ static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 	return 0;
 }
 
+static int pwrap_read32(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
+{
+	int ret, msb;
+
+	*rdata = 0;
+	for (msb = 0; msb < 2; msb++) {
+		ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
+		if (ret) {
+			pwrap_leave_fsm_vldclr(wrp);
+			return ret;
+		}
+
+		pwrap_writel(wrp, ((msb << 30) | (adr << 16)),
+			     PWRAP_WACS2_CMD);
+
+		ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
+		if (ret)
+			return ret;
+
+		*rdata += (PWRAP_GET_WACS_RDATA(pwrap_readl(wrp,
+			   PWRAP_WACS2_RDATA)) << (16 * msb));
+
+		pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
+	}
+
+	return 0;
+}
+
+static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
+{
+	return wrp->slave->pwrap_read(wrp, adr, rdata);
+}
+
 static int pwrap_regmap_read(void *context, u32 adr, u32 *rdata)
 {
 	return pwrap_read(context, adr, rdata);
@@ -752,6 +792,8 @@ static int pwrap_mt2701_init_reg_clock(struct pmic_wrapper *wrp)
 		pwrap_writel(wrp, 0x2, PWRAP_CSLEXT_START);
 		pwrap_writel(wrp, 0x2, PWRAP_CSLEXT_END);
 		break;
+	default:
+		break;
 	}
 
 	return 0;
@@ -815,6 +857,8 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 		pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_EN],
 			    0x1);
 		break;
+	default:
+		break;
 	}
 
 	/* wait for cipher data ready at AP */
@@ -1035,11 +1079,19 @@ static const struct regmap_config pwrap_regmap_config = {
 static const struct pwrap_slv_type pmic_mt6323 = {
 	.dew_regs = mt6323_regs,
 	.type = PMIC_MT6323,
+	.pwrap_read = pwrap_read16,
+};
+
+static const struct pwrap_slv_type pmic_mt6380 = {
+	.dew_regs = NULL,
+	.type = PMIC_MT6380,
+	.pwrap_read = pwrap_read32,
 };
 
 static const struct pwrap_slv_type pmic_mt6397 = {
 	.dew_regs = mt6397_regs,
 	.type = PMIC_MT6397,
+	.pwrap_read = pwrap_read16,
 };
 
 static const struct of_device_id of_slave_match_tbl[] = {
-- 
2.7.4
