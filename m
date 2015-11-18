From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 17 Nov 2015 22:58:40 -0500 (EST)
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <HK2PR06MB056175E6E4356DD8C3566D758A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
 <HK2PR06MB056142FFDA4E99A764DF9ECB8A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161730030.5826@knanqh.ubzr>
 <HK2PR06MB05614D47A9C35ECB4CA72D3F8A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511162127180.5826@knanqh.ubzr>
 <HK2PR06MB056175E6E4356DD8C3566D758A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <alpine.LFD.2.20.1511172255410.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, Chris Brandt wrote:

> I think this one is more of a coding issue.
> These were the attempts to fix the temporary stack issue:
> 
> My first patch:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/357106.html
> 
> Magnus's try:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/383394.html

Here's my proposal:

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index de2b246fed..2d0ac32320 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -274,10 +274,12 @@ __v7_ca15mp_setup:
 __v7_b15mp_setup:
 __v7_ca17mp_setup:
 	mov	r10, #0
-1:	adr	r12, __v7_setup_stack		@ the local stack
-	stmia	r12, {r0-r5, lr}		@ v7_invalidate_l1 touches r0-r6
+1:	adr	r0, __v7_setup_stack_ptr
+	ldr	r12, [r0]
+	add	r12, r12, r0			@ the local stack
+	stmia	r12, {r1-r6, lr}		@ v7_invalidate_l1 touches r0-r6
 	bl      v7_invalidate_l1
-	ldmia	r12, {r0-r5, lr}
+	ldmia	r12, {r1-r6, lr}
 #ifdef CONFIG_SMP
 	ALT_SMP(mrc	p15, 0, r0, c1, c0, 1)
 	ALT_UP(mov	r0, #(1 << 6))		@ fake it for UP
@@ -415,10 +417,12 @@ __v7_pj4b_setup:
 #endif /* CONFIG_CPU_PJ4B */
 
 __v7_setup:
-	adr	r12, __v7_setup_stack		@ the local stack
-	stmia	r12, {r0-r5, lr}		@ v7_invalidate_l1 touches r0-r6
+	adr	r0, __v7_setup_stack_ptr
+	ldr	r12, [r0]
+	add	r12, r12, r0			@ the local stack
+	stmia	r12, {r1-r6, lr}		@ v7_invalidate_l1 touches r0-r6
 	bl      v7_invalidate_l1
-	ldmia	r12, {r0-r5, lr}
+	ldmia	r12, {r1-r6, lr}
 
 __v7_setup_cont:
 	and	r0, r9, #0xff000000		@ ARM?
@@ -480,11 +484,16 @@ __errata_finish:
 	orr	r0, r0, r6			@ set them
  THUMB(	orr	r0, r0, #1 << 30	)	@ Thumb exceptions
 	ret	lr				@ return to head.S:__ret
+
+	.align	2
+__v7_setup_stack_ptr:
+	.word	__v7_setup_stack - .
 ENDPROC(__v7_setup)
 
+	.bss
 	.align	2
 __v7_setup_stack:
-	.space	4 * 7				@ 12 registers
+	.space	4 * 7				@ 7 registers
 
 	__INITDATA
 
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 67d9209077..8cd465927a 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -123,10 +123,12 @@ __v7m_setup:
 	ret	lr
 ENDPROC(__v7m_setup)
 
+	.pushsection .bss
 	.align 2
 __v7m_setup_stack:
 	.space	4 * 8				@ 8 registers
 __v7m_setup_stack_top:
+	.previous
 
 	define_processor_functions v7m, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 
