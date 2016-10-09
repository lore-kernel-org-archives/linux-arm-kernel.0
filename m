From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun,  9 Oct 2016 18:42:23 +0100
Subject: [PATCH 4/6] crypto: arm64/sha2-ce - fix for big endian
In-Reply-To: <1476034945-9186-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476034945-9186-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1476034945-9186-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SHA256 digest is an array of 8 32-bit quantities, so we should refer
to them as such in order for this code to work correctly when built for
big endian. So replace 16 byte scalar loads and stores with 4x32 vector
ones where appropriate.

Fixes: 6ba6c74dfc6b ("arm64/crypto: SHA-224/SHA-256 using ARMv8 Crypto Extensions")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/sha2-ce-core.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/crypto/sha2-ce-core.S b/arch/arm64/crypto/sha2-ce-core.S
index 5df9d9d470ad..01cfee066837 100644
--- a/arch/arm64/crypto/sha2-ce-core.S
+++ b/arch/arm64/crypto/sha2-ce-core.S
@@ -85,7 +85,7 @@ ENTRY(sha2_ce_transform)
 	ld1		{v12.4s-v15.4s}, [x8]
 
 	/* load state */
-	ldp		dga, dgb, [x0]
+	ld1		{dgav.4s, dgbv.4s}, [x0]
 
 	/* load sha256_ce_state::finalize */
 	ldr		w4, [x0, #:lo12:sha256_ce_offsetof_finalize]
@@ -148,6 +148,6 @@ CPU_LE(	rev32		v19.16b, v19.16b	)
 	b		1b
 
 	/* store new state */
-3:	stp		dga, dgb, [x0]
+3:	st1		{dgav.4s, dgbv.4s}, [x0]
 	ret
 ENDPROC(sha2_ce_transform)
-- 
2.7.4
