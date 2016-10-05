From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 09:33:30 +0200
Subject: [PATCH v4 4/8] scpi: Add support for Legacy match table for Amlogic
 GXBB SoC
In-Reply-To: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
References: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1475652814-30619-5-git-send-email-narmstrong@baylibre.com>
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
index 1fb3bbf..21fafbe 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -895,6 +895,11 @@ static int scpi_alloc_xfer_list(struct device *dev, struct scpi_chan *ch)
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
@@ -907,6 +912,9 @@ static int scpi_probe(struct platform_device *pdev)
 	if (!scpi_info)
 		return -ENOMEM;
 
+	if (of_match_device(legacy_scpi_of_match, &pdev->dev))
+		scpi_info->is_legacy = true;
+
 	count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
 	if (count < 0) {
 		dev_err(dev, "no mboxes property in '%s'\n", np->full_name);
@@ -1009,6 +1017,7 @@ static int scpi_probe(struct platform_device *pdev)
 
 static const struct of_device_id scpi_of_match[] = {
 	{.compatible = "arm,scpi"},
+	{.compatible = "amlogic,meson-gxbb-scpi"},
 	{},
 };
 
-- 
1.9.1
