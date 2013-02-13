From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Wed, 13 Feb 2013 13:22:24 +0100
Subject: [PATCH v8 1/7] watchdog: core: add and use watchdog_is_valid_timeout
 function
In-Reply-To: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1360758150-23004-2-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/watchdog/watchdog_core.c | 14 ++++++++++++++
 drivers/watchdog/watchdog_dev.c  |  3 +--
 include/linux/watchdog.h         |  2 ++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 3796434..f10fa31 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -43,6 +43,20 @@ static DEFINE_IDA(watchdog_ida);
 static struct class *watchdog_class;
 
 /**
+ * watchdog_is_valid_timeout() - check if the timeout is within a valid range
+ * @timeout: value to check
+ */
+bool watchdog_is_valid_timeout(struct watchdog_device *wdd, uint timeout)
+{
+	if (wdd->min_timeout < wdd->max_timeout)
+		return (wdd->min_timeout <= timeout) &&
+			(timeout <= wdd->max_timeout);
+	else
+		return (timeout > 0);
+}
+EXPORT_SYMBOL_GPL(watchdog_is_valid_timeout);
+
+/**
  * watchdog_register_device() - register a watchdog device
  * @wdd: watchdog device
  *
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ef8edec..49976f8 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -200,8 +200,7 @@ static int watchdog_set_timeout(struct watchdog_device *wddev,
 	    !(wddev->info->options & WDIOF_SETTIMEOUT))
 		return -EOPNOTSUPP;
 
-	if ((wddev->max_timeout != 0) &&
-	    (timeout < wddev->min_timeout || timeout > wddev->max_timeout))
+	if (!watchdog_is_valid_timeout(wddev, timeout))
 		return -EINVAL;
 
 	mutex_lock(&wddev->lock);
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 3a9df2f..9ae945e 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -130,6 +130,8 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 }
 
 /* drivers/watchdog/watchdog_core.c */
+extern bool watchdog_is_valid_timeout(struct watchdog_device *wdd,
+				      uint timeout);
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
-- 
1.8.1.1
