From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 28 Jul 2016 16:15:14 +0200
Subject: [PATCH] arm64: vmlinux.lds: make __rela_offset and __dynsym_offset
 ABSOLUTE
Message-ID: <1469715314-23260-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the untyped KIMAGE_VADDR constant, the linker may not notice
that the __rela_offset and __dynsym_offset expressions are absolute
values (i.e., are not subject to relocation). This does not matter for
KASLR, but it does confuse kallsyms in relative mode, since it uses
the lowest non-absolute symbol address as the anchor point, and expects
all other symbol addresses to be within 4 GB of it.

Fix this by qualifying these expressions as ABSOLUTE() explicitly.

Fixes: 0cd3defe0af4 ("arm64: kernel: perform relocation processing from ID map")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 89d6e177ecbd..d49492179967 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -184,9 +184,9 @@ SECTIONS
 		*(.hash)
 	}
 
-	__rela_offset	= ADDR(.rela) - KIMAGE_VADDR;
+	__rela_offset	= ABSOLUTE(ADDR(.rela) - KIMAGE_VADDR);
 	__rela_size	= SIZEOF(.rela);
-	__dynsym_offset	= ADDR(.dynsym) - KIMAGE_VADDR;
+	__dynsym_offset	= ABSOLUTE(ADDR(.dynsym) - KIMAGE_VADDR);
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__init_end = .;
-- 
2.7.4
