From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 10 Jan 2018 12:11:37 +0000
Subject: [PATCH 2/7] arm64/crypto: aes-cipher: move S-box to .rodata section
In-Reply-To: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
References: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
Message-ID: <20180110121142.18291-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the AES inverse S-box to the .rodata section where it is safe from
abuse by speculation.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/aes-cipher-core.S | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/crypto/aes-cipher-core.S b/arch/arm64/crypto/aes-cipher-core.S
index 6d2445d603cc..3a44eada2347 100644
--- a/arch/arm64/crypto/aes-cipher-core.S
+++ b/arch/arm64/crypto/aes-cipher-core.S
@@ -125,6 +125,16 @@ CPU_BE(	rev		w7, w7		)
 	ret
 	.endm
 
+ENTRY(__aes_arm64_encrypt)
+	do_crypt	fround, crypto_ft_tab, crypto_ft_tab + 1, 2
+ENDPROC(__aes_arm64_encrypt)
+
+	.align		5
+ENTRY(__aes_arm64_decrypt)
+	do_crypt	iround, crypto_it_tab, __aes_arm64_inverse_sbox, 0
+ENDPROC(__aes_arm64_decrypt)
+
+	.section	".rodata", "a"
 	.align		L1_CACHE_SHIFT
 	.type		__aes_arm64_inverse_sbox, %object
 __aes_arm64_inverse_sbox:
@@ -161,12 +171,3 @@ __aes_arm64_inverse_sbox:
 	.byte		0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26
 	.byte		0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d
 	.size		__aes_arm64_inverse_sbox, . - __aes_arm64_inverse_sbox
-
-ENTRY(__aes_arm64_encrypt)
-	do_crypt	fround, crypto_ft_tab, crypto_ft_tab + 1, 2
-ENDPROC(__aes_arm64_encrypt)
-
-	.align		5
-ENTRY(__aes_arm64_decrypt)
-	do_crypt	iround, crypto_it_tab, __aes_arm64_inverse_sbox, 0
-ENDPROC(__aes_arm64_decrypt)
-- 
2.11.0
