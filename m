From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Jul 2014 17:16:18 +0200
Subject: [RFC PATCH 03/10] arm64: add macros to emit little endian ASM
 constants
In-Reply-To: <1405955785-13477-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1405955785-13477-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1405955785-13477-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Image header contains many constants that should be emitted in little
endian regardless of the endianness of the kernel. Add helper macros le16,
le32 and le64 to <asm/assembler.h> to aid with this.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 5901480bfdca..7db7c946f73f 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -155,3 +155,21 @@ lr	.req	x30		// link register
 #endif
 	orr	\rd, \lbits, \hbits, lsl #32
 	.endm
+
+	/*
+	 * Define LE constants
+	 */
+	.macro		le16, x
+	.byte		\x & 0xff
+	.byte		(\x >> 8) & 0xff
+	.endm
+
+	.macro		le32, x
+	le16		\x
+	le16		\x >> 16
+	.endm
+
+	.macro		le64, x
+	le32		\x
+	le32		\x >> 32
+	.endm
-- 
1.8.3.2
