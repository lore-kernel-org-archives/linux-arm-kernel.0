From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Dec 2016 13:38:50 +0100
Subject: [RFC PATCH 15/23] arm: use kconfig fragments for ARCH_PXA defconfigs
 (part 1)
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1481027938-31831-16-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace [lpd270,lubbock,mainstone,pxa255-idp]_defconfig-s with
a Makefile target using merge_config.

The patch was verified with doing:

    $ make [lpd270,...]_defconfig
    $ make savedefconfig

and comparing resulting defconfig files (before/after the patch).

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/Makefile                                  | 16 +++++++
 arch/arm/configs/lpd270.config                     | 20 ++++++++
 arch/arm/configs/lpd270_defconfig                  | 56 ----------------------
 arch/arm/configs/lubbock.config                    | 11 +++++
 arch/arm/configs/lubbock_defconfig                 | 47 ------------------
 arch/arm/configs/mainstone.config                  | 11 +++++
 arch/arm/configs/pxa255-idp.config                 | 14 ++++++
 arch/arm/configs/pxa255-idp_defconfig              | 50 -------------------
 .../{mainstone_defconfig => pxa_basic1_defconfig}  | 11 -----
 9 files changed, 72 insertions(+), 164 deletions(-)
 create mode 100644 arch/arm/configs/lpd270.config
 delete mode 100644 arch/arm/configs/lpd270_defconfig
 create mode 100644 arch/arm/configs/lubbock.config
 delete mode 100644 arch/arm/configs/lubbock_defconfig
 create mode 100644 arch/arm/configs/mainstone.config
 create mode 100644 arch/arm/configs/pxa255-idp.config
 delete mode 100644 arch/arm/configs/pxa255-idp_defconfig
 rename arch/arm/configs/{mainstone_defconfig => pxa_basic1_defconfig} (72%)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d4def05..58890a9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -406,6 +406,22 @@ PHONY += nuc960_defconfig
 nuc960_defconfig:
 	$(call merge_into_defconfig,nuc910_defconfig,nuc960)
 
+PHONY += lpd270_defconfig
+lpd270_defconfig:
+	$(call merge_into_defconfig,pxa_basic1_defconfig,lpd270)
+
+PHONY += lubbock_defconfig
+lubbock_defconfig:
+	$(call merge_into_defconfig,pxa_basic1_defconfig,lubbock)
+
+PHONY += mainstone_defconfig
+mainstone_defconfig:
+	$(call merge_into_defconfig,pxa_basic1_defconfig,mainstone)
+
+PHONY += pxa255-idp_defconfig
+pxa255-idp_defconfig:
+	$(call merge_into_defconfig,pxa_basic1_defconfig,pxa255-idp)
+
 PHONY += vdso_install
 vdso_install:
 ifeq ($(CONFIG_VDSO),y)
diff --git a/arch/arm/configs/lpd270.config b/arch/arm/configs/lpd270.config
new file mode 100644
index 0000000..e70b144
--- /dev/null
+++ b/arch/arm/configs/lpd270.config
@@ -0,0 +1,20 @@
+CONFIG_SLAB=y
+CONFIG_MACH_LOGICPD_PXA270=y
+CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET6_XFRM_MODE_BEET is not set
+# CONFIG_IPV6_SIT is not set
+CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_BLK_DEV_NBD=y
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_HW_RANDOM is not set
+CONFIG_FB=y
+CONFIG_FB_PXA=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
+CONFIG_SND_PXA2XX_AC97=y
diff --git a/arch/arm/configs/lpd270_defconfig b/arch/arm/configs/lpd270_defconfig
deleted file mode 100644
index be58e42..0000000
--- a/arch/arm/configs/lpd270_defconfig
+++ /dev/null
@@ -1,56 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_ARCH_PXA=y
-CONFIG_MACH_LOGICPD_PXA270=y
-# CONFIG_ARM_THUMB is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
-CONFIG_FPE_NWFPE=y
-CONFIG_NET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET6_XFRM_MODE_BEET is not set
-# CONFIG_IPV6_SIT is not set
-CONFIG_MTD=y
-CONFIG_MTD_REDBOOT_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_ADV_OPTIONS=y
-CONFIG_MTD_CFI_GEOMETRY=y
-# CONFIG_MTD_CFI_I1 is not set
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_BLK_DEV_NBD=y
-CONFIG_NETDEVICES=y
-CONFIG_SMC91X=y
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO_SERPORT is not set
-CONFIG_SERIAL_PXA=y
-CONFIG_SERIAL_PXA_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_FB=y
-CONFIG_FB_PXA=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
-CONFIG_SOUND=y
-CONFIG_SND=y
-# CONFIG_SND_SUPPORT_OLD_API is not set
-CONFIG_SND_PXA2XX_AC97=y
-CONFIG_EXT2_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_JFFS2_FS=y
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/lubbock.config b/arch/arm/configs/lubbock.config
new file mode 100644
index 0000000..e16e2ee
--- /dev/null
+++ b/arch/arm/configs/lubbock.config
@@ -0,0 +1,11 @@
+CONFIG_ARCH_LUBBOCK=y
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_PXA2XX=y
+CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IPV6 is not set
+CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_PCMCIA_PCNET=y
+CONFIG_SERIO_SA1111=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_G_SERIAL=m
diff --git a/arch/arm/configs/lubbock_defconfig b/arch/arm/configs/lubbock_defconfig
deleted file mode 100644
index ca68a88..0000000
--- a/arch/arm/configs/lubbock_defconfig
+++ /dev/null
@@ -1,47 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_MODULES=y
-CONFIG_ARCH_PXA=y
-CONFIG_ARCH_LUBBOCK=y
-# CONFIG_ARM_THUMB is not set
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_PXA2XX=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
-CONFIG_FPE_NWFPE=y
-CONFIG_NET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IPV6 is not set
-CONFIG_MTD=y
-CONFIG_MTD_REDBOOT_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_ADV_OPTIONS=y
-CONFIG_MTD_CFI_GEOMETRY=y
-# CONFIG_MTD_CFI_I1 is not set
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_NETDEVICES=y
-CONFIG_PCMCIA_PCNET=y
-CONFIG_SMC91X=y
-CONFIG_INPUT_EVDEV=y
-# CONFIG_SERIO_SERPORT is not set
-CONFIG_SERIO_SA1111=y
-CONFIG_SERIAL_PXA=y
-CONFIG_SERIAL_PXA_CONSOLE=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_G_SERIAL=m
-CONFIG_EXT2_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_JFFS2_FS=y
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/mainstone.config b/arch/arm/configs/mainstone.config
new file mode 100644
index 0000000..6aafb26
--- /dev/null
+++ b/arch/arm/configs/mainstone.config
@@ -0,0 +1,11 @@
+CONFIG_MACH_MAINSTONE=y
+CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IPV6 is not set
+CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_IDE=y
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_FB=y
+CONFIG_FB_PXA=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
diff --git a/arch/arm/configs/pxa255-idp.config b/arch/arm/configs/pxa255-idp.config
new file mode 100644
index 0000000..528f4b2
--- /dev/null
+++ b/arch/arm/configs/pxa255-idp.config
@@ -0,0 +1,14 @@
+CONFIG_ARCH_PXA_IDP=y
+CONFIG_CMDLINE="root=/dev/nfs ip=dhcp console=ttyS0,115200 mem=64M"
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IPV6 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_FB=y
+CONFIG_FB_PXA=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
diff --git a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
deleted file mode 100644
index 4d71e2e..0000000
--- a/arch/arm/configs/pxa255-idp_defconfig
+++ /dev/null
@@ -1,50 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_MODULES=y
-CONFIG_ARCH_PXA=y
-CONFIG_ARCH_PXA_IDP=y
-# CONFIG_ARM_THUMB is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs ip=dhcp console=ttyS0,115200 mem=64M"
-CONFIG_FPE_NWFPE=y
-CONFIG_NET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-# CONFIG_IPV6 is not set
-CONFIG_MTD=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_ADV_OPTIONS=y
-CONFIG_MTD_CFI_GEOMETRY=y
-# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
-# CONFIG_MTD_CFI_I1 is not set
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_NETDEVICES=y
-CONFIG_SMC91X=y
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO_SERPORT is not set
-CONFIG_SERIAL_PXA=y
-CONFIG_SERIAL_PXA_CONSOLE=y
-CONFIG_FB=y
-CONFIG_FB_PXA=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
-CONFIG_EXT2_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_JFFS2_FS=y
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
diff --git a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/pxa_basic1_defconfig
similarity index 72%
rename from arch/arm/configs/mainstone_defconfig
rename to arch/arm/configs/pxa_basic1_defconfig
index 73ac07d..9fffb40 100644
--- a/arch/arm/configs/mainstone_defconfig
+++ b/arch/arm/configs/pxa_basic1_defconfig
@@ -2,38 +2,27 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_MODULES=y
 CONFIG_ARCH_PXA=y
-CONFIG_MACH_MAINSTONE=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IPV6 is not set
 CONFIG_MTD=y
-CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
 CONFIG_MTD_CFI_GEOMETRY=y
 # CONFIG_MTD_CFI_I1 is not set
 CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_IDE=y
 CONFIG_NETDEVICES=y
 CONFIG_SMC91X=y
 CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
-CONFIG_FB=y
-CONFIG_FB_PXA=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_JFFS2_FS=y
-- 
1.9.1
