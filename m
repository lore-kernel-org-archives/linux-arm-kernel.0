From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 16 Dec 2016 20:06:11 +0000
Subject: [PATCH] i2c: mux: pca954x: fix i2c mux selection caching
Message-ID: <E1cHylf-00071o-KZ@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

smbus functions return -ve on error, 0 on success.  However,
__i2c_transfer() have a different return signature - -ve on error, or
number of buffers transferred (which may be zero or greater.)

The upshot of this is that the sense of the test is reversed when using
the mux on a bus supporting the master_xfer method: we cache the value
and never retry if we fail to transfer any buffers, but if we succeed,
we clear the cached value.

Fix this.

Fixes: 463e8f845cbf ("i2c: mux: pca954x: retry updating the mux selection on failure")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 8bc3d36d2837..b6d62ecbd5b6 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -179,7 +179,7 @@ static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)
 	/* Only select the channel if its different from the last channel */
 	if (data->last_chan != regval) {
 		ret = pca954x_reg_write(muxc->parent, client, regval);
-		data->last_chan = ret ? 0 : regval;
+		data->last_chan = ret >= 0 ? regval : 0;
 	}
 
 	return ret;
-- 
2.7.4
