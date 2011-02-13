From: ccross@android.com (Colin Cross)
Date: Sun, 13 Feb 2011 15:13:33 -0800
Subject: [PATCH] ARM: vfp: Always save VFP state in vfp_pm_suspend
Message-ID: <1297638813-1315-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vfp_pm_suspend should save the VFP state any time there is
a last_VFP_context.  If it only saves when the VFP is enabled,
the state can get lost when, on a UP system:
   Thread 1 uses the VFP
   Context switch occurs to thread 2, VFP is disabled but the
      VFP context is not saved to allow lazy save and restore
   Thread 2 initiates suspend
   vfp_pm_suspend is called with the VFP disabled, but the
      context has not been saved.

Modify vfp_pm_suspend to save the VFP context whenever
last_VFP_context is set.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/vfp/vfpmodule.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 66bf8d1..7aea616 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -415,13 +415,12 @@ static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
 	struct thread_info *ti = current_thread_info();
 	u32 fpexc = fmrx(FPEXC);
 
-	/* if vfp is on, then save state for resumption */
-	if (fpexc & FPEXC_EN) {
+	/* save state for resume */
+	if (last_VFP_context[ti->cpu]) {
 		printk(KERN_DEBUG "%s: saving vfp state\n", __func__);
-		vfp_save_state(&ti->vfpstate, fpexc);
-
-		/* disable, just in case */
-		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+		fmxr(FPEXC, fpexc | FPEXC_EN);
+		vfp_save_state(last_VFP_context[ti->cpu], fpexc);
+		fmxr(FPEXC, fpexc & ~FPEXC_EN);
 	}
 
 	/* clear any information we had about last context state */
-- 
1.7.3.1
