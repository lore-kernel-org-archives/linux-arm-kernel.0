From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Feb 2012 23:34:00 +0000
Subject: [PATCH] Optimize multi-CPU tlb flushing a little more
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178FACB70B@HQMAIL01.nvidia.com>
References: <20110823110602.GG19622@n2100.arm.linux.org.uk>
 <CAH+eYFC_mkdObV0NfN5Jtv0L6fM9e0YGOBghTEVSqf=TAFxdXw@mail.gmail.com>
 <20120213162359.GC25655@n2100.arm.linux.org.uk>
 <20120213165926.GA24426@debian>
 <74CDBE0F657A3D45AFBB94109FB122FF178FACB6A1@HQMAIL01.nvidia.com>
 <20120214222354.GB29765@n2100.arm.linux.org.uk>
 <74CDBE0F657A3D45AFBB94109FB122FF178FACB6D7@HQMAIL01.nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178FACB70B@HQMAIL01.nvidia.com>
Message-ID: <20120214233400.GC29765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 03:21:52PM -0800, Stephen Warren wrote:
> Russell,
> 
> One more query about the original patch; in the following chunk:
> 
> @@ -491,15 +471,11 @@ static inline void clean_pmd_entry(void *pmd)
>  {
>         const unsigned int __tlb_flag = __cpu_tlb_flags;
>  
> -       if (tlb_flag(TLB_DCLEAN))
> -               asm("mcr        p15, 0, %0, c7, c10, 1  @ flush_pmd"
> -                       : : "r" (pmd) : "cc");
> -
> -       if (tlb_flag(TLB_L2CLEAN_FR))
> -               asm("mcr        p15, 1, %0, c15, c9, 1  @ L2 flush_pmd"
> -                       : : "r" (pmd) : "cc");
> +       tlb_op(TLB_DCLEAN, "c7, c10, 1  @ flush_pmd", pmd);
> +       tlb_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
>  }
> 
> You'll notice that the second mcr instruction is passed "p15, 1, ...".
> However, the replacement code in tlb_op() always passes "p15, 0, ..."
> to mcr/mcrne. I assume this is a problem?
> 
> The same thing applies to flush_pmd_entry() too.

Damn it.  Well spotted, yes this needs fixing.  Here's an updated patch.

 arch/arm/include/asm/tlbflush.h |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index bb6408a..1f1d2ed 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -318,18 +318,21 @@ extern struct cpu_tlb_fns cpu_tlb;
 
 #define tlb_flag(f)	((always_tlb_flags & (f)) || (__tlb_flag & possible_tlb_flags & (f)))
 
-#define tlb_op(f, regs, arg)						\
+#define __tlb_op(f, insnarg, arg)					\
 	do {								\
 		if (always_tlb_flags & (f))				\
-			asm("mcr p15, 0, %0, " regs			\
+			asm("mcr " insnarg				\
 			    : : "r" (arg) : "cc");			\
 		else if (possible_tlb_flags & (f))			\
 			asm("tst %1, %2\n\t"				\
-			    "mcrne p15, 0, %0, " regs			\
+			    "mcrne " insnarg				\
 			    : : "r" (arg), "r" (__tlb_flag), "Ir" (f)	\
 			    : "cc");					\
 	} while (0)
 
+#define tlb_op(f, regs, arg)	__tlb_op(f, "p15, 0, %0, " regs, arg)
+#define tlb_l2_op(f, regs_arg)	__tlb_op(f, "p15, 1, %0, " regs, arg)
+
 static inline void local_flush_tlb_all(void)
 {
 	const int zero = 0;
@@ -359,14 +362,15 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (possible_tlb_flags & (TLB_V3_FULL|TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL) &&
-	    cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
-		tlb_op(TLB_V3_FULL, "c6, c0, 0", zero);
-		tlb_op(TLB_V4_U_FULL, "c8, c7, 0", zero);
-		tlb_op(TLB_V4_D_FULL, "c8, c6, 0", zero);
-		tlb_op(TLB_V4_I_FULL, "c8, c5, 0", zero);
+	if (possible_tlb_flags & (TLB_V3_FULL|TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL)) {
+		if (cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
+			tlb_op(TLB_V3_FULL, "c6, c0, 0", zero);
+			tlb_op(TLB_V4_U_FULL, "c8, c7, 0", zero);
+			tlb_op(TLB_V4_D_FULL, "c8, c6, 0", zero);
+			tlb_op(TLB_V4_I_FULL, "c8, c5, 0", zero);
+		}
+		put_cpu();
 	}
-	put_cpu();
 
 	tlb_op(TLB_V6_U_ASID, "c8, c7, 2", asid);
 	tlb_op(TLB_V6_D_ASID, "c8, c6, 2", asid);
@@ -461,7 +465,7 @@ static inline void flush_pmd_entry(void *pmd)
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
-	tlb_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
+	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
 
 	if (tlb_flag(TLB_WB))
 		dsb();
@@ -472,7 +476,7 @@ static inline void clean_pmd_entry(void *pmd)
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
-	tlb_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
+	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
 }
 
 #undef tlb_op
