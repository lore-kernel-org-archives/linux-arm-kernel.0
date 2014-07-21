From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Jul 2014 17:16:19 +0200
Subject: [RFC PATCH 04/10] arm64: add EFI little endian constants to linker
 script
In-Reply-To: <1405955785-13477-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1405955785-13477-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1405955785-13477-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to how text offset and kernel size are mangled to produce little
endian constants for the Image header regardless of the endianness of the
kernel, this adds a number of constants used in the EFI PE/COFF header which
can only be calculated (and byte swapped) by the linker.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/image.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index 8fae0756e175..f5a2f298810d 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -37,8 +37,10 @@
 	 (((data) & 0x0000ff0000000000) >> 24) |	\
 	 (((data) & 0x00ff000000000000) >> 40) |	\
 	 (((data) & 0xff00000000000000) >> 56))
+#define DATA_LE32(data) (DATA_LE64(data) >> 32)
 #else
 #define DATA_LE64(data) ((data) & 0xffffffffffffffff)
+#define DATA_LE32(data) ((data) & 0xffffffff)
 #endif
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
@@ -57,6 +59,18 @@
 #define HEAD_SYMBOLS						\
 	_kernel_size_le		= DATA_LE64(_end - _text);	\
 	_kernel_offset_le	= DATA_LE64(TEXT_OFFSET);	\
-	_kernel_flags_le	= DATA_LE64(__HEAD_FLAGS);
+	_kernel_flags_le	= DATA_LE64(__HEAD_FLAGS);	\
+	EFI_HEAD_SYMBOLS
+
+#ifdef CONFIG_EFI
+#define EFI_HEAD_SYMBOLS						    \
+	_efi_stext_offset_le	= DATA_LE32(stext_offset);		    \
+	_efi_code_virtsize_le	= DATA_LE32(_end - _text - stext_offset);   \
+	_efi_code_rawsize_le	= DATA_LE32(_edata - _text - stext_offset); \
+	_efi_image_size_le	= DATA_LE32(_end - _text);		    \
+	_efi_entry_point_le	= DATA_LE32(efi_stub_entry - _text);
+#else
+#define  EFI_HEAD_SYMBOLS
+#endif
 
 #endif /* __ASM_IMAGE_H */
-- 
1.8.3.2
