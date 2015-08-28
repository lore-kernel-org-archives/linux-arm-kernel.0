From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 28 Aug 2015 12:21:42 -0700
Subject: [PATCH] spmi: pmic-arb: Don't byte swap when reading/writing FIFO
Message-ID: <1440789702-1648-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't want to swap bytes that we're reading and writing to the
FIFOs when we're running on a big-endian CPU. Doing so causes
problems like where the qcom-spmi-iadc driver can't detect the
type of device because the bytes are all mixed up. Use the raw IO
accessors for these API instead, and collapse pmic_arb_base_read()
into the byte reading API so that we aren't tempted to read non-FIFO
data like commands with that function.

Cc: Andy Gross <agross@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/spmi/spmi-pmic-arb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index bdfb3c84c3cb..5e834bd23c09 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -168,11 +168,6 @@ struct pmic_arb_ver_ops {
 	u32 (*irq_clear)(u8 n);
 };
 
-static inline u32 pmic_arb_base_read(struct spmi_pmic_arb_dev *dev, u32 offset)
-{
-	return readl_relaxed(dev->rd_base + offset);
-}
-
 static inline void pmic_arb_base_write(struct spmi_pmic_arb_dev *dev,
 				       u32 offset, u32 val)
 {
@@ -193,7 +188,7 @@ static inline void pmic_arb_set_rd_cmd(struct spmi_pmic_arb_dev *dev,
  */
 static void pa_read_data(struct spmi_pmic_arb_dev *dev, u8 *buf, u32 reg, u8 bc)
 {
-	u32 data = pmic_arb_base_read(dev, reg);
+	u32 data = __raw_readl(dev->rd_base + reg);
 	memcpy(buf, &data, (bc & 3) + 1);
 }
 
@@ -208,7 +203,7 @@ pa_write_data(struct spmi_pmic_arb_dev *dev, const u8 *buf, u32 reg, u8 bc)
 {
 	u32 data = 0;
 	memcpy(&data, buf, (bc & 3) + 1);
-	pmic_arb_base_write(dev, reg, data);
+	__raw_writel(data, dev->wr_base + reg);
 }
 
 static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
