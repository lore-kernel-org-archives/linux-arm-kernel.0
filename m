From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Thu, 17 Sep 2015 12:38:09 +0300
Subject: [PATCH v6 3/6] x86, efi, kasan: #undef memset/memcpy/memmove per arch.
In-Reply-To: <1442482692-6416-1-git-send-email-ryabinin.a.a@gmail.com>
References: <1442482692-6416-1-git-send-email-ryabinin.a.a@gmail.com>
Message-ID: <1442482692-6416-4-git-send-email-ryabinin.a.a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In not-instrumented code KASAN replaces instrumented
memset/memcpy/memmove with not-instrumented analogues
__memset/__memcpy/__memove.
However, on x86 the EFI stub is not linked with the kernel.
It uses not-instrumented mem*() functions from
arch/x86/boot/compressed/string.c
So we don't replace them with __mem*() variants in EFI stub.

On ARM64 the EFI stub is linked with the kernel, so we should
replace mem*() functions with __mem*(), because the EFI stub
runs before KASAN sets up early shadow.

So let's move these #undef mem* into arch's asm/efi.h which is
also included by the EFI stub.

Also, this will fix the warning in 32-bit build reported by
kbuild test robot <fengguang.wu@intel.com>:
	efi-stub-helper.c:599:2: warning: implicit declaration of function 'memcpy'

Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
 arch/x86/include/asm/efi.h             | 12 ++++++++++++
 drivers/firmware/efi/libstub/efistub.h |  4 ----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 155162e..6db2742 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -86,6 +86,18 @@ extern u64 asmlinkage efi_call(void *fp, ...);
 extern void __iomem *__init efi_ioremap(unsigned long addr, unsigned long size,
 					u32 type, u64 attribute);
 
+/*
+ * CONFIG_KASAN may redefine memset to __memset.
+ * __memset function is present only in kernel binary.
+ * Since the EFI stub linked into a separate binary it
+ * doesn't have __memset(). So we should use standard
+ * memset from arch/x86/boot/compressed/string.c
+ * The same applies to memcpy and memmove.
+ */
+#undef memcpy
+#undef memset
+#undef memmove
+
 #endif /* CONFIG_X86_32 */
 
 extern struct efi_scratch efi_scratch;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index e334a01..6b6548f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -5,10 +5,6 @@
 /* error code which can't be mistaken for valid address */
 #define EFI_ERROR	(~0UL)
 
-#undef memcpy
-#undef memset
-#undef memmove
-
 void efi_char16_printk(efi_system_table_t *, efi_char16_t *);
 
 efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg, void *__image,
-- 
2.4.6
