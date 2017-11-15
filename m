From: liuwenliang@huawei.com (Liuwenliang (Abbott Liu))
Date: Wed, 15 Nov 2017 10:20:02 +0000
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <8e959f69-a578-793b-6c32-18b5b0cd08c2@arm.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-2-liuwenliang@huawei.com>
 <227e2c6e-f479-849d-8942-1d5ff4ccd440@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063172@dggemm510-mbs.china.huawei.com>
 <8e959f69-a578-793b-6c32-18b5b0cd08c2@arm.com>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0063545@dggemm510-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/17 18:11, Marc Zyngier [mailto:marc.zyngier at arm.com] wrote:
>On 09/11/17 07:46, Liuwenliang (Abbott Liu) wrote:
>> diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
>> index 049ee0a..359a782 100644
>> --- a/arch/arm/mm/kasan_init.c
>> +++ b/arch/arm/mm/kasan_init.c
>> @@ -15,6 +15,7 @@
>>  #include <asm/proc-fns.h>
>>  #include <asm/tlbflush.h>
>>  #include <asm/cp15.h>
>> +#include <asm/kvm_hyp.h>
>
>No, please don't do that. You shouldn't have to include KVM stuff in
>unrelated code. Instead of adding stuff to kvm_hyp.h, move all the
>__ACCESS_CP15* to cp15.h, and it will be obvious to everyone that this
>is where new definition should be added.

Thanks for your review.
You are right. It is better to move __ACCESS_CP15* to cp15.h than to include
kvm_hyp.h. But I don't think it is a good idea to move registers definition which
is used in virtualization to cp15.h, Because there is no virtualization stuff in
cp15.h.

Here is the code which I tested on vexpress_a15 and vexpress_a9:
diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index dbdbce1..6db1f51 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -64,6 +64,43 @@
 #define __write_sysreg(v, r, w, c, t)  asm volatile(w " " c : : "r" ((t)(v)))
 #define write_sysreg(v, ...)           __write_sysreg(v, __VA_ARGS__)

+#ifdef CONFIG_ARM_LPAE
+#define TTBR0           __ACCESS_CP15_64(0, c2)
+#define TTBR1           __ACCESS_CP15_64(1, c2)
+#define PAR             __ACCESS_CP15_64(0, c7)
+#else
+#define TTBR0           __ACCESS_CP15(c2, 0, c0, 0)
+#define TTBR1           __ACCESS_CP15(c2, 0, c0, 1)
+#define PAR             __ACCESS_CP15(c7, 0, c4, 0)
+#endif
+#define MIDR            __ACCESS_CP15(c0, 0, c0, 0)
+#define CSSELR          __ACCESS_CP15(c0, 2, c0, 0)
+#define SCTLR           __ACCESS_CP15(c1, 0, c0, 0)
+#define CPACR           __ACCESS_CP15(c1, 0, c0, 2)
+#define TTBCR           __ACCESS_CP15(c2, 0, c0, 2)
+#define DACR            __ACCESS_CP15(c3, 0, c0, 0)
+#define DFSR            __ACCESS_CP15(c5, 0, c0, 0)
+#define IFSR            __ACCESS_CP15(c5, 0, c0, 1)
+#define ADFSR           __ACCESS_CP15(c5, 0, c1, 0)
+#define AIFSR           __ACCESS_CP15(c5, 0, c1, 1)
+#define DFAR            __ACCESS_CP15(c6, 0, c0, 0)
+#define IFAR            __ACCESS_CP15(c6, 0, c0, 2)
+#define ICIALLUIS       __ACCESS_CP15(c7, 0, c1, 0)
+#define ATS1CPR         __ACCESS_CP15(c7, 0, c8, 0)
+#define TLBIALLIS       __ACCESS_CP15(c8, 0, c3, 0)
+#define TLBIALL         __ACCESS_CP15(c8, 0, c7, 0)
+#define TLBIALLNSNHIS   __ACCESS_CP15(c8, 4, c3, 4)
+#define PRRR            __ACCESS_CP15(c10, 0, c2, 0)
+#define NMRR            __ACCESS_CP15(c10, 0, c2, 1)
+#define AMAIR0          __ACCESS_CP15(c10, 0, c3, 0)
+#define AMAIR1          __ACCESS_CP15(c10, 0, c3, 1)
+#define CID             __ACCESS_CP15(c13, 0, c0, 1)
+#define TID_URW         __ACCESS_CP15(c13, 0, c0, 2)
+#define TID_URO         __ACCESS_CP15(c13, 0, c0, 3)
+#define TID_PRIV        __ACCESS_CP15(c13, 0, c0, 4)
+#define CNTKCTL         __ACCESS_CP15(c14, 0, c1, 0)
+#define CNTHCTL         __ACCESS_CP15(c14, 4, c1, 0)
+
 extern unsigned long cr_alignment;     /* defined in entry-armv.S */

 static inline unsigned long get_cr(void)
diff --git a/arch/arm/include/asm/kvm_hyp.h b/arch/arm/include/asm/kvm_hyp.h
index 14b5903..db8d8db 100644
--- a/arch/arm/include/asm/kvm_hyp.h
+++ b/arch/arm/include/asm/kvm_hyp.h
@@ -37,55 +37,25 @@
        __val;                                                  \
 })

-#define TTBR0              __ACCESS_CP15_64(0, c2)
-#define TTBR1              __ACCESS_CP15_64(1, c2)
 #define VTTBR          __ACCESS_CP15_64(6, c2)
-#define PAR                __ACCESS_CP15_64(0, c7)
 #define CNTV_CVAL      __ACCESS_CP15_64(3, c14)
 #define CNTVOFF                __ACCESS_CP15_64(4, c14)

-#define MIDR               __ACCESS_CP15(c0, 0, c0, 0)
-#define CSSELR             __ACCESS_CP15(c0, 2, c0, 0)
 #define VPIDR          __ACCESS_CP15(c0, 4, c0, 0)
 #define VMPIDR         __ACCESS_CP15(c0, 4, c0, 5)
-#define SCTLR              __ACCESS_CP15(c1, 0, c0, 0)
-#define CPACR              __ACCESS_CP15(c1, 0, c0, 2)
 #define HCR            __ACCESS_CP15(c1, 4, c1, 0)
 #define HDCR           __ACCESS_CP15(c1, 4, c1, 1)
 #define HCPTR          __ACCESS_CP15(c1, 4, c1, 2)
 #define HSTR           __ACCESS_CP15(c1, 4, c1, 3)
-#define TTBCR              __ACCESS_CP15(c2, 0, c0, 2)
 #define HTCR           __ACCESS_CP15(c2, 4, c0, 2)
 #define VTCR           __ACCESS_CP15(c2, 4, c1, 2)
-#define DACR               __ACCESS_CP15(c3, 0, c0, 0)
-#define DFSR               __ACCESS_CP15(c5, 0, c0, 0)
-#define IFSR               __ACCESS_CP15(c5, 0, c0, 1)
-#define ADFSR              __ACCESS_CP15(c5, 0, c1, 0)
-#define AIFSR              __ACCESS_CP15(c5, 0, c1, 1)
 #define HSR            __ACCESS_CP15(c5, 4, c2, 0)
-#define DFAR               __ACCESS_CP15(c6, 0, c0, 0)
-#define IFAR               __ACCESS_CP15(c6, 0, c0, 2)
 #define HDFAR          __ACCESS_CP15(c6, 4, c0, 0)
 #define HIFAR          __ACCESS_CP15(c6, 4, c0, 2)
 #define HPFAR          __ACCESS_CP15(c6, 4, c0, 4)
-#define ICIALLUIS  __ACCESS_CP15(c7, 0, c1, 0)
-#define ATS1CPR            __ACCESS_CP15(c7, 0, c8, 0)
-#define TLBIALLIS  __ACCESS_CP15(c8, 0, c3, 0)
-#define TLBIALL            __ACCESS_CP15(c8, 0, c7, 0)
-#define TLBIALLNSNHIS      __ACCESS_CP15(c8, 4, c3, 4)
-#define PRRR               __ACCESS_CP15(c10, 0, c2, 0)
-#define NMRR               __ACCESS_CP15(c10, 0, c2, 1)
-#define AMAIR0             __ACCESS_CP15(c10, 0, c3, 0)
-#define AMAIR1             __ACCESS_CP15(c10, 0, c3, 1)
 #define VBAR           __ACCESS_CP15(c12, 0, c0, 0)
-#define CID                __ACCESS_CP15(c13, 0, c0, 1)
-#define TID_URW            __ACCESS_CP15(c13, 0, c0, 2)
-#define TID_URO            __ACCESS_CP15(c13, 0, c0, 3)
-#define TID_PRIV   __ACCESS_CP15(c13, 0, c0, 4)
 #define HTPIDR         __ACCESS_CP15(c13, 4, c0, 2)
-#define CNTKCTL            __ACCESS_CP15(c14, 0, c1, 0)
 #define CNTV_CTL       __ACCESS_CP15(c14, 0, c3, 1)
-#define CNTHCTL            __ACCESS_CP15(c14, 4, c1, 0)

 #define VFP_FPEXC      __ACCESS_VFP(FPEXC)
