From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 14 Apr 2016 20:53:34 +0800
Subject: [PATCH 4/4] i2c: designware: remove runtime suspend prevention during
 registration
In-Reply-To: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
References: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
Message-ID: <1460638414-5987-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now all users make sure there won't be runtime suspend when calling
i2c_dw_probe(), so we can remove the prevention code now.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/i2c/busses/i2c-designware-core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 99b54be..4255eaa 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -881,17 +881,9 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 		return r;
 	}
 
-	/*
-	 * Increment PM usage count during adapter registration in order to
-	 * avoid possible spurious runtime suspend when adapter device is
-	 * registered to the device core and immediate resume in case bus has
-	 * registered I2C slaves that do I2C transfers in their probe.
-	 */
-	pm_runtime_get_noresume(dev->dev);
 	r = i2c_add_numbered_adapter(adap);
 	if (r)
 		dev_err(dev->dev, "failure adding adapter: %d\n", r);
-	pm_runtime_put_noidle(dev->dev);
 
 	return r;
 }
-- 
2.8.0.rc3
