From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 May 2013 18:00:12 +0100
Subject: [PATCH] ARM: vfp: ensure VFP_arch is non-zero when VFP is not
 supported
Message-ID: <1368550812-30492-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d3f79584a8b5 ("ARM: cleanup undefined instruction entry code")
improved the register scheduling when handling undefined instructions.
A side effect of this is that r5 is now used as a temporary, whilst the
VFP probing code relies on r5 containing a non-zero value when VFP is
not supported.

This patch fixes the VFP detection code so that we don't rely on the
contents of r5. Without this patch, Linux dies loudly on CPUs without
VFP support.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/vfp/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 323ce1a..46e1749 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -60,7 +60,7 @@ ENTRY(vfp_testing_entry)
 	str	r11, [r10, #TI_PREEMPT]
 #endif
 	ldr	r0, VFP_arch_address
-	str	r5, [r0]		@ known non-zero value
+	str	r0, [r0]		@ set to non-zero value
 	mov	pc, r9			@ we have handled the fault
 ENDPROC(vfp_testing_entry)
 
-- 
1.8.2.2
