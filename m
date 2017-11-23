From: liuwenliang@huawei.com (Liuwenliang (Abbott Liu))
Date: Thu, 23 Nov 2017 01:54:59 +0000
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <757534e5-fcea-3eb4-3c8d-b8c7e709f555@arm.com>
References: <bbf43f92-3d0c-940d-b66b-68f92eb9b282@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C00635F3@dggemm510-mbs.china.huawei.com>
 <87po8ir1kg.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C006371B@dggemm510-mbs.china.huawei.com>
 <87375eqobb.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063816@dggemm510-mbs.china.huawei.com>
 <20171117073556.GB28855@cbox>
 <B8AC3E80E903784988AB3003E3E97330C00638D4@dggemm510-mbs.china.huawei.com>
 <20171118134841.3f6c9183@why.wild-wind.fr.eu.org>
 <B8AC3E80E903784988AB3003E3E97330C0068F12@dggemm510-mbx.china.huawei.com>
 <20171121122938.sydii3i36jbzi7x4@lakrids.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0069032@dggemm510-mbx.china.huawei.com>
 <757534e5-fcea-3eb4-3c8d-b8c7e709f555@arm.com>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0069083@dggemm510-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 23, 2017  20:30  Marc Zyngier [mailto:marc.zyngier at arm.com]  wrote:
>Please define both PAR accessors. Yes, I know the 32bit version is not
>used yet, but it doesn't hurt to make it visible.

Thanks for your review.
I'm going to change it in the new version.
Here is the code I tested on vexpress_a9 and vexpress_a15:
diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index dbdbce1..b8353b1 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -2,6 +2,7 @@
 #define __ASM_ARM_CP15_H

 #include <asm/barrier.h>
+#include <linux/stringify.h>

 /*
  * CR1 bits (CP#15 CR1)
@@ -64,8 +65,109 @@
 #define __write_sysreg(v, r, w, c, t)  asm volatile(w " " c : : "r" ((t)(v)))
 #define write_sysreg(v, ...)           __write_sysreg(v, __VA_ARGS__)

+#define TTBR0_32     __ACCESS_CP15(c2, 0, c0, 0)
+#define TTBR1_32     __ACCESS_CP15(c2, 0, c0, 1)
+#define PAR_32               __ACCESS_CP15(c7, 0, c4, 0)
+#define TTBR0_64     __ACCESS_CP15_64(0, c2)
+#define TTBR1_64     __ACCESS_CP15_64(1, c2)
+#define PAR_64               __ACCESS_CP15_64(0, c7)
+#define VTTBR           __ACCESS_CP15_64(6, c2)
+#define CNTV_CVAL       __ACCESS_CP15_64(3, c14)
+#define CNTVOFF         __ACCESS_CP15_64(4, c14)
+
+#define MIDR            __ACCESS_CP15(c0, 0, c0, 0)
+#define CSSELR          __ACCESS_CP15(c0, 2, c0, 0)
+#define VPIDR           __ACCESS_CP15(c0, 4, c0, 0)
+#define VMPIDR          __ACCESS_CP15(c0, 4, c0, 5)
+#define SCTLR           __ACCESS_CP15(c1, 0, c0, 0)
+#define CPACR           __ACCESS_CP15(c1, 0, c0, 2)
+#define HCR             __ACCESS_CP15(c1, 4, c1, 0)
+#define HDCR            __ACCESS_CP15(c1, 4, c1, 1)
+#define HCPTR           __ACCESS_CP15(c1, 4, c1, 2)
+#define HSTR            __ACCESS_CP15(c1, 4, c1, 3)
+#define TTBCR           __ACCESS_CP15(c2, 0, c0, 2)
+#define HTCR            __ACCESS_CP15(c2, 4, c0, 2)
+#define VTCR            __ACCESS_CP15(c2, 4, c1, 2)
+#define DACR            __ACCESS_CP15(c3, 0, c0, 0)
+#define DFSR            __ACCESS_CP15(c5, 0, c0, 0)
+#define IFSR            __ACCESS_CP15(c5, 0, c0, 1)
+#define ADFSR           __ACCESS_CP15(c5, 0, c1, 0)
+#define AIFSR           __ACCESS_CP15(c5, 0, c1, 1)
+#define HSR             __ACCESS_CP15(c5, 4, c2, 0)
+#define DFAR            __ACCESS_CP15(c6, 0, c0, 0)
+#define IFAR            __ACCESS_CP15(c6, 0, c0, 2)
+#define HDFAR           __ACCESS_CP15(c6, 4, c0, 0)
+#define HIFAR           __ACCESS_CP15(c6, 4, c0, 2)
+#define HPFAR           __ACCESS_CP15(c6, 4, c0, 4)
+#define ICIALLUIS       __ACCESS_CP15(c7, 0, c1, 0)
+#define ATS1CPR         __ACCESS_CP15(c7, 0, c8, 0)
+#define TLBIALLIS       __ACCESS_CP15(c8, 0, c3, 0)
+#define TLBIALL         __ACCESS_CP15(c8, 0, c7, 0)
+#define TLBIALLNSNHIS   __ACCESS_CP15(c8, 4, c3, 4)
+#define PRRR            __ACCESS_CP15(c10, 0, c2, 0)
+#define NMRR            __ACCESS_CP15(c10, 0, c2, 1)
+#define AMAIR0          __ACCESS_CP15(c10, 0, c3, 0)
+#define AMAIR1          __ACCESS_CP15(c10, 0, c3, 1)
+#define VBAR            __ACCESS_CP15(c12, 0, c0, 0)
+#define CID             __ACCESS_CP15(c13, 0, c0, 1)
+#define TID_URW         __ACCESS_CP15(c13, 0, c0, 2)
+#define TID_URO         __ACCESS_CP15(c13, 0, c0, 3)
+#define TID_PRIV        __ACCESS_CP15(c13, 0, c0, 4)
+#define HTPIDR          __ACCESS_CP15(c13, 4, c0, 2)
+#define CNTKCTL         __ACCESS_CP15(c14, 0, c1, 0)
+#define CNTV_CTL        __ACCESS_CP15(c14, 0, c3, 1)
+#define CNTHCTL         __ACCESS_CP15(c14, 4, c1, 0)
+
 extern unsigned long cr_alignment;     /* defined in entry-armv.S */

+static inline void set_par(u64 val)
+{
+        if (IS_ENABLED(CONFIG_ARM_LPAE))
+                write_sysreg(val, PAR_64);
+        else
+                write_sysreg(val, PAR_32);
+}
+
+static inline u64 get_par(void)
+{
+        if (IS_ENABLED(CONFIG_ARM_LPAE))
+                return read_sysreg(PAR_64);
+        else
+                return (u64)read_sysreg(PAR_32);
+}
+
+static inline void set_ttbr0(u64 val)
+{
+ if (IS_ENABLED(CONFIG_ARM_LPAE))
+         write_sysreg(val, TTBR0_64);
+ else
+         write_sysreg(val, TTBR0_32);
+}
+
+static inline u64 get_ttbr0(void)
+{
+ if (IS_ENABLED(CONFIG_ARM_LPAE))
+         return read_sysreg(TTBR0_64);
+ else
+         return (u64)read_sysreg(TTBR0_32);
+}
+
+static inline void set_ttbr1(u64 val)
+{
+ if (IS_ENABLED(CONFIG_ARM_LPAE))
+         write_sysreg(val, TTBR1_64);
+ else
+         write_sysreg(val, TTBR1_32);
+}
+
+static inline u64 get_ttbr1(void)
+{
+ if (IS_ENABLED(CONFIG_ARM_LPAE))
+         return read_sysreg(TTBR1_64);
+ else
+         return (u64)read_sysreg(TTBR1_32);
+}
+
 static inline unsigned long get_cr(void)
 {
        unsigned long val;
diff --git a/arch/arm/include/asm/kvm_hyp.h b/arch/arm/include/asm/kvm_hyp.h
index 14b5903..8db8a8c 100644
--- a/arch/arm/include/asm/kvm_hyp.h
+++ b/arch/arm/include/asm/kvm_hyp.h
@@ -37,56 +37,6 @@
        __val;                                                  \
 })

-#define TTBR0              __ACCESS_CP15_64(0, c2)
-#define TTBR1              __ACCESS_CP15_64(1, c2)
-#define VTTBR              __ACCESS_CP15_64(6, c2)
-#define PAR                __ACCESS_CP15_64(0, c7)
-#define CNTV_CVAL  __ACCESS_CP15_64(3, c14)
-#define CNTVOFF            __ACCESS_CP15_64(4, c14)
-
-#define MIDR               __ACCESS_CP15(c0, 0, c0, 0)
-#define CSSELR             __ACCESS_CP15(c0, 2, c0, 0)
-#define VPIDR              __ACCESS_CP15(c0, 4, c0, 0)
-#define VMPIDR             __ACCESS_CP15(c0, 4, c0, 5)
-#define SCTLR              __ACCESS_CP15(c1, 0, c0, 0)
-#define CPACR              __ACCESS_CP15(c1, 0, c0, 2)
-#define HCR                __ACCESS_CP15(c1, 4, c1, 0)
-#define HDCR               __ACCESS_CP15(c1, 4, c1, 1)
-#define HCPTR              __ACCESS_CP15(c1, 4, c1, 2)
-#define HSTR               __ACCESS_CP15(c1, 4, c1, 3)
-#define TTBCR              __ACCESS_CP15(c2, 0, c0, 2)
-#define HTCR               __ACCESS_CP15(c2, 4, c0, 2)
-#define VTCR               __ACCESS_CP15(c2, 4, c1, 2)
-#define DACR               __ACCESS_CP15(c3, 0, c0, 0)
-#define DFSR               __ACCESS_CP15(c5, 0, c0, 0)
-#define IFSR               __ACCESS_CP15(c5, 0, c0, 1)
-#define ADFSR              __ACCESS_CP15(c5, 0, c1, 0)
-#define AIFSR              __ACCESS_CP15(c5, 0, c1, 1)
-#define HSR                __ACCESS_CP15(c5, 4, c2, 0)
-#define DFAR               __ACCESS_CP15(c6, 0, c0, 0)
-#define IFAR               __ACCESS_CP15(c6, 0, c0, 2)
-#define HDFAR              __ACCESS_CP15(c6, 4, c0, 0)
-#define HIFAR              __ACCESS_CP15(c6, 4, c0, 2)
-#define HPFAR              __ACCESS_CP15(c6, 4, c0, 4)
-#define ICIALLUIS  __ACCESS_CP15(c7, 0, c1, 0)
-#define ATS1CPR            __ACCESS_CP15(c7, 0, c8, 0)
-#define TLBIALLIS  __ACCESS_CP15(c8, 0, c3, 0)
-#define TLBIALL            __ACCESS_CP15(c8, 0, c7, 0)
-#define TLBIALLNSNHIS      __ACCESS_CP15(c8, 4, c3, 4)
-#define PRRR               __ACCESS_CP15(c10, 0, c2, 0)
-#define NMRR               __ACCESS_CP15(c10, 0, c2, 1)
-#define AMAIR0             __ACCESS_CP15(c10, 0, c3, 0)
-#define AMAIR1             __ACCESS_CP15(c10, 0, c3, 1)
-#define VBAR               __ACCESS_CP15(c12, 0, c0, 0)
-#define CID                __ACCESS_CP15(c13, 0, c0, 1)
-#define TID_URW            __ACCESS_CP15(c13, 0, c0, 2)
-#define TID_URO            __ACCESS_CP15(c13, 0, c0, 3)
-#define TID_PRIV   __ACCESS_CP15(c13, 0, c0, 4)
-#define HTPIDR             __ACCESS_CP15(c13, 4, c0, 2)
-#define CNTKCTL            __ACCESS_CP15(c14, 0, c1, 0)
-#define CNTV_CTL   __ACCESS_CP15(c14, 0, c3, 1)
-#define CNTHCTL            __ACCESS_CP15(c14, 4, c1, 0)
-
 #define VFP_FPEXC      __ACCESS_VFP(FPEXC)

 /* AArch64 compatibility macros, only for the timer so far */
diff --git a/arch/arm/kvm/hyp/cp15-sr.c b/arch/arm/kvm/hyp/cp15-sr.c
index c478281..d365e3c 100644
--- a/arch/arm/kvm/hyp/cp15-sr.c
+++ b/arch/arm/kvm/hyp/cp15-sr.c
@@ -31,8 +31,8 @@ void __hyp_text __sysreg_save_state(struct kvm_cpu_context *ctxt)
        ctxt->cp15[c0_CSSELR]           = read_sysreg(CSSELR);
        ctxt->cp15[c1_SCTLR]            = read_sysreg(SCTLR);
        ctxt->cp15[c1_CPACR]            = read_sysreg(CPACR);
-   *cp15_64(ctxt, c2_TTBR0)        = read_sysreg(TTBR0);
-   *cp15_64(ctxt, c2_TTBR1)        = read_sysreg(TTBR1);
+ *cp15_64(ctxt, c2_TTBR0)    = read_sysreg(TTBR0_64);
+ *cp15_64(ctxt, c2_TTBR1)    = read_sysreg(TTBR1_64);
        ctxt->cp15[c2_TTBCR]            = read_sysreg(TTBCR);
        ctxt->cp15[c3_DACR]             = read_sysreg(DACR);
        ctxt->cp15[c5_DFSR]             = read_sysreg(DFSR);
@@ -41,7 +41,7 @@ void __hyp_text __sysreg_save_state(struct kvm_cpu_context *ctxt)
        ctxt->cp15[c5_AIFSR]            = read_sysreg(AIFSR);
        ctxt->cp15[c6_DFAR]             = read_sysreg(DFAR);
        ctxt->cp15[c6_IFAR]             = read_sysreg(IFAR);
-   *cp15_64(ctxt, c7_PAR)          = read_sysreg(PAR);
+ *cp15_64(ctxt, c7_PAR)              = read_sysreg(PAR_64);
        ctxt->cp15[c10_PRRR]            = read_sysreg(PRRR);
        ctxt->cp15[c10_NMRR]            = read_sysreg(NMRR);
        ctxt->cp15[c10_AMAIR0]          = read_sysreg(AMAIR0);
@@ -60,8 +60,8 @@ void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
        write_sysreg(ctxt->cp15[c0_CSSELR],     CSSELR);
        write_sysreg(ctxt->cp15[c1_SCTLR],      SCTLR);
        write_sysreg(ctxt->cp15[c1_CPACR],      CPACR);
-   write_sysreg(*cp15_64(ctxt, c2_TTBR0),  TTBR0);
-   write_sysreg(*cp15_64(ctxt, c2_TTBR1),  TTBR1);
+ write_sysreg(*cp15_64(ctxt, c2_TTBR0),      TTBR0_64);
+ write_sysreg(*cp15_64(ctxt, c2_TTBR1),      TTBR1_64);
        write_sysreg(ctxt->cp15[c2_TTBCR],      TTBCR);
        write_sysreg(ctxt->cp15[c3_DACR],       DACR);
        write_sysreg(ctxt->cp15[c5_DFSR],       DFSR);
@@ -70,7 +70,7 @@ void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
        write_sysreg(ctxt->cp15[c5_AIFSR],      AIFSR);
        write_sysreg(ctxt->cp15[c6_DFAR],       DFAR);
        write_sysreg(ctxt->cp15[c6_IFAR],       IFAR);
-   write_sysreg(*cp15_64(ctxt, c7_PAR),    PAR);
+ write_sysreg(*cp15_64(ctxt, c7_PAR),        PAR_64);
        write_sysreg(ctxt->cp15[c10_PRRR],      PRRR);
        write_sysreg(ctxt->cp15[c10_NMRR],      NMRR);
        write_sysreg(ctxt->cp15[c10_AMAIR0],    AMAIR0);
diff --git a/arch/arm/kvm/hyp/switch.c b/arch/arm/kvm/hyp/switch.c
index ebd2dd4..4879588 100644
--- a/arch/arm/kvm/hyp/switch.c
+++ b/arch/arm/kvm/hyp/switch.c
@@ -133,12 +133,12 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
        if (!(hsr & HSR_DABT_S1PTW) && (hsr & HSR_FSC_TYPE) == FSC_PERM) {
                u64 par, tmp;

-           par = read_sysreg(PAR);
+         par = read_sysreg(PAR_64);
                write_sysreg(far, ATS1CPR);
                isb();

-           tmp = read_sysreg(PAR);
-           write_sysreg(par, PAR);
+         tmp = read_sysreg(PAR_64);
+         write_sysreg(par, PAR_64);

                if (unlikely(tmp & 1))
                        return false; /* Translation failed, back to guest */
diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 049ee0a..87c86c7 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -203,16 +203,16 @@ void __init kasan_init(void)
        u64 orig_ttbr0;
        int i;

-   orig_ttbr0 = cpu_get_ttbr(0);
+ orig_ttbr0 = get_ttbr0();

 #ifdef CONFIG_ARM_LPAE
        memcpy(tmp_pmd_table, pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_START)), sizeof(tmp_pmd_table));
        memcpy(tmp_page_table, swapper_pg_dir, sizeof(tmp_page_table));
        set_pgd(&tmp_page_table[pgd_index(KASAN_SHADOW_START)], __pgd(__pa(tmp_pmd_table) | PMD_TYPE_TABLE | L_PGD_SWAPPER));
-   cpu_set_ttbr0(__pa(tmp_page_table));
+ set_ttbr0(__pa(tmp_page_table));
 #else
        memcpy(tmp_page_table, swapper_pg_dir, sizeof(tmp_page_table));
-   cpu_set_ttbr0(__pa(tmp_page_table));
+ set_ttbr0((u64)__pa(tmp_page_table));
 #endif
        flush_cache_all();
        local_flush_bp_all();
@@ -257,7 +257,7 @@ void __init kasan_init(void)
                                 /*__pgprot(_L_PTE_DEFAULT | L_PTE_DIRTY | L_PTE_XN | L_PTE_RDONLY))*/
                                __pgprot(pgprot_val(PAGE_KERNEL) | L_PTE_RDONLY)));
        memset(kasan_zero_page, 0, PAGE_SIZE);
-   cpu_set_ttbr0(orig_ttbr0);
+ set_ttbr0(orig_ttbr0);
        flush_cache_all();
        local_flush_bp_all();
        local_flush_tlb_all();



-----????-----
???: Marc Zyngier [mailto:marc.zyngier at arm.com] 
????: 2017?11?22? 21:06
???: Liuwenliang (Abbott Liu); Mark Rutland
??: tixy at linaro.org; mhocko at suse.com; grygorii.strashko at linaro.org; catalin.marinas at arm.com; linux-mm at kvack.org; glider at google.com; afzal.mohd.ma at gmail.com; mingo at kernel.org; Christoffer Dall; f.fainelli at gmail.com; mawilcox at microsoft.com; linux at armlinux.org.uk; kasan-dev at googlegroups.com; Dailei; linux-arm-kernel at lists.infradead.org; aryabinin at virtuozzo.com; labbott at redhat.com; vladimir.murzin at arm.com; keescook at chromium.org; arnd at arndb.de; Zengweilin; opendmb at gmail.com; Heshaoliang; tglx at linutronix.de; dvyukov at google.com; ard.biesheuvel at linaro.org; linux-kernel at vger.kernel.org; Jiazhenghua; akpm at linux-foundation.org; robin.murphy at arm.com; thgarnie at google.com; kirill.shutemov at linux.intel.com
??: Re: [PATCH 01/11] Initialize the mapping of KASan shadow memory

On 22/11/17 12:56, Liuwenliang (Abbott Liu) wrote:
> On Nov 22, 2017  20:30  Mark Rutland [mailto:mark.rutland at arm.com] wrote:
>> On Tue, Nov 21, 2017 at 07:59:01AM +0000, Liuwenliang (Abbott Liu) wrote:
>>> On Nov 17, 2017  21:49  Marc Zyngier [mailto:marc.zyngier at arm.com]  wrote:
>>>> On Sat, 18 Nov 2017 10:40:08 +0000
>>>> "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com> wrote:
>>>>> On Nov 17, 2017  15:36 Christoffer Dall [mailto:cdall at linaro.org]  wrote:
> 
>>> Please don't ask people to limit to 4GB of physical space on CPU
>>> supporting LPAE, please don't ask people to guaranteed to have some
>>> memory below 4GB on CPU supporting LPAE.
> 
>> I don't think that Marc is suggesting that you'd always use the 32-bit
>> accessors on an LPAE system, just that all the definitions should exist
>> regardless of configuration.
> 
>> So rather than this:
> 
>>> +#ifdef CONFIG_ARM_LPAE
>>> +#define TTBR0           __ACCESS_CP15_64(0, c2)
>>> +#define TTBR1           __ACCESS_CP15_64(1, c2)
>>> +#define PAR             __ACCESS_CP15_64(0, c7)
>>> +#else
>>> +#define TTBR0           __ACCESS_CP15(c2, 0, c0, 0)
>>> +#define TTBR1           __ACCESS_CP15(c2, 0, c0, 1)
>>> +#define PAR             __ACCESS_CP15(c7, 0, c4, 0)
>>> +#endif
> 
>> ... you'd have the following in cp15.h:
> 
>> #define TTBR0_64       __ACCESS_CP15_64(0, c2)
>> #define TTBR1_64       __ACCESS_CP15_64(1, c2)
>> #define PAR_64         __ACCESS_CP15_64(0, c7)
> 
>> #define TTBR0_32       __ACCESS_CP15(c2, 0, c0, 0)
>> #define TTBR1_32       __ACCESS_CP15(c2, 0, c0, 1)
>> #define PAR_32         __ACCESS_CP15(c7, 0, c4, 0)
> 
>> ... and elsewhere, where it matters, we choose which to use depending on
>> the kernel configuration, e.g.
> 
>> void set_ttbr0(u64 val)
>> {
>>       if (IS_ENABLED(CONFIG_ARM_LPAE))
>>               write_sysreg(val, TTBR0_64);
>>       else
>>               write_sysreg(val, TTBR0_32);
>> }
> 
>> Thanks,
>> Mark.
> 
> Thanks for your solution.
> I didn't know there was a IS_ENABLED macro that I can use, so I can't write a function 
> like:
> void set_ttbr0(u64 val)
> {
>        if (IS_ENABLED(CONFIG_ARM_LPAE))
>                write_sysreg(val, TTBR0_64);
>        else
>                write_sysreg(val, TTBR0_32);
> }
> 
> 
> Here is the code I tested on vexpress_a9 and vexpress_a15:
> diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
> index dbdbce1..5eb0185 100644
> --- a/arch/arm/include/asm/cp15.h
> +++ b/arch/arm/include/asm/cp15.h
> @@ -2,6 +2,7 @@
>  #define __ASM_ARM_CP15_H
> 
>  #include <asm/barrier.h>
> +#include <linux/stringify.h>
> 
>  /*
>   * CR1 bits (CP#15 CR1)
> @@ -64,8 +65,93 @@
>  #define __write_sysreg(v, r, w, c, t)  asm volatile(w " " c : : "r" ((t)(v)))
>  #define write_sysreg(v, ...)           __write_sysreg(v, __VA_ARGS__)
> 
> +#define TTBR0_32           __ACCESS_CP15(c2, 0, c0, 0)
> +#define TTBR1_32           __ACCESS_CP15(c2, 0, c0, 1)
> +#define TTBR0_64           __ACCESS_CP15_64(0, c2)
> +#define TTBR1_64           __ACCESS_CP15_64(1, c2)
> +#define PAR             __ACCESS_CP15_64(0, c7)

Please define both PAR accessors. Yes, I know the 32bit version is not
used yet, but it doesn't hurt to make it visible.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
