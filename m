From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 13:47:33 +0100
Subject: [PATCH] regulator: ab8500-ext: Don't register without initialisation
 data
In-Reply-To: <1369226853-16978-1-git-send-email-lee.jones@linaro.org>
References: <1369226853-16978-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1369226853-16978-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a bug introduced in the v3.10 merge window.

Some platforms will not want external registers. Rather than setting up
lots of different clauses in the core ab8500 regulator driver not to
call ab8500-ext init() we just won't pass the initialisation data from
platform code. This patch checks for it and if it's missing, we won't
register the external regulators.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500-ext.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index b4d4547..8421537 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -334,6 +334,12 @@ int ab8500_ext_regulator_init(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/* have any external regulators been specified? */
+	if (pdata->num_ext_regulator == 0) {
+		dev_warn(&pdev->dev, "Not using external regulators\n");
+		return 0;
+	}
+
 	/* make sure the platform data has the correct size */
 	if (pdata->num_ext_regulator != ARRAY_SIZE(ab8500_ext_regulator_info)) {
 		dev_err(&pdev->dev, "Configuration error: size mismatch.\n");
-- 
1.7.10.4
