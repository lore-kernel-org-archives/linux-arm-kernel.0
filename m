From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 19 Oct 2016 14:51:10 +0200
Subject: [PATCH v5 3/5] scpi: Add support for Legacy match table for Amlogic
 GXBB SoC
In-Reply-To: <1476881472-13055-1-git-send-email-narmstrong@baylibre.com>
References: <1476881472-13055-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1476881472-13055-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new DT match table to setup the is_legacy boolean value across
the scpi functions.
Add the Amlogic GXBB SoC compatible for platform and as legacy match entry.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 9022336..75b60c4 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -871,6 +871,11 @@ static int scpi_alloc_xfer_list(struct device *dev, struct scpi_chan *ch)
 	return 0;
 }
 
+static const struct of_device_id legacy_scpi_of_match[] = {
+	{.compatible = "amlogic,meson-gxbb-scpi"},
+	{},
+};
+
 static int scpi_probe(struct platform_device *pdev)
 {
 	int count, idx, ret;
@@ -883,6 +888,9 @@ static int scpi_probe(struct platform_device *pdev)
 	if (!scpi_info)
 		return -ENOMEM;
 
+	if (of_match_device(legacy_scpi_of_match, &pdev->dev))
+		scpi_info->is_legacy = true;
+
 	count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
 	if (count < 0) {
 		dev_err(dev, "no mboxes property in '%s'\n", np->full_name);
@@ -984,6 +992,7 @@ static int scpi_probe(struct platform_device *pdev)
 
 static const struct of_device_id scpi_of_match[] = {
 	{.compatible = "arm,scpi"},
+	{.compatible = "amlogic,meson-gxbb-scpi"},
 	{},
 };
 
-- 
1.9.1
