From: alan-jenkins@tuffmail.co.uk (Alan Jenkins)
Date: Fri, 9 Oct 2009 13:35:13 +0100
Subject: [PATCH] ARM: unexport symbols used to implement floating point emulation
Message-ID: <mailman.59.1255096106.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig for in-tree floating point emulation does not allow building
as a module. That leaves the Acorn FPEmulator module. I found two public
releases of this as a binary module for 2.1 and 2.2 kernels.[1] If there
is a resurgence of interest in this, the symbols can always be exported
again.

The real purpose here is to remove the EXPORT_SYMBOL_ALIAS() hack.
EXPORT_SYMBOL_ALIAS() makes it harder to sort the resulting kernel
symbol tables.  Sorted symbol tables will allow for faster symbol
resolution during module loading.


Note that fp_send_sigs() and fp_printk() are simply aliases for existing
exports and add no obvious value.  Similarly fp_enter could easily be
renamed to kern_fp_enter at the point of definition.  So removing
EXPORT_SYMBOL_ALIAS() would not serve as a material obstacle to
re-adding these exports in future.

Build tested only.

[1] http://ftp.arm.linux.org.uk/pub/linux/arm/fpemulator/

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 arch/arm/kernel/armksyms.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 0e62770..8214bfe 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -48,27 +48,7 @@ extern void __aeabi_uidivmod(void);
 extern void __aeabi_ulcmp(void);
 
 extern void fpundefinstr(void);
-extern void fp_enter(void);
 
-/*
- * This has a special calling convention; it doesn't
- * modify any of the usual registers, except for LR.
- */
-#define EXPORT_CRC_ALIAS(sym) __CRC_SYMBOL(sym, "")
-
-#define EXPORT_SYMBOL_ALIAS(sym,orig)		\
- EXPORT_CRC_ALIAS(sym)				\
- static const struct kernel_symbol __ksymtab_##sym	\
-  __used __attribute__((section("__ksymtab"))) =	\
-    { (unsigned long)&orig, #sym };
-
-/*
- * floating point math emulator support.
- * These symbols will never change their calling convention...
- */
-EXPORT_SYMBOL_ALIAS(kern_fp_enter,fp_enter);
-EXPORT_SYMBOL_ALIAS(fp_printk,printk);
-EXPORT_SYMBOL_ALIAS(fp_send_sig,send_sig);
 
 EXPORT_SYMBOL(__backtrace);
 
-- 
1.6.3.2
