From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 17 Nov 2015 16:06:44 -0800
Subject: [PATCH] mfd: qcom-spmi-pmic: Don't access non-existing registers
Message-ID: <1447805204-32483-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>

Revision ID registers are available only on devices with
Slave IDs that are even, so don't make access to unavailable
registers.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
[sboyd at codeaurora.org: Consider all slave ids that are even]
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/mfd/qcom-spmi-pmic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index af6ac1c4b45c..8653e8b9bb4f 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -127,7 +127,9 @@ static int pmic_spmi_probe(struct spmi_device *sdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	pmic_spmi_show_revid(regmap, &sdev->dev);
+	/* Only the first slave id for a PMIC contains this information */
+	if (sdev->usid % 2 == 0)
+		pmic_spmi_show_revid(regmap, &sdev->dev);
 
 	return of_platform_populate(root, NULL, NULL, &sdev->dev);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
