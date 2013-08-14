From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 14 Aug 2013 17:42:41 +0100
Subject: [PATCH 1/3] ARM: Correct BUG() assembly to ensure it is
 endian-agnostic
In-Reply-To: <1376498563-8146-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1376498563-8146-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1376498563-8146-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently BUG() uses .word or .hword to create the necessary illegal
instructions. However if we are building BE8 then these get swapped
by the linker into different illegal instructions in the text.

Change to using .inst and .inst.w to create the instructions and mark
them as instructions so that the linker acts correctly.

Fixes issue reported by Dave Martin <Dave.Martin@arm.com>

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/include/asm/bug.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index 7af5c6c..b95da52 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -12,10 +12,10 @@
  */
 #ifdef CONFIG_THUMB2_KERNEL
 #define BUG_INSTR_VALUE 0xde02
-#define BUG_INSTR_TYPE ".hword "
+#define BUG_INSTR_TYPE ".inst.w "
 #else
 #define BUG_INSTR_VALUE 0xe7f001f2
-#define BUG_INSTR_TYPE ".word "
+#define BUG_INSTR_TYPE ".inst "
 #endif
 
 
-- 
1.7.10.4
