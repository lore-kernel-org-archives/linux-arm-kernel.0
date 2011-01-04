From: balbi@ti.com (Felipe Balbi)
Date: Tue, 4 Jan 2011 12:34:32 +0200
Subject: [PATCH 2/2] arm: omap: select HAVE_SPARSE_IRQ
In-Reply-To: <20110104095410.GA17298@n2100.arm.linux.org.uk>
References: <1294133966-20279-1-git-send-email-balbi@ti.com>
	<1294133966-20279-3-git-send-email-balbi@ti.com>
	<20110104095410.GA17298@n2100.arm.linux.org.uk>
Message-ID: <20110104103432.GM2656@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 04, 2011 at 09:54:10AM +0000, Russell King - ARM Linux wrote:
>On Tue, Jan 04, 2011 at 11:39:26AM +0200, Felipe Balbi wrote:
>> select HAVE_SPARSE_IRQ and irq_descs can be added
>> to a radix tree instead of an array.
>
>Please move HAVE_GENERIC_HARDIRQS to the config ARM entry, and remove
>these:
>
>config GENERIC_HARDIRQS
>        bool
>        default y
>
>config GENERIC_HARDIRQS_NO__DO_IRQ
>        def_bool y
>
>as they're in kernel/irq/Kconfig, and are visible if HAVE_GENERIC_HARDIRQS
>is enabled.

do you mean:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d56d21c0..70ff78a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -14,6 +14,7 @@ config ARM
  	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
  	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
  	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
+	select HAVE_GENERIC_HARDIRQS
  	select HAVE_GENERIC_DMA_COHERENT
  	select HAVE_KERNEL_GZIP
  	select HAVE_KERNEL_LZO
@@ -88,10 +89,6 @@ config MCA
  	  <file:Documentation/mca.txt> (and especially the web page given
  	  there) before attempting to build an MCA bus kernel.
  
-config GENERIC_HARDIRQS
-	bool
-	default y
-
  config STACKTRACE_SUPPORT
  	bool
  	default y
@@ -171,9 +168,6 @@ config FIQ
  config ARCH_MTD_XIP
  	bool
  
-config GENERIC_HARDIRQS_NO__DO_IRQ
-	def_bool y
-
  config ARM_L1_CACHE_SHIFT_6
  	bool
  	help
@@ -510,7 +504,7 @@ config ARCH_MMP
  	select GENERIC_CLOCKEVENTS
  	select TICK_ONESHOT
  	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
  	help
  	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
  
@@ -589,7 +583,7 @@ config ARCH_PXA
  	select GENERIC_CLOCKEVENTS
  	select TICK_ONESHOT
  	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
  	help
  	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
  
@@ -1398,15 +1392,6 @@ config HW_PERF_EVENTS
  	  Enable hardware performance counter support for perf events. If
  	  disabled, perf events will use software events only.
  
-config SPARSE_IRQ
-	def_bool n
-	help
-	  This enables support for sparse irqs. This is useful in general
-	  as most CPUs have a fairly sparse array of IRQ vectors, which
-	  the irq_desc then maps directly on to. Systems with a high
-	  number of off-chip IRQs will want to treat this as
-	  experimental until they have been independently verified.
-
  source "mm/Kconfig"
  
  config FORCE_MAX_ZONEORDER

-- 
balbi
