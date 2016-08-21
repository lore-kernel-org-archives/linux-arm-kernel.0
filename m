From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 21 Aug 2016 10:11:19 +0800
Subject: [PATCH 3/9] regulator: core: Try full range when adjusting regulators
 to constraints
In-Reply-To: <20160821021125.1521-1-wens@csie.org>
References: <20160821021125.1521-1-wens@csie.org>
Message-ID: <20160821021125.1521-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently when we try to bring regulator in bounds of its constraints,
we pick either the minimum or maximum voltage as the target. This fails
if the regulator range is not continuous, and the target voltage is not
an exact value the regulator can achieve, i.e. the target is not aligned
to the step of the regulator.

Instead pass the full range of the constraints, and have the regulator
core work out a suitable voltage within.

Fixes: ("regulator: core: Ensure we are at least in bounds for our
	 constraints")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/regulator/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index db320e8fa865..86f69c92ce7a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -897,13 +897,9 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 		target_min = current_uV;
 		target_max = current_uV;
 
-		if (current_uV < rdev->constraints->min_uV) {
+		if (current_uV < rdev->constraints->min_uV ||
+		    current_uV > rdev->constraints->max_uV) {
 			target_min = rdev->constraints->min_uV;
-			target_max = rdev->constraints->min_uV;
-		}
-
-		if (current_uV > rdev->constraints->max_uV) {
-			target_min = rdev->constraints->max_uV;
 			target_max = rdev->constraints->max_uV;
 		}
 
-- 
2.9.3
