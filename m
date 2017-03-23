From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 23 Mar 2017 19:00:47 +0000
Subject: [PATCH v3 4/8] arm64: efi: clean up Image header after PE header has
 been split off
In-Reply-To: <20170323190051.14882-1-ard.biesheuvel@linaro.org>
References: <20170323190051.14882-1-ard.biesheuvel@linaro.org>
Message-ID: <20170323190051.14882-5-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After having split off the PE header, clean up the bits that remain:
use .long consistently, merge two adjacent #ifdef CONFIG_EFI blocks,
fix the offset of the PE header pointer and remove the redundant .align
that follows it.

Also, since we will be eliminating all open coded constants from the
EFI header in subsequent patches, let's replace the open coded "ARM\x64"
magic number with its .ascii equivalent.

No changes to the resulting binary image are intended.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c1977bed01db..6d49e716bf40 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -91,20 +91,14 @@ _head:
 	.quad	0				// reserved
 	.quad	0				// reserved
 	.quad	0				// reserved
-	.byte	0x41				// Magic number, "ARM\x64"
-	.byte	0x52
-	.byte	0x4d
-	.byte	0x64
+	.ascii	"ARM\x64"			// Magic number
 #ifdef CONFIG_EFI
 	.long	pe_header - _head		// Offset to the PE header.
-#else
-	.word	0				// reserved
-#endif
 
-#ifdef CONFIG_EFI
-	.align 3
 pe_header:
 	__EFI_PE_HEADER
+#else
+	.long	0				// reserved
 #endif
 
 	__INIT
-- 
2.9.3
