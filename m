From: m.purski@samsung.com (Maciej Purski)
Date: Mon, 04 Jun 2018 15:59:20 +0200
Subject: [PATCH 3/7] regulator: core: Use re-entrant locks
In-Reply-To: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
References: <20180530144505.GB5705@atomide.com>
 <1528120764-14316-1-git-send-email-m.purski@samsung.com>
 <CGME20180604135953eucas1p2f2c9dd9581cd114d323c3d64afe5c308@eucas1p2.samsung.com>
Message-ID: <1528120764-14316-4-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-entrant locks were implemented in previous patches. They should
substitute all mutex_lock() and mutex_unlock() calls on regulators'
mutexes.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 413a824..c5478d2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2274,9 +2274,9 @@ int regulator_enable(struct regulator *regulator)
 			return ret;
 	}
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	ret = _regulator_enable(rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2384,9 +2384,9 @@ int regulator_disable(struct regulator *regulator)
 	if (regulator->always_on)
 		return 0;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	ret = _regulator_disable(rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2436,10 +2436,10 @@ int regulator_force_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	if (rdev->supply)
 		while (rdev->open_count--)
@@ -2587,9 +2587,9 @@ int regulator_is_enabled(struct regulator *regulator)
 	if (regulator->always_on)
 		return 1;
 
-	mutex_lock(&regulator->rdev->mutex);
+	regulator_lock(regulator->rdev);
 	ret = _regulator_is_enabled(regulator->rdev);
-	mutex_unlock(&regulator->rdev->mutex);
+	regulator_unlock(regulator->rdev);
 
 	return ret;
 }
-- 
2.7.4
