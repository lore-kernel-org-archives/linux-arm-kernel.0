From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Dec 2015 22:33:41 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <5669808F.2050909@vollmann.ch>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <3908335.j4dogqtadm@wuerfel> <5669808F.2050909@vollmann.ch>
Message-ID: <2569698.WNyYKB5EP3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 14:39:27 Detlef Vollmann wrote:
> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/arm 4.4.0-rc3 Kernel Configuration
> #

Just for fun, a few things you can probably disable without
much downsides:

> CONFIG_DEFAULT_HOSTNAME="dns-323"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y

SYSVIPC could be disabled in principle for most embedded systems

> CONFIG_SYSFS_DEPRECATED=y
> CONFIG_SYSFS_DEPRECATED_V2=y
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""

SYSFS_DEPRECATED can probably go, initramfs would be smaller than initrd

> CONFIG_COMPAT_BRK=y
> CONFIG_SLAB=y
> # CONFIG_SLUB is not set
> # CONFIG_SLOB is not set
> # CONFIG_SYSTEM_DATA_VERIFICATION is not set
> # CONFIG_PROFILING is not set
> CONFIG_KEXEC_CORE=y
> CONFIG_HAVE_OPROFILE=y

SLOB would be smaller than SLAB, kexec is often not needed. 

> CONFIG_SWIOTLB=y
> CONFIG_IOMMU_HELPER=y

I have no idea why SWIOTLB is always enabled on ARM, I suspect that's
a bug, and disabling it would save some space (need to change arm/Kconfig)

> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=y
> CONFIG_MTD_BLOCK=y

I suspect you don't use MTD_BLOCK

> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_NULL_BLK is not set
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=4
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=y

Loop and RAM could be loadable modules, if that saves space in the
end. If modules are actually larger, you can have everything built-in.
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> # CONFIG_SERIAL_8250_PCI is not set
> CONFIG_SERIAL_8250_NR_UARTS=2
> CONFIG_SERIAL_8250_RUNTIME_UARTS=2
> # CONFIG_SERIAL_8250_EXTENDED is not set
> CONFIG_SERIAL_8250_FSL=y

No need for 8250_FSL or 8250_DMA on your hardware

> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_74XX_MMIO is not set
> # CONFIG_GPIO_ALTERA is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EM is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_GRGPIO is not set
> CONFIG_GPIO_MVEBU=y
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_XILINX is not set
> # CONFIG_GPIO_ZEVIO is not set
> # CONFIG_GPIO_ZX is not set

It looks like you get two GPIO drivers for the same hardware.
We should probably change this so you only need one of the two.

> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> # CONFIG_USB_XHCI_HCD is not set
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> # CONFIG_USB_EHCI_TT_NEWSCHED is not set
> CONFIG_USB_EHCI_PCI=y
> CONFIG_USB_EHCI_HCD_ORION=y

You probably don't have a PCI EHCI

> CONFIG_USB_STORAGE=y

module

> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y

probably not needed since you have no specific driver for it.

> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y

EXT2 no longer needs to be built when EXT4 is enabled, you can just
use the EXT4 code to mount EXT2 file systems.

> CONFIG_XFS_FS=y
> # CONFIG_XFS_QUOTA is not set

XFS is huge. If you don't need it, that would likely save more than anything
else.

> CONFIG_MINIX_FS=y

minixfs is almost never needed, but small.

> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_PSTORE is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y

NFS and NFSD are also pretty big, but I assume you need them.

	Arnd
