From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Aug 2013 08:53:10 +0200
Subject: [PATCH 05/12] ARM: mvebu: Makes ll_set_cpu_coherent() more
 configurable
In-Reply-To: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1377240797-4047-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ll_set_cpu_coherent does two things to set the coherency for a CPU:

- Adding the CPU to the SMP group 0
- Enabling the snooping on the CPU

Only the second part is needed when coming back from a CPU Idle. This
commit allows to choose to do the first part or not.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c    |  4 ++--
 arch/arm/mach-mvebu/coherency_ll.S | 30 ++++++++++++++++++------------
 arch/arm/mach-mvebu/headsmp.S      |  3 +++
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index a2b6366..2f934f1 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -43,7 +43,7 @@ static struct of_device_id of_coherency_table[] = {
 };
 
 /* Function defined in coherency_ll.S */
-int ll_set_cpu_coherent(bool use_virt_addr);
+int ll_set_cpu_coherent(bool use_virt_addr, bool use_smp_group);
 
 int set_cpu_coherent(void)
 {
@@ -53,7 +53,7 @@ int set_cpu_coherent(void)
 		return 1;
 	}
 
-	return ll_set_cpu_coherent(true);
+	return ll_set_cpu_coherent(true, true);
 }
 
 static inline void mvebu_hwcc_sync_io_barrier(void)
diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index fc2e6f7..1526b94 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -22,7 +22,8 @@
 
 	.text
 /*
- * r0: if r0==0 => physical addres, else virtual address
+ * r0: Use virtual address if r0 != 0, else physical address
+ * r1: Add CPU to the SMP group if r1 != 0
  */
 ENTRY(ll_set_cpu_coherent)
 	cmp	r0, #0
@@ -38,26 +39,31 @@ ENTRY(ll_set_cpu_coherent)
 	ldr	r0, [r0]
 2:
 	/* Create bit by cpu index */
-	mrc	15, 0, r1, cr0, cr0, 5
-	and	r1, r1, #15
+	mrc	15, 0, r3, cr0, cr0, 5
+	and	r3, r3, #15
 	mov	r2, #(1 << 24)
-	lsl	r1, r2, r1
+	lsl	r3, r2, r3
+
+	/* If r1=!0 then just enable the snooping */
+	cmp	r1, #0
+	beq	2f
 
 	/* Add CPU to SMP group - Atomic */
-	add	r3, r0, #ARMADA_XP_CFB_CTL_REG_OFFSET
+	add	r1, r0, #ARMADA_XP_CFB_CTL_REG_OFFSET
 1:
-	ldrex	r2, [r3]
-	orr	r2, r2, r1
-	strex 	r0, r2, [r3]
+	ldrex	r2, [r1]
+	orr	r2, r2, r3
+	strex 	r0, r2, [r1]
 	cmp	r0, #0
 	bne 1b
 
+2:
 	/* Enable coherency on CPU - Atomic */
-	add	r3, r3, #ARMADA_XP_CFB_CFG_REG_OFFSET
+	add	r1, r1, #ARMADA_XP_CFB_CFG_REG_OFFSET
 1:
-	ldrex	r2, [r3]
-	orr	r2, r2, r1
-	strex	r0, r2, [r3]
+	ldrex	r2, [r1]
+	orr	r2, r2, r3
+	strex	r0, r2, [r1]
 	cmp	r0, #0
 	bne 1b
 
diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
index b2c6e95..f2732c8 100644
--- a/arch/arm/mach-mvebu/headsmp.S
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -30,6 +30,9 @@ ENTRY(armada_xp_secondary_startup)
 	/* Use physical addrss */
 	mov	r0, #0
 
+	/* Add CPU to the SMP group*/
+	mov	r1, #1
+
 	/* Add CPU to coherency fabric */
 	bl	ll_set_cpu_coherent
 	b	secondary_startup
-- 
1.8.1.2
