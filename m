From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 26 Dec 2016 02:31:08 -0800
Subject: [PATCH] arm64: Do not include linux/uaccess.h from assembler files
Message-ID: <1482748268-10399-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Including linux/uaccess.h from assembler files in arm64 builds results
in the following build errors.

In file included from arm64/include/asm/asm-offsets.h:1:0,
                 from arch/arm64/include/asm/assembler.h:26,
		 from arch/arm64/include/asm/alternative.h:68,
		 from arch/arm64/kernel/entry.S

include/linux/sched/prio.h: Assembler messages:
include/linux/sched/prio.h:47: Error:
	unknown mnemonic `static' --
		`static inline long nice_to_rlimit(long nice)'
build/include/linux/sched/prio.h:48: Error:
	junk at end of line, first unrecognized character is `{'

[and many more]

If asm/uaccess.h is not included, many of the affected files fail to build
with errors such as the following.

arch/arm64/lib/copy_to_user.S: Assembler messages:
arch/arm64/lib/copy_to_user.S:66: Error:
	unknown mnemonic `uaccess_enable_not_uao' --
		`uaccess_enable_not_uao x3,x4'
arch/arm64/lib/copy_template.S:71: Error:
	unknown mnemonic `uao_user_alternative' --
		`uao_user_alternative 9998f,strb,st trb,tmp1w,dst,#1'

Either drop the include if unnecessary or, if needed, replace with
asm/uaccess.h.

Fixes: 7c0f6ba682b9 ("Replace <asm/uaccess.h> with <linux/uaccess.h> globally")
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/kernel/entry.S       | 1 -
 arch/arm64/lib/clear_user.S     | 2 +-
 arch/arm64/lib/copy_from_user.S | 2 +-
 arch/arm64/lib/copy_in_user.S   | 2 +-
 arch/arm64/lib/copy_to_user.S   | 2 +-
 arch/arm64/mm/cache.S           | 2 +-
 arch/arm64/xen/hypercall.S      | 2 +-
 7 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a7504f40d7ee..fb93f8c25ff0 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -31,7 +31,6 @@
 #include <asm/memory.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
-#include <linux/uaccess.h>
 #include <asm/unistd.h>
 
 /*
diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index add4a1334085..d7150e30438a 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -17,7 +17,7 @@
  */
 #include <linux/linkage.h>
 
-#include <linux/uaccess.h>
+#include <asm/uaccess.h>
 
 	.text
 
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index fd6cd05593f9..cfe13396085b 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -17,7 +17,7 @@
 #include <linux/linkage.h>
 
 #include <asm/cache.h>
-#include <linux/uaccess.h>
+#include <asm/uaccess.h>
 
 /*
  * Copy from user space to a kernel buffer (alignment handled by the hardware)
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index d828540ded6f..718b1c4e2f85 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -19,7 +19,7 @@
 #include <linux/linkage.h>
 
 #include <asm/cache.h>
-#include <linux/uaccess.h>
+#include <asm/uaccess.h>
 
 /*
  * Copy from user space to user space (alignment handled by the hardware)
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 3e6ae2663b82..e99e31c9acac 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -17,7 +17,7 @@
 #include <linux/linkage.h>
 
 #include <asm/cache.h>
-#include <linux/uaccess.h>
+#include <asm/uaccess.h>
 
 /*
  * Copy to user space from a kernel buffer (alignment handled by the hardware)
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 17f422a4dc55..da9576932322 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -23,7 +23,7 @@
 #include <asm/assembler.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative.h>
-#include <linux/uaccess.h>
+#include <asm/uaccess.h>
 
 /*
  *	flush_icache_range(start,end)
diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
index 47cf3f9d89ff..b41aff25426d 100644
--- a/arch/arm64/xen/hypercall.S
+++ b/arch/arm64/xen/hypercall.S
@@ -49,7 +49,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <linux/uaccess.h>
+#include <asm/uaccess.h>
 #include <xen/interface/xen.h>
 
 
-- 
2.7.4
