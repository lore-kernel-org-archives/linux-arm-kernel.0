From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 13:46:52 +0200
Subject: [PATCH v2 3/7] scpi: Add support for Legacy match table for Amlogic
 GXBB SoC
In-Reply-To: <1471952816-30877-1-git-send-email-narmstrong@baylibre.com>
References: <1471952816-30877-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471952816-30877-4-git-send-email-narmstrong@baylibre.com>
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
index d24d1de..badef70 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -888,6 +888,11 @@ static int scpi_alloc_xfer_list(struct device *dev, struct scpi_chan *ch)
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
@@ -900,6 +905,9 @@ static int scpi_probe(struct platform_device *pdev)
 	if (!scpi_info)
 		return -ENOMEM;
 
+	if (of_match_device(legacy_scpi_of_match, &pdev->dev))
+		scpi_info->is_legacy = true;
+
 	count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
 	if (count < 0) {
 		dev_err(dev, "no mboxes property in '%s'\n", np->full_name);
@@ -996,6 +1004,7 @@ err:
 
 static const struct of_device_id scpi_of_match[] = {
 	{.compatible = "arm,scpi"},
+	{.compatible = "amlogic,meson-gxbb-scpi"},
 	{},
 };
 
-- 
1.9.1
