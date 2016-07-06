From: jbaron@akamai.com (Jason Baron)
Date: Wed,  6 Jul 2016 17:42:34 -0400
Subject: [PATCH v3 5/7] arm: jump label may reference text in __exit
In-Reply-To: <cover.1467837322.git.jbaron@akamai.com>
References: <cover.1467837322.git.jbaron@akamai.com>
Message-ID: <60284113bb759121e8ae3e99af1535647e52123f.1467837322.git.jbaron@akamai.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The jump table can reference text found in an __exit section. Thus,
instead of discarding it at build time, include EXIT_TEXT as part
of __init and it will be released when the system boots.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux at armlinux.org.uk
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 arch/arm/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index e2c6da096cef..d4be685bc1eb 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -44,7 +44,7 @@
 #endif
 
 #if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
-	defined(CONFIG_GENERIC_BUG)
+	defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL)
 #define ARM_EXIT_KEEP(x)	x
 #define ARM_EXIT_DISCARD(x)
 #else
-- 
2.6.1
