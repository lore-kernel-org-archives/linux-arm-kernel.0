From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 04 Oct 2012 21:12:45 +0530
Subject: [PATCH v1 07/14] drm: exynos: hdmi: add support for exynos5 ddc
In-Reply-To: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
References: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1349365372-21417-8-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for exynos5 ddc with device tree enabled.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_ddc.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_ddc.c b/drivers/gpu/drm/exynos/exynos_ddc.c
index 7e1051d..ef28779 100644
--- a/drivers/gpu/drm/exynos/exynos_ddc.c
+++ b/drivers/gpu/drm/exynos/exynos_ddc.c
@@ -26,29 +26,41 @@ static int s5p_ddc_probe(struct i2c_client *client,
 {
 	hdmi_attach_ddc_client(client);
 
-	dev_info(&client->adapter->dev, "attached s5p_ddc "
-		"into i2c adapter successfully\n");
+	dev_info(&client->adapter->dev,
+		"attached %s into i2c adapter successfully\n",
+		client->name);
 
 	return 0;
 }
 
 static int s5p_ddc_remove(struct i2c_client *client)
 {
-	dev_info(&client->adapter->dev, "detached s5p_ddc "
-		"from i2c adapter successfully\n");
+	dev_info(&client->adapter->dev,
+		"detached %s from i2c adapter successfully\n",
+		client->name);
 
 	return 0;
 }
 
 static struct i2c_device_id ddc_idtable[] = {
 	{"s5p_ddc", 0},
+	{"exynos5-hdmiddc", 0},
 	{ },
 };
 
+static struct of_device_id hdmiddc_match_types[] = {
+	{
+		.compatible = "samsung,exynos5-hdmiddc",
+	}, {
+		/* end node */
+	}
+};
+
 struct i2c_driver ddc_driver = {
 	.driver = {
-		.name = "s5p_ddc",
+		.name = "exynos-hdmiddc",
 		.owner = THIS_MODULE,
+		.of_match_table = hdmiddc_match_types,
 	},
 	.id_table	= ddc_idtable,
 	.probe		= s5p_ddc_probe,
-- 
1.7.0.4
