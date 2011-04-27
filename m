From: bs14@csr.com (Barry Song)
Date: Tue, 26 Apr 2011 23:30:24 -0700
Subject: [PATCH] arm:pm: save the vfp state of last scheduled-out proceed
	while suspending
Message-ID: <1303885825-5411-1-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

Current vfp pm suspend entry only saves the vfp state of running proceed if it is using vfp. If current proceed doesn't use vfp,
the state of last process will be lost after resume. In pressure tests, we can see old vfp processes crash after resume.

In order that schedule can be faster, scheduler doesn't save vfp state if we schedule from proceeds using vfp to proceeds which
don't use vfp. If system suspend happens just at proceeds which don't use vfp, we have no any chance to save old vfp state.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Cc: Binghua Duan <binghua.duan@csr.com>
Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 arch/arm/vfp/vfpmodule.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index bbf3da0..a980967 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -384,6 +384,7 @@ static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
 {
 	struct thread_info *ti = current_thread_info();
 	u32 fpexc = fmrx(FPEXC);
+	unsigned int cpu = get_cpu();
 
 	/* if vfp is on, then save state for resumption */
 	if (fpexc & FPEXC_EN) {
@@ -392,8 +393,16 @@ static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
 
 		/* disable, just in case */
 		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+	} else {
+		if (last_VFP_context[cpu]) {
+			fmxr(FPEXC, fpexc | FPEXC_EN);
+			vfp_save_state(last_VFP_context[cpu], fpexc);
+			fmxr(FPEXC, fpexc);
+		}
 	}
 
+	put_cpu();
+
 	/* clear any information we had about last context state */
 	memset(last_VFP_context, 0, sizeof(last_VFP_context));
 
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
