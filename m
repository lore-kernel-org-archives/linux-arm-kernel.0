From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Nov 2015 12:07:30 -0800
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151124103948.GZ8644@n2100.arm.linux.org.uk>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <133921941.Qfq59EaTOs@wuerfel>
 <20151123213206.GG19156@codeaurora.org>
 <6359949.bhCrxaQvmL@wuerfel>
 <20151124001306.GI19156@codeaurora.org>
 <20151124085349.GQ19156@codeaurora.org>
 <20151124103948.GZ8644@n2100.arm.linux.org.uk>
Message-ID: <20151124200730.GA25963@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24, Russell King - ARM Linux wrote:
> On Tue, Nov 24, 2015 at 12:53:49AM -0800, Stephen Boyd wrote:
> > 
> > And adding CPU_V7VE causes a cascade of changes to wherever
> > CPU_V7 is being used today. Here's the patch I currently have,
> > without the platform changes:

> > @@ -1069,7 +1075,7 @@ config ARM_ERRATA_411920
> >  
> >  config ARM_ERRATA_430973
> >  	bool "ARM errata: Stale prediction on replaced interworking branch"
> > -	depends on CPU_V7
> > +	depends on CPU_V7 || CPU_V7VE
> 
> NAK on all this.  The fact that you're having to add CPU_V7VE at all
> sites which have CPU_V7 shows that this is a totally broken way of
> approaching this.
> 
> Make CPU_V7VE be an _add-on_ to CPU_V7.  In other words, when CPU_V7VE
> is enabled, CPU_V7 should also be enabled, just like we do for CPU_V6K.
> 
> Note that v7M is different because that's not an add-on feature, it's
> a different CPU class from (what should be) v7A.
> 

Ok. Presumably the order of arch-$(CONFIG) lines in the Makefile
are done in an order to allow the build to degrade to the lowest
common denominator among architecture support. CPU_V7 selects
CPU_32v7 and we're using that config to select -march=armv7-a in
the Makefile. The patch currently uses CPU_32v7VE to select
-march=armv7ve. If CPU_V7VE selects CPU_V7 we'll never be able to
use -march=armv7ve because CPU_V7 will be selecting CPU_32v7 and
that will come after CPU_32v7VE in the Makefile.

My understanding is that we want to support CPU_V7VE without
CPU_V7 enabled so that it uses the idiv instructions in that
configuration. When V7VE and V7 are both enabled, we should
degrade to the aeabi functions, and the same is true for when
V7VE is disabled.

I suppose we can fix this by making CPU_V7 a hidden option? Or I
need some coffee because I'm missing something.

---8<----
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ccd0d5553d38..158ffb983387 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -626,7 +626,7 @@ config ARCH_SHMOBILE_LEGACY
 	select ARCH_SHMOBILE
 	select ARM_PATCH_PHYS_VIRT if MMU
 	select CLKDEV_LOOKUP
-	select CPU_V7
+	select CPU_V7_NOEXT
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
@@ -802,7 +802,7 @@ config ARCH_MULTI_V7
 	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
 	default y
 	select ARCH_MULTI_V6_V7
-	select CPU_V7
+	select CPU_V7_NOEXT
 	select HAVE_SMP
 
 config ARCH_MULTI_V7VE
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 9ab8932403e5..7e1b36400e14 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -25,7 +25,7 @@ config ARCH_ATLAS7
 	bool "CSR SiRFSoC ATLAS7 ARM Cortex A7 Platform"
 	default y
 	select ARM_GIC
-	select CPU_V7
+	select CPU_V7_NOEXT
 	select HAVE_ARM_SCU if SMP
 	select HAVE_SMP
 	help
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 565925f37dc5..7e084c34071c 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -24,7 +24,7 @@ config MACH_REALVIEW_EB
 config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9 Tile"
 	depends on MACH_REALVIEW_EB
-	select CPU_V7
+	select CPU_V7_NOEXT
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
@@ -93,7 +93,7 @@ config REALVIEW_PB1176_SECURE_FLASH
 config MACH_REALVIEW_PBA8
 	bool "Support RealView(R) Platform Baseboard for Cortex(tm)-A8 platform"
 	select ARM_GIC
-	select CPU_V7
+	select CPU_V7_NOEXT
 	select HAVE_PATA_PLATFORM
 	help
 	  Include support for the ARM(R) RealView Platform Baseboard for
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index e4ff161da98f..02a887235155 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -350,11 +350,11 @@ config CPU_FEROCEON_OLD_ID
 config CPU_PJ4
 	bool
 	select ARM_THUMBEE
-	select CPU_V7
+	select CPU_V7_NOEXT
 
 config CPU_PJ4B
 	bool
-	select CPU_V7
+	select CPU_V7_NOEXT
 
 # ARMv6
 config CPU_V6
@@ -383,11 +383,9 @@ config CPU_V6K
 	select CPU_PABRT_V6
 	select CPU_TLB_V6 if MMU
 
-# ARMv7
 config CPU_V7
-	bool "Support ARM V7 processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V7) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
+	bool
 	select CPU_32v6K
-	select CPU_32v7
 	select CPU_ABRT_EV7
 	select CPU_CACHE_V7
 	select CPU_CACHE_VIPT
@@ -398,6 +396,12 @@ config CPU_V7
 	select CPU_PABRT_V7
 	select CPU_TLB_V7 if MMU
 
+# ARMv7
+config CPU_V7_NOEXT
+	bool "Support ARM V7 processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V7) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
+	select CPU_32v7
+	select CPU_V7
+
 # ARMv7M
 config CPU_V7M
 	bool
@@ -410,17 +414,8 @@ config CPU_V7M
 # ARMv7ve
 config CPU_V7VE
 	bool "Support ARM V7 processor w/ virtualization extensions" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V7VE) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
-	select CPU_32v6K
 	select CPU_32v7VE
-	select CPU_ABRT_EV7
-	select CPU_CACHE_V7
-	select CPU_CACHE_VIPT
-	select CPU_COPY_V6 if MMU
-	select CPU_CP15_MMU if MMU
-	select CPU_CP15_MPU if !MMU
-	select CPU_HAS_ASID if MMU
-	select CPU_PABRT_V7
-	select CPU_TLB_V7 if MMU
+	select CPU_V7
 
 config CPU_THUMBONLY
 	bool

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
