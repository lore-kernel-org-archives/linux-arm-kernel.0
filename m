From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  8 May 2015 10:46:22 +0200
Subject: [PATCH 2/2] crypto: arm/aes - streamline AES-192 code path
In-Reply-To: <1431074782-22141-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1431074782-22141-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1431074782-22141-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This trims off a couple of instructions of the total size of the
core AES transform by reordering the final branch in the AES-192
code path with the rounds that are performed regardless of whether
the branch is taken or not. Other than the slight size reduction,
this has no performance benefit.

Fix up a comment regarding the prototype of this function while
we're at it.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/aes-ce-core.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/crypto/aes-ce-core.S b/arch/arm/crypto/aes-ce-core.S
index 8cfa468ee570..987aa632c9f0 100644
--- a/arch/arm/crypto/aes-ce-core.S
+++ b/arch/arm/crypto/aes-ce-core.S
@@ -101,15 +101,14 @@
 	\dround		q10, q11
 	blo		0f			@ AES-128: 10 rounds
 	vld1.8		{q10-q11}, [ip]!
-	beq		1f			@ AES-192: 12 rounds
 	\dround		q12, q13
+	beq		1f			@ AES-192: 12 rounds
 	vld1.8		{q12-q13}, [ip]
 	\dround		q10, q11
 0:	\fround		q12, q13, q14
 	bx		lr
 
-1:	\dround		q12, q13
-	\fround		q10, q11, q14
+1:	\fround		q10, q11, q14
 	bx		lr
 	.endm
 
@@ -122,8 +121,8 @@
 	 *   q2        : third in/output block (_3x version only)
 	 *   q8        : first round key
 	 *   q9        : secound round key
-	 *   ip        : address of 3rd round key
 	 *   q14       : final round key
+	 *   r2        : address of round key array
 	 *   r3        : number of rounds
 	 */
 	.align		6
-- 
1.9.1
