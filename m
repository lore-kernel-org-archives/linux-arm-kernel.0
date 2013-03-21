From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:09 +0000
Subject: [PATCH 12/46] regulator: ab8500: Init debug from regulator driver
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this patch is to guarantee that ab8500-debug will
record the regulator registers before they are modified by the
ab8500 regulator driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c       |   10 ++++++++++
 include/linux/regulator/ab8500.h |   14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index dfe191c..74620cc 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -962,6 +962,11 @@ static int ab8500_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/* initialize debug (initial state is recorded with this call) */
+	err = ab8500_regulator_debug_init(pdev);
+	if (err)
+		return err;
+
 	/* initialize registers */
 	for (i = 0; i < pdata->num_reg_init; i++) {
 		int id, mask, value;
@@ -1012,6 +1017,11 @@ static int ab8500_regulator_remove(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	/* remove regulator debug */
+	err = ab8500_regulator_debug_exit(pdev);
+	if (err)
+		return err;
+
 	return 0;
 }
 
diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index 9a2da6a..094d24c 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -190,4 +190,18 @@ inline int ab8500_ext_regulator_exit(struct platform_device *pdev)
 }
 #endif
 
+#ifdef CONFIG_REGULATOR_AB8500_DEBUG
+int ab8500_regulator_debug_init(struct platform_device *pdev);
+int ab8500_regulator_debug_exit(struct platform_device *pdev);
+#else
+static inline int ab8500_regulator_debug_init(struct platform_device *pdev)
+{
+	return 0;
+}
+static inline int ab8500_regulator_debug_exit(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 #endif
-- 
1.7.10.4
