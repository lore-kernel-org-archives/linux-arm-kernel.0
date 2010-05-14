From: leiwen@marvell.com (Lei Wen)
Date: Fri, 14 May 2010 13:31:04 +0800
Subject: [PATCH] mmp: refresh nand timing
Message-ID: <mailman.441.1273818283.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the NAND clock of PXA168. And adjust the nand timing configuration.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/configs/pxa168_defconfig |   98 ++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-mmp/pxa168.c        |    2 +-
 drivers/mtd/nand/pxa3xx_nand.c    |    5 +-
 3 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/pxa168_defconfig
b/arch/arm/configs/pxa168_defconfig
index 113511f..909bbfa 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -301,7 +301,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs
nfsroot=192.168.2.100:/nfsroot/
ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on
console=ttyS0,115200 mem=128M"
+CONFIG_CMDLINE="root=/dev/mtdblock4 rootfstype=jffs2
ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on
console=ttyS0,115200 mem=128M"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set

@@ -438,7 +438,89 @@ CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AFS_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+# CONFIG_MTD_NAND_GPIO is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+CONFIG_MTD_NAND_PXA3xx=y
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
 # CONFIG_BLK_DEV is not set
 # CONFIG_MISC_DEVICES is not set
@@ -720,6 +802,18 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_LOGFS is not set
 CONFIG_CRAMFS=y
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 1873c82..0ee09cf 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -73,7 +73,7 @@ static APBC_CLK(pwm2, PXA168_PWM2, 1, 13000000);
 static APBC_CLK(pwm3, PXA168_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA168_PWM4, 1, 13000000);

-static APMU_CLK(nand, NAND, 0x01db, 208000000);
+static APMU_CLK(nand, NAND, 0x019b, 156000000);

 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] = {
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 793b64c..7c871af 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -330,11 +330,11 @@ static struct pxa3xx_nand_flash __devinitdata
builtin_flash_types[] = {
 { 0x46ec, 32, 512, 16, 16, ECC_HAMMIN, 4096, \
 	{ 0, 10, 0, 20, 40, 30, 40, 11123, 0, 110, 10, }, },
 { 0xdaec, 64, 2048, 8, 8, ECC_HAMMIN, 2048, \
-	{ 0, 10, 0, 20, 40, 30, 40, 11123, 0, 110, 10, }, },
+	{ 0, 10, 0, 20, 40, 30, 40, 25000, 0, 110, 10, }, },
 { 0xd3ec, 128, 2048, 8, 8, ECC_BCH, 4096, \
 	{ 0, 10, 0, 20, 40, 30, 40, 11123, 0, 110, 10, }, },
 { 0xd7ec, 128, 4096, 8, 8, ECC_BCH, 8192, \
-	{ 0, 10, 0, 20, 40, 30, 40, 25000, 0, 110, 10, }, },
+	{ 200, 10, 15, 10, 12, 10, 8, 60000, 20, 75, 10, }, },
 { 0xa12c, 64, 2048, 8, 8, ECC_HAMMIN, 1024, \
 	{ 0, 10, 25, 15, 25, 15, 30, 25000, 0, 60, 10, }, },
 { 0xb12c, 64, 2048, 16, 16, ECC_HAMMIN, 1024, \
@@ -509,7 +509,6 @@ static void pxa3xx_nand_set_timing(struct
pxa3xx_nand_info *info,
 		| NDTR1_tWHR(ns2cycle(t->tWHR, nand_clk))
 		| NDTR1_tAR(ns2cycle(t->tAR, nand_clk));

-
 	nand_writel(nand, NDTR0CS0, ndtr0);
 	nand_writel(nand, NDTR1CS0, ndtr1);
 	nand_writel(nand, NDREDEL, 0x0);
-- 
1.5.6.5
