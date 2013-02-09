From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sat,  9 Feb 2013 23:15:09 +0000
Subject: [PATCH 2/2] ARM: mm: mm->context.id fix for big-endian
In-Reply-To: <1360451709-19740-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360451709-19740-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360451709-19740-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the new ASID code introduced in b5466f8728527a05a493cc4abe9e6f034a1bbaab
uses 64bit operations, when running in BE mode we see the values in
mm->context.id swapped around as the lowest word is being stored in
mm->context.id + 4, instead of + 0.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mm/proc-macros.S |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index eb6aa73..5a6a347 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -40,7 +40,11 @@
  * mmid - get context id from mm pointer (mm->context.id)
  */
 	.macro	mmid, rd, rn
+#ifdef __ARMEB__
+	ldr	\rd, [\rn, #MM_CONTEXT_ID + 4 ]
+#else
 	ldr	\rd, [\rn, #MM_CONTEXT_ID]
+#endif
 	.endm
 
 /*
-- 
1.7.10.4
