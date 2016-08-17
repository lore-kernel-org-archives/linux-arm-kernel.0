From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 17 Aug 2016 17:17:14 +0100
Subject: [PATCH] ARM: mm: pull asm/memory.h explicitly
Message-ID: <1471450634-45566-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d78114554939a (""ARM: 8512/1: proc-v7.S: Adjust stack address when
XIP_KERNEL"") introduced a macro which lives under asm/memory.h.
Unfortunately, for MMU-less systems (like R-class) it leads to build failure:

arch/arm/mm/proc-v7.S: Assembler messages:
arch/arm/mm/proc-v7.S:538: Error: unrecognised relocation suffix
make[1]: *** [arch/arm/mm/proc-v7.o] Error 1
make: *** [arch/arm/mm] Error 2

since it is implicitly pulled via asm/pgtable.h for MMU capable systems only.

To fix it include asm/memory.h explicitly.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/proc-v7.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index d0b116c..8cb105b 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -16,6 +16,7 @@
 #include <asm/hwcap.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
+#include <asm/memory.h>
 
 #include "proc-macros.S"
 
-- 
1.7.9.5
