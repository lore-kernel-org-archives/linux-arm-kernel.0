From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Dec 2015 14:43:43 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <3908335.j4dogqtadm@wuerfel>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <56697665.1070609@vollmann.ch> <3908335.j4dogqtadm@wuerfel>
Message-ID: <27901501.7xKhhTyrKu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 14:18:11 Arnd Bergmann wrote:
> On Thursday 10 December 2015 13:56:05 Detlef Vollmann wrote:
> > On 11/30/15 14:43, Gregory CLEMENT wrote:
> > >> Detlef, Benjamin,
> > >>
> > >> could you test it on an Orion5x based board?
> > Ok, I tested the v2 series on v4.4-rc3 on my
> > DNS-323: Identified HW revision B1
> > Orion ID: MV88F5182-A2. TCLK=166666667.
> > 
> > Only basic tests, serial port and network.
> > 
> > The good news:
> > orion5x_defconfig works and is even slightly smaller than the
> > original v4.4-rc3 kernel image.
> > 
> > The bad news:
> > My own config (which is massivly stripped down) produces a kernel
> > image that's more than 26K bigger than on v4.4-rc3 without any
> > added functionality.
> > The DNS-323 is extremly constrained in space (the whole system
> > including boot loader, kernel and filesystem has to fit into 8M flash).
> > Any ideas how I can get rid of this additional overhead?
> 
> Can you send me your config file? I can have a look.
> 

I've done a quick check with an allnoconfig-like test and it seems that
CONFIG_OF is weighing in at around 86K here, with all the other options
it pulls in, comparing an allnoconfig kernel for DS-323 with one that
has CONFIG_OF enabled as well.

The multiplatform kernel also enables CONFIG_OF unconditionally, but is
otherwise a little smaller than the mach-orion5x based one:

   text    data     bss     dec     hex filename
 942144   64112   17648 1023904   f9fa0 build/tmp/vmlinux-orion-allno
1027516   54052   20824 1102392  10d238 build/tmp/vmlinux-multi-plus-orion
1025320   66020   18744 1110084  10f044 build/tmp/vmlinux-orion-plus-of

The diff below shows all the differences between orion-allno and
multi-plus-orion.

	Arnd

--- config-orion	2015-12-10 14:25:05.609113585 +0100
+++ .config	2015-12-10 14:24:29.646879038 +0100
@@ -3,6 +3,8 @@
 # Linux/arm 4.4.0-rc4 Kernel Configuration
 #
 CONFIG_ARM=y
+CONFIG_ARM_HAS_SG_CHAIN=y
+CONFIG_MIGHT_HAVE_PCI=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_LOCKDEP_SUPPORT=y
@@ -14,8 +16,7 @@
 CONFIG_NEED_DMA_MAP_STATE=y
 CONFIG_ARCH_SUPPORTS_UPROBES=y
 CONFIG_VECTORS_BASE=0xffff0000
-# CONFIG_ARM_PATCH_PHYS_VIRT is not set
-CONFIG_PHYS_OFFSET=0x0
+CONFIG_ARM_PATCH_PHYS_VIRT=y
 CONFIG_PGTABLE_LEVELS=2
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 CONFIG_BUILDTIME_EXTABLE_SORT=y
@@ -56,6 +57,7 @@
 CONFIG_IRQ_DOMAIN=y
 CONFIG_HANDLE_DOMAIN_IRQ=y
 CONFIG_IRQ_FORCED_THREADING=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 
 #
@@ -186,7 +188,7 @@
 # System Type
 #
 CONFIG_MMU=y
-# CONFIG_ARCH_MULTIPLATFORM is not set
+CONFIG_ARCH_MULTIPLATFORM=y
 # CONFIG_ARCH_VERSATILE is not set
 # CONFIG_ARCH_CLPS711X is not set
 # CONFIG_ARCH_GEMINI is not set
@@ -198,9 +200,6 @@
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
 # CONFIG_ARCH_IXP4XX is not set
-# CONFIG_ARCH_DOVE is not set
-# CONFIG_ARCH_MV78XX0 is not set
-CONFIG_ARCH_ORION5X=y
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_W90X900 is not set
 # CONFIG_ARCH_LPC32XX is not set
@@ -212,8 +211,29 @@
 # CONFIG_ARCH_OMAP1 is not set
 
 #
-# Orion Implementations
+# Multiple platform selection
+#
+
 #
+# CPU Core family selection
+#
+# CONFIG_ARCH_MULTI_V4 is not set
+# CONFIG_ARCH_MULTI_V4T is not set
+CONFIG_ARCH_MULTI_V5=y
+CONFIG_ARCH_MULTI_V4_V5=y
+# CONFIG_ARCH_MULTI_V6 is not set
+# CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_ARCH_MULTI_CPU_AUTO=y
+# CONFIG_ARCH_MVEBU is not set
+# CONFIG_MACH_ASM9260 is not set
+# CONFIG_ARCH_AT91 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_MV78XX0 is not set
+# CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_MXS is not set
+# CONFIG_ARCH_NOMADIK is not set
+# CONFIG_ARCH_NSPIRE is not set
+CONFIG_ARCH_ORION5X=y
 # CONFIG_ARCH_ORION5X_DT is not set
 # CONFIG_MACH_DB88F5281 is not set
 # CONFIG_MACH_RD88F5182 is not set
@@ -237,6 +257,11 @@
 # CONFIG_MACH_RD88F5181L_GE is not set
 # CONFIG_MACH_RD88F5181L_FXO is not set
 # CONFIG_MACH_RD88F6183AP_GE is not set
+# CONFIG_ARCH_MMP is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_PLAT_SPEAR is not set
+# CONFIG_ARCH_U300 is not set
+# CONFIG_ARCH_WM8505 is not set
 CONFIG_PLAT_ORION=y
 CONFIG_PLAT_ORION_LEGACY=y
 
@@ -286,6 +311,10 @@
 #
 # PCI host controller drivers
 #
+# CONFIG_PCI_HOST_GENERIC is not set
+# CONFIG_PCI_LAYERSCAPE is not set
+# CONFIG_PCIE_IPROC is not set
+# CONFIG_PCIE_ALTERA is not set
 # CONFIG_PCIEPORTBUS is not set
 # CONFIG_PCCARD is not set
 
@@ -346,16 +375,16 @@
 #
 # Boot options
 #
-# CONFIG_USE_OF is not set
+CONFIG_USE_OF=y
 CONFIG_ATAGS=y
 # CONFIG_DEPRECATED_PARAM_STRUCT is not set
 CONFIG_ZBOOT_ROM_TEXT=0
 CONFIG_ZBOOT_ROM_BSS=0
+# CONFIG_ARM_APPENDED_DTB is not set
 CONFIG_CMDLINE=""
-# CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
-# CONFIG_AUTO_ZRELADDR is not set
+CONFIG_AUTO_ZRELADDR=y
 
 #
 # CPU Power Management
@@ -427,8 +456,20 @@
 #
 # CONFIG_BRCMSTB_GISB_ARB is not set
 CONFIG_MVEBU_MBUS=y
+# CONFIG_VEXPRESS_CONFIG is not set
 # CONFIG_MTD is not set
-# CONFIG_OF is not set
+CONFIG_DTC=y
+CONFIG_OF=y
+# CONFIG_OF_UNITTEST is not set
+CONFIG_OF_FLATTREE=y
+CONFIG_OF_EARLY_FLATTREE=y
+CONFIG_OF_ADDRESS=y
+CONFIG_OF_ADDRESS_PCI=y
+CONFIG_OF_IRQ=y
+CONFIG_OF_PCI=y
+CONFIG_OF_PCI_IRQ=y
+CONFIG_OF_RESERVED_MEM=y
+# CONFIG_OF_OVERLAY is not set
 CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
 # CONFIG_PARPORT is not set
 
@@ -550,17 +591,26 @@
 # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
 #
 CONFIG_ARCH_HAVE_CUSTOM_GPIO_H=y
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_DEVRES=y
+CONFIG_OF_GPIO=y
 # CONFIG_DEBUG_GPIO is not set
 
 #
 # Memory mapped GPIO drivers
 #
+# CONFIG_GPIO_74XX_MMIO is not set
+# CONFIG_GPIO_ALTERA is not set
 # CONFIG_GPIO_DWAPB is not set
+# CONFIG_GPIO_EM is not set
 # CONFIG_GPIO_GENERIC_PLATFORM is not set
+# CONFIG_GPIO_GRGPIO is not set
+CONFIG_GPIO_MVEBU=y
 # CONFIG_GPIO_VX855 is not set
+# CONFIG_GPIO_XILINX is not set
+# CONFIG_GPIO_ZEVIO is not set
 # CONFIG_GPIO_ZX is not set
 
 #
@@ -597,8 +647,11 @@
 # Multifunction device drivers
 #
 # CONFIG_MFD_CORE is not set
+# CONFIG_MFD_ATMEL_FLEXCOM is not set
+# CONFIG_MFD_ATMEL_HLCDC is not set
 # CONFIG_MFD_CROS_EC is not set
 # CONFIG_MFD_ASIC3 is not set
+# CONFIG_MFD_HI6421_PMIC is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_LPC_ICH is not set
@@ -670,6 +723,7 @@
 #
 # Common Clock Framework
 #
+# CONFIG_CLK_QORIQ is not set
 # CONFIG_COMMON_CLK_PXA is not set
 
 #
@@ -679,6 +733,8 @@
 #
 # Clock Source drivers
 #
+CONFIG_CLKSRC_OF=y
+CONFIG_CLKSRC_PROBE=y
 CONFIG_CLKSRC_MMIO=y
 # CONFIG_ARM_TIMER_SP804 is not set
 # CONFIG_ATMEL_PIT is not set
@@ -711,6 +767,7 @@
 # CONFIG_NTB is not set
 # CONFIG_VME_BUS is not set
 # CONFIG_PWM is not set
+CONFIG_IRQCHIP=y
 # CONFIG_IPACK_BUS is not set
 # CONFIG_RESET_CONTROLLER is not set
 # CONFIG_FMC is not set
@@ -907,7 +964,7 @@
 CONFIG_DEBUG_UART_8250_SHIFT=2
 # CONFIG_DEBUG_UART_8250_WORD is not set
 # CONFIG_DEBUG_UART_8250_FLOW_CONTROL is not set
-CONFIG_UNCOMPRESS_INCLUDE="mach/uncompress.h"
+CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
 # CONFIG_CORESIGHT is not set
 
 #
@@ -924,6 +981,8 @@
 #
 # Library routines
 #
+CONFIG_BITREVERSE=y
+# CONFIG_HAVE_ARCH_BITREVERSE is not set
 CONFIG_RATIONAL=y
 CONFIG_GENERIC_STRNCPY_FROM_USER=y
 CONFIG_GENERIC_STRNLEN_USER=y
@@ -935,7 +994,12 @@
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_T10DIF is not set
 # CONFIG_CRC_ITU_T is not set
-# CONFIG_CRC32 is not set
+CONFIG_CRC32=y
+# CONFIG_CRC32_SELFTEST is not set
+CONFIG_CRC32_SLICEBY8=y
+# CONFIG_CRC32_SLICEBY4 is not set
+# CONFIG_CRC32_SARWATE is not set
+# CONFIG_CRC32_BIT is not set
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 # CONFIG_CRC8 is not set
@@ -952,6 +1016,7 @@
 CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
 # CONFIG_CORDIC is not set
 # CONFIG_DDR is not set
+CONFIG_LIBFDT=y
 # CONFIG_SG_SPLIT is not set
-# CONFIG_ARCH_HAS_SG_CHAIN is not set
+CONFIG_ARCH_HAS_SG_CHAIN=y
 # CONFIG_VIRTUALIZATION is not set
