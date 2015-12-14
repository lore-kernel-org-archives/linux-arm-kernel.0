From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 14 Dec 2015 16:07:24 +0000
Subject: [PATCH] arm64: Add missing linux/bug.h include in asm/pgtable.h
Message-ID: <1450109244-20122-1-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linux 4.4-rc5 doesn't build for arm64 with CONFIG_XEN=y enabled:

In file included from linux/arch/arm64/include/asm/pgtable.h:60:0,
                 from linux/arch/arm64/include/../../arm/include/asm/xen/page.h:5,
                 from linux/arch/arm64/include/asm/xen/page.h:1,
                 from linux/include/xen/page.h:28,
                 from linux/arch/arm64/xen/../../arm/xen/grant-table.c:33:
linux/arch/arm64/include/asm/pgtable.h: In function 'set_pte_at':
linux/include/linux/mmdebug.h:49:39: error: implicit declaration of function 'BUILD_BUG_ON_INVALID' [-Werror=implicit-function-declaration]
 #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
                                       ^
linux/arch/arm64/include/asm/pgtable.h:281:3: note: in expansion of macro 'VM_WARN_ONCE'
   VM_WARN_ONCE(!pte_young(pte),
   ^

This has been introduced by commit 82d340081b6f71237373d1452e3573a5a122794c
"arm64: Improve error reporting on set_pte_at() checks". This is because
mmdebug.h relies on the includer to properly include the dependencies.

Signed-off-by: Julien Grall <julien.grall@citrix.com>

---
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>

    I was tempted to add the missing include in linux/mmdebug.h but I'm
    not sure about the policy for headers inclusion in Linux.

    Also, I'm not sure why the compiler error only happen with CONFIG_XEN=y.
---
 arch/arm64/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 63f52b5..0dd96f3 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -57,6 +57,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bug.h>
 #include <linux/mmdebug.h>
 
 extern void __pte_error(const char *file, int line, unsigned long val);
-- 
2.1.4
