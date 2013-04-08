From: vladimir.danushevsky@oracle.com (Vladimir Danushevsky)
Date: Mon, 8 Apr 2013 08:34:28 -0400
Subject: [PATCH] Report double word access atomicity on LPAE enabled targets
 through AUXV
Message-ID: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Danushevsky <vladidan@oracle.com>

Hi All,

One of the indirect LPAE features in a single-copy atomicity of LDRD/STRD instructions. This information is useful for some dynamic code generating applications (e.g. JIT compilers) to produce a more efficient access mechanism to atomic/volatile operands. 

The feature is part of the design scheme therefore it's not related to the platform configuration i.e. whether CONFIG_ARM_LPAE is enabled or not.

The patch exposes that information through hwcap entry of an Auxiliary Vector.



Signed-off-by: Vladimir Danushevsky <vladidan@oracle.com>

---

--- linux-3.8.4_vanilla/arch/arm/include/uapi/asm/hwcap.h       2013-03-20 16:11:19.000000000 -0400

+++ linux-3.8.4/arch/arm/include/uapi/asm/hwcap.h       2013-03-26 16:32:18.266043699 -0400

@@ -25,6 +25,7 @@

 #define HWCAP_IDIVT    (1 << 18)

 #define HWCAP_VFPD32   (1 << 19)       /* set if VFP has 32 regs (not 16) */

 #define HWCAP_IDIV     (HWCAP_IDIVA | HWCAP_IDIVT)

+#define HWCAP_ATOMICD   (1 << 20)       /* ldrd/strd single-copy atomicity */



 #endif /* _UAPI__ASMARM_HWCAP_H */


--- linux-3.8.4_vanilla/arch/arm/kernel/setup.c 2013-03-20 16:11:19.000000000 -0400

+++ linux-3.8.4/arch/arm/kernel/setup.c 2013-04-03 15:42:31.580525201 -0400

@@ -487,6 +487,10 @@ static void __init setup_processor(void)

        elf_hwcap &= ~HWCAP_THUMB;

 #endif


+        /* check LPAE presence */ 

+        if (((read_cpuid_ext(CPUID_EXT_MMFR3) >> 28) & 0xf) > 0)

+          elf_hwcap |= HWCAP_ATOMICD;

+

        feat_v6_fixup();


        cacheid_init();

---
