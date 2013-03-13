From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Mar 2013 16:43:48 +0000
Subject: [PATCH] ARM: fix CONFIG_VIRT_TO_BUS handling
Message-ID: <201303131643.48506.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

887cbce0 "arch Kconfig: centralise CONFIG_ARCH_NO_VIRT_TO_BUS"
and  4febd95a8 "Select VIRT_TO_BUS directly where needed" from
Stephen Rothwell changed globally how CONFIG_VIRT_TO_BUS is
selected, while my own a5d533ee0 "ARM: disable virt_to_bus/
virt_to_bus almost everywhere" was merged at the same time and
changed which platforms select it on ARM.

The result of this conflict was that we again see CONFIG_VIRT_TO_BUS
on all ARM systems. This patch fixes up the problem and removes
CONFIG_ARCH_NO_VIRT_TO_BUS again on ARM.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---

I'd like to merge this one through the arm-soc tree as a 3.9 bug fix
unless there are objections.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 78ffcc6..ad52cd4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -49,7 +49,6 @@ config ARM
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
-	select HAVE_VIRT_TO_BUS
 	select KTIME_SCALAR
 	select PERF_USE_VMALLOC
 	select RTC_LIB
@@ -733,6 +732,7 @@ config ARCH_RPC
 	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	select NO_IOPORT
+	select VIRT_TO_BUS
 	help
 	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
 	  CD-ROM interface, serial and parallel port, and the floppy drive.
@@ -868,6 +868,7 @@ config ARCH_SHARK
 	select ISA_DMA
 	select NEED_MACH_MEMORY_H
 	select PCI
+	select VIRT_TO_BUS
 	select ZONE_DMA
 	help
 	  Support for the StrongARM based Digital DNARD machine, also known
@@ -1451,10 +1452,6 @@ config ISA_DMA
 	bool
 	select ISA_DMA_API
 
-config ARCH_NO_VIRT_TO_BUS
-	def_bool y
-	depends on !ARCH_RPC && !ARCH_NETWINDER && !ARCH_SHARK
-
 # Select ISA DMA interface
 config ISA_DMA_API
 	bool
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index abda5a1..0f2111a 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -67,6 +67,7 @@ config ARCH_NETWINDER
 	select ISA
 	select ISA_DMA
 	select PCI
+	select VIRT_TO_BUS
 	help
 	  Say Y here if you intend to run this kernel on the Rebel.COM
 	  NetWinder.  Information about this machine can be found at:
