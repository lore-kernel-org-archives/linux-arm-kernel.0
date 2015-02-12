From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 12 Feb 2015 18:45:52 +0100
Subject: [PATCH 02/14] ARM: ARMv7M: Enlarge vector table to 256 entries
In-Reply-To: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1423763164-5606-3-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From Cortex-M4 and M7 reference manuals, the nvic supports up to 240
interrupts. So the number of entries in vectors table is 256.

This patch adds the missing entries, and change the alignement, so that
vector_table remains naturally aligned.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/kernel/entry-v7m.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 8944f49..29a461b 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -117,9 +117,9 @@ ENTRY(__switch_to)
 ENDPROC(__switch_to)
 
 	.data
-	.align	8
+	.align	10
 /*
- * Vector table (64 words => 256 bytes natural alignment)
+ * Vector table (256 words => 1024 bytes alignment)
  */
 ENTRY(vector_table)
 	.long	0			@ 0 - Reset stack pointer
@@ -138,6 +138,6 @@ ENTRY(vector_table)
 	.long	__invalid_entry		@ 13 - Reserved
 	.long	__pendsv_entry		@ 14 - PendSV
 	.long	__invalid_entry		@ 15 - SysTick
-	.rept	64 - 16
-	.long	__irq_entry		@ 16..64 - External Interrupts
+	.rept	256 - 16
+	.long	__irq_entry		@ 16..256 - External Interrupts
 	.endr
-- 
1.9.1
