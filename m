From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 4 Nov 2015 01:02:44 +0300
Subject: [patch] bus: sunxi-rsb: unlock on error in sunxi_rsb_read()
Message-ID: <20151103220244.GA19280@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't forget to unlock before returning an error code.

Fixes: d787dcdb9c8f ('bus: sunxi-rsb: Add driver for Allwinner Reduced Serial Bus')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 846bc29c..0cfcb39 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -342,13 +342,13 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 
 	ret = _sunxi_rsb_run_xfer(rsb);
 	if (ret)
-		goto out;
+		goto unlock;
 
 	*buf = readl(rsb->regs + RSB_DATA);
 
+unlock:
 	mutex_unlock(&rsb->lock);
 
-out:
 	return ret;
 }
 
