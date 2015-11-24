From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Nov 2015 00:53:49 -0800
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151124001306.GI19156@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <133921941.Qfq59EaTOs@wuerfel>
 <20151123213206.GG19156@codeaurora.org>
 <6359949.bhCrxaQvmL@wuerfel>
 <20151124001306.GI19156@codeaurora.org>
Message-ID: <20151124085349.GQ19156@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23, Stephen Boyd wrote:
> On 11/23, Arnd Bergmann wrote:
> > 
> > Ok, thanks for the confirmation.
> > 
> > Summarizing what we've found, I think we can get away with just
> > introducing two Kconfig symbols ARCH_MULTI_V7VE and CPU_V7VE.
> > Most CPUs fall clearly into one category or the other, and then
> > we can allow LPAE to be selected for V7VE-only build but not
> > for plain V7, and we can unconditionally build the kernel with
> > 
> > arch-$(CONFIG_CPU_32v7VE)  = -D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7ve,-march=armv7-a -mcpu=cortex-a15)
> > 
> 
> This causes compiler spew for me:
> 
>   warning: switch -mcpu=cortex-a15 conflicts with -march=armv7-a switch
> 
> Removing -march=armv7-a from there makes it quiet.
> 
> Also, it's sort of feels wrong to have -mcpu in a place where
> we're exclusively doing -march. Perhaps the fallback should be
> bog standard -march=armv7-a? (or the fallback for that one
> "-march=armv5t -Wa$(comma)-march=armv7-a")?
> 

And adding CPU_V7VE causes a cascade of changes to wherever
CPU_V7 is being used today. Here's the patch I currently have,
without the platform changes:

---8<----
 arch/arm/Kconfig                   | 68 +++++++++++++++++++++-----------------
 arch/arm/Kconfig-nommu             |  2 +-
 arch/arm/Makefile                  |  1 +
 arch/arm/boot/compressed/head.S    |  2 +-
 arch/arm/boot/compressed/misc.c    |  2 +-
 arch/arm/include/asm/cacheflush.h  |  2 +-
 arch/arm/include/asm/glue-cache.h  |  2 +-
 arch/arm/include/asm/glue-proc.h   |  2 +-
 arch/arm/include/asm/switch_to.h   |  2 +-
 arch/arm/include/debug/icedcc.S    |  2 +-
 arch/arm/kernel/entry-armv.S       |  6 ++--
 arch/arm/kernel/perf_event_v7.c    |  4 +--
 arch/arm/kvm/Kconfig               |  2 +-
 arch/arm/mm/Kconfig                | 41 ++++++++++++++++-------
 arch/arm/mm/Makefile               |  1 +
 arch/arm/probes/kprobes/test-arm.c |  2 +-
 drivers/bus/Kconfig                |  6 ++--
 17 files changed, 86 insertions(+), 61 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9e2d2adcc85b..ccd0d5553d38 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -32,7 +32,7 @@ config ARM
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
-	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
+	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7 || CPU_32_v7VE) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32
 	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
@@ -46,12 +46,12 @@ config ARM
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32
-	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7VE) && MMU
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
-	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
+	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7VE))
 	select HAVE_IDE if PCI || ISA || PCMCIA
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_GZIP
@@ -805,6 +805,12 @@ config ARCH_MULTI_V7
 	select CPU_V7
 	select HAVE_SMP
 
+config ARCH_MULTI_V7VE
+	bool "ARMv7 w/ virtualization extensions based platforms (Cortex-A, PJ4-MP, Krait)"
+	select ARCH_MULTI_V6_V7
+	select CPU_V7VE
+	select HAVE_SMP
+
 config ARCH_MULTI_V6_V7
 	bool
 	select MIGHT_HAVE_CACHE_L2X0
@@ -1069,7 +1075,7 @@ config ARM_ERRATA_411920
 
 config ARM_ERRATA_430973
 	bool "ARM errata: Stale prediction on replaced interworking branch"
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	help
 	  This option enables the workaround for the 430973 Cortex-A8
 	  r1p* erratum. If a code sequence containing an ARM/Thumb
@@ -1085,7 +1091,7 @@ config ARM_ERRATA_430973
 
 config ARM_ERRATA_458693
 	bool "ARM errata: Processor deadlock when a false hazard is created"
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 458693 Cortex-A8 (r2p0)
@@ -1099,7 +1105,7 @@ config ARM_ERRATA_458693
 
 config ARM_ERRATA_460075
 	bool "ARM errata: Data written to the L2 cache can be overwritten with stale data"
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 460075 Cortex-A8 (r2p0)
@@ -1112,7 +1118,7 @@ config ARM_ERRATA_460075
 
 config ARM_ERRATA_742230
 	bool "ARM errata: DMB operation may be faulty"
-	depends on CPU_V7 && SMP
+	depends on (CPU_V7 || CPU_V7VE) && SMP
 	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 742230 Cortex-A9
@@ -1125,7 +1131,7 @@ config ARM_ERRATA_742230
 
 config ARM_ERRATA_742231
 	bool "ARM errata: Incorrect hazard handling in the SCU may lead to data corruption"
-	depends on CPU_V7 && SMP
+	depends on (CPU_V7 || CPU_V7VE) && SMP
 	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 742231 Cortex-A9
@@ -1140,7 +1146,7 @@ config ARM_ERRATA_742231
 
 config ARM_ERRATA_643719
 	bool "ARM errata: LoUIS bit field in CLIDR register is incorrect"
-	depends on CPU_V7 && SMP
+	depends on (CPU_V7 || CPU_V7VE) && SMP
 	default y
 	help
 	  This option enables the workaround for the 643719 Cortex-A9 (prior to
@@ -1151,7 +1157,7 @@ config ARM_ERRATA_643719
 
 config ARM_ERRATA_720789
 	bool "ARM errata: TLBIASIDIS and TLBIMVAIS operations can broadcast a faulty ASID"
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	help
 	  This option enables the workaround for the 720789 Cortex-A9 (prior to
 	  r2p0) erratum. A faulty ASID can be sent to the other CPUs for the
@@ -1163,7 +1169,7 @@ config ARM_ERRATA_720789
 
 config ARM_ERRATA_743622
 	bool "ARM errata: Faulty hazard checking in the Store Buffer may lead to data corruption"
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 743622 Cortex-A9
@@ -1177,7 +1183,7 @@ config ARM_ERRATA_743622
 
 config ARM_ERRATA_751472
 	bool "ARM errata: Interrupted ICIALLUIS may prevent completion of broadcasted operation"
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 751472 Cortex-A9 (prior
@@ -1188,7 +1194,7 @@ config ARM_ERRATA_751472
 
 config ARM_ERRATA_754322
 	bool "ARM errata: possible faulty MMU translations following an ASID switch"
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	help
 	  This option enables the workaround for the 754322 Cortex-A9 (r2p*,
 	  r3p*) erratum. A speculative memory access may cause a page table walk
@@ -1199,7 +1205,7 @@ config ARM_ERRATA_754322
 
 config ARM_ERRATA_754327
 	bool "ARM errata: no automatic Store Buffer drain"
-	depends on CPU_V7 && SMP
+	depends on (CPU_V7 || CPU_V7VE) && SMP
 	help
 	  This option enables the workaround for the 754327 Cortex-A9 (prior to
 	  r2p0) erratum. The Store Buffer does not have any automatic draining
@@ -1222,7 +1228,7 @@ config ARM_ERRATA_364296
 
 config ARM_ERRATA_764369
 	bool "ARM errata: Data cache line maintenance operation by MVA may not succeed"
-	depends on CPU_V7 && SMP
+	depends on (CPU_V7 || CPU_V7VE) && SMP
 	help
 	  This option enables the workaround for erratum 764369
 	  affecting Cortex-A9 MPCore with two or more processors (all
@@ -1236,7 +1242,7 @@ config ARM_ERRATA_764369
 
 config ARM_ERRATA_775420
        bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
-       depends on CPU_V7
+       depends on CPU_V7 || CPU_V7VE
        help
 	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
 	 r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
@@ -1246,7 +1252,7 @@ config ARM_ERRATA_775420
 
 config ARM_ERRATA_798181
 	bool "ARM errata: TLBI/DSB failure on Cortex-A15"
-	depends on CPU_V7 && SMP
+	depends on (CPU_V7 || CPU_V7VE) && SMP
 	help
 	  On Cortex-A15 (r0p0..r3p2) the TLBI*IS/DSB operations are not
 	  adequately shooting down all use of the old entries. This
@@ -1256,7 +1262,7 @@ config ARM_ERRATA_798181
 
 config ARM_ERRATA_773022
 	bool "ARM errata: incorrect instructions may be executed from loop buffer"
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	help
 	  This option enables the workaround for the 773022 Cortex-A15
 	  (up to r0p4) erratum. In certain rare sequences of code, the
@@ -1337,7 +1343,7 @@ config HAVE_SMP
 
 config SMP
 	bool "Symmetric Multi-Processing"
-	depends on CPU_V6K || CPU_V7
+	depends on CPU_V6K || CPU_V7 || CPU_V7VE
 	depends on GENERIC_CLOCKEVENTS
 	depends on HAVE_SMP
 	depends on MMU || ARM_MPU
@@ -1373,7 +1379,7 @@ config SMP_ON_UP
 
 config ARM_CPU_TOPOLOGY
 	bool "Support cpu topology definition"
-	depends on SMP && CPU_V7
+	depends on SMP && (CPU_V7 || CPU_V7VE)
 	default y
 	help
 	  Support ARM cpu topology definition. The MPIDR register defines
@@ -1403,7 +1409,7 @@ config HAVE_ARM_SCU
 
 config HAVE_ARM_ARCH_TIMER
 	bool "Architected timer support"
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	select ARM_ARCH_TIMER
 	select GENERIC_CLOCKEVENTS
 	help
@@ -1417,7 +1423,7 @@ config HAVE_ARM_TWD
 
 config MCPM
 	bool "Multi-Cluster Power Management"
-	depends on CPU_V7 && SMP
+	depends on (CPU_V7 || CPU_V7VE) && SMP
 	help
 	  This option provides the common power management infrastructure
 	  for (multi-)cluster based systems, such as big.LITTLE based
@@ -1434,7 +1440,7 @@ config MCPM_QUAD_CLUSTER
 
 config BIG_LITTLE
 	bool "big.LITTLE support (Experimental)"
-	depends on CPU_V7 && SMP
+	depends on (CPU_V7 || CPU_V7VE) && SMP
 	select MCPM
 	help
 	  This option enables support selections for the big.LITTLE
@@ -1501,7 +1507,7 @@ config HOTPLUG_CPU
 
 config ARM_PSCI
 	bool "Support for the ARM Power State Coordination Interface (PSCI)"
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	select ARM_PSCI_FW
 	help
 	  Say Y here if you want Linux to communicate with system firmware
@@ -1579,7 +1585,7 @@ config SCHED_HRTICK
 
 config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode" if !CPU_THUMBONLY
-	depends on (CPU_V7 || CPU_V7M) && !CPU_V6 && !CPU_V6K
+	depends on (CPU_V7 || CPU_V7VE || CPU_V7M) && !CPU_V6 && !CPU_V6K
 	default y if CPU_THUMBONLY
 	select AEABI
 	select ARM_ASM_UNIFIED
@@ -1642,7 +1648,7 @@ config AEABI
 
 config ARM_PATCH_UIDIV
 	bool "Runtime patch calls to __aeabi_{u}idiv() with udiv/sdiv"
-	depends on CPU_V7 && !XIP_KERNEL && AEABI
+	depends on CPU_32v7 && !XIP_KERNEL && AEABI
 	help
 	  Some v7 CPUs have support for the udiv and sdiv instructions
 	  that can be used in place of calls to __aeabi_uidiv and __aeabi_idiv
@@ -1843,7 +1849,7 @@ config XEN_DOM0
 config XEN
 	bool "Xen guest support on ARM"
 	depends on ARM && AEABI && OF
-	depends on CPU_V7 && !CPU_V6
+	depends on (CPU_V7 || CPU_V7VE) && !CPU_V6
 	depends on !GENERIC_ATOMIC64
 	depends on MMU
 	select ARCH_DMA_ADDR_T_64BIT
@@ -2132,7 +2138,7 @@ config FPE_FASTFPE
 
 config VFP
 	bool "VFP-format floating point maths"
-	depends on CPU_V6 || CPU_V6K || CPU_ARM926T || CPU_V7 || CPU_FEROCEON
+	depends on CPU_V6 || CPU_V6K || CPU_ARM926T || CPU_V7 || CPU_V7VE || CPU_FEROCEON
 	help
 	  Say Y to include VFP support code in the kernel. This is needed
 	  if your hardware includes a VFP unit.
@@ -2145,11 +2151,11 @@ config VFP
 config VFPv3
 	bool
 	depends on VFP
-	default y if CPU_V7
+	default y if CPU_V7 || CPU_V7VE
 
 config NEON
 	bool "Advanced SIMD (NEON) Extension support"
-	depends on VFPv3 && CPU_V7
+	depends on VFPv3 && (CPU_V7 || CPU_V7VE)
 	help
 	  Say Y to include support code for NEON, the ARMv7 Advanced SIMD
 	  Extension.
@@ -2174,7 +2180,7 @@ source "kernel/power/Kconfig"
 
 config ARCH_SUSPEND_POSSIBLE
 	depends on CPU_ARM920T || CPU_ARM926T || CPU_FEROCEON || CPU_SA1100 || \
-		CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M || CPU_XSC3 || CPU_XSCALE || CPU_MOHAWK
+		CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M || CPU_V7VE || CPU_XSC3 || CPU_XSCALE || CPU_MOHAWK
 	def_bool y
 
 config ARM_CPU_SUSPEND
diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index aed66d5df7f1..aa04be6b29b9 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -53,7 +53,7 @@ config REMAP_VECTORS_TO_RAM
 
 config ARM_MPU
        bool 'Use the ARM v7 PMSA Compliant MPU'
-       depends on CPU_V7
+       depends on CPU_V7 || CPU_V7VE
        default y
        help
          Some ARM systems without an MMU have instead a Memory Protection
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 2c2b28ee4811..c553862e26c8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -67,6 +67,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-sra)
 # macro, but instead defines a whole series of macros which makes
 # testing for a specific architecture or later rather impossible.
 arch-$(CONFIG_CPU_32v7M)	=-D__LINUX_ARM_ARCH__=7 -march=armv7-m -Wa,-march=armv7-m
+arch-$(CONFIG_CPU_32v7VE)	=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7ve,-mcpu=cortex-a15)
 arch-$(CONFIG_CPU_32v7)		=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7-a)
 arch-$(CONFIG_CPU_32v6)		=-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6,-march=armv5t -Wa$(comma)-march=armv6)
 # Only override the compiler option if ARMv6. The ARMv6K extensions are
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 06e983f59980..e51ef838947c 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -26,7 +26,7 @@
 
 #if defined(CONFIG_DEBUG_ICEDCC)
 
-#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7) || defined (CONFIG_CPU_V7VE)
 		.macro	loadsp, rb, tmp
 		.endm
 		.macro	writeb, ch, rb
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index d4f891f56996..0e0300c25008 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -29,7 +29,7 @@ extern void error(char *x);
 
 #ifdef CONFIG_DEBUG_ICEDCC
 
-#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7VE)
 
 static void icedcc_putc(int ch)
 {
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index d5525bfc7e3e..ff5e71c45809 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -193,7 +193,7 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
  * Optimized __flush_icache_all for the common cases. Note that UP ARMv7
  * will fall through to use __flush_icache_all_generic.
  */
-#if (defined(CONFIG_CPU_V7) && \
+#if ((defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7VE)) && \
      (defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K))) || \
 	defined(CONFIG_SMP_ON_UP)
 #define __flush_icache_preferred	__cpuc_flush_icache_all
diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index cab07f69382d..4a2f076dbcc3 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -109,7 +109,7 @@
 # endif
 #endif
 
-#if defined(CONFIG_CPU_V7)
+#if defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7VE)
 # ifdef _CACHE
 #  define MULTI_CACHE 1
 # else
diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
index 74be7c22035a..345a32137117 100644
--- a/arch/arm/include/asm/glue-proc.h
+++ b/arch/arm/include/asm/glue-proc.h
@@ -239,7 +239,7 @@
 # endif
 #endif
 
-#ifdef CONFIG_CPU_V7
+#if defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7VE)
 /*
  * Cortex-A9 needs a different suspend/resume function, so we need
  * multiple CPU support for ARMv7 anyway.
diff --git a/arch/arm/include/asm/switch_to.h b/arch/arm/include/asm/switch_to.h
index 12ebfcc1d539..79fd3fc09d45 100644
--- a/arch/arm/include/asm/switch_to.h
+++ b/arch/arm/include/asm/switch_to.h
@@ -9,7 +9,7 @@
  * to ensure that the maintenance completes in case we migrate to another
  * CPU.
  */
-#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP) && defined(CONFIG_CPU_V7)
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP) && (defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7VE))
 #define __complete_pending_tlbi()	dsb(ish)
 #else
 #define __complete_pending_tlbi()
diff --git a/arch/arm/include/debug/icedcc.S b/arch/arm/include/debug/icedcc.S
index 43afcb021fa3..6b3b2d2f3694 100644
--- a/arch/arm/include/debug/icedcc.S
+++ b/arch/arm/include/debug/icedcc.S
@@ -14,7 +14,7 @@
 		.macro	addruart, rp, rv, tmp
 		.endm
 
-#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7VE)
 
 		.macro	senduart, rd, rx
 		mcr	p14, 0, \rd, c0, c5, 0
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 3ce377f7251f..317de38c357e 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -504,7 +504,7 @@ __und_usr:
 __und_usr_thumb:
 	@ Thumb instruction
 	sub	r4, r2, #2			@ First half of thumb instr@LR - 2
-#if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7
+#if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && (CONFIG_CPU_V7 || CONFIG_CPU_V7VE)
 /*
  * Thumb-2 instruction handling.  Note that because pre-v6 and >= v6 platforms
  * can never be supported in a single kernel, this code is not applicable at
@@ -549,7 +549,7 @@ ARM_BE8(rev16	r0, r0)				@ little endian instruction
 	.arch	armv6
 #endif
 #endif /* __LINUX_ARM_ARCH__ < 7 */
-#else /* !(CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7) */
+#else /* !(CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && (CONFIG_CPU_V7 || CONFIG_CPU_V7VE)) */
 	b	__und_usr_fault_16
 #endif
  UNWIND(.fnend)
@@ -565,7 +565,7 @@ ENDPROC(__und_usr)
 	.popsection
 	.pushsection __ex_table,"a"
 	.long	1b, 4b
-#if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7
+#if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && (CONFIG_CPU_V7 || CONFIG_CPU_V7VE)
 	.long	2b, 4b
 	.long	3b, 4b
 #endif
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 126dc679b230..6c3c4b269e90 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -16,7 +16,7 @@
  *  counter and all 4 performance counters together can be reset separately.
  */
 
-#ifdef CONFIG_CPU_V7
+#if defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7VE)
 
 #include <asm/cp15.h>
 #include <asm/cputype.h>
@@ -1900,4 +1900,4 @@ static int __init register_armv7_pmu_driver(void)
 	return platform_driver_register(&armv7_pmu_driver);
 }
 device_initcall(register_armv7_pmu_driver);
-#endif	/* CONFIG_CPU_V7 */
+#endif	/* CONFIG_CPU_V7 || CONFIG_CPU_V7VE */
diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 95a000515e43..ea62ada144b1 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -5,7 +5,7 @@
 source "virt/kvm/Kconfig"
 
 menuconfig VIRTUALIZATION
-	bool "Virtualization"
+	bool "Virtualization" if CPU_V7VE
 	---help---
 	  Say Y here to get to see options for using your Linux host to run
 	  other operating systems inside virtual machines (guests).
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c21941349b3e..e4ff161da98f 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -407,6 +407,21 @@ config CPU_V7M
 	select CPU_PABRT_LEGACY
 	select CPU_THUMBONLY
 
+# ARMv7ve
+config CPU_V7VE
+	bool "Support ARM V7 processor w/ virtualization extensions" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V7VE) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
+	select CPU_32v6K
+	select CPU_32v7VE
+	select CPU_ABRT_EV7
+	select CPU_CACHE_V7
+	select CPU_CACHE_VIPT
+	select CPU_COPY_V6 if MMU
+	select CPU_CP15_MMU if MMU
+	select CPU_CP15_MPU if !MMU
+	select CPU_HAS_ASID if MMU
+	select CPU_PABRT_V7
+	select CPU_TLB_V7 if MMU
+
 config CPU_THUMBONLY
 	bool
 	# There are no CPUs available with MMU that don't implement an ARM ISA:
@@ -450,6 +465,9 @@ config CPU_32v6K
 config CPU_32v7
 	bool
 
+config CPU_32v7VE
+	bool
+
 config CPU_32v7M
 	bool
 
@@ -626,8 +644,7 @@ comment "Processor Features"
 
 config ARM_LPAE
 	bool "Support for the Large Physical Address Extension"
-	depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
-		!CPU_32v4 && !CPU_32v3
+	depends on MMU && CPU_32v7VE
 	help
 	  Say Y if you have an ARMv7 processor supporting the LPAE page
 	  table format and you would like to access memory beyond the
@@ -652,7 +669,7 @@ config ARM_THUMB
 		CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || \
 		CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
 		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || \
-		CPU_V7 || CPU_FEROCEON || CPU_V7M
+		CPU_V7 || CPU_FEROCEON || CPU_V7M || CPU_V7VE
 	default y
 	help
 	  Say Y if you want to include kernel support for running user space
@@ -666,7 +683,7 @@ config ARM_THUMB
 
 config ARM_THUMBEE
 	bool "Enable ThumbEE CPU extension"
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	help
 	  Say Y here if you have a CPU with the ThumbEE extension and code to
 	  make use of it. Say N for code that can run on CPUs without ThumbEE.
@@ -674,7 +691,7 @@ config ARM_THUMBEE
 config ARM_VIRT_EXT
 	bool
 	depends on MMU
-	default y if CPU_V7
+	default y if CPU_V7VE
 	help
 	  Enable the kernel to make use of the ARM Virtualization
 	  Extensions to install hypervisors without run-time firmware
@@ -686,7 +703,7 @@ config ARM_VIRT_EXT
 
 config SWP_EMULATE
 	bool "Emulate SWP/SWPB instructions" if !SMP
-	depends on CPU_V7
+	depends on CPU_V7 || CPU_V7VE
 	default y if SMP
 	select HAVE_PROC_CPU if PROC_FS
 	help
@@ -723,7 +740,7 @@ config CPU_BIG_ENDIAN
 config CPU_ENDIAN_BE8
 	bool
 	depends on CPU_BIG_ENDIAN
-	default CPU_V6 || CPU_V6K || CPU_V7
+	default CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7VE
 	help
 	  Support for the BE-8 (big-endian) mode on ARMv6 and ARMv7 processors.
 
@@ -789,7 +806,7 @@ config CPU_CACHE_ROUND_ROBIN
 
 config CPU_BPREDICT_DISABLE
 	bool "Disable branch prediction"
-	depends on CPU_ARM1020 || CPU_V6 || CPU_V6K || CPU_MOHAWK || CPU_XSC3 || CPU_V7 || CPU_FA526
+	depends on CPU_ARM1020 || CPU_V6 || CPU_V6K || CPU_MOHAWK || CPU_XSC3 || CPU_V7 || CPU_V7VE || CPU_FA526
 	help
 	  Say Y here to disable branch prediction.  If unsure, say N.
 
@@ -835,7 +852,7 @@ config KUSER_HELPERS
 
 config VDSO
 	bool "Enable VDSO for acceleration of some system calls"
-	depends on AEABI && MMU && CPU_V7
+	depends on AEABI && MMU && (CPU_V7 || CPU_V7VE)
 	default y if ARM_ARCH_TIMER
 	select GENERIC_TIME_VSYSCALL
 	help
@@ -984,7 +1001,7 @@ config CACHE_XSC3L2
 
 config ARM_L1_CACHE_SHIFT_6
 	bool
-	default y if CPU_V7
+	default y if CPU_V7 || CPU_V7VE
 	help
 	  Setting ARM L1 cache line size to 64 Bytes.
 
@@ -994,10 +1011,10 @@ config ARM_L1_CACHE_SHIFT
 	default 5
 
 config ARM_DMA_MEM_BUFFERABLE
-	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
+	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !(CPU_V7 || CPU_V7VE)
 	depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
 		     MACH_REALVIEW_PB11MP)
-	default y if CPU_V6 || CPU_V6K || CPU_V7
+	default y if CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7VE
 	help
 	  Historically, the kernel has used strongly ordered mappings to
 	  provide DMA coherent memory.  With the advent of ARMv7, mapping
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 57c8df500e8c..4f542b29137c 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_CPU_FEROCEON)	+= proc-feroceon.o
 obj-$(CONFIG_CPU_V6)		+= proc-v6.o
 obj-$(CONFIG_CPU_V6K)		+= proc-v6.o
 obj-$(CONFIG_CPU_V7)		+= proc-v7.o
+obj-$(CONFIG_CPU_V7VE)		+= proc-v7.o
 obj-$(CONFIG_CPU_V7M)		+= proc-v7m.o
 
 AFLAGS_proc-v6.o	:=-Wa,-march=armv6
diff --git a/arch/arm/probes/kprobes/test-arm.c b/arch/arm/probes/kprobes/test-arm.c
index 8866aedfdea2..c2591b8b8718 100644
--- a/arch/arm/probes/kprobes/test-arm.c
+++ b/arch/arm/probes/kprobes/test-arm.c
@@ -192,7 +192,7 @@ void kprobe_arm_test_cases(void)
 	TEST_BF_R ("mov	pc, r",0,2f,"")
 	TEST_BF_R ("add	pc, pc, r",14,(2f-1f-8)*2,", asr #1")
 	TEST_BB(   "sub	pc, pc, #1b-2b+8")
-#if __LINUX_ARM_ARCH__ == 6 && !defined(CONFIG_CPU_V7)
+#if __LINUX_ARM_ARCH__ == 6 && !(defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7VE))
 	TEST_BB(   "sub	pc, pc, #1b-2b+8-2") /* UNPREDICTABLE before and after ARMv6 */
 #endif
 	TEST_BB_R( "sub	pc, pc, r",14, 1f-2f+8,"")
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 0ebca8ba7bc4..33fa47dc03a8 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -17,7 +17,7 @@ config ARM_CCI400_COMMON
 
 config ARM_CCI400_PMU
 	bool "ARM CCI400 PMU support"
-	depends on (ARM && CPU_V7) || ARM64
+	depends on (ARM && (CPU_V7 || CPU_V7VE)) || ARM64
 	depends on PERF_EVENTS
 	select ARM_CCI400_COMMON
 	select ARM_CCI_PMU
@@ -28,7 +28,7 @@ config ARM_CCI400_PMU
 
 config ARM_CCI400_PORT_CTRL
 	bool
-	depends on ARM && OF && CPU_V7
+	depends on ARM && OF && (CPU_V7 || CPU_V7VE)
 	select ARM_CCI400_COMMON
 	help
 	  Low level power management driver for CCI400 cache coherent
@@ -36,7 +36,7 @@ config ARM_CCI400_PORT_CTRL
 
 config ARM_CCI500_PMU
 	bool "ARM CCI500 PMU support"
-	depends on (ARM && CPU_V7) || ARM64
+	depends on (ARM && (CPU_V7 || CPU_V7VE)) || ARM64
 	depends on PERF_EVENTS
 	select ARM_CCI_PMU
 	help
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
