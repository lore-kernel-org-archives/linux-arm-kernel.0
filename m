From: b32955@freescale.com (Huang Shijie)
Date: Mon, 29 Aug 2011 19:13:01 +0800
Subject: [PATCH v11 3/3] MTD : add GPMI-NAND driver in the config and Makefile
In-Reply-To: <1314616381-11615-1-git-send-email-b32955@freescale.com>
References: <1314616381-11615-1-git-send-email-b32955@freescale.com>
Message-ID: <1314616381-11615-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the GPMI-NAND driver in the relevant Kconfig and Makefile in the MTD.

Signed-off-by: Huang Shijie <b32955@freescale.com>
Acked-by: Marek Vasut <marek.vasut@gmail.com>
Tested-by: Koen Beel <koen.beel@barco.com>
---
 drivers/mtd/nand/Kconfig            |   13 +++++++++++++
 drivers/mtd/nand/Makefile           |    1 +
 drivers/mtd/nand/gpmi-nand/Makefile |    3 +++
 3 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/gpmi-nand/Makefile

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 7ec5b49..42b7b86 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -417,6 +417,19 @@ config MTD_NAND_NANDSIM
 	  The simulator may simulate various NAND flash chips for the
 	  MTD nand layer.
 
+config MTD_NAND_GPMI_NAND
+        bool "GPMI NAND Flash Controller driver"
+        depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28)
+	select MTD_PARTITIONS
+	select MTD_CMDLINE_PARTS
+        help
+	 Enables NAND Flash support for IMX23 or IMX28.
+	 The GPMI controller is very powerful, with the help of BCH
+	 module, it can do the hardware ECC. The GPMI supports several
+	 NAND flashs at the same time. The GPMI may conflicts with other
+	 block, such as SD card. So pay attention to it when you enable
+	 the GPMI.
+
 config MTD_NAND_PLATFORM
 	tristate "Support for generic platform NAND driver"
 	help
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index c9334e9..618f4ba 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -48,5 +48,6 @@ obj-$(CONFIG_MTD_NAND_BCM_UMI)		+= bcm_umi_nand.o nand_bcm_umi.o
 obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
 obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
 obj-$(CONFIG_MTD_NAND_JZ4740)		+= jz4740_nand.o
+obj-$(CONFIG_MTD_NAND_GPMI_NAND)	+= gpmi-nand/
 
 nand-objs := nand_base.o nand_bbt.o
diff --git a/drivers/mtd/nand/gpmi-nand/Makefile b/drivers/mtd/nand/gpmi-nand/Makefile
new file mode 100644
index 0000000..3a46248
--- /dev/null
+++ b/drivers/mtd/nand/gpmi-nand/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_MTD_NAND_GPMI_NAND) += gpmi_nand.o
+gpmi_nand-objs += gpmi-nand.o
+gpmi_nand-objs += gpmi-lib.o
-- 
1.7.0.4
