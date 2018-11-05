From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Nov 2018 13:06:46 +0000
Subject: [PATCH 07/10] arm64: uaccess: use asm EXPORT_SYMBOL()
In-Reply-To: <20181105130649.29429-1-mark.rutland@arm.com>
References: <20181105130649.29429-1-mark.rutland@arm.com>
Message-ID: <20181105130649.29429-8-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a while now it's been possible to use EXPORT_SYMBOL() in assembly
files, which allows us to place exports immediately after assembly
functions, as we do for C functions.

As a step towards removing arm64ksyms.c, let's move the uaccess exports
to the assembly files the functions are defined in.  As we have to
include <asm/export.h>, the existing includes are fixed to follow the
usual ordering conventions.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c  | 7 -------
 arch/arm64/lib/clear_user.S     | 2 ++
 arch/arm64/lib/copy_from_user.S | 4 +++-
 arch/arm64/lib/copy_in_user.S   | 4 +++-
 arch/arm64/lib/copy_to_user.S   | 4 +++-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 784b257d9643..02019667e319 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -24,18 +24,11 @@
 #include <linux/delay.h>
 #include <linux/in6.h>
 #include <linux/syscalls.h>
-#include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/kprobes.h>
 
 #include <asm/checksum.h>
 
-	/* user mem (segment) */
-EXPORT_SYMBOL(__arch_copy_from_user);
-EXPORT_SYMBOL(__arch_copy_to_user);
-EXPORT_SYMBOL(__arch_clear_user);
-EXPORT_SYMBOL(__arch_copy_in_user);
-
 	/* string / mem functions */
 #ifndef CONFIG_KASAN
 EXPORT_SYMBOL(strchr);
diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index 21ba0b29621b..81a572dec379 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -18,6 +18,7 @@
 #include <linux/linkage.h>
 
 #include <asm/asm-uaccess.h>
+#include <asm/export.h>
 
 	.text
 
@@ -53,6 +54,7 @@ uao_user_alternative 9f, strb, sttrb, wzr, x0, 0
 	uaccess_disable_not_uao x2, x3
 	ret
 ENDPROC(__arch_clear_user)
+EXPORT_SYMBOL(__arch_clear_user)
 
 	.section .fixup,"ax"
 	.align	2
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 20305d485046..d7a0a1deef5d 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -16,8 +16,9 @@
 
 #include <linux/linkage.h>
 
-#include <asm/cache.h>
 #include <asm/asm-uaccess.h>
+#include <asm/cache.h>
+#include <asm/export.h>
 
 /*
  * Copy from user space to a kernel buffer (alignment handled by the hardware)
@@ -71,6 +72,7 @@ ENTRY(__arch_copy_from_user)
 	mov	x0, #0				// Nothing to copy
 	ret
 ENDPROC(__arch_copy_from_user)
+EXPORT_SYMBOL(__arch_copy_from_user)
 
 	.section .fixup,"ax"
 	.align	2
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 54b75deb1d16..804a65470d13 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -18,8 +18,9 @@
 
 #include <linux/linkage.h>
 
-#include <asm/cache.h>
 #include <asm/asm-uaccess.h>
+#include <asm/cache.h>
+#include <asm/export.h>
 
 /*
  * Copy from user space to user space (alignment handled by the hardware)
@@ -73,6 +74,7 @@ ENTRY(__arch_copy_in_user)
 	mov	x0, #0
 	ret
 ENDPROC(__arch_copy_in_user)
+EXPORT_SYMBOL(__arch_copy_in_user)
 
 	.section .fixup,"ax"
 	.align	2
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index fda6172d6b88..2f42acba6d68 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -16,8 +16,9 @@
 
 #include <linux/linkage.h>
 
-#include <asm/cache.h>
 #include <asm/asm-uaccess.h>
+#include <asm/export.h>
+#include <asm/cache.h>
 
 /*
  * Copy to user space from a kernel buffer (alignment handled by the hardware)
@@ -70,6 +71,7 @@ ENTRY(__arch_copy_to_user)
 	mov	x0, #0
 	ret
 ENDPROC(__arch_copy_to_user)
+EXPORT_SYMBOL(__arch_copy_to_user)
 
 	.section .fixup,"ax"
 	.align	2
-- 
2.11.0
