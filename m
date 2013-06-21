From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Jun 2013 19:48:19 -0400
Subject: [PATCH 5/8] ARM: mm: Add __pv_stub_mov to patch MOV instruction
In-Reply-To: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
References: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1371858502-10083-6-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sricharan R <r.sricharan@ti.com>

Patch adds stub for MOV instruction. This is preparatory patch to
add the subsequent 64 bit patching which will use MOV stub.

For review simplicity the patch is kept as a separate change

Signed-off-by: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/memory.h |   10 ++++++++++
 arch/arm/kernel/head.S        |    2 ++
 arch/arm/kernel/vmlinux.lds.S |    5 +++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 3d4f79c..d8a3ea6 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -172,6 +172,7 @@
  * so that all we need to do is modify the 8-bit constant field.
  */
 #define __PV_BITS_31_24	0x81000000
+#define __PV_BITS_7_0	0x81
 
 extern phys_addr_t (*arch_virt_to_idmap) (unsigned long x);
 extern unsigned long __pv_phys_offset;
@@ -188,6 +189,15 @@ extern unsigned long __pv_offset;
 	: "=r" (to)					\
 	: "r" (from), "I" (type))
 
+#define __pv_stub_mov(to, instr, type)			\
+	__asm__ volatile("@ __pv_stub_mov\n"		\
+	"1:	" instr "	%R0, %1\n"		\
+	"	.pushsection .pv_high_table,\"a\"\n"	\
+	"	.long	1b\n"				\
+	"	.popsection\n"				\
+	: "=r" (to)					\
+	: "I" (type))
+
 static inline phys_addr_t __virt_to_phys(unsigned long x)
 {
 	unsigned long t;
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 764e83b..b1bdeb5 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -565,6 +565,8 @@ ENDPROC(__fixup_pv_table)
 	.long	__pv_table_begin
 	.long	__pv_table_end
 2:	.long	__pv_phys_offset
+3:	.long	__pv_high_table_begin
+	.long	__pv_high_table_end
 
 	.text
 __fixup_a_pv_table:
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index a871b8e..cf17c7b 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -182,6 +182,11 @@ SECTIONS
 		*(.pv_table)
 		__pv_table_end = .;
 	}
+	.init.pv_high_table : {
+		__pv_high_table_begin = .;
+		*(.pv_high_table)
+		__pv_high_table_end = .;
+	}
 	.init.data : {
 #ifndef CONFIG_XIP_KERNEL
 		INIT_DATA
-- 
1.7.9.5
