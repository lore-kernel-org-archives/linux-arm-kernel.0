From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 3 Nov 2015 17:52:53 +0000
Subject: v7-M: Fixing XIP when the kernel is in ROM
In-Reply-To: <20151028074304.GN4931@pengutronix.de>
References: <20151026080537.GW4931@pengutronix.de>
 <CAAEAJfB0yywtQ2MrYf2ih5+a3fZJXAy0hFSXWA038wQMQswa7g@mail.gmail.com>
 <CAAEAJfD29_PSTw+srx7d2YrF+Akx-_94Wv9ifKzT+8HTfH5tGA@mail.gmail.com>
 <562FA053.6010208@st.com>
 <CALszF6C4B-S-o3E1OHK3+bKpDQ8a64Ly-ABNQwfSfj95y7qFyA@mail.gmail.com>
 <85aea33b93066d0959d98b56f8787ba3@agner.ch>
 <CALszF6Di3LWLu_W67Zdn2LyKKRF_5U241eKFKMmJ-0s+0boFag@mail.gmail.com>
 <CAAEAJfCL8veLOi9zi8kARL2kBcYQfxwKS13-mkGbQ_U6Ojg9LA@mail.gmail.com>
 <CALszF6Aodf0nXwsrE+Rtrg6UQw-1OMGY+BdadtK-dtHYv-Bqnw@mail.gmail.com>
 <CAAEAJfCfYo+J32PuW8k2p1S5eFxeCL6qTPeTLCGrNQrA0yC1kQ@mail.gmail.com>
 <20151028074304.GN4931@pengutronix.de>
Message-ID: <HK2PR06MB0561D4F2B8C36A2A1427EE5A8A2B0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So the right fix is to move __v7m_setup_stack to .data I guess.


Since my set of patches went nowhere, last week we had a look at doing just that (using a pre-allocated stack in .data instead of hard coding to the top of PLAT_PHYS_OFFSET).

Here's the code we came up with. Seems to work on XIP and non-XIP builds as well as SMP and non-SMP.


Maybe you can try this technique to allocate the temporary stack in the data section.


(and if your patch gets in...then maybe I'll try submitting again...)


-Chris




arch/arm/mm/proc-v7.S |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mm/proc-v7.S
+++ work/arch/arm/mm/proc-v7.S	2015-10-28 15:44:48.980513000 +0900
@@ -274,7 +274,15 @@ __v7_ca15mp_setup:
 __v7_b15mp_setup:
 __v7_ca17mp_setup:
 	mov	r10, #0
-1:	adr	r12, __v7_setup_stack		@ the local stack
+1:	adr	r11, __v7_setup_stack_ptr	@ pointer to local stack
+	ldmia	r11, {r0, r12}
+#ifdef CONFIG_XIP_KERNEL
+	ldr	r11, =PLAT_PHYS_OFFSET		@ fixed address
+#else
+	sub	r11, r11, r0			@ position independent offset
+#endif	
+	add	r12, r12, r11			@ phys address
+	sub	r12, #PAGE_OFFSET
 	stmia	r12, {r0-r5, lr}		@ v7_invalidate_l1 touches r0-r6
 	bl      v7_invalidate_l1
 	ldmia	r12, {r0-r5, lr}
@@ -415,7 +423,15 @@ __v7_pj4b_setup:
 #endif /* CONFIG_CPU_PJ4B */
 
 __v7_setup:
-	adr	r12, __v7_setup_stack		@ the local stack
+	adr	r11, __v7_setup_stack_ptr	@ pointer to local stack
+	ldmia	r11, {r0, r12}
+#ifdef CONFIG_XIP_KERNEL
+	ldr	r11, =PLAT_PHYS_OFFSET		@ fixed address
+#else
+	sub	r11, r11, r0			@ position independent offset
+#endif	
+	add	r12, r12, r11			@ phys address
+	sub	r12, #PAGE_OFFSET
 	stmia	r12, {r0-r5, lr}		@ v7_invalidate_l1 touches r0-r6
 	bl      v7_invalidate_l1
 	ldmia	r12, {r0-r5, lr}
@@ -482,6 +498,11 @@ __errata_finish:
 	ret	lr				@ return to head.S:__ret
 ENDPROC(__v7_setup)
 
+__v7_setup_stack_ptr:
+	.long	.
+	.long	__v7_setup_stack
+
+	.data
 	.align	2
 __v7_setup_stack:
 	.space	4 * 7				@ 12 registers
