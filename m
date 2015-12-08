From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 22:54:45 +0100
Subject: [RFC] ARM: remove VIRT_TO_BUS
Message-ID: <1630488.4B57tj3Z8o@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All drivers that are relevant for rpc or footbridge have stopped
using virt_to_bus a while ago, so we can remove it and avoid some
harmless randconfig warnings for drivers that we do not care about:

drivers/atm/zatm.c: In function 'poll_rx':
drivers/atm/zatm.c:401:18: warning: 'bus_to_virt' is deprecated [-Wdeprecated-declarations]
   skb = ((struct rx_buffer_head *) bus_to_virt(here[2]))->skb;

FWIW, the remaining drivers using this are:

ATM:  firestream, zatm, ambassador, horizon
ISDN: hisax/netjet
V4L:  STA2X11, zoran
Net:  Appletalk LTPC, Tulip DE4x5, Toshiba IrDA
WAN:  comtrol sv11, cosa, lanmedia, sealevel
SCSI: DPT_I2O, buslogic
VME:  CA91C142

My best guess is that all of the above are so hopelessly obsolete that
we are best off removing all of them form the kernel, but that can be
done another time.

The sound drivers used to rely on virt_to_bus, but don't any more.
As a lot of architectures don't provide VIRT_TO_BUS any more, removing
the dependency in sounds/oss/ would make the deprecated drivers appear
there, which we probably don't want. Instead I'm replacing the
simple dependency with 'VIRT_TO_BUS || RPC || NETWINDER' so we can
still build these sound drivers for the platforms that need them,
but don't change anything on other architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
No hurry for this one. If we can agree that it's a good idea, we
can probably do the sound/oss change first, and then do the
rest for the following merge window. If nobody cares about picking
up the sound/oss patches, we can also just do it as one patch.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a077f59350a2..b03892cecd65 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -556,7 +556,6 @@ config ARCH_RPC
 	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	select NO_IOPORT_MAP
-	select VIRT_TO_BUS
 	help
 	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
 	  CD-ROM interface, serial and parallel port, and the floppy drive.
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index c79b57bf71c4..8f8c3a0571a6 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -303,20 +303,6 @@ static inline phys_addr_t __virt_to_idmap(unsigned long x)
 #define __bus_to_pfn(x)	__phys_to_pfn(x)
 #endif
 
-#ifdef CONFIG_VIRT_TO_BUS
-#define virt_to_bus virt_to_bus
-static inline __deprecated unsigned long virt_to_bus(void *x)
-{
-	return __virt_to_bus((unsigned long)x);
-}
-
-#define bus_to_virt bus_to_virt
-static inline __deprecated void *bus_to_virt(unsigned long x)
-{
-	return (void *)__bus_to_virt(x);
-}
-#endif
-
 /*
  * Conversion between a struct page and a physical address.
  *
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index 735909f90349..7b87bac114a2 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -68,7 +68,6 @@ config ARCH_NETWINDER
 	select ISA
 	select ISA_DMA
 	select PCI
-	select VIRT_TO_BUS
 	help
 	  Say Y here if you intend to run this kernel on the Rebel.COM
 	  NetWinder.  Information about this machine can be found at:
diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
index 48568fdf847f..4033fe58f0cf 100644
--- a/sound/oss/Kconfig
+++ b/sound/oss/Kconfig
@@ -240,7 +240,7 @@ config MSND_FIFOSIZE
 
 menuconfig SOUND_OSS
 	tristate "OSS sound modules"
-	depends on ISA_DMA_API && VIRT_TO_BUS
+	depends on ISA_DMA_API && (VIRT_TO_BUS || ARCH_RPC || ARCH_NETWINDER)
 	depends on !GENERIC_ISA_DMA_SUPPORT_BROKEN
 	help
 	  OSS is the Open Sound System suite of sound card drivers.  They make
