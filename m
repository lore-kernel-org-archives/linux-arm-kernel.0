From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Sep 2015 16:05:42 +0200
Subject: [PATCH 2/6] regulator: core: introduce function to lock regulators
 and its supplies
In-Reply-To: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1443621946-8712-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each regulator_dev is locked with its own mutex. This is fine as long
as only one regulator_dev is locked, but makes lockdep unhappy when we
have to walk up the supply chain like it can happen in
regulator_get_voltage:

regulator_get_voltage ->
 mutex_lock(&regulator->rdev->mutex) ->
_regulator_get_voltage(regulator->rdev) ->
regulator_get_voltage(rdev->supply) ->
mutex_lock(&regulator->rdev->mutex);

This causes lockdep to issue a possible deadlock warning.

There are at least two ways to work around this:

- We can always lock the whole supply chain using the functions
  introduced with this patch.
- We could store the current voltage in struct regulator_rdev so
  that we do not have to walk up the supply chain for the
  _regulator_get_voltage case.

Anyway, regulator_lock_supply/regulator_unlock_supply will be needed
once we allow regulator_set_voltage to optimize the supply voltages.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/regulator/core.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index bd9db70..e5de3d9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -132,6 +132,45 @@ static bool have_full_constraints(void)
 }
 
 /**
+ * regulator_lock_supply - lock a regulator and its supplies
+ * @rdev:         regulator source
+ */
+static void regulator_lock_supply(struct regulator_dev *rdev)
+{
+	struct regulator *supply;
+	int i = 0;
+
+	while (1) {
+		mutex_lock_nested(&rdev->mutex, i++);
+		supply = rdev->supply;
+
+		if (!rdev->supply)
+			return;
+
+		rdev = supply->rdev;
+	}
+}
+
+/**
+ * regulator_unlock_supply - unlock a regulator and its supplies
+ * @rdev:         regulator source
+ */
+static void regulator_unlock_supply(struct regulator_dev *rdev)
+{
+	struct regulator *supply;
+
+	while (1) {
+		mutex_unlock(&rdev->mutex);
+		supply = rdev->supply;
+
+		if (!rdev->supply)
+			return;
+
+		rdev = supply->rdev;
+	}
+}
+
+/**
  * of_get_regulator - get a regulator device node based on supply name
  * @dev: Device pointer for the consumer (of regulator) device
  * @supply: regulator supply name
-- 
2.5.3
