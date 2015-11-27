From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Nov 2015 13:04:30 +0100
Subject: [PATCH] regulator: core: fix regulator_lock_supply regression
Message-ID: <3399746.xt7N4lig0U@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As noticed by Geert Uytterhoeven, my patch to avoid a harmless build warning
in regulator_lock_supply() was total crap and introduced a real bug:

> [ BUG: bad unlock balance detected! ]
> kworker/u4:0/6 is trying to release lock (&rdev->mutex) at:
> [<c0247b84>] regulator_set_voltage+0x38/0x50

We still lock the regulator supplies, but not the actual regulators,
so we are missing a lock, and the unlock is unbalanced.

This rectifies it by first locking the regulator device itself before
using the same loop as before to lock its supplies.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 716fec9d1965 ("[SUBMITTED] regulator: core: avoid unused variable warning")
---
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c9bdca5f3b9b..89e4dcb84758 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -140,7 +140,8 @@ static void regulator_lock_supply(struct regulator_dev *rdev)
 {
        int i;
 
-       for (i = 0; rdev->supply; rdev = rdev->supply->rdev, i++)
+       mutex_lock(&rdev->mutex);
+       for (i = 1; rdev->supply; rdev = rdev->supply->rdev, i++)
                mutex_lock_nested(&rdev->mutex, i);
 }
 
