From: bahadir@l4dev.org (Bahadir Balban)
Date: Fri, 21 May 2010 15:14:08 +0300
Subject: Function for revised cpuid format
Message-ID: <4BF67910.1080108@l4dev.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Below is a patch for this. What do you think?


 From 30ed7d843d61a9663b7fe8d2f8c67ede3d819e50 Mon Sep 17 00:00:00 2001
From: Bahadir Balban <bbalban@b-labs.co.uk>
Date: Fri, 21 May 2010 14:39:56 +0300
Subject: [PATCH] Define revised cpuid function and convert assembler to use that.

This patch defines a minor function to read the revised cpuid
format and converts an assembler statement to use this function.

Signed-off-by: Bahadir Balban <bbalban@b-labs.co.uk>
---
  arch/codezero/include/asm/cputype.h |    5 +++++
  arch/codezero/kernel/setup.c        |    5 ++---
  2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/codezero/include/asm/cputype.h b/arch/codezero/include/asm/cputype.h
index 20ae96c..60071d8 100644
--- a/arch/codezero/include/asm/cputype.h
+++ b/arch/codezero/include/asm/cputype.h
@@ -58,6 +58,11 @@ static inline unsigned int __attribute_const__ read_cpuid_id(void)
  	return read_cpuid(CPUID_ID);
  }

+static inline unsigned int __attribute_const__ read_cpuid_revised_id(void)
+{
+	return read_cpuid_ext(CPUID_EXT_MMFR0);
+}
+
  static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
  {
  	return read_cpuid(CPUID_CACHETYPE);
diff --git a/arch/codezero/kernel/setup.c b/arch/codezero/kernel/setup.c
index c91c77b..c64b029 100644
--- a/arch/codezero/kernel/setup.c
+++ b/arch/codezero/kernel/setup.c
@@ -213,12 +213,11 @@ int cpu_architecture(void)
  		if (cpu_arch)
  			cpu_arch += CPU_ARCH_ARMv3;
  	} else if ((read_cpuid_id() & 0x000f0000) == 0x000f0000) {
-		unsigned int mmfr0;

  		/* Revised CPUID format. Read the Memory Model Feature
  		 * Register 0 and check for VMSAv7 or PMSAv7 */
-		asm("mrc	p15, 0, %0, c0, c1, 4"
-		    : "=r" (mmfr0));
+		unsigned int mmfr0 = read_cpuid_revised_id();
+
  		if ((mmfr0 & 0x0000000f) == 0x00000003 ||
  		    (mmfr0 & 0x000000f0) == 0x00000030)
  			cpu_arch = CPU_ARCH_ARMv7;
-- 
1.6.3.3

-- 
Bahadir
