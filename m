From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 08 Sep 2015 18:41:01 +0200
Subject: [PATCH v5 1/4] PM / OPP: add dev_pm_opp_get_suspend_opp() helper
In-Reply-To: <1441730464-7947-1-git-send-email-b.zolnierkie@samsung.com>
References: <1441730464-7947-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1441730464-7947-2-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dev_pm_opp_get_suspend_opp() helper to obtain suspend opp.

Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/base/power/opp.c | 30 ++++++++++++++++++++++++++++++
 include/linux/pm_opp.h   |  6 ++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index eb25449..3d948ea 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -341,6 +341,36 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
 
 /**
+ * dev_pm_opp_get_suspend_opp() - Get suspend opp
+ * @dev:	device for which we do this operation
+ *
+ * Return: This function returns pointer to the suspend opp if it is
+ * defined, otherwise it returns NULL.
+ *
+ * Locking: This function must be called under rcu_read_lock(). opp is a rcu
+ * protected pointer. The reason for the same is that the opp pointer which is
+ * returned will remain valid for use with opp_get_{voltage, freq} only while
+ * under the locked area. The pointer returned must be used prior to unlocking
+ * with rcu_read_unlock() to maintain the integrity of the pointer.
+ */
+struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *opp;
+
+	opp_rcu_lockdep_assert();
+
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		opp = NULL;
+	else
+		opp = dev_opp->suspend_opp;
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp);
+
+/**
  * dev_pm_opp_get_opp_count() - Get number of opps available in the opp list
  * @dev:	device for which we do this operation
  *
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cab7ba5..e817722 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -34,6 +34,7 @@ bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 
 int dev_pm_opp_get_opp_count(struct device *dev);
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
+struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
@@ -80,6 +81,11 @@ static inline unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 	return 0;
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
+{
+	return NULL;
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					unsigned long freq, bool available)
 {
-- 
1.9.1
