From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 30 Mar 2011 13:46:23 +0100
Subject: [PATCH] ARM: vfp: Remote obsolete fpmx_state field from
	vfp_hard_struct
Message-ID: <1301489184-4112-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fpmx_state field was presumably used in the past, when
FSTMX/FLDMX were used to save and resture the VFP state.

This was been deprecated since ARMv6, the context switch code
has been ported to use the double-precision load/store variants
many years ago, and now it appears that nothing in the kernel
references this field any more.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/fpstate.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/fpstate.h b/arch/arm/include/asm/fpstate.h
index ee5e03e..08bb836 100644
--- a/arch/arm/include/asm/fpstate.h
+++ b/arch/arm/include/asm/fpstate.h
@@ -18,7 +18,6 @@
  * VFP storage area has:
  *  - FPEXC, FPSCR, FPINST and FPINST2.
  *  - 16 or 32 double precision data registers
- *  - an implementation-dependant word of state for FLDMX/FSTMX (pre-ARMv6)
  * 
  *  FPEXC will always be non-zero once the VFP has been used in this process.
  */
@@ -29,9 +28,6 @@ struct vfp_hard_struct {
 #else
 	__u64 fpregs[16];
 #endif
-#if __LINUX_ARM_ARCH__ < 6
-	__u32 fpmx_state;
-#endif
 	__u32 fpexc;
 	__u32 fpscr;
 	/*
-- 
1.7.1
