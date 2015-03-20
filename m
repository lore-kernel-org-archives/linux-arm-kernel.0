From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Fri, 20 Mar 2015 14:25:25 -0700
Subject: [PATCH v1 1/3] phy: phy-core: allow specifying supply at port level
In-Reply-To: <1426886727-537-1-git-send-email-arun.ramamurthy@broadcom.com>
References: <1426886727-537-1-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <1426886727-537-2-git-send-email-arun.ramamurthy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Multi-port phy's may have per-port power supplies. Let's change phy core
to first attempt to look up the supply at the port level, and then, if
not found, check parent device.

Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
---
 drivers/phy/phy-core.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index a12d353..b43bb6b 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -650,16 +650,6 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 		goto free_phy;
 	}
 
-	/* phy-supply */
-	phy->pwr = regulator_get_optional(dev, "phy");
-	if (IS_ERR(phy->pwr)) {
-		if (PTR_ERR(phy->pwr) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto free_ida;
-		}
-		phy->pwr = NULL;
-	}
-
 	device_initialize(&phy->dev);
 	mutex_init(&phy->mutex);
 
@@ -673,6 +663,26 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 	if (ret)
 		goto put_dev;
 
+	/*
+	 * Locate phy-supply. We first try individual port and then,
+	 * if supply is not found, try parent device.
+	 */
+	phy->pwr = regulator_get_optional(&phy->dev, "phy");
+	if (IS_ERR(phy->pwr)) {
+		ret = PTR_ERR(phy->pwr);
+		if (ret == -EPROBE_DEFER)
+			goto free_ida;
+
+		phy->pwr = regulator_get_optional(phy->dev.parent, "phy");
+		if (IS_ERR(phy->pwr)) {
+			ret = PTR_ERR(phy->pwr);
+			if (ret == -EPROBE_DEFER)
+				goto free_ida;
+
+			phy->pwr = NULL;
+		}
+	}
+
 	ret = device_add(&phy->dev);
 	if (ret)
 		goto put_dev;
-- 
2.3.2
