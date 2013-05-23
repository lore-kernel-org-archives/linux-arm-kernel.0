From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 23 May 2013 10:54:02 +0200
Subject: [PATCH] ARM: mvebu: Fix bug in coherency fabric low level init
 function
In-Reply-To: <1369299242-16506-1-git-send-email-gregory.clement@free-electrons.com>
References: <1369299242-16506-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1369299242-16506-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nadav Haklai <nadavh@marvell.com>

When adding CPU to the SMP group and enabling the coherency on this
CPU we must protect the register access.
The previous implementation claims to be atomic but doesn't provide
any protection against parallel access to the coherency fabric control
and configuration registers.

This patch fixes this by using the ldrex and strex mechanism.
This method should be used in all accesses to those registers.

[gregory.clement at free-electrons.com: fixed the commit's topic]
Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency_ll.S | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index 53e8391..5476669 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -32,15 +32,21 @@ ENTRY(ll_set_cpu_coherent)
 
 	/* Add CPU to SMP group - Atomic */
 	add	r3, r0, #ARMADA_XP_CFB_CTL_REG_OFFSET
-	ldr	r2, [r3]
+1:
+	ldrex	r2, [r3]
 	orr	r2, r2, r1
-	str	r2, [r3]
+	strex 	r0, r2, [r3]
+	cmp	r0, #0
+	bne 1b
 
 	/* Enable coherency on CPU - Atomic */
-	add	r3, r0, #ARMADA_XP_CFB_CFG_REG_OFFSET
-	ldr	r2, [r3]
+	add	r3, r3, #ARMADA_XP_CFB_CFG_REG_OFFSET
+1:
+	ldrex	r2, [r3]
 	orr	r2, r2, r1
-	str	r2, [r3]
+	strex	r0, r2, [r3]
+	cmp	r0, #0
+	bne 1b
 
 	dsb
 
-- 
1.8.1.2
