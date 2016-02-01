From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  1 Feb 2016 18:02:34 +0100
Subject: [PATCH] ARM: vmlinux.lds: assert that ROM and RAM don't overlap when
 XIP_KERNEL=y
Message-ID: <1454346154-12931-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building an XIP kernel, the linker produces two disjoint VMA regions,
where the first is mapped onto ROM and the second onto RAM. For this reason,
the linker output pointer '.' is updated halfway through the linker script,
and set to a value that corresponds with the start of the RAM region.

However, in some cases, the ROM region exceeds the expected size, and the
assignment of the output pointer results in a decrement rather than an
increment, causing the virtual addresses of the .data region to clash with
the .text region. Such a kernel cannot boot normally, but it also confuses
the hell out of kallsyms, since .data symbols may appear inside the
[_stext, _etext] or [_sinittext, _einittext] intervals in the first pass,
but not in the second (or vice versa), resulting in inconsistent kallsyms
data.

So let's make sure that the output pointer only advances, and never jumps
back into the ROM region.

Cc: arnd at arndb.de
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 8b60fde5ce48..950114d533e1 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -229,6 +229,7 @@ SECTIONS
 
 #ifdef CONFIG_XIP_KERNEL
 	__data_loc = ALIGN(4);		/* location in binary */
+	ASSERT(. < PAGE_OFFSET + TEXT_OFFSET, "XIP_KERNEL: ROM and RAM overlap")
 	. = PAGE_OFFSET + TEXT_OFFSET;
 #else
 #ifdef CONFIG_ARM_KERNMEM_PERMS
-- 
2.5.0
