From: b32955@freescale.com (Huang Shijie)
Date: Fri, 25 Mar 2011 18:23:01 +0800
Subject: [ PATCH V2  7/7] MTD : add GPMI driver in the config and Makefile
In-Reply-To: <1301048581-21321-1-git-send-email-b32955@freescale.com>
References: <1301048581-21321-1-git-send-email-b32955@freescale.com>
Message-ID: <1301048581-21321-8-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the GPMI driver in the relevant Kconfig and Makefile in the MTD.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/Kconfig           |   10 ++++++++++
 drivers/mtd/nand/Makefile          |    1 +
 drivers/mtd/nand/gpmi-nfc/Makefile |    7 +++++++
 3 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/gpmi-nfc/Makefile

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 450afc5..86effe8 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -426,6 +426,16 @@ config MTD_NAND_NANDSIM
 	  The simulator may simulate various NAND flash chips for the
 	  MTD nand layer.
 
+config MTD_NAND_GPMI_NFC
+        bool "GPMI NAND Flash Controller driver"
+        depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28)
+	select MTD_PARTITIONS
+        help
+	 Enables NAND Flash support for IMX23 or IMX28.
+	 The GPMI controller is very powerful, with the help of BCH
+	 module, it can do the hardware ECC. The GPMI supports several
+	 NAND flashs at the same time.
+
 config MTD_NAND_PLATFORM
 	tristate "Support for generic platform NAND driver"
 	help
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 8ad6fae..80d1f08 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -48,5 +48,6 @@ obj-$(CONFIG_MTD_NAND_BCM_UMI)		+= bcm_umi_nand.o nand_bcm_umi.o
 obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
 obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
 obj-$(CONFIG_MTD_NAND_JZ4740)		+= jz4740_nand.o
+obj-$(CONFIG_MTD_NAND_GPMI_NFC)		+= gpmi-nfc/
 
 nand-objs := nand_base.o nand_bbt.o
diff --git a/drivers/mtd/nand/gpmi-nfc/Makefile b/drivers/mtd/nand/gpmi-nfc/Makefile
new file mode 100644
index 0000000..4811303
--- /dev/null
+++ b/drivers/mtd/nand/gpmi-nfc/Makefile
@@ -0,0 +1,7 @@
+obj-$(CONFIG_MTD_NAND_GPMI_NFC) += gpmi-nfc.o
+gpmi-nfc-objs += gpmi-nfc-main.o
+gpmi-nfc-objs += hal-imx23.o
+gpmi-nfc-objs += hal-imx28.o
+gpmi-nfc-objs += rom-imx23.o
+gpmi-nfc-objs += rom-imx28.o
+gpmi-nfc-objs += ../nand_device_info.o
-- 
1.7.0.4
