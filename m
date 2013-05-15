From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 15 May 2013 11:27:00 +0200
Subject: [PATCH] ARM: crypto: sha1-armv4-large.S: fix SP handling
Message-ID: <1368610020-29219-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the SHA1 asm code ABI conformant by making sure all stack
accesses occur above the stack pointer.

Origin:
http://git.openssl.org/gitweb/?p=openssl.git;a=commit;h=1a9d60d2

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/sha1-armv4-large.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/crypto/sha1-armv4-large.S b/arch/arm/crypto/sha1-armv4-large.S
index 92c6eed..99207c4 100644
--- a/arch/arm/crypto/sha1-armv4-large.S
+++ b/arch/arm/crypto/sha1-armv4-large.S
@@ -195,6 +195,7 @@ ENTRY(sha1_block_data_order)
 	add	r3,r3,r10			@ E+=F_00_19(B,C,D)
 	cmp	r14,sp
 	bne	.L_00_15		@ [((11+4)*5+2)*3]
+	sub	sp,sp,#25*4
 #if __ARM_ARCH__<7
 	ldrb	r10,[r1,#2]
 	ldrb	r9,[r1,#3]
@@ -290,7 +291,6 @@ ENTRY(sha1_block_data_order)
 	add	r3,r3,r10			@ E+=F_00_19(B,C,D)
 
 	ldr	r8,.LK_20_39		@ [+15+16*4]
-	sub	sp,sp,#25*4
 	cmn	sp,#0			@ [+3], clear carry to denote 20_39
 .L_20_39_or_60_79:
 	ldr	r9,[r14,#15*4]
-- 
1.8.1.2
