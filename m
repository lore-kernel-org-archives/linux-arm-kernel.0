From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 29 Feb 2016 10:51:57 +1100
Subject: linux-next: manual merge of the arm64 tree with the arm-soc tree
Message-ID: <20160229105157.003bda53@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Today's linux-next merge of the arm64 tree got a conflict in:

  arch/arm64/include/asm/cputype.h

between commit:

  9eb8a2cdf65c ("arm64: cputype info for Broadcom Vulcan")

from the arm-soc tree and commit:

  d5370f754875 ("arm64: prefetch: add alternative pattern for CPUs without a prefetcher")

from the arm64 tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm64/include/asm/cputype.h
index 3dcecdf3d6ee,b3a83da152a7..000000000000
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@@ -76,10 -80,20 +81,22 @@@
  
  #define CAVIUM_CPU_PART_THUNDERX	0x0A1
  
 +#define BRCM_CPU_PART_VULCAN		0x516
 +
+ #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
+ #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
+ #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
+ 
  #ifndef __ASSEMBLY__
  
+ #include <asm/sysreg.h>
+ 
+ #define read_cpuid(reg) ({						\
+ 	u64 __val;							\
+ 	asm("mrs_s	%0, " __stringify(reg) : "=r" (__val));		\
+ 	__val;								\
+ })
+ 
  /*
   * The CPU ID never changes at run time, so we might as well tell the
   * compiler that it's constant.  Use this function to read the CPU ID
