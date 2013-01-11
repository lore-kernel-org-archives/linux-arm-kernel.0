From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 11 Jan 2013 15:08:31 +0100
Subject: [PATCH 2/2 v2] ASoC: atmel-ssc: add pinctrl selection to driver
In-Reply-To: <cover.1357912706.git.nicolas.ferre@atmel.com>
References: <cover.1357912706.git.nicolas.ferre@atmel.com>
Message-ID: <d1060534f9dafe4baa9bec2506815ae63455ebd6.1357912706.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bo Shen <voice.shen@atmel.com>

Add default pinctrl selection to atmel-ssc driver. The pinctrl
is mandatory.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
[nicolas.ferre at atmel.com: split dtsi and driver changes]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/misc/atmel-ssc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index 158da5a..3c09cbb 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 
 /* Serialize access to ssc_list and user count */
 static DEFINE_SPINLOCK(user_lock);
@@ -131,6 +132,13 @@ static int ssc_probe(struct platform_device *pdev)
 	struct resource *regs;
 	struct ssc_device *ssc;
 	const struct atmel_ssc_platform_data *plat_dat;
+	struct pinctrl *pinctrl;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		dev_err(&pdev->dev, "Failed to request pinctrl\n");
+		return PTR_ERR(pinctrl);
+	}
 
 	ssc = devm_kzalloc(&pdev->dev, sizeof(struct ssc_device), GFP_KERNEL);
 	if (!ssc) {
-- 
1.8.0
