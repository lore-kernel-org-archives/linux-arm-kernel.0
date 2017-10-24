From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 24 Oct 2017 15:32:25 +0800
Subject: [PATCH] ARM: Fix csum_partial_copy_from_user() stack mismatch
Message-ID: <20171024073225.17374-1-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>

An additional 'ip' will be pushed to the stack, for restoring the
DACR later, if CONFIG_CPU_SW_DOMAIN_PAN defined.

However, the fixup still get the err_ptr by add #8*4 to sp, which
results in the fact that the code area pointed by the LR will be
overwritten, or the kernel will crash if CONFIG_DEBUG_RODATA is enabled.

This patch fixes the stack mismatch.

Signed-off-by: Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm/lib/csumpartialcopyuser.S |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 1712f13..b83fdc0 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -85,7 +85,11 @@
 		.pushsection .text.fixup,"ax"
 		.align	4
 9001:		mov	r4, #-EFAULT
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+		ldr	r5, [sp, #9*4]		@ *err_ptr
+#else
 		ldr	r5, [sp, #8*4]		@ *err_ptr
+#endif
 		str	r4, [r5]
 		ldmia	sp, {r1, r2}		@ retrieve dst, len
 		add	r2, r2, r1
-- 
1.7.9.5
