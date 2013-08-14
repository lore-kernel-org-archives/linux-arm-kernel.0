From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 14 Aug 2013 17:42:43 +0100
Subject: [PATCH 3/3] ARM: kdgb: use <asm/opcodes.h> for data to be assembled
 as intruction
In-Reply-To: <1376498563-8146-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1376498563-8146-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1376498563-8146-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch_kgdb_breakpoint() function uses an inline assembly directive
to assemble a specific instruction using .word. This means the linker
will not treat is as an instruction, and therefore incorrectly swap
the endian-ness if running BE8.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
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
