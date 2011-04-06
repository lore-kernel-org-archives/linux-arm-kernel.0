From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  6 Apr 2011 11:24:23 +0200
Subject: [PATCH 3/5] driver core/platform_device_add_resources: set resource
	to NULL if !res
In-Reply-To: <20110301153438.GB15633@suse.de>
References: <20110301153438.GB15633@suse.de>
Message-ID: <1302081865-2962-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the res = NULL case more consistant to the res != NULL case
as now both overwrite pdev->resource.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/base/platform.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 01caf61..812d8ff 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -191,18 +191,17 @@ EXPORT_SYMBOL_GPL(platform_device_alloc);
 int platform_device_add_resources(struct platform_device *pdev,
 				  const struct resource *res, unsigned int num)
 {
-	struct resource *r;
+	struct resource *r = NULL;
 
-	if (!res)
-		return 0;
-
-	r = kmemdup(res, sizeof(struct resource) * num, GFP_KERNEL);
-	if (r) {
-		pdev->resource = r;
-		pdev->num_resources = num;
-		return 0;
+	if (res) {
+		r = kmemdup(res, sizeof(struct resource) * num, GFP_KERNEL);
+		if (!r)
+			return -ENOMEM;
 	}
-	return -ENOMEM;
+
+	pdev->resource = r;
+	pdev->num_resources = num;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_device_add_resources);
 
-- 
1.7.2.3
