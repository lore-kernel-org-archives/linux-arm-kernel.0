From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sun, 10 Feb 2013 14:57:28 +0000
Subject: [PATCH 2/2] ARM: mm: mm->context.id fix for big-endian
In-Reply-To: <1360508248-25252-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360508248-25252-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360508248-25252-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the new ASID code in [b5466f8728527a05a493cc4abe9e6f034a1bbaab]
was changed to use 64bit operations it has broken the BE operation due
to an issue with the MM code accessing sub-fields of mm->context.id.

When running in BE mode we see the values in mm->context.id are stored
with the highest value first, so the LDR in the arch/arm/mm/proc-macros.S
reads the wrong part of this field. To resolve this, change the LDR in
the mmid macro to load from +4.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mm/context.c     |    3 +++
 arch/arm/mm/proc-macros.S |    5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index bc4a5e9..7a05111 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -34,6 +34,9 @@
  * The ASID is used to tag entries in the CPU caches and TLBs.
  * The context ID is used by debuggers and trace logic, and
  * should be unique within all running processes.
+ *
+ * In big endian operation, the two 32 bit words are swapped if accesed by
+ * non 64-bit operations.
  */
 #define ASID_FIRST_VERSION	(1ULL << ASID_BITS)
 #define NUM_USER_ASIDS		(ASID_FIRST_VERSION - 1)
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index eb6aa73..f9a0aa7 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -38,9 +38,14 @@
 
 /*
  * mmid - get context id from mm pointer (mm->context.id)
+ * note, this field is 64bit, so in big-endian the two words are swapped too.
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
