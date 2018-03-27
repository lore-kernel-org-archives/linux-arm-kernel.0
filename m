From: roy.pledge@nxp.com (Roy Pledge)
Date: Tue, 27 Mar 2018 14:13:32 -0400
Subject: [PATCH v4 2/4] drivers/staging/fsl-mc: Fix DPIO error path issue
In-Reply-To: <1522174414-30380-1-git-send-email-roy.pledge@nxp.com>
References: <1522174414-30380-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1522174414-30380-3-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded call to dev_set_drvdata(dev, NULL) since the device
will be deallocated in any case.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index ffcbd5a..9e12576 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -101,7 +101,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	if (err) {
 		dev_dbg(dev, "MC portal allocation failed\n");
 		err = -EPROBE_DEFER;
-		goto err_mcportal;
+		goto err_priv_alloc;
 	}
 
 	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
@@ -196,8 +196,6 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
 err_open:
 	fsl_mc_portal_free(dpio_dev->mc_io);
-err_mcportal:
-	dev_set_drvdata(dev, NULL);
 err_priv_alloc:
 	return err;
 }
@@ -241,8 +239,6 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 
 	fsl_mc_portal_free(dpio_dev->mc_io);
 
-	dev_set_drvdata(dev, NULL);
-
 	return 0;
 
 err_open:
-- 
2.7.4
