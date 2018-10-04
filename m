From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 4 Oct 2018 21:05:22 +0530
Subject: [PATCH v8 04/10] edac: synopsys: Make return type void for functions
 always returning 0
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1538667328-9465-5-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current driver has functions which are always returning 0. Those
functions can be modified to void.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 7db5928..675155f 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -352,10 +352,8 @@ static enum mem_type edac_get_mtype(const void __iomem *base)
  *
  * Initializes the chip select rows associated with the EDAC memory
  * controller instance.
- *
- * Return: Unconditionally 0.
  */
-static int edac_init_csrows(struct mem_ctl_info *mci)
+static void edac_init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
@@ -376,8 +374,6 @@ static int edac_init_csrows(struct mem_ctl_info *mci)
 			dimm->dtype	= edac_get_dtype(priv->baseaddr);
 		}
 	}
-
-	return 0;
 }
 
 /**
@@ -388,13 +384,10 @@ static int edac_init_csrows(struct mem_ctl_info *mci)
  * Performs initialization of the EDAC memory controller instance and
  * related driver-private data associated with the memory controller the
  * instance is bound to.
- *
- * Return: Always zero.
  */
-static int edac_mc_init(struct mem_ctl_info *mci,
+static void edac_mc_init(struct mem_ctl_info *mci,
 				 struct platform_device *pdev)
 {
-	int status;
 	struct synps_edac_priv *priv;
 
 	mci->pdev = &pdev->dev;
@@ -416,9 +409,7 @@ static int edac_mc_init(struct mem_ctl_info *mci,
 	mci->edac_check = edac_check;
 	mci->ctl_page_to_phys = NULL;
 
-	status = edac_init_csrows(mci);
-
-	return status;
+	edac_init_csrows(mci);
 }
 
 /**
@@ -466,12 +457,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
-	rc = edac_mc_init(mci, pdev);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "Failed to initialize instance\n");
-		goto free_edac_mc;
-	}
+	edac_mc_init(mci, pdev);
 
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
-- 
2.1.1
