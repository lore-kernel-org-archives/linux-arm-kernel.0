From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 14 Apr 2014 17:10:09 +0200
Subject: [PATCH v7 06/11] ARM: mvebu: Low level function to disable HW
 coherency support
In-Reply-To: <1397488214-20685-1-git-send-email-gregory.clement@free-electrons.com>
References: <1397488214-20685-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1397488214-20685-7-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When going to deep idle we need to disable the SoC snooping (aka
hardware coherency support). Playing with the coherency fabric
requires to use assembly code to be sure that the compiler doesn't
reorder the instructions nor do wrong optimization.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency_ll.S | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index f2e2e8677c4b..6828f9f157b0 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -102,6 +102,26 @@ ENTRY(ll_enable_coherency)
 	mov	pc, lr
 ENDPROC(ll_enable_coherency)
 
+ENTRY(ll_disable_coherency)
+	/*
+	 * r0 being untouched in ll_get_coherency_base and
+	 * ll_get_cpuid, we can use it to save lr modifing it with the
+	 * following bl
+	 */
+	mov r0, lr
+	bl	ll_get_coherency_base
+	bl	ll_get_cpuid
+	mov lr, r0
+	add	r0, r1, #ARMADA_XP_CFB_CTL_REG_OFFSET
+1:
+	ldrex	r2, [r0]
+	bic	r2, r2, r3
+	strex	r1, r2, [r0]
+	cmp	r1, #0
+	bne	1b
+	dsb
+	mov	pc, lr
+ENDPROC(ll_disable_coherency)
 
 	.align 2
 3:
-- 
1.8.1.2
