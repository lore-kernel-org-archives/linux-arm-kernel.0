From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Sep 2013 22:31:25 +0100
Subject: [PATCH v4] ARM: Add check for Cortex-A15 errata 798181 ECO
In-Reply-To: <20130902135842.GU6617@n2100.arm.linux.org.uk>
References: <1377440747-4564-1-git-send-email-robherring2@gmail.com>
 <20130902135842.GU6617@n2100.arm.linux.org.uk>
Message-ID: <20130902213125.GB6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 02:58:42PM +0100, Russell King - ARM Linux wrote:
> On Sun, Aug 25, 2013 at 09:25:47AM -0500, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > The work-around for A15 errata 798181 is not needed if appropriate ECO
> > fixes have been applied to r3p2 and earlier core revisions. This can be
> > checked by reading REVIDR register bits 4 and 9. If only bit 4 is set,
> > then the IPI broadcast can be skipped.
> > 
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> 
> So, this patch in the patch system claims to be against v3.11-rc2:
> 
> $ git checkout v3.11-rc2
> ...
> $ pdb gitapply 7804/2
> Patching 7804/2...
> git apply --whitespace=fix -p1 --index --check > /tmp/pdb.15757 2>&1 exited with non-zero status: 256
> error: patch failed: arch/arm/include/asm/tlbflush.h:443
> error: arch/arm/include/asm/tlbflush.h: patch does not apply
> error: patch failed: arch/arm/kernel/smp_tlb.c:70
> error: arch/arm/kernel/smp_tlb.c: patch does not apply
> error: patch failed: arch/arm/mm/context.c:245
> error: arch/arm/mm/context.c: patch does not apply
> 
> > v3:
> > - Rebase to v3.11-rc5 due to commit 1f49856 (ARM: 7789/1: Do not run
> >  dummy_flush_tlb_a15_erratum() on non-Cortex-A15)
> > - Move the revision checking out of line and use function ptrs.
> 
> Hmm, so -rc5 not -rc2 that you put into the patch system...  Also, the
> patch you put into the patch system didn't have Will's ack on it.

And... merging everything together tonight gives me a conflict with Will's
barriers patches, which I've resolved like this - this will need to be
checked:

diff --cc arch/arm/include/asm/tlbflush.h
index decff8d,3896026..0000000
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@@ -434,25 -545,51 +545,31 @@@ static inline void local_flush_bp_all(v
  	const int zero = 0;
  	const unsigned int __tlb_flag = __cpu_tlb_flags;
  
+ 	__local_flush_bp_all();
  	if (tlb_flag(TLB_V7_UIS_BP))
- 		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
- 	else if (tlb_flag(TLB_V6_BP))
  		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero));
+ }
  
- 	if (tlb_flag(TLB_BARRIER))
- 		isb();
+ static inline void __flush_bp_all(void)
+ {
+ 	const int zero = 0;
+ 	const unsigned int __tlb_flag = __cpu_tlb_flags;
+ 
+ 	__local_flush_bp_all();
+ 	if (tlb_flag(TLB_V7_UIS_BP))
+ 		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
  }
  
 -#include <asm/cputype.h>
 -#ifdef CONFIG_ARM_ERRATA_798181
 -static inline int erratum_a15_798181(void)
 -{
 -	unsigned int midr = read_cpuid_id();
 -
 -	/* Cortex-A15 r0p0..r3p2 affected */
 -	if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2)
 -		return 0;
 -	return 1;
 -}
 -
 -static inline void dummy_flush_tlb_a15_erratum(void)
 -{
 -	/*
 -	 * Dummy TLBIMVAIS. Using the unmapped address 0 and ASID 0.
 -	 */
 -	asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
 -	dsb(ish);
 -}
 -#else
 -static inline int erratum_a15_798181(void)
 -{
 -	return 0;
 -}
 +extern void erratum_a15_798181_init(void);
 +extern bool (*erratum_a15_798181_handler)(void);
  
 -static inline void dummy_flush_tlb_a15_erratum(void)
 +static inline bool erratum_a15_798181(void)
  {
 +	if (unlikely(IS_ENABLED(CONFIG_ARM_ERRATA_798181) &&
 +		erratum_a15_798181_handler))
 +		return erratum_a15_798181_handler();
 +	return false;
  }
 -#endif
  
  /*
   *	flush_pmd_entry
diff --cc arch/arm/mm/context.c
index 28daa1c,84e6f77..0000000
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index 12ab803..3bb055d 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -75,14 +75,14 @@ bool (*erratum_a15_798181_handler)(void);
 static bool erratum_a15_798181_partial(void)
 {
 	asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
-	dsb();
+	dsb(ish);
 	return false;
 }
 
 static bool erratum_a15_798181_broadcast(void)
 {
 	asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
-	dsb();
+	dsb(ish);
 	return true;
 }
 
