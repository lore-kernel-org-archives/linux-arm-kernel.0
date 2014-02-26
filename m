From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Feb 2014 11:05:54 -0800
Subject: [PATCH v3 1/9] Input: pmic8xxx-pwrkey - Migrate to regmap APIs
In-Reply-To: <1393441562-685-1-git-send-email-sboyd@codeaurora.org>
References: <1393441562-685-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1393441562-685-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the regmap APIs for this driver instead of custom pm8xxx
APIs. This breaks this driver's dependency on the pm8xxx APIs and
allows us to easily port it to other bus protocols in the future.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/input/misc/pmic8xxx-pwrkey.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index 0e1a05f95858..cf6125dc3b51 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -120,6 +120,10 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
 	input_set_capability(pwr, EV_KEY, KEY_POWER);
 
 	pwr->name = "pmic8xxx_pwrkey";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
