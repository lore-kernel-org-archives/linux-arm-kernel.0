From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 28 Oct 2010 10:32:45 +0300
Subject: Is ep93xx support broken in linux-next?
In-Reply-To: <20101027202018.GB24573@n2100.arm.linux.org.uk>
References: <1288094199.2098.26.camel@r60e>
	<20101026125050.GB15333@gw.healthdatacare.com>
	<20101026125841.GC15333@gw.healthdatacare.com>
	<1288099206.2098.27.camel@r60e>
	<20101026132235.GD15333@gw.healthdatacare.com>
	<20101027202018.GB24573@n2100.arm.linux.org.uk>
Message-ID: <20101028073245.GE15333@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 09:20:18PM +0100, Russell King - ARM Linux wrote:
> 
> Is there an updated patch ready?

Yes, see below.

It is tested on ep93xx and I tried to compile test on others which
had suitable defconfig.

Regards,
MW

From: Mika Westerberg <mika.westerberg@iki.fi>
Date: Tue, 26 Oct 2010 15:35:44 +0300
Subject: [PATCH] ARM: implement flush_icache_all for the rest of the CPUs

Commit 81d11955bf0 ("ARM: 6405/1: Handle __flush_icache_all for
CONFIG_SMP_ON_UP") added a new function to struct cpu_cache_fns:
flush_icache_all(). It also implemented this for v6 and v7 but not
for v5 and backwards. Without the function pointer in place, we
will be calling wrong cache functions.

For example with ep93xx we get following:

    Unable to handle kernel paging request at virtual address ee070f38
    pgd = c0004000
    [ee070f38] *pgd=00000000
    Internal error: Oops: 80000005 [#1] PREEMPT
    last sysfs file:
    Modules linked in:
    CPU: 0    Not tainted  (2.6.36+ #1)
    PC is at 0xee070f38
    LR is at __dma_alloc+0x11c/0x2d0
    pc : [<ee070f38>]    lr : [<c0032c8c>]    psr: 60000013
    sp : c581bde0  ip : 00000000  fp : c0472000
    r10: c0472000  r9 : 000000d0  r8 : 00020000
    r7 : 0001ffff  r6 : 00000000  r5 : c0472400  r4 : c5980000
    r3 : c03ab7e0  r2 : 00000000  r1 : c59a0000  r0 : c5980000
    Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
    Control: c000717f  Table: c0004000  DAC: 00000017
    Process swapper (pid: 1, stack limit = 0xc581a270)
    [<c0032c8c>] (__dma_alloc+0x11c/0x2d0)
    [<c0032e5c>] (dma_alloc_writecombine+0x1c/0x24)
    [<c0204148>] (ep93xx_pcm_preallocate_dma_buffer+0x44/0x60)
    [<c02041c0>] (ep93xx_pcm_new+0x5c/0x88)
    [<c01ff188>] (snd_soc_instantiate_cards+0x8a8/0xbc0)
    [<c01ff59c>] (soc_probe+0xfc/0x134)
    [<c01adafc>] (platform_drv_probe+0x18/0x1c)
    [<c01acca4>] (driver_probe_device+0xb0/0x16c)
    [<c01ac284>] (bus_for_each_drv+0x48/0x84)
    [<c01ace90>] (device_attach+0x50/0x68)
    [<c01ac0f8>] (bus_probe_device+0x24/0x44)
    [<c01aad7c>] (device_add+0x2fc/0x44c)
    [<c01adfa8>] (platform_device_add+0x104/0x15c)
    [<c0015eb8>] (simone_init+0x60/0x94)
    [<c0021410>] (do_one_initcall+0xd0/0x1a4)

__dma_alloc() calls (inlined) __dma_alloc_buffer() which ends up
calling dmac_flush_range(). Now since the entries in the
arm920_cache_fns are shifted by one, we jump into address 0xee070f38
which is actually next instruction after the arm920_cache_fns
structure.

So implement flush_icache_all() for the rest of the supported CPUs
using a generic 'invalidate I cache' instruction.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mm/cache-fa.S      |   12 ++++++++++++
 arch/arm/mm/cache-v3.S      |   10 ++++++++++
 arch/arm/mm/cache-v4.S      |   10 ++++++++++
 arch/arm/mm/cache-v4wb.S    |   12 ++++++++++++
 arch/arm/mm/cache-v4wt.S    |   12 ++++++++++++
 arch/arm/mm/proc-arm1020.S  |   15 +++++++++++++++
 arch/arm/mm/proc-arm1020e.S |   15 +++++++++++++++
 arch/arm/mm/proc-arm1022.S  |   15 +++++++++++++++
 arch/arm/mm/proc-arm1026.S  |   15 +++++++++++++++
 arch/arm/mm/proc-arm920.S   |   12 ++++++++++++
 arch/arm/mm/proc-arm922.S   |   12 ++++++++++++
 arch/arm/mm/proc-arm925.S   |   12 ++++++++++++
 arch/arm/mm/proc-arm926.S   |   12 ++++++++++++
 arch/arm/mm/proc-arm940.S   |   12 ++++++++++++
 arch/arm/mm/proc-arm946.S   |   12 ++++++++++++
 arch/arm/mm/proc-feroceon.S |   13 +++++++++++++
 arch/arm/mm/proc-xsc3.S     |   12 ++++++++++++
 arch/arm/mm/proc-xscale.S   |   12 ++++++++++++
 18 files changed, 225 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index 7148e53..1fa6f71 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -38,6 +38,17 @@
 #define CACHE_DLIMIT	(CACHE_DSIZE * 2)
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(fa_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(fa_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Clean and invalidate all cache entries in a particular address
@@ -233,6 +244,7 @@ ENDPROC(fa_dma_unmap_area)
 
 	.type	fa_cache_fns, #object
 ENTRY(fa_cache_fns)
+	.long	fa_flush_icache_all
 	.long	fa_flush_kern_cache_all
 	.long	fa_flush_user_cache_all
 	.long	fa_flush_user_cache_range
diff --git a/arch/arm/mm/cache-v3.S b/arch/arm/mm/cache-v3.S
index c2ff3c5..2e2bc40 100644
--- a/arch/arm/mm/cache-v3.S
+++ b/arch/arm/mm/cache-v3.S
@@ -13,6 +13,15 @@
 #include "proc-macros.S"
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(v3_flush_icache_all)
+	mov	pc, lr
+ENDPROC(v3_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Invalidate all cache entries in a particular address
@@ -122,6 +131,7 @@ ENDPROC(v3_dma_map_area)
 
 	.type	v3_cache_fns, #object
 ENTRY(v3_cache_fns)
+	.long	v3_flush_icache_all
 	.long	v3_flush_kern_cache_all
 	.long	v3_flush_user_cache_all
 	.long	v3_flush_user_cache_range
diff --git a/arch/arm/mm/cache-v4.S b/arch/arm/mm/cache-v4.S
index 4810f7e..a8fefb5 100644
--- a/arch/arm/mm/cache-v4.S
+++ b/arch/arm/mm/cache-v4.S
@@ -13,6 +13,15 @@
 #include "proc-macros.S"
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(v4_flush_icache_all)
+	mov	pc, lr
+ENDPROC(v4_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Invalidate all cache entries in a particular address
@@ -134,6 +143,7 @@ ENDPROC(v4_dma_map_area)
 
 	.type	v4_cache_fns, #object
 ENTRY(v4_cache_fns)
+	.long	v4_flush_icache_all
 	.long	v4_flush_kern_cache_all
 	.long	v4_flush_user_cache_all
 	.long	v4_flush_user_cache_range
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index df8368a..d3644db 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -51,6 +51,17 @@ flush_base:
 	.text
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(v4wb_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(v4wb_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Clean and invalidate all cache entries in a particular address
@@ -244,6 +255,7 @@ ENDPROC(v4wb_dma_unmap_area)
 
 	.type	v4wb_cache_fns, #object
 ENTRY(v4wb_cache_fns)
+	.long	v4wb_flush_icache_all
 	.long	v4wb_flush_kern_cache_all
 	.long	v4wb_flush_user_cache_all
 	.long	v4wb_flush_user_cache_range
diff --git a/arch/arm/mm/cache-v4wt.S b/arch/arm/mm/cache-v4wt.S
index 45c7031..49c2b66 100644
--- a/arch/arm/mm/cache-v4wt.S
+++ b/arch/arm/mm/cache-v4wt.S
@@ -41,6 +41,17 @@
 #define CACHE_DLIMIT	16384
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(v4wt_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(v4wt_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Invalidate all cache entries in a particular address
@@ -188,6 +199,7 @@ ENDPROC(v4wt_dma_map_area)
 
 	.type	v4wt_cache_fns, #object
 ENTRY(v4wt_cache_fns)
+	.long	v4wt_flush_icache_all
 	.long	v4wt_flush_kern_cache_all
 	.long	v4wt_flush_user_cache_all
 	.long	v4wt_flush_user_cache_range
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index a6f5f84..bcf748d 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -119,6 +119,20 @@ ENTRY(cpu_arm1020_do_idle)
 /* ================================= CACHE ================================ */
 
 	.align	5
+
+/*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(arm1020_flush_icache_all)
+#ifndef CONFIG_CPU_ICACHE_DISABLE
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+#endif
+	mov	pc, lr
+ENDPROC(arm1020_flush_icache_all)
+
 /*
  *	flush_user_cache_all()
  *
@@ -351,6 +365,7 @@ ENTRY(arm1020_dma_unmap_area)
 ENDPROC(arm1020_dma_unmap_area)
 
 ENTRY(arm1020_cache_fns)
+	.long	arm1020_flush_icache_all
 	.long	arm1020_flush_kern_cache_all
 	.long	arm1020_flush_user_cache_all
 	.long	arm1020_flush_user_cache_range
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index afc06b9..ab7ec26 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -119,6 +119,20 @@ ENTRY(cpu_arm1020e_do_idle)
 /* ================================= CACHE ================================ */
 
 	.align	5
+
+/*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(arm1020e_flush_icache_all)
+#ifndef CONFIG_CPU_ICACHE_DISABLE
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+#endif
+	mov	pc, lr
+ENDPROC(arm1020e_flush_icache_all)
+
 /*
  *	flush_user_cache_all()
  *
@@ -337,6 +351,7 @@ ENTRY(arm1020e_dma_unmap_area)
 ENDPROC(arm1020e_dma_unmap_area)
 
 ENTRY(arm1020e_cache_fns)
+	.long	arm1020e_flush_icache_all
 	.long	arm1020e_flush_kern_cache_all
 	.long	arm1020e_flush_user_cache_all
 	.long	arm1020e_flush_user_cache_range
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index 8915e0b..831c5e5 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -108,6 +108,20 @@ ENTRY(cpu_arm1022_do_idle)
 /* ================================= CACHE ================================ */
 
 	.align	5
+
+/*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(arm1022_flush_icache_all)
+#ifndef CONFIG_CPU_ICACHE_DISABLE
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+#endif
+	mov	pc, lr
+ENDPROC(arm1022_flush_icache_all)
+
 /*
  *	flush_user_cache_all()
  *
@@ -326,6 +340,7 @@ ENTRY(arm1022_dma_unmap_area)
 ENDPROC(arm1022_dma_unmap_area)
 
 ENTRY(arm1022_cache_fns)
+	.long	arm1022_flush_icache_all
 	.long	arm1022_flush_kern_cache_all
 	.long	arm1022_flush_user_cache_all
 	.long	arm1022_flush_user_cache_range
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index ff446c5..e3f7e9a 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -108,6 +108,20 @@ ENTRY(cpu_arm1026_do_idle)
 /* ================================= CACHE ================================ */
 
 	.align	5
+
+/*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(arm1026_flush_icache_all)
+#ifndef CONFIG_CPU_ICACHE_DISABLE
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+#endif
+	mov	pc, lr
+ENDPROC(arm1026_flush_icache_all)
+
 /*
  *	flush_user_cache_all()
  *
@@ -320,6 +334,7 @@ ENTRY(arm1026_dma_unmap_area)
 ENDPROC(arm1026_dma_unmap_area)
 
 ENTRY(arm1026_cache_fns)
+	.long	arm1026_flush_icache_all
 	.long	arm1026_flush_kern_cache_all
 	.long	arm1026_flush_user_cache_all
 	.long	arm1026_flush_user_cache_range
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index fecf570..6109f27 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -110,6 +110,17 @@ ENTRY(cpu_arm920_do_idle)
 #ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(arm920_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(arm920_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Invalidate all cache entries in a particular address
@@ -305,6 +316,7 @@ ENTRY(arm920_dma_unmap_area)
 ENDPROC(arm920_dma_unmap_area)
 
 ENTRY(arm920_cache_fns)
+	.long	arm920_flush_icache_all
 	.long	arm920_flush_kern_cache_all
 	.long	arm920_flush_user_cache_all
 	.long	arm920_flush_user_cache_range
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index e3cbf87..bb2f0f4 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -112,6 +112,17 @@ ENTRY(cpu_arm922_do_idle)
 #ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(arm922_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(arm922_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Clean and invalidate all cache entries in a particular
@@ -307,6 +318,7 @@ ENTRY(arm922_dma_unmap_area)
 ENDPROC(arm922_dma_unmap_area)
 
 ENTRY(arm922_cache_fns)
+	.long	arm922_flush_icache_all
 	.long	arm922_flush_kern_cache_all
 	.long	arm922_flush_user_cache_all
 	.long	arm922_flush_user_cache_range
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 572424c..c13e01a 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -145,6 +145,17 @@ ENTRY(cpu_arm925_do_idle)
 	mov	pc, lr
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(arm925_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(arm925_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Clean and invalidate all cache entries in a particular
@@ -362,6 +373,7 @@ ENTRY(arm925_dma_unmap_area)
 ENDPROC(arm925_dma_unmap_area)
 
 ENTRY(arm925_cache_fns)
+	.long	arm925_flush_icache_all
 	.long	arm925_flush_kern_cache_all
 	.long	arm925_flush_user_cache_all
 	.long	arm925_flush_user_cache_range
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 63d168b..42eb431 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -111,6 +111,17 @@ ENTRY(cpu_arm926_do_idle)
 	mov	pc, lr
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(arm926_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(arm926_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Clean and invalidate all cache entries in a particular
@@ -325,6 +336,7 @@ ENTRY(arm926_dma_unmap_area)
 ENDPROC(arm926_dma_unmap_area)
 
 ENTRY(arm926_cache_fns)
+	.long	arm926_flush_icache_all
 	.long	arm926_flush_kern_cache_all
 	.long	arm926_flush_user_cache_all
 	.long	arm926_flush_user_cache_range
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index f6a6282..7b11cdb 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -68,6 +68,17 @@ ENTRY(cpu_arm940_do_idle)
 	mov	pc, lr
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(arm940_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(arm940_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  */
 ENTRY(arm940_flush_user_cache_all)
@@ -254,6 +265,7 @@ ENTRY(arm940_dma_unmap_area)
 ENDPROC(arm940_dma_unmap_area)
 
 ENTRY(arm940_cache_fns)
+	.long	arm940_flush_icache_all
 	.long	arm940_flush_kern_cache_all
 	.long	arm940_flush_user_cache_all
 	.long	arm940_flush_user_cache_range
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index ea2e7f2..1a5bbf0 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -75,6 +75,17 @@ ENTRY(cpu_arm946_do_idle)
 	mov	pc, lr
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(arm946_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(arm946_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  */
 ENTRY(arm946_flush_user_cache_all)
@@ -296,6 +307,7 @@ ENTRY(arm946_dma_unmap_area)
 ENDPROC(arm946_dma_unmap_area)
 
 ENTRY(arm946_cache_fns)
+	.long	arm946_flush_icache_all
 	.long	arm946_flush_kern_cache_all
 	.long	arm946_flush_user_cache_all
 	.long	arm946_flush_user_cache_range
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 578da69..b4597ed 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -124,6 +124,17 @@ ENTRY(cpu_feroceon_do_idle)
 	mov	pc, lr
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(feroceon_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(feroceon_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Clean and invalidate all cache entries in a particular
@@ -401,6 +412,7 @@ ENTRY(feroceon_dma_unmap_area)
 ENDPROC(feroceon_dma_unmap_area)
 
 ENTRY(feroceon_cache_fns)
+	.long	feroceon_flush_icache_all
 	.long	feroceon_flush_kern_cache_all
 	.long	feroceon_flush_user_cache_all
 	.long	feroceon_flush_user_cache_range
@@ -412,6 +424,7 @@ ENTRY(feroceon_cache_fns)
 	.long	feroceon_dma_flush_range
 
 ENTRY(feroceon_range_cache_fns)
+	.long	feroceon_flush_icache_all
 	.long	feroceon_flush_kern_cache_all
 	.long	feroceon_flush_user_cache_all
 	.long	feroceon_flush_user_cache_range
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index cad07e4..ec26355 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -141,6 +141,17 @@ ENTRY(cpu_xsc3_do_idle)
 /* ================================= CACHE ================================ */
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(xsc3_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(xsc3_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Invalidate all cache entries in a particular address
@@ -325,6 +336,7 @@ ENTRY(xsc3_dma_unmap_area)
 ENDPROC(xsc3_dma_unmap_area)
 
 ENTRY(xsc3_cache_fns)
+	.long	xsc3_flush_icache_all
 	.long	xsc3_flush_kern_cache_all
 	.long	xsc3_flush_user_cache_all
 	.long	xsc3_flush_user_cache_range
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index cb245ed..523408c 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -181,6 +181,17 @@ ENTRY(cpu_xscale_do_idle)
 /* ================================= CACHE ================================ */
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(xscale_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(xscale_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Invalidate all cache entries in a particular address
@@ -397,6 +408,7 @@ ENTRY(xscale_dma_unmap_area)
 ENDPROC(xscale_dma_unmap_area)
 
 ENTRY(xscale_cache_fns)
+	.long	xscale_flush_icache_all
 	.long	xscale_flush_kern_cache_all
 	.long	xscale_flush_user_cache_all
 	.long	xscale_flush_user_cache_range
-- 
1.5.6.5
