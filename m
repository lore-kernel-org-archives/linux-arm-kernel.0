From: gores@marvell.com (Siddarth Gore)
Date: Fri, 21 May 2010 16:07:08 +0530
Subject: L2 cache support for pxa16x
In-Reply-To: <AANLkTimdpvBJjF_JgnD1_K6AdnRjW2jaE_49eBb8CoMu@mail.gmail.com>
References: <1273658181.6926.27.camel@pe-dt434>
	<AANLkTiky2tG7-n5bmMBqhKBIn7tq1tIT0KeWpkUee5YK@mail.gmail.com>
	<1274350676.6926.58.camel@pe-dt434>
	<AANLkTil839_xcOATFEFyQH5YVgWPwJcf31Wo1ZqmJ7Z6@mail.gmail.com>
	<1274435046.6926.69.camel@pe-dt434>
	<AANLkTimdpvBJjF_JgnD1_K6AdnRjW2jaE_49eBb8CoMu@mail.gmail.com>
Message-ID: <1274438229.6926.73.camel@pe-dt434>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-05-21 at 03:27 -0700, Eric Miao wrote:
> On Fri, May 21, 2010 at 5:44 PM, Siddarth Gore <gores@marvell.com> wrote:
> >
> > On Thu, 2010-05-20 at 07:06 -0700, Eric Miao wrote:
> > > On Thu, May 20, 2010 at 6:17 PM, Siddarth Gore <gores@marvell.com> wrote:
> > > > On Wed, 2010-05-12 at 03:11 -0700, Eric Miao wrote:
> > > >> On Wed, May 12, 2010 at 11:56 AM, Siddarth Gore <gores@marvell.com> wrote:
> > > >> > Hi Eric/Haojian,
> > > >> >
> > > >> > Can the Tauros2 support be used for pxa168 as well? The one difference I
> > > >> > can see is that L2 Enable is in control register instead of extra
> > > >> > feature register. But rest of the things look very similar to me.
> > > >> >
> > > >
> > > > I tried doing this. It works when I enable L2 before turning the MMU on,
> > > > i.e. in __mohawk_setup
> > > >
> > > > But when I do the following in tauros2_init(), the kernel crashes.
> > > > 1. flush and disable dcache
> > > > 2. invalidate and disable icache
> > > > 3. drain write buffer
> > > > 4. invalidate TLB
> > > > 5. invalidate L2
> > > > 6. enable L2
> > > > 7. enable icache
> > > > 8. enable dcache
> > > >
> > > > I think the right place to enable L2 is in tauros2_init, so any idea
> > > > what I am doing wrong here?
> > > >
> > >
> > > I believe that was the reason why I didn't put tauros2 support to pxa168
> > > at the first place. And enabling L2 after MMU is enabled is supposed to
> > > be unsafe, which is mentioned in xscale3 manual, though not sure if that's
> > > the case for pxa168 as well.
> > >
> > I did not find it mentioned anywhere in the mohawk (PJ1) datasheet. Also
> > any idea why is this unsafe? I clean and disable the L1 cache first so
> > all the page tables, etc. will be backed up in main memory before
> > turning L2 on. plus invalidate the entire L2, so all the fetches will
> > first go to main memory.
> >
> > other CPUs using tauros2 (also feroceon) turn L2 on after MMU, and they
> > work fine.
> >
> 
> Can you post here the changes you've made?

Please find them below. It works if I uncomment the last change in
proc-mohawk.S

-siddarth

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index a2d307e..d047d8c 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 
+#include <asm/hardware/cache-tauros2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/addr-map.h>
@@ -125,6 +126,7 @@ static struct pxa3xx_nand_platform_data
aspenite_nand_info = {
 
 static void __init common_init(void)
 {
+	tauros2_init();
 	mfp_config(ARRAY_AND_SIZE(common_pin_config));
 
 	/* on-chip devices */
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5bd7c89..ededf5a 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -769,7 +769,7 @@ config CACHE_L2X0
 
 config CACHE_TAUROS2
 	bool "Enable the Tauros2 L2 cache controller"
-	depends on ARCH_DOVE
+	depends on ARCH_DOVE || ARCH_MMP
 	default y
 	select OUTER_CACHE
 	help
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 5086865..d2d4545 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -48,6 +48,10 @@ static inline void tauros2_inv_pa(unsigned long addr)
 	__asm__("mcr p15, 1, %0, c7, c7, 3" : : "r" (addr));
 }
 
+static inline void tauros2_inv_all(void)
+{
+	__asm__("mcr p15, 1, %0, c7, c7, 0" : : "r" (0));
+}
 
 /*
  * Linux primitives.
@@ -168,6 +172,62 @@ static inline void __init write_actlr(u32 actlr)
 	__asm__("mcr p15, 0, %0, c1, c0, 1\n" : : "r" (actlr));
 }
 
+static int __init flush_and_disable_dcache(void)
+{
+	u32 cr;
+
+	cr = get_cr();
+	if (cr & CR_C) {
+		unsigned long flags;
+
+		raw_local_irq_save(flags);
+		flush_cache_all();
+		set_cr(cr & ~CR_C);
+		raw_local_irq_restore(flags);
+		return 1;
+	}
+	return 0;
+}
+
+static void __init enable_dcache(void)
+{
+	u32 cr;
+
+	cr = get_cr();
+	set_cr(cr | CR_C);
+}
+
+static void __init __invalidate_icache(void)
+{
+	__asm__("mcr p15, 0, %0, c7, c5, 0" : : "r" (0));
+}
+
+static int __init invalidate_and_disable_icache(void)
+{
+	u32 cr;
+
+	cr = get_cr();
+	if (cr & CR_I) {
+		set_cr(cr & ~CR_I);
+		__invalidate_icache();
+		return 1;
+	}
+	return 0;
+}
+
+static void __init enable_icache(void)
+{
+	u32 cr;
+
+	cr = get_cr();
+	set_cr(cr | CR_I);
+}
+
+static void __init __invalidate_tlb(void)
+{
+	__asm__("mcr p15, 0, %0, c8, c7, 0" : : "r" (0));
+}
+
 void __init tauros2_init(void)
 {
 	extern int processor_id;
@@ -179,6 +239,25 @@ void __init tauros2_init(void)
 	if ((processor_id & 0xff0f0000) == 0x56050000) {
 		u32 feat;
 
+#ifdef CONFIG_CPU_MOHAWK
+		/*
+ 		 * for mohawk cpu, L2 enable bit is in control reg
+ 		 */
+#define	CR_L2 (1 << 26)
+		feat = get_cr();
+		if (!(feat & CR_L2)) {
+			printk(KERN_INFO "Tauros2: Enabling L2 cache.\n");
+		
+			flush_and_disable_dcache();
+			invalidate_and_disable_icache();
+			dsb();
+			__invalidate_tlb();
+			tauros2_inv_all();
+			set_cr(feat | CR_L2);
+			enable_icache();
+			enable_dcache();
+		}
+#else
 		/*
 		 * v5 CPUs with Tauros2 have the L2 cache enable bit
 		 * located in the CPU Extra Features register.
@@ -188,6 +267,7 @@ void __init tauros2_init(void)
 			printk(KERN_INFO "Tauros2: Enabling L2 cache.\n");
 			write_extra_features(feat | 0x00400000);
 		}
+#endif
 
 		mode = "ARMv5";
 		outer_cache.inv_range = tauros2_inv_range;
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index caa3115..5f7d706 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -361,6 +361,7 @@ __mohawk_setup:
 	mrc	p15, 0, r0, c1, c0		@ get control register
 	bic	r0, r0, r5
 	orr	r0, r0, r6
+@	orr     r0, r0, #(1 << 26)              @ L2 enable - xscale/PJ41/PJ4
 	mov	pc, lr
 
 	.size	__mohawk_setup, . - __mohawk_setup
