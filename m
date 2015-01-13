From: zlim@broadcom.com (Zi Shen Lim)
Date: Mon, 12 Jan 2015 18:15:04 -0800
Subject: [PATCH boot-wrapper-aarch64 4/4] psci: implement PSCI v0.2
In-Reply-To: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
References: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
Message-ID: <1421115304-19580-5-git-send-email-zlim@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this simple implementation:
* cpu_suspend is not supported, and as such is not fully
  compliant with the spec.
* The system_{off,reset} functions currently just spin on
  one CPU, when it should instead power {down,cycle}
  the system.

Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
---
 Makefile.am |   4 +-
 psci.S      | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 138 insertions(+), 24 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 4f5bfdd..471462a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -23,10 +23,8 @@ BOOTLOADER	:= boot.S
 if PSCI
 BOOTMETHOD	:= psci.o
 PSCI_NODE	:= psci {				\
-			compatible = \"arm,psci\";	\
+			compatible = \"arm,psci-0.2\";	\
 			method = \"smc\";		\
-			cpu_on = <0xc4000003>;		\
-			cpu_off = <0x84000002>;		\
 		   };
 CPU_NODES	:= $(shell $(top_srcdir)/gen-cpu-nodes.sh $(CPU_IDS))
 CPUS_NODE	:= cpus {		\
diff --git a/psci.S b/psci.S
index c51e125..b8afb0e 100644
--- a/psci.S
+++ b/psci.S
@@ -8,13 +8,26 @@
  */
 #include "common.S"
 
-#define PSCI_CPU_OFF		0x84000002
-#define PSCI_CPU_ON		0xc4000003
-
-#define PSCI_RET_SUCCESS	0
-#define PSCI_RET_NOT_IMPL	(-1)
-#define PSCI_RET_INVALID	(-2)
-#define PSCI_RET_DENIED		(-3)
+#define PSCI_VERSION			0x84000000
+#define PSCI_CPU_SUSPEND		0xc4000001
+#define PSCI_CPU_OFF			0x84000002
+#define PSCI_CPU_ON			0xc4000003
+#define PSCI_AFFINITY_INFO		0xc4000004
+#define PSCI_MIGRATE			0xc4000005
+#define PSCI_MIGRATE_INFO_TYPE		0x84000006
+#define PSCI_MIGRATE_INFO_UP_CPU	0xc4000007
+#define PSCI_SYSTEM_OFF			0x84000008
+#define PSCI_SYSTEM_RESET		0x84000009
+
+#define PSCI_RET_SUCCESS		0
+#define PSCI_RET_NOT_SUPPORTED		(-1)
+#define PSCI_RET_INVALID_PARAMETERS	(-2)
+#define PSCI_RET_DENIED			(-3)
+#define PSCI_RET_ALREADY_ON		(-4)
+#define PSCI_RET_ON_PENDING		(-5)
+#define PSCI_RET_INTERNAL_FAILURE	(-6)
+#define PSCI_RET_NOT_PRESENT		(-7)
+#define PSCI_RET_DISABLED		(-8)
 
 #ifndef CPU_IDS
 #error No CPU MPIDRs provided.
@@ -77,6 +90,16 @@ branch_table:
 	.quad ADDR_INVALID
 	.endr
 
+#define AFFINFO_ON		0
+#define AFFINFO_OFF		1
+#define AFFINFO_ON_PENDING	2
+#define AFFINFO_DISABLED	PSCI_RET_DISABLED
+
+affinfo_table:
+	.rept (nr_cpus)
+	.quad AFFINFO_DISABLED
+	.endr
+
 	.text
 
 	.globl start_no_el3
@@ -86,10 +109,18 @@ err_exception:
 	b err_exception
 
 psci_call32:
-	mov	w0, PSCI_RET_NOT_IMPL
+	mov	w0, PSCI_RET_NOT_SUPPORTED
 	eret
 
 psci_call64:
+	ldr	x7, =PSCI_VERSION
+	cmp	x0, x7
+	b.eq	psci_version
+
+	ldr	x7, =PSCI_CPU_SUSPEND
+	cmp	x0, x7
+	b.eq	psci_not_supported	// XXX: not spec compliant
+
 	ldr	x7, =PSCI_CPU_OFF
 	cmp	x0, x7
 	b.eq	psci_cpu_off
@@ -98,7 +129,36 @@ psci_call64:
 	cmp	x0, x7
 	b.eq	psci_cpu_on
 
-	mov	x0, PSCI_RET_NOT_IMPL
+	ldr	x7, =PSCI_AFFINITY_INFO
+	cmp	x0, x7
+	b.eq	psci_affinity_info
+
+	ldr	x7, =PSCI_MIGRATE
+	cmp	x0, x7
+	b.eq	psci_not_supported
+
+	ldr	x7, =PSCI_MIGRATE_INFO_TYPE
+	cmp	x0, x7
+	b.eq	psci_migrate_info_type
+
+	ldr	x7, =PSCI_MIGRATE_INFO_UP_CPU
+	cmp	x0, x7
+	b.eq	psci_not_supported
+
+	ldr	x7, =PSCI_SYSTEM_OFF
+	cmp	x0, x7
+	b.eq	psci_system_off
+
+	ldr	x7, =PSCI_SYSTEM_RESET
+	cmp	x0, x7
+	b.eq	psci_system_reset
+
+psci_not_supported:
+	mov	x0, PSCI_RET_NOT_SUPPORTED
+	eret
+
+psci_version:
+	mov	x0, #((0 << 16) | (2 << 0))
 	eret
 
 /*
@@ -109,6 +169,11 @@ psci_cpu_off:
 	ldr	x1, =MPIDR_ID_BITS
 	and	x0, x0, x1
 	bl	find_logical_id
+
+	adr	x1, affinfo_table
+	mov	x2, #AFFINFO_OFF
+	str	x2, [x1, x0, lsl #3]
+
 	adr	x1, branch_table
 	mov	x2, #ADDR_INVALID
 	str	x2, [x1, x0, lsl #3]
@@ -118,39 +183,85 @@ psci_cpu_off:
 /*
  * x1 - target cpu
  * x2 - address
+ * x3 - context id (Note: currently ignored)
  */
 psci_cpu_on:
-	mov	x15, x30
 	mov	x14, x2
-	mov	x0, x1
 
+	mov	x0, x1
+	mov	x15, x30
 	bl	find_logical_id
+	mov	x30, x15
 	cmp	x0, #MPIDR_INVALID
 	b.eq	1f
 
+	adr	x1, affinfo_table
+	ldr	x2, [x1, x0, lsl #3]
+	cmp	x2, #AFFINFO_ON
+	b.eq	2f
+	cmp	x2, #AFFINFO_ON_PENDING
+	b.eq	3f
+	cmp	x2, #AFFINFO_DISABLED
+	b.eq	1f
+
+	mov	x2, #AFFINFO_ON_PENDING
+	str	x2, [x1, x0, lsl #3]
+
 	adr	x3, branch_table
 	add	x3, x3, x0, lsl #3
 
-	ldr	x4, =ADDR_INVALID
-
 	ldxr	x5, [x3]
-	cmp	x4, x5
-	b.ne	1f
+	cmp	x5, #ADDR_INVALID
+	b.ne	2f
 
 	stxr	w4, x14, [x3]
-	cbnz	w4, 1f
+	cbnz	w4, 2f
 
 	dsb	ishst
 	sev
 
 	mov	x0, #PSCI_RET_SUCCESS
-	mov	x30, x15
 	eret
 
-1:	mov	x0, #PSCI_RET_DENIED
+1:	mov	x0, #PSCI_RET_INVALID_PARAMETERS
+	eret
+
+2:	mov	x0, #PSCI_RET_ALREADY_ON
+	eret
+
+3:	mov	x0, #PSCI_RET_ON_PENDING
+	eret
+
+/*
+ * x1 - target affinity (same as target cpu)
+ * x2 - lowest affinity level (Note: only 0 is supported)
+ */
+psci_affinity_info:
+	cbnz	x2, 1f
+
+	mov	x0, x1
+	mov	x15, x30
+	bl	find_logical_id
 	mov	x30, x15
+	cmp	x0, #MPIDR_INVALID
+	b.eq	1f
+
+	adr	x3, affinfo_table
+	ldr	x0, [x3, x0, lsl #3]
 	eret
 
+1:	mov	x0, #PSCI_RET_INVALID_PARAMETERS
+	eret
+
+psci_migrate_info_type:
+	mov	x0, #2	// Trusted OS not present, doesn't require migration.
+	eret
+
+psci_system_off:
+	b	spin_dead	// XXX: need to power down system
+
+psci_system_reset:
+	b	spin_dead	// XXX: need to power cycle system
 
 /*
  * Takes masked MPIDR in x0, returns logical id in x0
@@ -208,16 +319,21 @@ spin:
 	cmp	x0, #MPIDR_INVALID
 	b.eq	spin_dead
 
-	adr	x1, branch_table
-	mov	x3, #ADDR_INVALID
+	adr	x15, affinfo_table
+	mov	x14, #AFFINFO_OFF
+	str	x14, [x15, x0, lsl #3]
 
+	adr	x1, branch_table
 	add	x1, x1, x0, lsl #3
 
 1:	wfe
 	ldr	x2, [x1]
-	cmp	x2, x3
+	cmp	x2, #ADDR_INVALID
 	b.eq	1b
 
+	mov	x14, #AFFINFO_ON
+	str	x14, [x15, x0, lsl #3]
+
 	ldr	x0, =SCTLR_EL2_RESET
 	msr	sctlr_el2, x0
 
-- 
2.1.0
