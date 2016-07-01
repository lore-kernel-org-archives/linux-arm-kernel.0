From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  1 Jul 2016 14:18:59 -0700
Subject: [PATCH] soc: qcom: smem: Silence probe defer error
Message-ID: <20160701211859.23471-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we fail to get the hwspinlock due to probe defer, we shouldn't
print an error message. Just be silent in this case.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/soc/qcom/smem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 2e1aa9f130f4..18ec52f2078a 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -740,7 +740,8 @@ static int qcom_smem_probe(struct platform_device *pdev)
 
 	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
 	if (hwlock_id < 0) {
-		dev_err(&pdev->dev, "failed to retrieve hwlock\n");
+		if (hwlock_id != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to retrieve hwlock\n");
 		return hwlock_id;
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
