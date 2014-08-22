From: dmurphy@ti.com (Dan Murphy)
Date: Fri, 22 Aug 2014 09:11:36 -0500
Subject: [PATCH] input: misc: drv260x: add check for ERM mode and LRA Libraries
Message-ID: <1408716696-1126-1-git-send-email-dmurphy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a check to ensure that LRA libraries are not mixed with
the ERM mode.

If ERM mode and the Library is empty "OR" the
LRA library then exit.

As the LRA and empty libraries are not applicable for
the ERM actuator.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/input/misc/drv260x.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index a7a19e6..d6a26a7 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -564,6 +564,14 @@ static int drv260x_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
+	if (haptics->mode == DRV260X_ERM_MODE &&
+	    haptics->library == DRV260X_LIB_EMPTY ||
+	    haptics->library == DRV260X_LIB_LRA) {
+		dev_err(&client->dev,
+			"ERM Mode with LRA Library mismatch\n");
+		return -EINVAL;
+	}
+
 	haptics->regulator = devm_regulator_get(&client->dev, "vbat");
 	if (IS_ERR(haptics->regulator)) {
 		error = PTR_ERR(haptics->regulator);
-- 
1.7.9.5
