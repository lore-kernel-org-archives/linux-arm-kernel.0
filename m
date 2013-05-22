From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 14:07:05 +0100
Subject: [PATCH] regulator: ab8500: Remove external regulator init() clauses
Message-ID: <1369228025-17192-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver no longer needs to worry about which platform can and can't
use external regulators successfully. Instead platform code will hold
back external regulator initialisation data in the use-cases where the
driver isn't applicable.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index f6656b8..b6270f5 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -3156,12 +3156,10 @@ static int ab8500_regulator_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	if (!is_ab8505(ab8500)) {
-		/* register external regulators (before Vaux1, 2 and 3) */
-		err = ab8500_ext_regulator_init(pdev);
-		if (err)
-			return err;
-	}
+	/* register external regulators (before Vaux1, 2 and 3) */
+	err = ab8500_ext_regulator_init(pdev);
+	if (err)
+		return err;
 
 	/* register all regulators */
 	for (i = 0; i < abx500_regulator.info_size; i++) {
-- 
1.7.10.4
