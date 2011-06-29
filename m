From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:25:56 +0100
Subject: [PATCH 21/23] ARM: entry: data abort: always use r6 for offset
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbr1w-0002Ga-8w@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/abort-lv4t.S  |    6 +++---
 arch/arm/mm/proc-arm6_7.S |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/abort-lv4t.S b/arch/arm/mm/abort-lv4t.S
index 921aaab..54b6d27 100644
--- a/arch/arm/mm/abort-lv4t.S
+++ b/arch/arm/mm/abort-lv4t.S
@@ -102,13 +102,13 @@ ENTRY(v4t_late_abort)
 	tst	r8, #1 << 21			@ check writeback bit
 	beq	do_DataAbort			@ no writeback -> no fixup
 .data_arm_lateldrpostconst:
-	movs	r9, r8, lsl #20			@ Get offset
+	movs	r6, r8, lsl #20			@ Get offset
 	beq	do_DataAbort			@ zero -> no fixup
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
 	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
-	subne	r7, r7, r9, lsr #20		@ Undo increment
-	addeq	r7, r7, r9, lsr #20		@ Undo decrement
+	subne	r7, r7, r6, lsr #20		@ Undo increment
+	addeq	r7, r7, r6, lsr #20		@ Undo decrement
 	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
index 141906e..4d96311 100644
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -116,13 +116,13 @@ ENTRY(cpu_arm6_data_abort)
 	tst	r8, #1 << 21			@ check writeback bit
 	beq	do_DataAbort			@ no writeback -> no fixup
 .data_arm_lateldrpostconst:
-	movs	r9, r8, lsl #20			@ Get offset
+	movs	r6, r8, lsl #20			@ Get offset
 	beq	do_DataAbort			@ zero -> no fixup
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
 	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
-	subne	r7, r7, r9, lsr #20		@ Undo increment
-	addeq	r7, r7, r9, lsr #20		@ Undo decrement
+	subne	r7, r7, r6, lsr #20		@ Undo increment
+	addeq	r7, r7, r6, lsr #20		@ Undo decrement
 	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
-- 
1.7.4.4
