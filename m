From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 15:23:19 +0100
Subject: [PATCH v3a] regulator: core: avoid unused variable warning
Message-ID: <57950510.5n95rqyCDA@wuerfel>
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

We had some discussion about changing mutex_lock_nested to an
inline function, which would make the code do the right thing here,
but in the end decided against it, in order to guarantee that
mutex_lock_nested() does not introduced overhead without
CONFIG_DEBUG_LOCK_ALLOC.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9f01cd4a915 ("regulator: core: introduce function to lock regulators and its supplies")
Link: http://permalink.gmane.org/gmane.linux.kernel/2068900

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4cf1390784e5..5afe02cce9aa 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -142,7 +142,11 @@ static void regulator_lock_supply(struct regulator_dev *rdev)
 	int i = 0;
 
 	while (1) {
-		mutex_lock_nested(&rdev->mutex, i++);
+		mutex_lock_nested(&rdev->mutex, i);
+
+		/* avoid unused variable warning without DEBUG_LOCK_ALLOC */
+		(void)i++;
+
 		supply = rdev->supply;
 
 		if (!rdev->supply)
