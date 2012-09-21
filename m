From: sr@denx.de (Stefan Roese)
Date: Fri, 21 Sep 2012 14:55:19 +0200
Subject: [PATCH] ARM: spear6xx: Add X600 (SPEAr600) board support
Message-ID: <1348232119-18576-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the X600 board based on the
ST SPEAr600 SoC.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/boot/dts/x600.dts        |  92 ++++++++++++++++++++++++++++++++++
 arch/arm/configs/x600_defconfig   | 101 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-spear6xx/spear6xx.c |  36 ++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 arch/arm/boot/dts/x600.dts
 create mode 100644 arch/arm/configs/x600_defconfig

diff --git a/arch/arm/boot/dts/x600.dts b/arch/arm/boot/dts/x600.dts
new file mode 100644
index 0000000..6ef8793
--- /dev/null
+++ b/arch/arm/boot/dts/x600.dts
@@ -0,0 +1,92 @@
+/*
+ * Copyright 2012 Stefan Roese <sr@denx.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "spear600.dtsi"
+
+/ {
+	model = "X600";
+	compatible = "anonymous,x600", "st,spear600";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &gmac;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x10000000>;
+	};
+
+	ahb {
+		gmac: ethernet at e0800000 {
+			phy-mode = "gmii";
+			status = "okay";
+		};
+
+		fsmc: flash at d1800000 {
+			status = "okay";
+			bank-width = <1>;
+			nand-skip-bbtscan;
+
+			partition at 0 {
+				label = "ubi0";
+				reg = <0x00000000 0x08000000>;
+			};
+		};
+
+		smi: flash at fc000000 {
+			status = "okay";
+			clock-rate = <50000000>;	/* 50MHz */
+
+			flash at f8000000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xf8000000 0x80000>;
+				st,smi-fast-mode;
+
+				partition at 0 {
+					label = "u-boot";
+					reg = <0x0 0x60000>;
+				};
+				partition at 60000 {
+					label = "env1";
+					reg = <0x60000 0x10000>;
+				};
+				partition at 70000 {
+					label = "env2";
+					reg = <0x70000 0x10000>;
+				};
+			};
+		};
+
+		apb {
+			serial at d0000000 {
+				status = "okay";
+			};
+
+			serial at d0080000 {
+				status = "okay";
+			};
+
+			i2c at d0200000 {
+				clock-frequency = <400000>;
+				status = "okay";
+
+				rtc at 68 {
+					compatible = "stm,m41t82";
+					reg = <0x68>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/configs/x600_defconfig b/arch/arm/configs/x600_defconfig
new file mode 100644
index 0000000..bdb3ed0
--- /dev/null
+++ b/arch/arm/configs/x600_defconfig
@@ -0,0 +1,101 @@
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_NAMESPACES=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_PLAT_SPEAR=y
+CONFIG_ARCH_SPEAR6XX=y
+CONFIG_AEABI=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_BINFMT_MISC=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IPV6 is not set
+CONFIG_DNS_RESOLVER=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_FSMC=y
+CONFIG_MTD_UBI=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_SCSI=y
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+CONFIG_STMMAC_ETH=y
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_RAW_DRIVER=y
+CONFIG_MAX_RAW_DEVS=8192
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PL061=y
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_MON=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_SERIAL=y
+CONFIG_USB_SERIAL_FTDI_SIO=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_ZERO=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_M41T80=y
+CONFIG_UIO=y
+CONFIG_UIO_PDRV=y
+CONFIG_UIO_PDRV_GENIRQ=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
+CONFIG_TMPFS=y
+CONFIG_UBIFS_FS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_DEFAULT="utf8"
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_INFO=y
+CONFIG_KEYS=y
+CONFIG_XZ_DEC=y
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 5a5a52d..608c948 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -20,6 +20,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/phy.h>
 #include <asm/hardware/pl080.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
@@ -414,10 +415,45 @@ struct of_dev_auxdata spear6xx_auxdata_lookup[] __initdata = {
 	{}
 };
 
+#define VCS8641_PHY_ID		0x00070431
+#define VCS8641_PHY_MASK	0xfffffff0
+
+static int x600_phy_fixup(struct phy_device *phydev)
+{
+	/* Extended PHY control 1, select GMII */
+	phy_write(phydev, 23, 0x0020);
+
+	/* Software reset necessary after GMII mode selction */
+	phy_write(phydev, MII_BMCR, BMCR_RESET);
+
+	/* Enable extended page register access */
+	phy_write(phydev, 31, 0x0001);
+
+	/* 17e: Enhanced LED behavior, needs to be written twice */
+	phy_write(phydev, 17, 0x09ff);
+	phy_write(phydev, 17, 0x09ff);
+
+	/* 16e: Enhanced LED method select */
+	phy_write(phydev, 16, 0xe0ea);
+
+	/* Disable extended page register access */
+	phy_write(phydev, 31, 0x0000);
+
+	/* Enable clock output pin */
+	phy_write(phydev, 18, 0x0049);
+
+	return 0;
+}
+
 static void __init spear600_dt_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table,
 			spear6xx_auxdata_lookup, NULL);
+
+	/* Register the fixup for PHY on X600 */
+	if (of_machine_is_compatible("anonymous,x600"))
+		phy_register_fixup_for_uid(VCS8641_PHY_ID, VCS8641_PHY_MASK,
+					   x600_phy_fixup);
 }
 
 static const char *spear600_dt_board_compat[] = {
-- 
1.7.12.1
