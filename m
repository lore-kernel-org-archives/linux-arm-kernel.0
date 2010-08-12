From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 12 Aug 2010 04:53:54 +0200
Subject: [PATCH 1/2 v2] ARM: Fix gen_nand probe structures contents
Message-ID: <1281581635-26213-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These three platforms didn't properly fill nr_chips in gen_nand registration and
therefore depended on gen_nand bug fixed by the following patch:

"mtd: gen_nand: fix support for multiple chips"

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
v2: Added other broken boards outside arch-arm (mips and bfin)
v1: Initial patch

 arch/arm/mach-ixp4xx/ixdp425-setup.c      |    1 +
 arch/arm/mach-mx3/mach-qong.c             |    1 +
 arch/arm/mach-orion5x/ts78xx-setup.c      |    1 +
 arch/blackfin/mach-bf537/boards/stamp.c   |    1 +
 arch/blackfin/mach-bf561/boards/acvilon.c |    1 +
 arch/mips/nxp/pnx833x/common/platform.c   |    1 +
 6 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 827cbc4..ea9ee4e 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -100,6 +100,7 @@ ixdp425_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 static struct platform_nand_data ixdp425_flash_nand_data = {
 	.chip = {
+		.nr_chips		= 1,
 		.chip_delay		= 30,
 		.options		= NAND_NO_AUTOINCR,
 #ifdef CONFIG_MTD_PARTITIONS
diff --git a/arch/arm/mach-mx3/mach-qong.c b/arch/arm/mach-mx3/mach-qong.c
index e5b5b83..1f9363f 100644
--- a/arch/arm/mach-mx3/mach-qong.c
+++ b/arch/arm/mach-mx3/mach-qong.c
@@ -169,6 +169,7 @@ static void qong_nand_select_chip(struct mtd_info *mtd, int chip)
 
 static struct platform_nand_data qong_nand_data = {
 	.chip = {
+		.nr_chips		= 1,
 		.chip_delay		= 20,
 		.options		= 0,
 	},
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 5041d1b..696b1a9 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -216,6 +216,7 @@ static struct mtd_partition ts78xx_ts_nand_parts[] = {
 
 static struct platform_nand_data ts78xx_ts_nand_data = {
 	.chip	= {
+		.nr_chips		= 1,
 		.part_probe_types	= ts_nand_part_probes,
 		.partitions		= ts78xx_ts_nand_parts,
 		.nr_partitions		= ARRAY_SIZE(ts78xx_ts_nand_parts),
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 9eaf5b0..68a27bc 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -400,6 +400,7 @@ static int bfin_plat_nand_dev_ready(struct mtd_info *mtd)
 
 static struct platform_nand_data bfin_plat_nand_data = {
 	.chip = {
+		.nr_chips = 1,
 		.chip_delay = 30,
 #ifdef CONFIG_MTD_PARTITIONS
 		.part_probe_types = part_probes,
diff --git a/arch/blackfin/mach-bf561/boards/acvilon.c b/arch/blackfin/mach-bf561/boards/acvilon.c
index bfcfa86..35b6d12 100644
--- a/arch/blackfin/mach-bf561/boards/acvilon.c
+++ b/arch/blackfin/mach-bf561/boards/acvilon.c
@@ -284,6 +284,7 @@ static int bfin_plat_nand_dev_ready(struct mtd_info *mtd)
 
 static struct platform_nand_data bfin_plat_nand_data = {
 	.chip = {
+		 .nr_chips = 1,
 		 .chip_delay = 30,
 #ifdef CONFIG_MTD_PARTITIONS
 		 .part_probe_types = part_probes,
diff --git a/arch/mips/nxp/pnx833x/common/platform.c b/arch/mips/nxp/pnx833x/common/platform.c
index 01f8345..ce45df1 100644
--- a/arch/mips/nxp/pnx833x/common/platform.c
+++ b/arch/mips/nxp/pnx833x/common/platform.c
@@ -266,6 +266,7 @@ pnx833x_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 static struct platform_nand_data pnx833x_flash_nand_data = {
 	.chip = {
+		.nr_chips		= 1,
 		.chip_delay		= 25,
 		.part_probe_types 	= part_probes,
 	},
-- 
1.7.1
