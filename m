From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  4 Aug 2017 14:00:26 +0200
Subject: [PATCH 4/5] edac: synopsys: Update ecc error message info
In-Reply-To: <60ff19f90adfd252cf296fe8988c614c4c3e43fd.1501848023.git.michal.simek@xilinx.com>
References: <60ff19f90adfd252cf296fe8988c614c4c3e43fd.1501848023.git.michal.simek@xilinx.com>
Message-ID: <1c27213cd2dd9880c49fc0f65d9c2aa44c404db7.1501848023.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>

This patch updates the ecc error message info
for zynqmp ddrc. added Block number and Bankgroup
in the message info.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/edac/synopsys_edac.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 546adc243bca..501ef447df37 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -418,9 +418,17 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "CE", pinf->row, pinf->bank, pinf->col);
+		if (priv->p_data->quirks == 0)
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				 "CE", pinf->row, pinf->bank, pinf->col);
+		else
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d "
+				 "BankGroup Number %d Block Number %d",
+				 "CE", pinf->row, pinf->bank, pinf->col,
+				 pinf->bankgrpnr, pinf->blknr);
+
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -428,9 +436,16 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "UE", pinf->row, pinf->bank, pinf->col);
+		if (priv->p_data->quirks == 0)
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				"UE", pinf->row, pinf->bank, pinf->col);
+		else
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d "
+				 "BankGroup Number %d Block Number %d",
+				 "UE", pinf->row, pinf->bank, pinf->col,
+				 pinf->bankgrpnr, pinf->blknr);
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
-- 
1.9.1
