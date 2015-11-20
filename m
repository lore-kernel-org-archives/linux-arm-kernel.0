From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 15:24:39 +0100
Subject: [PATCH v3b] regulator: core: avoid unused variable warning
Message-ID: <4083086.03MkICpY7S@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second argument of the mutex_lock_nested() helper is only
evaluated if CONFIG_DEBUG_LOCK_ALLOC is set. Otherwise we
get this build warning for the new regulator_lock_supply
function:

drivers/regulator/core.c: In function 'regulator_lock_supply':
drivers/regulator/core.c:142:6: warning: unused variable 'i' [-Wunused-variable]

To avoid the warning, this restructures the code to make it
both simpler and to move the 'i++' outside of the mutex_lock_nested
call, where it is now always used and the variable is not
flagged as unused.

We had some discussion about changing mutex_lock_nested to an
inline function, which would make the code do the right thing here,
but in the end decided against it, in order to guarantee that
mutex_lock_nested() does not introduced overhead without
CONFIG_DEBUG_LOCK_ALLOC.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9f01cd4a915 ("regulator: core: introduce function to lock regulators and its supplies")
Link: http://permalink.gmane.org/gmane.linux.kernel/2068900
---
This is a different approach I came up with now, feel free to
pick either v3a or v3b of the patch, whichever seems more appropriate
to you.

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4cf1390784e5..c9bdca5f3b9b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -138,18 +138,10 @@ static bool have_full_constraints(void)
  */
 static void regulator_lock_supply(struct regulator_dev *rdev)
 {
-	struct regulator *supply;
-	int i = 0;
-
-	while (1) {
-		mutex_lock_nested(&rdev->mutex, i++);
-		supply = rdev->supply;
-
-		if (!rdev->supply)
-			return;
+	int i;
 
-		rdev = supply->rdev;
-	}
+	for (i = 0; rdev->supply; rdev = rdev->supply->rdev, i++)
+		mutex_lock_nested(&rdev->mutex, i);
 }
 
 /**
