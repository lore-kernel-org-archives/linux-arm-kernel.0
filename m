From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:47 -0700
Subject: [PATCH 23/47] davinci: am17x/da830/omap-l137 evm: setup NAND flash
	timing
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-24-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Setup the NAND flash timings for DA830 EVM.

Before configuring the timing values, throughput calculation
using dd command yielded 477 kB/s write and 970 kB/s read speed.

After the timing configuration, the throughput was measured to
be 2.5 MB/s write and 5.1 MB/s read.

[Mukul Bhatnagar: actual calculation of timing values from the
NAND datasheet]

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Cc: Mukul Bhatnagar <mbhatnagar@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 292e8b7..de82739 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -29,6 +29,7 @@
 #include <mach/nand.h>
 #include <mach/da8xx.h>
 #include <mach/usb.h>
+#include <mach/aemif.h>
 
 #define DA830_EVM_PHY_MASK		0x0
 #define DA830_EVM_MDIO_FREQUENCY	2200000	/* PHY bus frequency */
@@ -360,6 +361,16 @@ static struct nand_bbt_descr da830_evm_nand_bbt_mirror_descr = {
 	.pattern	= da830_evm_nand_mirror_pattern
 };
 
+static struct davinci_aemif_timing da830_evm_nandflash_timing = {
+	.wsetup         = 24,
+	.wstrobe        = 21,
+	.whold          = 14,
+	.rsetup         = 19,
+	.rstrobe        = 50,
+	.rhold          = 0,
+	.ta             = 20,
+};
+
 static struct davinci_nand_pdata da830_evm_nand_pdata = {
 	.parts		= da830_evm_nand_partitions,
 	.nr_parts	= ARRAY_SIZE(da830_evm_nand_partitions),
@@ -368,6 +379,7 @@ static struct davinci_nand_pdata da830_evm_nand_pdata = {
 	.options	= NAND_USE_FLASH_BBT,
 	.bbt_td		= &da830_evm_nand_bbt_main_descr,
 	.bbt_md		= &da830_evm_nand_bbt_mirror_descr,
+	.timing         = &da830_evm_nandflash_timing,
 };
 
 static struct resource da830_evm_nand_resources[] = {
-- 
1.7.2.1
