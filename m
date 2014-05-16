From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 May 2014 10:05:14 -0700
Subject: [PATCH] clk: qcom: Fix msm8660 GCC probe
Message-ID: <1400259914-28121-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When consolidating the msm8660 GCC probe code I forgot to keep
around these temporary clock registrations. Put them back so the
clock tree is not entirely orphaned.

Fixes: 49fc825f0cc2 (clk: qcom: Consolidate common probe code)
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8660.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8660.c b/drivers/clk/qcom/gcc-msm8660.c
index 44bc6fa64d78..0c4b727ae429 100644
--- a/drivers/clk/qcom/gcc-msm8660.c
+++ b/drivers/clk/qcom/gcc-msm8660.c
@@ -2718,6 +2718,18 @@ MODULE_DEVICE_TABLE(of, gcc_msm8660_match_table);
 
 static int gcc_msm8660_probe(struct platform_device *pdev)
 {
+	struct clk *clk;
+	struct device *dev = &pdev->dev;
+
+	/* Temporary until RPM clocks supported */
+	clk = clk_register_fixed_rate(dev, "cxo", NULL, CLK_IS_ROOT, 19200000);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	clk = clk_register_fixed_rate(dev, "pxo", NULL, CLK_IS_ROOT, 27000000);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
 	return qcom_cc_probe(pdev, &gcc_msm8660_desc);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
