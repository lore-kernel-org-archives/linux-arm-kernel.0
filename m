From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Apr 2013 11:02:43 +0100
Subject: [Suggestion] ARM:S5pv210: compiling issue for s5pv210 by using
 randconfig
In-Reply-To: <516E6A8E.3000001@asianux.com>
References: <514FB202.3040807@asianux.com> <515BFA8D.2000204@asianux.com>
 <20130403101018.GE11040@mudshark.cambridge.arm.com>
 <515C047A.9010906@asianux.com> <516E6A8E.3000001@asianux.com>
Message-ID: <20130417100243.GV14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 05:25:34PM +0800, Chen Gang wrote:
> CONFIG_CPU_ARM7TDMI=y
> CONFIG_CPU_ARM9TDMI=y
> CONFIG_CPU_V7=y
> CONFIG_CPU_32v4T=y
> CONFIG_CPU_32v6K=y
> CONFIG_CPU_32v7=y

This is an invalid configuration.  A single kernel can not support ARMv7
and ARMv4T simultaneously.

The problem is caused by MMU=n, which exposes the CPU_ARM7TDMI and
CPU_ARM9TDMI options, which in turn select 32v4T.  This is in turn
caused by the incomplete integration of uclinux.

I think the only thing which can be done is to remove the ARM9TDMI
support code, which doesn't seem to be used by anything, and adjust
ARM7TDMI so that it isn't visible, but is selected by ARCH_AT91X40
(which seems to be its only user.)

Here's the slightly smaller version of that:

diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index 6c24985..dc972e1 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -47,6 +47,7 @@ config ARCH_AT91X40
 	select ARCH_USES_GETTIMEOFFSET
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
+	select CPU_ARM7TDMI
 
 endchoice
 
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index cb812a1..deb6c6a 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -6,7 +6,7 @@ comment "Processor Type"
 
 # ARM7TDMI
 config CPU_ARM7TDMI
-	bool "Support ARM7TDMI processor"
+	bool
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
@@ -56,7 +56,7 @@ config CPU_ARM740T
 
 # ARM9TDMI
 config CPU_ARM9TDMI
-	bool "Support ARM9TDMI processor"
+	bool
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
