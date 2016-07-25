From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 25 Jul 2016 14:11:16 +0800
Subject: [PATCH v3] PM / OPP: optimize dev_pm_opp_set_rate() performance a bit
Message-ID: <1469427076-2078-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In dev_pm_opp_set_rate(), _find_opp_table() is called 4 times: once by
_get_opp_clk(), once by dev_pm_opp_set_rate() itself, and twice by
dev_pm_opp_find_freq_ceil(). If there are several opp_tables in the
system, three times of opp table finding is a big waste. This patch
reduced the call of _find_opp_table() to twice.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
Since v2:
 - fix gcc warnings

Since v1:
 - avoid opp_table pointer usage after the rcu_read_unlock() as pointed
   out by Viresh, thus we can only reduced the call of _find_opp_table
   to twice.

 drivers/base/power/opp/core.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 7c04c87..df0c709 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -402,6 +402,22 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
+static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
+						   unsigned long *freq)
+{
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
+	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available && temp_opp->rate >= *freq) {
+			opp = temp_opp;
+			*freq = opp->rate;
+			break;
+		}
+	}
+
+	return opp;
+}
+
 /**
  * dev_pm_opp_find_freq_ceil() - Search for an rounded ceil freq
  * @dev:	device for which we do this operation
@@ -427,7 +443,6 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq)
 {
 	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	opp_rcu_lockdep_assert();
 
@@ -440,15 +455,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 	if (IS_ERR(opp_table))
 		return ERR_CAST(opp_table);
 
-	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->rate >= *freq) {
-			opp = temp_opp;
-			*freq = opp->rate;
-			break;
-		}
-	}
-
-	return opp;
+	return _find_freq_ceil(opp_table, freq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
@@ -612,7 +619,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		return PTR_ERR(opp_table);
 	}
 
-	old_opp = dev_pm_opp_find_freq_ceil(dev, &old_freq);
+	old_opp = _find_freq_ceil(opp_table, &old_freq);
 	if (!IS_ERR(old_opp)) {
 		ou_volt = old_opp->u_volt;
 		ou_volt_min = old_opp->u_volt_min;
@@ -622,7 +629,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			__func__, old_freq, PTR_ERR(old_opp));
 	}
 
-	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+	opp = _find_freq_ceil(opp_table, &freq);
 	if (IS_ERR(opp)) {
 		ret = PTR_ERR(opp);
 		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
-- 
2.8.1
