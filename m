From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 26 Jul 2018 13:54:40 +0100
Subject: [PATCH v3 02/13] coresight: etb10: Fix handling of perf mode
In-Reply-To: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1532609691-16863-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the ETB is already enabled in sysfs mode, the ETB reports
success even if a perf mode is requested. Fix this by checking
the requested mode.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 306119e..e5808fd 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -148,8 +148,12 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
 		return -EBUSY;
 
 	/* Nothing to do, the tracer is already enabled. */
-	if (val == CS_MODE_SYSFS)
-		goto out;
+	if (val == CS_MODE_SYSFS) {
+		if (mode == CS_MODE_SYSFS)
+			goto out;
+		else
+			return -EBUSY;
+	}
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	etb_enable_hw(drvdata);
-- 
2.7.4
