From: bs14@csr.com (Barry Song)
Date: Tue, 3 May 2011 23:16:30 -0700
Subject: [PATCH v3] ARM: vfp: Always save VFP state in vfp_pm_suspend
Message-ID: <1304489790-30126-1-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

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

Signed-off-by: Colin Cross <ccross@android.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Binghua Duan <binghua.duan@csr.com>
Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 arch/arm/vfp/vfpmodule.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index bbf3da0..a54c4d6 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -392,6 +392,12 @@ static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
 
 		/* disable, just in case */
 		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+	} else {
+		if (last_VFP_context[ti->cpu]) {
+			fmxr(FPEXC, fpexc | FPEXC_EN);
+			vfp_save_state(last_VFP_context[ti->cpu], fpexc);
+			fmxr(FPEXC, fpexc);
+		}
 	}
 
 	/* clear any information we had about last context state */
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
