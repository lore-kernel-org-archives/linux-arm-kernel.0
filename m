From: stefan@agner.ch (Stefan Agner)
Date: Sat, 16 May 2015 11:44:25 +0200
Subject: [PATCH v7 13/13] ARM: vf610m4: add defconfig for Linux on Vybrids
 Cortex-M4
In-Reply-To: <1431769465-26867-1-git-send-email-stefan@agner.ch>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
Message-ID: <1431769465-26867-14-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add defconfig for Linux on Vybrid (vf610) on the secondary Cortex-
M4 CPU. The use of a XIP image has been tested which needs to be
loaded (e.g. using the custom m4boot loader) to the end of the
available RAM at address 0x8f000000. The Cortex-M4 has a code-alias
which makes sure that the instructions get fetched through the code
bus (alias starts at 0x00800000 => 0x80800000 in system address).
Hence, to get optimal performance, use 0x0f000000 as XIP_PHYS_ADDR.
This address is additionally shifted by the length of the minimal
loader which is inserted by m4boot. Currently, this offset is 0x80.

The standard DRAM base address is configured to 0x8C000000, which
gives the Cortex-M4 48MiB of RAM.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/vf610m4_defconfig | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 arch/arm/configs/vf610m4_defconfig

diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
new file mode 100644
index 0000000..aeb2482
--- /dev/null
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -0,0 +1,42 @@
+CONFIG_NAMESPACES=y
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_MMU is not set
+CONFIG_ARM_SINGLE_ARMV7M=y
+CONFIG_ARCH_MXC=y
+CONFIG_SOC_VF610=y
+CONFIG_SET_MEM_PARAM=y
+CONFIG_DRAM_BASE=0x8c000000
+CONFIG_FLASH_MEM_BASE=0x8f000000
+CONFIG_FLASH_SIZE=0x01000000
+CONFIG_CMDLINE="console=/dev/ttyLP2"
+CONFIG_XIP_KERNEL=y
+CONFIG_XIP_PHYS_ADDR=0x0f000080
+CONFIG_BINFMT_FLAT=y
+CONFIG_BINFMT_ZFLAT=y
+CONFIG_BINFMT_SHARED_FLAT=y
+# CONFIG_SUSPEND is not set
+# CONFIG_UEVENT_HELPER is not set
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=4
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_SERIAL_FSL_LPUART=y
+CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_MFD_SYSCON=y
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_FTRACE is not set
-- 
2.4.1
