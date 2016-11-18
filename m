From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 18 Nov 2016 19:40:04 +0000
Subject: [PATCH 1/2] i2c: designware: report short transfers
In-Reply-To: <20161118193542.GO1041@n2100.armlinux.org.uk>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
Message-ID: <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than reporting success for a short transfer due to interrupt
latency, report an error both to the caller, as well as to the kernel
log.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/i2c/busses/i2c-designware-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 9703fe392543..c53058d6139c 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -758,7 +758,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	}
 
 	/* no error */
-	if (likely(!dev->cmd_err)) {
+	if (likely(!dev->cmd_err && !dev->status)) {
 		ret = num;
 		goto done;
 	}
@@ -768,6 +768,11 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		ret = i2c_dw_handle_tx_abort(dev);
 		goto done;
 	}
+
+	if (dev->status)
+		dev_err(dev->dev,
+			"transfer terminated early - interrupt latency too high?\n");
+
 	ret = -EIO;
 
 done:
-- 
2.7.4
