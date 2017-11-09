From: liuwenliang@huawei.com (Liuwenliang (Abbott Liu))
Date: Thu, 9 Nov 2017 07:46:39 +0000
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <227e2c6e-f479-849d-8942-1d5ff4ccd440@arm.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-2-liuwenliang@huawei.com>
 <227e2c6e-f479-849d-8942-1d5ff4ccd440@arm.com>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0063172@dggemm510-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/17 15:59, Marc Zyngier [mailto:marc.zyngier at arm.com] wrote:
> On 11/10/17 09:22, Abbott Liu wrote:
>> diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
>> index f2e1af4..6e26714 100644
>> --- a/arch/arm/include/asm/proc-fns.h
>> +++ b/arch/arm/include/asm/proc-fns.h
>> @@ -131,6 +131,15 @@ extern void cpu_resume(void);
>>  		pg &= ~(PTRS_PER_PGD*sizeof(pgd_t)-1);	\
>>  		(pgd_t *)phys_to_virt(pg);		\
>>  	})
>> +
>> +#define cpu_set_ttbr0(val)					\
>> +	do {							\
>> +		u64 ttbr = val;					\
>> +		__asm__("mcrr	p15, 0, %Q0, %R0, c2"		\
>> +			: : "r" (ttbr));	\
>> +	} while (0)
>> +
>> +
>>  #else
>>  #define cpu_get_pgd()	\
>>  	({						\
>> @@ -140,6 +149,30 @@ extern void cpu_resume(void);
>>  		pg &= ~0x3fff;				\
>>  		(pgd_t *)phys_to_virt(pg);		\
>>  	})
>> +
>> +#define cpu_set_ttbr(nr, val)					\
>> +	do {							\
>> +		u64 ttbr = val;					\
>> +		__asm__("mcr	p15, 0, %0, c2, c0, 0"		\
>> +			: : "r" (ttbr));			\
>> +	} while (0)
>> +
>> +#define cpu_get_ttbr(nr)					\
>> +	({							\
>> +		unsigned long ttbr;				\
>> +		__asm__("mrc	p15, 0, %0, c2, c0, 0"		\
>> +			: "=r" (ttbr));				\
>> +		ttbr;						\
>> +	})
>> +
>> +#define cpu_set_ttbr0(val)					\
>> +	do {							\
>> +		u64 ttbr = val;					\
>> +		__asm__("mcr	p15, 0, %0, c2, c0, 0"		\
>> +			: : "r" (ttbr));			\
>> +	} while (0)
>> +
>> +
>
>You could instead lift and extend the definitions provided in kvm_hyp.h,
>and use the read_sysreg/write_sysreg helpers defined in cp15.h.

Thanks for your review. 
I extend definitions of TTBR0/TTBR1/PAR in kvm_hyp.h when the CONFIG_ARM_LPAE is 
not defined. 
Because cortex A9 don't support virtualization, so use CONFIG_ARM_LPAE to exclude
some functions and macros which are only used in virtualization.

Here is the code which I tested on vexpress_a15 and vexpress_a9:

diff --git a/arch/arm/include/asm/kvm_hyp.h b/arch/arm/include/asm/kvm_hyp.h
index 14b5903..2592608 100644
--- a/arch/arm/include/asm/kvm_hyp.h
+++ b/arch/arm/include/asm/kvm_hyp.h
@@ -19,12 +19,14 @@
 #define __ARM_KVM_HYP_H__

 #include <linux/compiler.h>
-#include <linux/kvm_host.h>
 #include <asm/cp15.h>
+
+#ifdef CONFIG_ARM_LPAE
+#include <linux/kvm_host.h>
 #include <asm/kvm_mmu.h>
 #include <asm/vfp.h>
-
 #define __hyp_text __section(.hyp.text) notrace
+#endif

 #define __ACCESS_VFP(CRn)                      \
        "mrc", "mcr", __stringify(p10, 7, %0, CRn, cr0, 0), u32
@@ -37,12 +39,18 @@
        __val;                                                  \
 })

+#ifdef CONFIG_ARM_LPAE
 #define TTBR0          __ACCESS_CP15_64(0, c2)
 #define TTBR1          __ACCESS_CP15_64(1, c2)
 #define VTTBR          __ACCESS_CP15_64(6, c2)
 #define PAR            __ACCESS_CP15_64(0, c7)
 #define CNTV_CVAL      __ACCESS_CP15_64(3, c14)
 #define CNTVOFF                __ACCESS_CP15_64(4, c14)
+#else
+#define TTBR0           __ACCESS_CP15(c2, 0, c0, 0)
+#define TTBR1           __ACCESS_CP15(c2, 0, c0, 1)
+#define PAR          __ACCESS_CP15(c7, 0, c4, 0)
+#endif

 #define MIDR           __ACCESS_CP15(c0, 0, c0, 0)
 #define CSSELR         __ACCESS_CP15(c0, 2, c0, 0)
@@ -98,6 +106,7 @@
 #define cntvoff_el2                    CNTVOFF
 #define cnthctl_el2                    CNTHCTL

+#ifdef CONFIG_ARM_LPAE
 void __timer_save_state(struct kvm_vcpu *vcpu);
 void __timer_restore_state(struct kvm_vcpu *vcpu);

@@ -123,5 +132,6 @@ void __hyp_text __banked_restore_state(struct kvm_cpu_context *ctxt);
 asmlinkage int __guest_enter(struct kvm_vcpu *vcpu,
                             struct kvm_cpu_context *host);
 asmlinkage int __hyp_do_panic(const char *, int, u32);
+#endif

 #endif /* __ARM_KVM_HYP_H__ */
diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 049ee0a..359a782 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -15,6 +15,7 @@
 #include <asm/proc-fns.h>
 #include <asm/tlbflush.h>
 #include <asm/cp15.h>
+#include <asm/kvm_hyp.h>
 #include <linux/sched/task.h>

 #include "mm.h"
@@ -203,16 +204,16 @@ void __init kasan_init(void)
        u64 orig_ttbr0;
        int i;

-   orig_ttbr0 = cpu_get_ttbr(0);
+ orig_ttbr0 = read_sysreg(TTBR0);

 #ifdef CONFIG_ARM_LPAE
        memcpy(tmp_pmd_table, pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_START)), sizeof(tmp_pmd_table));
        memcpy(tmp_page_table, swapper_pg_dir, sizeof(tmp_page_table));
        set_pgd(&tmp_page_table[pgd_index(KASAN_SHADOW_START)], __pgd(__pa(tmp_pmd_table) | PMD_TYPE_TABLE | L_PGD_SWAPPER));
-   cpu_set_ttbr0(__pa(tmp_page_table));
+ write_sysreg(__pa(tmp_page_table), TTBR0);
 #else
        memcpy(tmp_page_table, swapper_pg_dir, sizeof(tmp_page_table));
-   cpu_set_ttbr0(__pa(tmp_page_table));
+ write_sysreg(__pa(tmp_page_table),TTBR0);
 #endif
        flush_cache_all();
        local_flush_bp_all();
@@ -257,7 +258,7 @@ void __init kasan_init(void)
                                 /*__pgprot(_L_PTE_DEFAULT | L_PTE_DIRTY | L_PTE_XN | L_PTE_RDONLY))*/
                                __pgprot(pgprot_val(PAGE_KERNEL) | L_PTE_RDONLY)));
        memset(kasan_zero_page, 0, PAGE_SIZE);
-   cpu_set_ttbr0(orig_ttbr0);
+ write_sysreg(orig_ttbr0 ,TTBR0);
        flush_cache_all();
        local_flush_bp_all();
        local_flush_tlb_all();
