From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:48 -0700
Subject: [PATCH 24/47] davinci: am18x/da850/omap-l138 evm: setup NAND flash
	timing
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-25-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Setup the NAND flash timings for DA850 EVM

Before configuring the timing values, throughput calculation
using dd command yielded 469 kB/s write and 966 kB/s read speed.

After the timing configuration, the throughput was measured to
be 2.4 MB/s write and 5 MB/s read.

[Mukul Bhatnagar: actual calculation of timing values from the
NAND datasheet]

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Cc: Mukul Bhatnagar <mbhatnagar@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 190ebd3..c1d45d7 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -36,6 +36,7 @@
 #include <mach/da8xx.h>
 #include <mach/nand.h>
 #include <mach/mux.h>
+#include <mach/aemif.h>
 
 #define DA850_EVM_PHY_MASK		0x1
 #define DA850_EVM_MDIO_FREQUENCY	2200000 /* PHY bus frequency */
@@ -143,12 +144,23 @@ static struct mtd_partition da850_evm_nandflash_partition[] = {
 	},
 };
 
+static struct davinci_aemif_timing da850_evm_nandflash_timing = {
+	.wsetup		= 24,
+	.wstrobe	= 21,
+	.whold		= 14,
+	.rsetup		= 19,
+	.rstrobe	= 50,
+	.rhold		= 0,
+	.ta		= 20,
+};
+
 static struct davinci_nand_pdata da850_evm_nandflash_data = {
 	.parts		= da850_evm_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(da850_evm_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
 	.ecc_bits	= 4,
 	.options	= NAND_USE_FLASH_BBT,
+	.timing		= &da850_evm_nandflash_timing,
 };
 
 static struct resource da850_evm_nandflash_resource[] = {
-- 
1.7.2.1
