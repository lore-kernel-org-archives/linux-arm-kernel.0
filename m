From: yuanzhichang@hisilicon.com (zhichang.yuan)
Date: Thu, 30 Mar 2017 23:26:59 +0800
Subject: [PATCH V8 6/6] LPC: Add the ACPI LPC support
In-Reply-To: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <1490887619-61732-7-git-send-email-yuanzhichang@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on the provious patches, this patch supports the ACPI LPC host on
Hip06/Hip07.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 018ea37..ef62045 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -458,7 +458,9 @@ static int hisilpc_probe(struct platform_device *pdev)
 	}
 
 	/* register the LPC host PIO resources */
-	if (!has_acpi_companion(dev)) {
+	if (has_acpi_companion(dev)) {
+		lpcdev->io_host = find_io_range_by_fwnode(dev->fwnode);
+	} else {
 		struct logic_pio_hwaddr *range, *tmprange;
 
 		range = kzalloc(sizeof(*range), GFP_KERNEL);
@@ -526,10 +528,18 @@ static int hisilpc_probe(struct platform_device *pdev)
 	{},
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id hisilpc_acpi_match[] = {
+	{"HISI0191", },
+	{},
+};
+#endif
+
 static struct platform_driver hisilpc_driver = {
 	.driver = {
 		.name           = "hisi_lpc",
 		.of_match_table = hisilpc_of_match,
+		.acpi_match_table = ACPI_PTR(hisilpc_acpi_match),
 	},
 	.probe = hisilpc_probe,
 };
-- 
1.9.1
