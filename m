From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:10:54 +0100
Subject: [PATCH 18/20] ARM: kdgb: use <asm/opcodes.h> for data to be assembled
 as intruction
In-Reply-To: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377889856-9447-19-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch_kgdb_breakpoint() function uses an inline assembly directive
to assemble a specific instruction using .word. This means the linker
will not treat is as an instruction, and therefore incorrectly swap
the endian-ness if running BE8.

As noted, this code means that kgdb is really only usable on arm32
kernels, and should be made dependant on not being a thumb2 kernel
until fixed. However this is not something to be added to this patch.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/include/asm/kgdb.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
index 48066ce..0a9d5dd 100644
--- a/arch/arm/include/asm/kgdb.h
+++ b/arch/arm/include/asm/kgdb.h
@@ -11,6 +11,7 @@
 #define __ARM_KGDB_H__
 
 #include <linux/ptrace.h>
+#include <asm/opcodes.h>
 
 /*
  * GDB assumes that we're a user process being debugged, so
@@ -41,7 +42,7 @@
 
 static inline void arch_kgdb_breakpoint(void)
 {
-	asm(".word 0xe7ffdeff");
+	asm(__inst_arm(0xe7ffdeff));
 }
 
 extern void kgdb_handle_bus_error(void);
-- 
1.7.10.4
