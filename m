From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 19 Jul 2017 14:42:26 +0300
Subject: [PATCH v3 2/8] staging: fsl-mc: use generic memory barriers
In-Reply-To: <20170719114232.8347-1-laurentiu.tudor@nxp.com>
References: <20170719114232.8347-1-laurentiu.tudor@nxp.com>
Message-ID: <20170719114232.8347-3-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

No need to use arch-specific memory barriers; switch to using generic
ones. The rmb()s were useless so drop them.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Notes:
    -v3
      -no changes
    -v2
      -no changes

 drivers/staging/fsl-mc/bus/mc-sys.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/staging/fsl-mc/bus/mc-sys.c
index a1704c3..012abd5 100644
--- a/drivers/staging/fsl-mc/bus/mc-sys.c
+++ b/drivers/staging/fsl-mc/bus/mc-sys.c
@@ -127,7 +127,8 @@ static inline void mc_write_command(struct mc_command __iomem *portal,
 	/* copy command parameters into the portal */
 	for (i = 0; i < MC_CMD_NUM_OF_PARAMS; i++)
 		__raw_writeq(cmd->params[i], &portal->params[i]);
-	__iowmb();
+	/* ensure command params are committed before submitting it */
+	wmb();
 
 	/* submit the command by writing the header */
 	__raw_writeq(cmd->header, &portal->header);
@@ -150,9 +151,7 @@ static inline enum mc_cmd_status mc_read_response(struct mc_command __iomem *
 	enum mc_cmd_status status;
 
 	/* Copy command response header from MC portal: */
-	__iormb();
 	resp->header = __raw_readq(&portal->header);
-	__iormb();
 	status = mc_cmd_hdr_read_status(resp);
 	if (status != MC_CMD_STATUS_OK)
 		return status;
@@ -160,7 +159,6 @@ static inline enum mc_cmd_status mc_read_response(struct mc_command __iomem *
 	/* Copy command response data from MC portal: */
 	for (i = 0; i < MC_CMD_NUM_OF_PARAMS; i++)
 		resp->params[i] = __raw_readq(&portal->params[i]);
-	__iormb();
 
 	return status;
 }
-- 
2.9.4
