From: gbean@codeaurora.org (Gregory Bean)
Date: Mon, 26 Jul 2010 13:37:58 -0700
Subject: [PATCH] msm: complete implementation of gpio utility functions.
Message-ID: <1280176678-18855-1-git-send-email-gbean@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the second half of the gpio_request_enable and
gpio_disable_free gpio/tlmm utility functions, now that gpiolib
has found its way to the MSM/QSD.  Now these functions
actually request and free, like they claim to.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
---
 arch/arm/mach-msm/gpio.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/gpio.c b/arch/arm/mach-msm/gpio.c
index bc32c84..796990f 100644
--- a/arch/arm/mach-msm/gpio.c
+++ b/arch/arm/mach-msm/gpio.c
@@ -71,15 +71,47 @@ void msm_gpios_disable(const struct msm_gpio *table, int size)
 }
 EXPORT_SYMBOL(msm_gpios_disable);
 
+int msm_gpios_request(const struct msm_gpio *table, int size)
+{
+	int i, result;
+
+	for (i = 0; i < size; ++i) {
+		result = gpio_request(GPIO_PIN(table[i].gpio_cfg),
+				      table[i].label);
+		if (result < 0)
+			goto err;
+	}
+
+	return 0;
+err:
+	msm_gpios_free(table, i);
+	return result;
+}
+EXPORT_SYMBOL(msm_gpios_request);
+
+void msm_gpios_free(const struct msm_gpio *table, int size)
+{
+	int i;
+
+	for (i = 0; i < size; ++i)
+		gpio_free(GPIO_PIN(table[i].gpio_cfg));
+}
+EXPORT_SYMBOL(msm_gpios_free);
+
 int msm_gpios_request_enable(const struct msm_gpio *table, int size)
 {
 	int rc = msm_gpios_enable(table, size);
+
+	if (rc == 0)
+		rc = msm_gpios_request(table, size);
+
 	return rc;
 }
 EXPORT_SYMBOL(msm_gpios_request_enable);
 
 void msm_gpios_disable_free(const struct msm_gpio *table, int size)
 {
+	msm_gpios_free(table, size);
 	msm_gpios_disable(table, size);
 }
 EXPORT_SYMBOL(msm_gpios_disable_free);
-- 
1.7.0.4

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
