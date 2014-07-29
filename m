From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 29 Jul 2014 18:28:56 +0200
Subject: [RFC 2/5] regulator: core: Allow to get voltage count and list from
 parent
In-Reply-To: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1406651339-28901-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Load switches are modeled as regulators but they just provide
the voltage of their parent input supply. So, the drivers for
these switches usually neither provide a .list_voltage handler
not set a .n_voltages count. But there is code in the kernel
that assumes that all regulators should be able to provide this
information (e.g: cpufreq and mmc subsystems).

If the voltage count and list are not available for a regulator
and it has a parent input supply, then use the parent values.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/regulator/core.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 089cea8..a3c3785 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2186,7 +2186,13 @@ int regulator_count_voltages(struct regulator *regulator)
 {
 	struct regulator_dev	*rdev = regulator->rdev;
 
-	return rdev->desc->n_voltages ? : -EINVAL;
+	if (rdev->desc->n_voltages)
+		return rdev->desc->n_voltages;
+
+	if (!rdev->supply)
+		return -EINVAL;
+
+	return regulator_count_voltages(rdev->supply);
 }
 EXPORT_SYMBOL_GPL(regulator_count_voltages);
 
@@ -2209,12 +2215,17 @@ int regulator_list_voltage(struct regulator *regulator, unsigned selector)
 	if (rdev->desc->fixed_uV && rdev->desc->n_voltages == 1 && !selector)
 		return rdev->desc->fixed_uV;
 
-	if (!ops->list_voltage || selector >= rdev->desc->n_voltages)
+	if (ops->list_voltage) {
+		if (selector >= rdev->desc->n_voltages)
+			return -EINVAL;
+		mutex_lock(&rdev->mutex);
+		ret = ops->list_voltage(rdev, selector);
+		mutex_unlock(&rdev->mutex);
+	} else if (rdev->supply) {
+		ret = regulator_list_voltage(rdev->supply, selector);
+	} else {
 		return -EINVAL;
-
-	mutex_lock(&rdev->mutex);
-	ret = ops->list_voltage(rdev, selector);
-	mutex_unlock(&rdev->mutex);
+	}
 
 	if (ret > 0) {
 		if (ret < rdev->constraints->min_uV)
-- 
2.0.0.rc2
