From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Thu,  1 Mar 2018 11:47:10 -0600
Subject: [PATCH 1/3] staging: fsl-mc: Cleanup dpbp and dpcon API
In-Reply-To: <20180301174712.2660-1-bogdan.purcareata@nxp.com>
References: <20180301174712.2660-1-bogdan.purcareata@nxp.com>
Message-ID: <20180301174712.2660-2-bogdan.purcareata@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some functions and associated structures are not used by current code,
so remove them.

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpbp-cmd.h | 10 ------
 drivers/staging/fsl-mc/bus/dpbp.c     | 67 -----------------------------------
 drivers/staging/fsl-mc/include/dpbp.h | 10 ------
 3 files changed, 87 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpbp-cmd.h b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
index 0b7f5c0..3340021 100644
--- a/drivers/staging/fsl-mc/bus/dpbp-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
@@ -19,28 +19,18 @@
 /* Command IDs */
 #define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
 #define DPBP_CMDID_OPEN			DPBP_CMD(0x804)
-#define DPBP_CMDID_GET_API_VERSION	DPBP_CMD(0xa04)
 
 #define DPBP_CMDID_ENABLE		DPBP_CMD(0x002)
 #define DPBP_CMDID_DISABLE		DPBP_CMD(0x003)
 #define DPBP_CMDID_GET_ATTR		DPBP_CMD(0x004)
 #define DPBP_CMDID_RESET		DPBP_CMD(0x005)
-#define DPBP_CMDID_IS_ENABLED		DPBP_CMD(0x006)
 
 struct dpbp_cmd_open {
 	__le32 dpbp_id;
 };
 
-struct dpbp_cmd_destroy {
-	__le32 object_id;
-};
-
 #define DPBP_ENABLE			0x1
 
-struct dpbp_rsp_is_enabled {
-	u8 enabled;
-};
-
 struct dpbp_rsp_get_attributes {
 	/* response word 0 */
 	__le16 pad;
diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/staging/fsl-mc/bus/dpbp.c
index c0addaa..85735bb 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/staging/fsl-mc/bus/dpbp.c
@@ -126,40 +126,6 @@ int dpbp_disable(struct fsl_mc_io *mc_io,
 EXPORT_SYMBOL_GPL(dpbp_disable);
 
 /**
- * dpbp_is_enabled() - Check if the DPBP is enabled.
- * @mc_io:	Pointer to MC portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @token:	Token of DPBP object
- * @en:		Returns '1' if object is enabled; '0' otherwise
- *
- * Return:	'0' on Success; Error code otherwise.
- */
-int dpbp_is_enabled(struct fsl_mc_io *mc_io,
-		    u32 cmd_flags,
-		    u16 token,
-		    int *en)
-{
-	struct mc_command cmd = { 0 };
-	struct dpbp_rsp_is_enabled *rsp_params;
-	int err;
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPBP_CMDID_IS_ENABLED, cmd_flags,
-					  token);
-
-	/* send command to mc*/
-	err = mc_send_command(mc_io, &cmd);
-	if (err)
-		return err;
-
-	/* retrieve response parameters */
-	rsp_params = (struct dpbp_rsp_is_enabled *)cmd.params;
-	*en = rsp_params->enabled & DPBP_ENABLE;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dpbp_is_enabled);
-
-/**
  * dpbp_reset() - Reset the DPBP, returns the object to initial state.
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
@@ -218,36 +184,3 @@ int dpbp_get_attributes(struct fsl_mc_io *mc_io,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dpbp_get_attributes);
-
-/**
- * dpbp_get_api_version - Get Data Path Buffer Pool API version
- * @mc_io:	Pointer to Mc portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @major_ver:	Major version of Buffer Pool API
- * @minor_ver:	Minor version of Buffer Pool API
- *
- * Return:	'0' on Success; Error code otherwise.
- */
-int dpbp_get_api_version(struct fsl_mc_io *mc_io,
-			 u32 cmd_flags,
-			 u16 *major_ver,
-			 u16 *minor_ver)
-{
-	struct mc_command cmd = { 0 };
-	int err;
-
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPBP_CMDID_GET_API_VERSION,
-					  cmd_flags, 0);
-
-	/* send command to mc */
-	err = mc_send_command(mc_io, &cmd);
-	if (err)
-		return err;
-
-	/* retrieve response parameters */
-	mc_cmd_read_api_version(&cmd, major_ver, minor_ver);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dpbp_get_api_version);
diff --git a/drivers/staging/fsl-mc/include/dpbp.h b/drivers/staging/fsl-mc/include/dpbp.h
index 4a18096..7b9f7ad 100644
--- a/drivers/staging/fsl-mc/include/dpbp.h
+++ b/drivers/staging/fsl-mc/include/dpbp.h
@@ -30,11 +30,6 @@ int dpbp_disable(struct fsl_mc_io *mc_io,
 		 u32 cmd_flags,
 		 u16 token);
 
-int dpbp_is_enabled(struct fsl_mc_io *mc_io,
-		    u32 cmd_flags,
-		    u16 token,
-		    int *en);
-
 int dpbp_reset(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token);
@@ -55,9 +50,4 @@ int dpbp_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpbp_attr *attr);
 
-int dpbp_get_api_version(struct fsl_mc_io *mc_io,
-			 u32 cmd_flags,
-			 u16 *major_ver,
-			 u16 *minor_ver);
-
 #endif /* __FSL_DPBP_H */
-- 
2.7.4
