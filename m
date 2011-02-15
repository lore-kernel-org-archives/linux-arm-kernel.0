From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 11:04:53 +0000
Subject: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <AANLkTinL0HgSsFmoxyiBuRA6JiWKsHTLW4wFnVDJf_1w@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
	<AANLkTinL0HgSsFmoxyiBuRA6JiWKsHTLW4wFnVDJf_1w@mail.gmail.com>
Message-ID: <20110215110453.GB11199@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 06:50:57PM -0800, Colin Cross wrote:
> > +ENDPROC(cpu_resume_turn_mmu_on)
> > +cpu_resume_after_mmu:
> > + ? ? ? str ? ? r5, [r2, r4, lsl #2] ? ?@ restore old mapping
> > +#ifdef MULTI_CACHE
> > + ? ? ? ldr ? ? r10, =cpu_cache
> > + ? ? ? ldr ? ? pc, [r10, #CACHE_FLUSH_KERN_ALL]
> > +#else
> > + ? ? ? b ? ? ? __cpuc_flush_kern_all
> > +#endif

I think we can eliminate this cache flush by delaying the cache enable
as below.  Could you see whether Tegra 2 survives this please?
Thanks.

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index bed1876..193be5f 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -4,6 +4,7 @@
 #include <asm/assembler.h>
 #include <asm/glue-cache.h>
 #include <asm/glue-proc.h>
+#include <asm/system.h>
 	.text
 
 /*
@@ -81,25 +82,22 @@ ENTRY(cpu_resume_mmu)
 	str	r3, [r2, r4, lsl #2]	@ setup 1:1 mapping for mmu code
 	sub	r2, r2, r1
 	ldr	r3, =cpu_resume_after_mmu
+	bic	r1, r0, #CR_C		@ ensure D-cache is disabled
 	b	cpu_resume_turn_mmu_on
 ENDPROC(cpu_resume_mmu)
 	.ltorg
 	.align	5
 cpu_resume_turn_mmu_on:
-	mcr	p15, 0, r0, c1, c0, 0	@ turn on MMU, caches, etc
-	mrc	p15, 0, r0, c0, c0, 0	@ read id reg
-	mov	r0, r0
-	mov	r0, r0
+	mcr	p15, 0, r1, c1, c0, 0	@ turn on MMU, I-cache, etc
+	mrc	p15, 0, r1, c0, c0, 0	@ read id reg
+	mov	r1, r1
+	mov	r1, r1
 	mov	pc, r3			@ jump to virtual address
 ENDPROC(cpu_resume_turn_mmu_on)
 cpu_resume_after_mmu:
 	str	r5, [r2, r4, lsl #2]	@ restore old mapping
-#ifdef MULTI_CACHE
-	ldr	r10, =cpu_cache
-	ldr	pc, [r10, #CACHE_FLUSH_KERN_ALL]
-#else
-	b	__cpuc_flush_kern_all
-#endif
+	mcr	p15, 0, r0, c1, c0, 0	@ turn on D-cache
+	mov	pc, lr
 
 /*
  * Note: Yes, part of the following code is located into the .data section.
