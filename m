From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Sep 2015 16:05:41 +0200
Subject: [PATCH 1/6] Revert "regulator: core: Handle full constraints systems
 when resolving supplies"
In-Reply-To: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1443621946-8712-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 9f7e25edb1575a6d2363dc003f9cc09d840657e2.

When a regulator A is registered and is supplied by regulator B which is
not yet registered then a regulator_get on regulator A will set the As
supply to the dummy regulator. This is not correct, we should return
-EPROBE_DEFER instead as done without this patch.
Of course reverting this patch brings back the issue it fixed, so this
is not a solution, but what is the correct solution?

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/regulator/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7849187..bd9db70 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1403,13 +1403,9 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 			return 0;
 		}
 
-		if (have_full_constraints()) {
-			r = dummy_regulator_rdev;
-		} else {
-			dev_err(dev, "Failed to resolve %s-supply for %s\n",
-				rdev->supply_name, rdev->desc->name);
-			return -EPROBE_DEFER;
-		}
+		dev_err(dev, "Failed to resolve %s-supply for %s\n",
+			rdev->supply_name, rdev->desc->name);
+		return -EPROBE_DEFER;
 	}
 
 	/* Recursively resolve the supply of the supply */
-- 
2.5.3
