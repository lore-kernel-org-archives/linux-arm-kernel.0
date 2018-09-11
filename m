From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 11 Sep 2018 15:49:54 -0600
Subject: [PATCH 4/5] coresight: Define macro to replace dev_dbg() boiler plate
 code
In-Reply-To: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
References: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1536702595-9999-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a macro is much better than repeating the same code everywhere
in the drivers.  That way it is easy to keep debug output messages
confined to the sysFS mode of operation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index acfe67646a05..8a7a197cba69 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -7,6 +7,7 @@
 #define _CORESIGHT_PRIV_H
 
 #include <linux/bitops.h>
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/coresight.h>
 #include <linux/pm_runtime.h>
@@ -74,6 +75,12 @@ enum cs_mode {
 	CS_MODE_PERF,
 };
 
+#define coresight_dev_dbg(dev, mode, format, ...)	\
+do {							\
+	if (mode == CS_MODE_SYSFS)			\
+		dev_dbg(dev, format, ##__VA_ARGS__);	\
+} while (0)
+
 /**
  * struct cs_buffer - keep track of a recording session' specifics
  * @cur:	index of the current buffer
-- 
2.7.4
