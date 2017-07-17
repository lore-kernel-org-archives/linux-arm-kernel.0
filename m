From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Mon, 17 Jul 2017 16:26:45 +0300
Subject: [PATCH 6/7] staging: fsl-mc: rewrite mc command send/receive to work
 on 32-bits
In-Reply-To: <20170717132646.3020-1-laurentiu.tudor@nxp.com>
References: <20170717132646.3020-1-laurentiu.tudor@nxp.com>
Message-ID: <20170717132646.3020-7-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Split the 64-bit accesses in 32-bit accesses because there's no real
constrain in MC to do only atomic 64-bit. There's only one place
where ordering is important: when writing the MC command header the
first 32-bit part of the header must be written last.
We do this switch in order to allow compiling the driver on 32-bit.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/mc-sys.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/staging/fsl-mc/bus/mc-sys.c
index 195d9f3..dd2828e 100644
--- a/drivers/staging/fsl-mc/bus/mc-sys.c
+++ b/drivers/staging/fsl-mc/bus/mc-sys.c
@@ -124,14 +124,15 @@ static inline void mc_write_command(struct mc_command __iomem *portal,
 {
 	int i;
 
-	/* copy command parameters into the portal */
-	for (i = 0; i < MC_CMD_NUM_OF_PARAMS; i++)
-		__raw_writeq(cmd->params[i], &portal->params[i]);
-	/* ensure command params are committed before submitting it */
-	wmb();
-
-	/* submit the command by writing the header */
-	__raw_writeq(cmd->header, &portal->header);
+	/*
+	 * copy command parameters into the portal. Final write
+	 * triggers the submission of the command.
+	 */
+	for (i = sizeof(struct mc_command) / sizeof(u32) - 1; i >= 0; i--) {
+		__raw_writel(((u32 *)cmd)[i], &((u32 *)portal)[i]);
+		/* ensure command params are committed before submitting it */
+		wmb();
+	}
 }
 
 /**
@@ -148,19 +149,11 @@ static inline enum mc_cmd_status mc_read_response(struct mc_command __iomem *
 						  struct mc_command *resp)
 {
 	int i;
-	enum mc_cmd_status status;
-
-	/* Copy command response header from MC portal: */
-	resp->header = __raw_readq(&portal->header);
-	status = mc_cmd_hdr_read_status(resp);
-	if (status != MC_CMD_STATUS_OK)
-		return status;
 
-	/* Copy command response data from MC portal: */
-	for (i = 0; i < MC_CMD_NUM_OF_PARAMS; i++)
-		resp->params[i] = __raw_readq(&portal->params[i]);
+	for (i = 0; i < sizeof(struct mc_command) / sizeof(u32); i++)
+		((u32 *)resp)[i] = __raw_readl(&((u32 *)portal)[i]);
 
-	return status;
+	return mc_cmd_hdr_read_status(resp);
 }
 
 /**
-- 
2.9.4
