From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 16 May 2013 21:32:08 +0100
Subject: [PATCH 2/9] I2C: mv64xxx: use return value from mv64xxx_i2c_map_regs()
In-Reply-To: <20130516202921.GW18614@n2100.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
Message-ID: <E1Ud4qO-0004JW-U7@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mv64xxx_i2c_map_regs() already returns an error code, so lets
propagate that to mv64xxx_i2c_probe()'s caller.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-mv64xxx.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 8d4c0a0..0339cd8 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -619,10 +619,9 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	if (!drv_data)
 		return -ENOMEM;
 
-	if (mv64xxx_i2c_map_regs(pd, drv_data)) {
-		rc = -ENODEV;
+	rc = mv64xxx_i2c_map_regs(pd, drv_data);
+	if (rc)
 		goto exit_kfree;
-	}
 
 	strlcpy(drv_data->adapter.name, MV64XXX_I2C_CTLR_NAME " adapter",
 		sizeof(drv_data->adapter.name));
-- 
1.7.4.4
