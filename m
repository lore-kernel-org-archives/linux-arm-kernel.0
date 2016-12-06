From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Dec 2016 13:38:37 +0100
Subject: [RFC PATCH 02/23] arm: use kconfig fragments for ARCH_ASPEED
 defconfigs
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1481027938-31831-3-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace aspeed_g[45]_defconfig with a Makefile target using
merge_config.

The patch was verified by doing:

    $ make aspeed_g[45]_defconfig
    $ make savedefconfig

and comparing resulting defconfig files (before/after the patch).

Cc: Joel Stanley <joel@jms.id.au>
Cc: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/Makefile                                  |  8 ++
 ...{aspeed_g4_defconfig => aspeed_basic_defconfig} |  1 -
 arch/arm/configs/aspeed_g4.config                  |  1 +
 arch/arm/configs/aspeed_g5.config                  |  3 +
 arch/arm/configs/aspeed_g5_defconfig               | 88 ----------------------
 5 files changed, 12 insertions(+), 89 deletions(-)
 rename arch/arm/configs/{aspeed_g4_defconfig => aspeed_basic_defconfig} (98%)
 create mode 100644 arch/arm/configs/aspeed_g4.config
 create mode 100644 arch/arm/configs/aspeed_g5.config
 delete mode 100644 arch/arm/configs/aspeed_g5_defconfig

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f2c0683..abe8a60 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -354,6 +354,14 @@ define merge_into_defconfig
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 endef
 
+PHONY += aspeed_g4_defconfig
+aspeed_g4_defconfig:
+	$(call merge_into_defconfig,aspeed_basic_defconfig,aspeed_g4)
+
+PHONY += aspeed_g5_defconfig
+aspeed_g5_defconfig:
+	$(call merge_into_defconfig,aspeed_basic_defconfig,aspeed_g5)
+
 PHONY += vdso_install
 vdso_install:
 ifeq ($(CONFIG_VDSO),y)
diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_basic_defconfig
similarity index 98%
rename from arch/arm/configs/aspeed_g4_defconfig
rename to arch/arm/configs/aspeed_basic_defconfig
index ca39c04..0846e85 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_basic_defconfig
@@ -24,7 +24,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLOCK is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_ASPEED=y
-CONFIG_MACH_ASPEED_G4=y
 CONFIG_DEBUG_RODATA=y
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
diff --git a/arch/arm/configs/aspeed_g4.config b/arch/arm/configs/aspeed_g4.config
new file mode 100644
index 0000000..d9586c5
--- /dev/null
+++ b/arch/arm/configs/aspeed_g4.config
@@ -0,0 +1 @@
+CONFIG_MACH_ASPEED_G4=y
diff --git a/arch/arm/configs/aspeed_g5.config b/arch/arm/configs/aspeed_g5.config
new file mode 100644
index 0000000..7ca5bc1
--- /dev/null
+++ b/arch/arm/configs/aspeed_g5.config
@@ -0,0 +1,3 @@
+CONFIG_ARCH_MULTI_V6=y
+CONFIG_MACH_ASPEED_G5=y
+CONFIG_UBSAN_ALIGNMENT=y
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
deleted file mode 100644
index 4f366b0..0000000
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ /dev/null
@@ -1,88 +0,0 @@
-CONFIG_KERNEL_XZ=y
-CONFIG_SYSVIPC=y
-CONFIG_USELIB=y
-CONFIG_IRQ_DOMAIN_DEBUG=y
-CONFIG_NO_HZ_IDLE=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
-# CONFIG_RD_LZO is not set
-# CONFIG_RD_LZ4 is not set
-CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_BPF_SYSCALL=y
-# CONFIG_SHMEM is not set
-# CONFIG_AIO is not set
-CONFIG_EMBEDDED=y
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
-CONFIG_CC_STACKPROTECTOR_STRONG=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLOCK is not set
-CONFIG_ARCH_MULTI_V6=y
-# CONFIG_ARCH_MULTI_V7 is not set
-CONFIG_ARCH_ASPEED=y
-CONFIG_MACH_ASPEED_G5=y
-CONFIG_DEBUG_RODATA=y
-CONFIG_AEABI=y
-CONFIG_UACCESS_WITH_MEMCPY=y
-CONFIG_SECCOMP=y
-# CONFIG_ATAGS is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_ARM_APPENDED_DTB=y
-CONFIG_ARM_ATAG_DTB_COMPAT=y
-CONFIG_KEXEC=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-# CONFIG_PREVENT_FIRMWARE_BUILD is not set
-# CONFIG_INPUT is not set
-# CONFIG_SERIO is not set
-# CONFIG_VT is not set
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
-CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=6
-CONFIG_SERIAL_8250_RUNTIME_UARTS=6
-CONFIG_SERIAL_8250_EXTENDED=y
-CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_SERIAL_OF_PLATFORM=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_IOMMU_SUPPORT is not set
-CONFIG_FIRMWARE_MEMMAP=y
-CONFIG_FANOTIFY=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DYNAMIC_DEBUG=y
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_PAGE_POISONING=y
-CONFIG_DEBUG_KMEMLEAK=y
-CONFIG_DEBUG_SHIRQ=y
-CONFIG_LOCKUP_DETECTOR=y
-CONFIG_WQ_WATCHDOG=y
-# CONFIG_SCHED_DEBUG is not set
-CONFIG_SCHED_STACK_END_CHECK=y
-CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
-# CONFIG_FTRACE is not set
-CONFIG_MEMTEST=y
-CONFIG_UBSAN=y
-CONFIG_UBSAN_ALIGNMENT=y
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_LL_UART_8250=y
-CONFIG_DEBUG_UART_PHYS=0x1e784000
-CONFIG_DEBUG_UART_VIRT=0xe8784000
-CONFIG_EARLY_PRINTK=y
-CONFIG_DEBUG_SET_MODULE_RONX=y
-# CONFIG_XZ_DEC_X86 is not set
-# CONFIG_XZ_DEC_POWERPC is not set
-# CONFIG_XZ_DEC_IA64 is not set
-# CONFIG_XZ_DEC_SPARC is not set
-- 
1.9.1
