From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 21:21:56 +0200
Subject: [PATCH 07/11] ARM: limit CONFIG_HAVE_IDE to platforms that do
In-Reply-To: <1317496920-7764-1-git-send-email-arnd@arndb.de>
References: <1317496920-7764-1-git-send-email-arnd@arndb.de>
Message-ID: <1317496920-7764-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for IDE drivers should not be automatic, since most platforms
cannot actually support any IDE low-level drivers. This partly
reverts 2064c946e "ARM: always select HAVE_IDE" to set this symbol
only when either a PC-style bus (PCI, ISA, PCMCIA) is enabled or
a platform is used that is known to have an existing driver in
drivers/ide.

New platforms should not need this option and just use CONFIG_ATA
with drivers/ata/.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig           |    6 +++++-
 arch/arm/plat-omap/Kconfig |    1 +
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3445f50..ed69fcd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,7 +3,7 @@ config ARM
 	default y
 	select HAVE_AOUT
 	select HAVE_DMA_API_DEBUG
-	select HAVE_IDE
+	select HAVE_IDE if PCI || ISA || PCMCIA
 	select HAVE_MEMBLOCK
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
@@ -385,6 +385,7 @@ config ARCH_FOOTBRIDGE
 	select CPU_SA110
 	select FOOTBRIDGE
 	select GENERIC_CLOCKEVENTS
+	select HAVE_IDE
 	help
 	  Support for systems based on the DC21285 companion chip
 	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
@@ -632,6 +633,7 @@ config ARCH_PXA
 	select AUTO_ZRELADDR
 	select MULTI_IRQ_HANDLER
 	select ARM_CPU_SUSPEND if PM
+	select HAVE_IDE
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
@@ -672,6 +674,7 @@ config ARCH_RPC
 	select NO_IOPORT
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_USES_GETTIMEOFFSET
+	select HAVE_IDE
 	help
 	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
 	  CD-ROM interface, serial and parallel port, and the floppy drive.
@@ -690,6 +693,7 @@ config ARCH_SA1100
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_IDE
 	help
 	  Support for StrongARM 11x0 based boards.
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index bb8f4a6..5b605a9 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -14,6 +14,7 @@ config ARCH_OMAP1
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
+	select HAVE_IDE
 	help
 	  "Systems based on omap7xx, omap15xx or omap16xx"
 
-- 
1.7.5.4
