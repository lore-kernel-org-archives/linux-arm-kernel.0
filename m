From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 20 Apr 2011 09:44:42 +0200
Subject: [PATCH v2 1/5] driver core/platform_device_add_data: set
	platform_data to NULL if !data
In-Reply-To: <20110420074248.GS31131@pengutronix.de>
References: <20110420074248.GS31131@pengutronix.de>
Message-ID: <1303285486-28598-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the data = NULL case more consistent to the data != NULL case.
The functional change is that now

	platform_device_add_data(somepdev, NULL, somesize)

sets pdev->dev.platform_data to NULL instead of not touching it.

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/base/platform.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9e0e4fc..65cb4c3 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -220,17 +220,16 @@ EXPORT_SYMBOL_GPL(platform_device_add_resources);
 int platform_device_add_data(struct platform_device *pdev, const void *data,
 			     size_t size)
 {
-	void *d;
+	void *d = NULL;
 
-	if (!data)
-		return 0;
-
-	d = kmemdup(data, size, GFP_KERNEL);
-	if (d) {
-		pdev->dev.platform_data = d;
-		return 0;
+	if (data) {
+		d = kmemdup(data, size, GFP_KERNEL);
+		if (!d)
+			return -ENOMEM;
 	}
-	return -ENOMEM;
+
+	pdev->dev.platform_data = d;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_device_add_data);
 
-- 
1.7.4.1
