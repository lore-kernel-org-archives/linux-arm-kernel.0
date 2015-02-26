From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 26 Feb 2015 15:59:34 -0600
Subject: [PATCH 2/4] ARM: qcom: Cleanup scm interface to only export what is
 needed
In-Reply-To: <1424987976-14531-1-git-send-email-galak@codeaurora.org>
References: <1424987976-14531-1-git-send-email-galak@codeaurora.org>
Message-ID: <1424987976-14531-2-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that scom boot interface is merged we don't need export scm_call
anymore.  Some other minor cleanups related to boot interface to only
export what is needed by scm_set_boot_addr().

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm/mach-qcom/scm.c | 7 ++++---
 arch/arm/mach-qcom/scm.h | 7 -------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-qcom/scm.c b/arch/arm/mach-qcom/scm.c
index e20db10..5147666 100644
--- a/arch/arm/mach-qcom/scm.c
+++ b/arch/arm/mach-qcom/scm.c
@@ -249,8 +249,8 @@ static void scm_inv_range(unsigned long start, unsigned long end)
  * response buffers is taken care of by scm_call; however, callers are
  * responsible for any other cached buffers passed over to the secure world.
  */
-int scm_call(u32 svc_id, u32 cmd_id, const void *cmd_buf, size_t cmd_len,
-		void *resp_buf, size_t resp_len)
+static int scm_call(u32 svc_id, u32 cmd_id, const void *cmd_buf, size_t cmd_len,
+			void *resp_buf, size_t resp_len)
 {
 	int ret;
 	struct scm_command *cmd;
@@ -287,7 +287,6 @@ out:
 	free_scm_command(cmd);
 	return ret;
 }
-EXPORT_SYMBOL(scm_call);
 
 u32 scm_get_version(void)
 {
@@ -325,6 +324,8 @@ u32 scm_get_version(void)
 }
 EXPORT_SYMBOL(scm_get_version);
 
+#define SCM_SVC_BOOT			0x1
+#define SCM_BOOT_ADDR			0x1
 /*
  * Set the cold/warm boot address for one of the CPU cores.
  */
diff --git a/arch/arm/mach-qcom/scm.h b/arch/arm/mach-qcom/scm.h
index cfe6935..d73c378 100644
--- a/arch/arm/mach-qcom/scm.h
+++ b/arch/arm/mach-qcom/scm.h
@@ -12,13 +12,6 @@
 #ifndef __MACH_SCM_H
 #define __MACH_SCM_H
 
-#define SCM_SVC_BOOT			0x1
-#define SCM_SVC_PIL			0x2
-
-extern int scm_call(u32 svc_id, u32 cmd_id, const void *cmd_buf, size_t cmd_len,
-		void *resp_buf, size_t resp_len);
-
-#define SCM_BOOT_ADDR			0x1
 #define SCM_FLAG_COLDBOOT_CPU1		0x01
 #define SCM_FLAG_COLDBOOT_CPU2		0x08
 #define SCM_FLAG_COLDBOOT_CPU3		0x20
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
