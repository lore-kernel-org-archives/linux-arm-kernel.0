From: veli-pekka.peltola@bluegiga.com (Veli-Pekka Peltola)
Date: Thu,  1 Mar 2012 21:45:19 +0200
Subject: [PATCH] mm: module_alloc: check if size is 0
Message-ID: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit de7d2b567d040e3b67fe7121945982f14343213d (mm/vmalloc.c: report
more vmalloc failures) users will get a warning if vmalloc_node_range() is
called with size 0. This happens if module's init size equals to 0. This
patch changes ARM, MIPS and x86 module_alloc() to return NULL before calling
vmalloc_node_range() that would also return NULL and print a warning.

Signed-off-by: Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86 at kernel.org
---
I found this with ARM but after checking out various implementations of
module_alloc() I thought it would be better to fix all at once.

One way to replicate the warning:
compile kernel with CONFIG_KALLSYMS=n
insmod module without init, I used usb-common.ko

 arch/arm/kernel/module.c  |    4 ++--
 arch/mips/kernel/module.c |    4 ++--
 arch/x86/kernel/module.c  |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 1e9be5d..d44d212 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -39,8 +39,8 @@
 #ifdef CONFIG_MMU
 void *module_alloc(unsigned long size)
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
+	return size == 0 ? NULL : __vmalloc_node_range(size, 1, MODULES_VADDR,
+				MODULES_END, GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
 				__builtin_return_address(0));
 }
 #endif
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index a5066b1..cd768e9 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -47,8 +47,8 @@ static DEFINE_SPINLOCK(dbe_lock);
 #ifdef MODULE_START
 void *module_alloc(unsigned long size)
 {
-	return __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
-				GFP_KERNEL, PAGE_KERNEL, -1,
+	return size == 0 ? NULL : __vmalloc_node_range(size, 1, MODULE_START,
+				MODULE_END, GFP_KERNEL, PAGE_KERNEL, -1,
 				__builtin_return_address(0));
 }
 #endif
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 925179f..bff6118 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -38,7 +38,7 @@
 
 void *module_alloc(unsigned long size)
 {
-	if (PAGE_ALIGN(size) > MODULES_LEN)
+	if (size == 0 || PAGE_ALIGN(size) > MODULES_LEN)
 		return NULL;
 	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
 				GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL_EXEC,
-- 
1.7.5.4
