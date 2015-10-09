From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 14:36:47 +0200
Subject: [PATCH] regulator: core: avoid unused variable warning
Message-ID: <5130320.kXvB35QoYU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second argument of the mutex_lock_nested() helper is only
evaluated if CONFIG_DEBUG_LOCK_ALLOC is set. Otherwise we
get this build warning for the new regulator_lock_supply
function:

drivers/regulator/core.c: In function 'regulator_lock_supply':
drivers/regulator/core.c:142:6: warning: unused variable 'i' [-Wunused-variable]

To avoid the warning, this patch moves the postincrement outside
of the call mutex_lock_nested(), which is enough to shut up
gcc about it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9f01cd4a915 ("regulator: core: introduce function to lock regulators and its supplies")

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 96dd7e1f1f28..bac8eefbfeff 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -142,7 +142,9 @@ static void __maybe_unused regulator_lock_supply(struct regulator_dev *rdev)
 	int i = 0;
 
 	while (1) {
-		mutex_lock_nested(&rdev->mutex, i++);
+		mutex_lock_nested(&rdev->mutex, i);
+		i++;
+
 		supply = rdev->supply;
 
 		if (!rdev->supply)
