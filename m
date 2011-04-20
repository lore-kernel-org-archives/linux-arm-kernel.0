From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 20 Apr 2011 09:44:46 +0200
Subject: [PATCH v2 5/5] driver core: let dev_set_drvdata return int instead of
	void as it can fail
In-Reply-To: <1303285486-28598-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110420074248.GS31131@pengutronix.de>
	<1303285486-28598-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1303285486-28598-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before commit

	b402843 (Driver core: move dev_get/set_drvdata to drivers/base/dd.c)

calling dev_set_drvdata with dev=NULL was an unchecked error. After some
discussion about what to return in this case removing the check (and so
producing a null pointer exception) seems fine.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/base/dd.c      |    7 +++----
 include/linux/device.h |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index da57ee9..f9d69d7 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -408,17 +408,16 @@ void *dev_get_drvdata(const struct device *dev)
 }
 EXPORT_SYMBOL(dev_get_drvdata);
 
-void dev_set_drvdata(struct device *dev, void *data)
+int dev_set_drvdata(struct device *dev, void *data)
 {
 	int error;
 
-	if (!dev)
-		return;
 	if (!dev->p) {
 		error = device_private_init(dev);
 		if (error)
-			return;
+			return error;
 	}
 	dev->p->driver_data = data;
+	return 0;
 }
 EXPORT_SYMBOL(dev_set_drvdata);
diff --git a/include/linux/device.h b/include/linux/device.h
index 350ceda..2215d01 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -557,7 +557,7 @@ extern int device_move(struct device *dev, struct device *new_parent,
 extern const char *device_get_devnode(struct device *dev,
 				      mode_t *mode, const char **tmp);
 extern void *dev_get_drvdata(const struct device *dev);
-extern void dev_set_drvdata(struct device *dev, void *data);
+extern int dev_set_drvdata(struct device *dev, void *data);
 
 /*
  * Root device objects for grouping under /sys/devices
-- 
1.7.4.1
