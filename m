From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Jul 2010 18:21:28 +0100
Subject: [patch 0/2] ARM: Disable outer cache before kexec call
In-Reply-To: <20100701170653.GA15162@n2100.arm.linux.org.uk>
References: <20100701160206.539545857@linutronix.de>
	<1278000887.7482.12.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007011820000.4507@localhost.localdomain>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5E41E0C@dbde02.ent.ti.com>
	<20100701170653.GA15162@n2100.arm.linux.org.uk>
Message-ID: <20100701172128.GB15162@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 01, 2010 at 06:06:53PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 01, 2010 at 10:08:37PM +0530, Shilimkar, Santosh wrote:
> > > -----Original Message-----
> > > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > > kernel-bounces at lists.infradead.org] On Behalf Of Thomas Gleixner
> > > To: Catalin Marinas
> > > Cc: LAK
> > > 
> > > Catalin,
> > > 
> > > But it can disable the inner caches? That's weird.
> > > 
> > If the C bit is disabled then it is as good as L1 and L2 are disabled.
> 
> However, if L2 contains valid cache lines which haven't been written
> back, the result of disabling the C bit effectively is instantaneous
> memory corruption.
> 
> We know that some L2 caches aren't searched if the C bit in the MMU
> tables is disabled, and for those caches I'd imagine the same thing
> happens when you clear the C bit in the SCTLR when turning off the
> MMU.  What we currently do for L1 is:
> 
> - disable interrupts
> - clean all caches (optionally invalidating)
> - turn off I & C bits
> - invalidate all caches
> 
> The 'clean' is there to push dirty data out of the caches back into
> memory.  We then turn off the I & C bits, ensuring that no new cache
> lines are read in.  At this point, some caches are no longer searched.
> 
> We then invalidate all caches to ensure that when _something_ later
> re-enables the caches, that they don't see our stale data.
> 
> As L2 needs this same handling, what I propose is, for both
> machine_restart() and machine_kexec():
> 
> 1. we move the IRQ (and FIQ) disable out of each CPUs proc_fin()
> 2. call flush_cache_all() immediately after IRQs are disabled
>    (removing any cache flushing from proc_fin() implementations.)
> 3. call outer_flush_all() (new function) after that
> 4. call proc_fin() to disable the C & I bits.
> 5. call flush_cache_all() again to invalidate the inner caches
> 6. call outer_flush_all() again to invalidate the outer caches
> 7. whatever's next after the existing cpu_proc_fin()...
> 
> The only potential problem I see with this is that (5) and (6) may end
> up writing back some dirty data associated with the stack, and one of
> these functions may overwrite its return address - thereby causing us
> to loop back to (2) or (3).  I don't think that's a problem as the next
> time around this 'loop' we won't be creating new dirty cache lines, and
> we should get to step 7.

Right, something like this.  I've not made an effort to fix the L2 bits,
but I have marked the places where attention is required.  The interesting
bit is the first two files.

The next question this provokes is whether we need a dsb() between steps 3
and 4, and maybe again between 4 and 5, and possibly after 6 ?

 arch/arm/kernel/machine_kexec.c |    8 +++++++-
 arch/arm/kernel/process.c       |   20 ++++++++++++++++----
 arch/arm/mm/proc-arm1020.S      |    6 +-----
 arch/arm/mm/proc-arm1020e.S     |    6 +-----
 arch/arm/mm/proc-arm1022.S      |    6 +-----
 arch/arm/mm/proc-arm1026.S      |    6 +-----
 arch/arm/mm/proc-arm6_7.S       |    2 --
 arch/arm/mm/proc-arm720.S       |    6 +-----
 arch/arm/mm/proc-arm740.S       |    6 +-----
 arch/arm/mm/proc-arm7tdmi.S     |    2 --
 arch/arm/mm/proc-arm920.S       |   10 +---------
 arch/arm/mm/proc-arm922.S       |   10 +---------
 arch/arm/mm/proc-arm925.S       |    6 +-----
 arch/arm/mm/proc-arm926.S       |    6 +-----
 arch/arm/mm/proc-arm940.S       |    6 +-----
 arch/arm/mm/proc-arm946.S       |    6 +-----
 arch/arm/mm/proc-arm9tdmi.S     |    2 --
 arch/arm/mm/proc-fa526.S        |    6 +-----
 arch/arm/mm/proc-feroceon.S     |    8 ++------
 arch/arm/mm/proc-mohawk.S       |    6 +-----
 arch/arm/mm/proc-sa110.S        |    8 ++------
 arch/arm/mm/proc-sa1100.S       |    6 +-----
 arch/arm/mm/proc-v6.S           |    5 +----
 arch/arm/mm/proc-v7.S           |    5 +----
 arch/arm/mm/proc-xsc3.S         |    6 +-----
 arch/arm/mm/proc-xscale.S       |    6 +-----
 26 files changed, 46 insertions(+), 124 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 598ca61..53f5dc4 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -74,7 +74,13 @@ void machine_kexec(struct kimage *image)
 			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
 	printk(KERN_INFO "Bye!\n");
 
-	cpu_proc_fin();
+	local_irq_disable();
+	local_fiq_disable();
 	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
+	flush_cache_all();
+	/* XXX: L2 cache flush */
+	cpu_proc_fin();
+	flush_cache_all();
+	/* XXX: L2 cache flush */
 	cpu_reset(reboot_code_buffer_phys);
 }
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index acf5e6f..3736887 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -84,10 +84,9 @@ __setup("hlt", hlt_setup);
 
 void arm_machine_restart(char mode, const char *cmd)
 {
-	/*
-	 * Clean and disable cache, and turn off interrupts
-	 */
-	cpu_proc_fin();
+	/* Disable interrupts first */
+	local_irq_disable();
+	local_fiq_disable();
 
 	/*
 	 * Tell the mm system that we are going to reboot -
@@ -96,6 +95,19 @@ void arm_machine_restart(char mode, const char *cmd)
 	 */
 	setup_mm_for_reboot(mode);
 
+	/* Clean and invalidate caches */
+	flush_cache_all();
+
+	/* XXX: L2 cache flush */
+
+	/* Turn off caching */
+	cpu_proc_fin();
+
+	/* Push out any further dirty data, and ensure cache is empty */
+	flush_cache_all();
+
+	/* XXX: L2 cache flush */
+
 	/*
 	 * Now call the architecture specific reboot code.
 	 */
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index 72507c6..203a4e9 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -79,15 +79,11 @@ ENTRY(cpu_arm1020_proc_init)
  * cpu_arm1020_proc_fin()
  */
 ENTRY(cpu_arm1020_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	arm1020_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000 		@ ...i............
 	bic	r0, r0, #0x000e 		@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_arm1020_reset(loc)
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index d278298..1a511e7 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -79,15 +79,11 @@ ENTRY(cpu_arm1020e_proc_init)
  * cpu_arm1020e_proc_fin()
  */
 ENTRY(cpu_arm1020e_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	arm1020e_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000 		@ ...i............
 	bic	r0, r0, #0x000e 		@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_arm1020e_reset(loc)
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index ce13e4a..1ffa4eb 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -68,15 +68,11 @@ ENTRY(cpu_arm1022_proc_init)
  * cpu_arm1022_proc_fin()
  */
 ENTRY(cpu_arm1022_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	arm1022_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000 		@ ...i............
 	bic	r0, r0, #0x000e 		@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_arm1022_reset(loc)
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 636672a..5697c34 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -68,15 +68,11 @@ ENTRY(cpu_arm1026_proc_init)
  * cpu_arm1026_proc_fin()
  */
 ENTRY(cpu_arm1026_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	arm1026_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000 		@ ...i............
 	bic	r0, r0, #0x000e 		@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_arm1026_reset(loc)
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
index 795dc61..64e0b32 100644
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -184,8 +184,6 @@ ENTRY(cpu_arm7_proc_init)
 
 ENTRY(cpu_arm6_proc_fin)
 ENTRY(cpu_arm7_proc_fin)
-		mov	r0, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-		msr	cpsr_c, r0
 		mov	r0, #0x31			@ ....S..DP...M
 		mcr	p15, 0, r0, c1, c0, 0		@ disable caches
 		mov	pc, lr
diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
index 0b62de2..9d96824 100644
--- a/arch/arm/mm/proc-arm720.S
+++ b/arch/arm/mm/proc-arm720.S
@@ -54,15 +54,11 @@ ENTRY(cpu_arm720_proc_init)
 		mov	pc, lr
 
 ENTRY(cpu_arm720_proc_fin)
-		stmfd	sp!, {lr}
-		mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-		msr	cpsr_c, ip
 		mrc	p15, 0, r0, c1, c0, 0
 		bic	r0, r0, #0x1000			@ ...i............
 		bic	r0, r0, #0x000e			@ ............wca.
 		mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-		mcr	p15, 0, r1, c7, c7, 0		@ invalidate cache
-		ldmfd	sp!, {pc}
+		mov	pc, lr
 
 /*
  * Function: arm720_proc_do_idle(void)
diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
index 01860cd..6c1a9ab 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -36,15 +36,11 @@ ENTRY(cpu_arm740_switch_mm)
  * cpu_arm740_proc_fin()
  */
 ENTRY(cpu_arm740_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
 	mrc	p15, 0, r0, c1, c0, 0
 	bic	r0, r0, #0x3f000000		@ bank/f/lock/s
 	bic	r0, r0, #0x0000000c		@ w-buffer/cache
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	mcr	p15, 0, r0, c7, c0, 0		@ invalidate cache
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_arm740_reset(loc)
diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
index 1201b98..6a850db 100644
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ b/arch/arm/mm/proc-arm7tdmi.S
@@ -36,8 +36,6 @@ ENTRY(cpu_arm7tdmi_switch_mm)
  * cpu_arm7tdmi_proc_fin()
  */
 ENTRY(cpu_arm7tdmi_proc_fin)
-		mov	r0, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-		msr	cpsr_c, r0
 		mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 8be8199..86f80aa 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -69,19 +69,11 @@ ENTRY(cpu_arm920_proc_init)
  * cpu_arm920_proc_fin()
  */
 ENTRY(cpu_arm920_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	bl	arm920_flush_kern_cache_all
-#else
-	bl	v4wt_flush_kern_cache_all
-#endif
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000			@ ...i............
 	bic	r0, r0, #0x000e			@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_arm920_reset(loc)
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index c0ff8e4..f76ce9b 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -71,19 +71,11 @@ ENTRY(cpu_arm922_proc_init)
  * cpu_arm922_proc_fin()
  */
 ENTRY(cpu_arm922_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	bl	arm922_flush_kern_cache_all
-#else
-	bl	v4wt_flush_kern_cache_all
-#endif
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000			@ ...i............
 	bic	r0, r0, #0x000e			@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_arm922_reset(loc)
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 3c6cffe..657bd3f 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -92,15 +92,11 @@ ENTRY(cpu_arm925_proc_init)
  * cpu_arm925_proc_fin()
  */
 ENTRY(cpu_arm925_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	arm925_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000			@ ...i............
 	bic	r0, r0, #0x000e			@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_arm925_reset(loc)
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 75b707c..73f1f3c 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -61,15 +61,11 @@ ENTRY(cpu_arm926_proc_init)
  * cpu_arm926_proc_fin()
  */
 ENTRY(cpu_arm926_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	arm926_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000			@ ...i............
 	bic	r0, r0, #0x000e			@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_arm926_reset(loc)
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index 1af1657..fffb061 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -37,15 +37,11 @@ ENTRY(cpu_arm940_switch_mm)
  * cpu_arm940_proc_fin()
  */
 ENTRY(cpu_arm940_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	arm940_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x00001000		@ i-cache
 	bic	r0, r0, #0x00000004		@ d-cache
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_arm940_reset(loc)
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 1664b6a..249a605 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -44,15 +44,11 @@ ENTRY(cpu_arm946_switch_mm)
  * cpu_arm946_proc_fin()
  */
 ENTRY(cpu_arm946_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	arm946_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x00001000		@ i-cache
 	bic	r0, r0, #0x00000004		@ d-cache
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_arm946_reset(loc)
diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
index 28545c2..db47566 100644
--- a/arch/arm/mm/proc-arm9tdmi.S
+++ b/arch/arm/mm/proc-arm9tdmi.S
@@ -36,8 +36,6 @@ ENTRY(cpu_arm9tdmi_switch_mm)
  * cpu_arm9tdmi_proc_fin()
  */
 ENTRY(cpu_arm9tdmi_proc_fin)
-		mov	r0, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-		msr	cpsr_c, r0
 		mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
index 08f5ac2..7803fdf 100644
--- a/arch/arm/mm/proc-fa526.S
+++ b/arch/arm/mm/proc-fa526.S
@@ -39,17 +39,13 @@ ENTRY(cpu_fa526_proc_init)
  * cpu_fa526_proc_fin()
  */
 ENTRY(cpu_fa526_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	fa_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000			@ ...i............
 	bic	r0, r0, #0x000e			@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
 	nop
 	nop
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_fa526_reset(loc)
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 53e6323..f8eff28 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -75,13 +75,9 @@ ENTRY(cpu_feroceon_proc_init)
  * cpu_feroceon_proc_fin()
  */
 ENTRY(cpu_feroceon_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	feroceon_flush_kern_cache_all
-
 #if defined(CONFIG_CACHE_FEROCEON_L2) && \
 	!defined(CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH)
+	XXX: move me to L2 cache support
 	mov	r0, #0
 	mcr	p15, 1, r0, c15, c9, 0		@ clean L2
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
@@ -91,7 +87,7 @@ ENTRY(cpu_feroceon_proc_fin)
 	bic	r0, r0, #0x1000			@ ...i............
 	bic	r0, r0, #0x000e			@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_feroceon_reset(loc)
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index caa3115..5f6892f 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -51,15 +51,11 @@ ENTRY(cpu_mohawk_proc_init)
  * cpu_mohawk_proc_fin()
  */
 ENTRY(cpu_mohawk_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	mohawk_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1800			@ ...iz...........
 	bic	r0, r0, #0x0006			@ .............ca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_mohawk_reset(loc)
diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
index 7b706b3..a201eb0 100644
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -44,17 +44,13 @@ ENTRY(cpu_sa110_proc_init)
  * cpu_sa110_proc_fin()
  */
 ENTRY(cpu_sa110_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	v4wb_flush_kern_cache_all	@ clean caches
-1:	mov	r0, #0
+	mov	r0, #0
 	mcr	p15, 0, r0, c15, c2, 2		@ Disable clock switching
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000			@ ...i............
 	bic	r0, r0, #0x000e			@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_sa110_reset(loc)
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 5c47760..7ddc480 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -55,16 +55,12 @@ ENTRY(cpu_sa1100_proc_init)
  *  - Clean and turn off caches.
  */
 ENTRY(cpu_sa1100_proc_fin)
-	stmfd	sp!, {lr}
-	mov	ip, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
-	msr	cpsr_c, ip
-	bl	v4wb_flush_kern_cache_all
 	mcr	p15, 0, ip, c15, c2, 2		@ Disable clock switching
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000			@ ...i............
 	bic	r0, r0, #0x000e			@ ............wca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  * cpu_sa1100_reset(loc)
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 7a5337e..e55ffd7 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -42,14 +42,11 @@ ENTRY(cpu_v6_proc_init)
 	mov	pc, lr
 
 ENTRY(cpu_v6_proc_fin)
-	stmfd	sp!, {lr}
-	cpsid	if				@ disable interrupts
-	bl	v6_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000			@ ...i............
 	bic	r0, r0, #0x0006			@ .............ca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 
 /*
  *	cpu_v6_reset(loc)
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7aaf88a..b0f8873 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -45,14 +45,11 @@ ENTRY(cpu_v7_proc_init)
 ENDPROC(cpu_v7_proc_init)
 
 ENTRY(cpu_v7_proc_fin)
-	stmfd	sp!, {lr}
-	cpsid	if				@ disable interrupts
-	bl	v7_flush_kern_cache_all
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1000			@ ...i............
 	bic	r0, r0, #0x0006			@ .............ca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldmfd	sp!, {pc}
+	mov	pc, lr
 ENDPROC(cpu_v7_proc_fin)
 
 /*
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index e5797f1..361a51e 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -90,15 +90,11 @@ ENTRY(cpu_xsc3_proc_init)
  * cpu_xsc3_proc_fin()
  */
 ENTRY(cpu_xsc3_proc_fin)
-	str	lr, [sp, #-4]!
-	mov	r0, #PSR_F_BIT|PSR_I_BIT|SVC_MODE
-	msr	cpsr_c, r0
-	bl	xsc3_flush_kern_cache_all	@ clean caches
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1800			@ ...IZ...........
 	bic	r0, r0, #0x0006			@ .............CA.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldr	pc, [sp], #4
+	mov	pc, lr
 
 /*
  * cpu_xsc3_reset(loc)
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 63037e2..1407597 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -124,15 +124,11 @@ ENTRY(cpu_xscale_proc_init)
  * cpu_xscale_proc_fin()
  */
 ENTRY(cpu_xscale_proc_fin)
-	str	lr, [sp, #-4]!
-	mov	r0, #PSR_F_BIT|PSR_I_BIT|SVC_MODE
-	msr	cpsr_c, r0
-	bl	xscale_flush_kern_cache_all	@ clean caches
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
 	bic	r0, r0, #0x1800			@ ...IZ...........
 	bic	r0, r0, #0x0006			@ .............CA.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
-	ldr	pc, [sp], #4
+	mov	pc, lr
 
 /*
  * cpu_xscale_reset(loc)
