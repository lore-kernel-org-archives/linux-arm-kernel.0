From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 10 Jan 2018 12:11:39 +0000
Subject: [PATCH 4/7] arm64/crypto: crc32: move literal data to .rodata section
In-Reply-To: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
References: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
Message-ID: <20180110121142.18291-5-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move CRC32 literal data to the .rodata section where it is safe from
being exploited by speculative execution.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/crc32-ce-core.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/crypto/crc32-ce-core.S b/arch/arm64/crypto/crc32-ce-core.S
index 18f5a8442276..16ed3c7ebd37 100644
--- a/arch/arm64/crypto/crc32-ce-core.S
+++ b/arch/arm64/crypto/crc32-ce-core.S
@@ -50,7 +50,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
-	.text
+	.section	".rodata", "a"
 	.align		6
 	.cpu		generic+crypto+crc
 
@@ -115,12 +115,13 @@
 	 * uint crc32_pmull_le(unsigned char const *buffer,
 	 *                     size_t len, uint crc32)
 	 */
+	.text
 ENTRY(crc32_pmull_le)
-	adr		x3, .Lcrc32_constants
+	adr_l		x3, .Lcrc32_constants
 	b		0f
 
 ENTRY(crc32c_pmull_le)
-	adr		x3, .Lcrc32c_constants
+	adr_l		x3, .Lcrc32c_constants
 
 0:	bic		LEN, LEN, #15
 	ld1		{v1.16b-v4.16b}, [BUF], #0x40
-- 
2.11.0
