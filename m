From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 21 Jun 2018 10:17:56 -0500
Subject: [PATCH 2/2] hwrng: msm: add ACPI support
In-Reply-To: <1529594276-12210-1-git-send-email-timur@codeaurora.org>
References: <1529594276-12210-1-git-send-email-timur@codeaurora.org>
Message-ID: <1529594276-12210-2-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for probing on ACPI systems, with ACPI HID QCOM8160.

On ACPI systems, clocks are always enabled, the PRNG should
already be enabled, and the register region is read-only.
The driver only verifies that the hardware is already
enabled never tries to disable or configure it.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/char/hw_random/msm-rng.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hw_random/msm-rng.c b/drivers/char/hw_random/msm-rng.c
index 44580588b938..f34713d23d77 100644
--- a/drivers/char/hw_random/msm-rng.c
+++ b/drivers/char/hw_random/msm-rng.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/acpi.h>
 
 /* Device specific register offsets */
 #define PRNG_DATA_OUT		0x0000
@@ -186,16 +187,32 @@ static int msm_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->base))
 		return PTR_ERR(rng->base);
 
-	rng->clk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(rng->clk))
-		return PTR_ERR(rng->clk);
-
 	rng->hwrng.name = KBUILD_MODNAME;
-	rng->hwrng.init = msm_rng_init;
-	rng->hwrng.cleanup = msm_rng_cleanup;
 	rng->hwrng.read = msm_rng_read;
 	spin_lock_init(&rng->lock);
 
+	/*
+	 * ACPI systems have v2 hardware. The clocks are always enabled,
+	 * the PRNG register space is read-only, and the PRNG should
+	 * already be enabled.
+	 */
+	if (has_acpi_companion(&pdev->dev)) {
+		u32 val;
+
+		val = readl(rng->base + PRNG_CONFIG);
+		if (!(val & PRNG_CONFIG_HW_ENABLE)) {
+			dev_err(&pdev->dev, "device is not enabled\n");
+			return -ENODEV;
+		}
+	} else {
+		rng->clk = devm_clk_get(&pdev->dev, "core");
+		if (IS_ERR(rng->clk))
+			return PTR_ERR(rng->clk);
+
+		rng->hwrng.init = msm_rng_init;
+		rng->hwrng.cleanup = msm_rng_cleanup;
+	}
+
 	ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register hwrng\n");
@@ -211,11 +228,22 @@ static int msm_rng_probe(struct platform_device *pdev)
 };
 MODULE_DEVICE_TABLE(of, msm_rng_of_match);
 
+#if IS_ENABLED(CONFIG_ACPI)
+static const struct acpi_device_id msm_rng_acpi_match[] = {
+	{
+		.id = "QCOM8160",	/* v2 PRNG */
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, msm_rng_acpi_match);
+#endif
+
 static struct platform_driver msm_rng_driver = {
 	.probe = msm_rng_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = of_match_ptr(msm_rng_of_match),
+		.acpi_match_table = ACPI_PTR(msm_rng_acpi_match),
 	}
 };
 module_platform_driver(msm_rng_driver);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
