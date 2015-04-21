From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Apr 2015 11:09:32 +0200
Subject: [PATCH 2/2] ARM: prefer "bx reg" over "mov pc, reg" for all registers
In-Reply-To: <1429607205-7501-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1429607205-7501-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1429607372-7598-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6ebbf2ce437b (ARM: convert all "mov.* pc, reg" to "bx reg"
for ARMv6+) replaced all occurrences of 'mov pc, <reg>' with the
'ret' macro. However, this macro only emits the 'bx' instruction
when used with the 'lr' register, but still uses 'mov pc, <reg>'
for everything else.

Since ARM/Thumb2 interworking is allowed in the static kernel
(i.e., inside vmlinux), this is potentially unsafe, since the mov
instruction will not switch modes based on the Thumb bit.

So instead, emit the 'bx' instruction in all cases, and not just
for the 'lr' register.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/assembler.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 186270b3e194..6dda6e3378ea 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -435,11 +435,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #if __LINUX_ARM_ARCH__ < 6
 	mov\c	pc, \reg
 #else
-	.ifeqs	"\reg", "lr"
 	bx\c	\reg
-	.else
-	mov\c	pc, \reg
-	.endif
 #endif
 	.endm
 	.endr
-- 
1.8.3.2
