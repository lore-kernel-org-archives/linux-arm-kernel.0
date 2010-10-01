From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:46 -0700
Subject: [PATCH 22/47] davinci: dm644x evm: setup NAND flash timing
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-23-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

The DM644x EVM nand flash timing was earlier being
done as a special case in the NAND driver itself.

With the NAND driver now capable of progamming the
AEMIF interface using timing data passed from the
platform, the timing values are being moved into
their rightful place in the EVM specific board file.

The values being programmed match what was being done
earlier and thus do not represent any change in
performance/functionality.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 34c8b41..65bb940 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -37,6 +37,7 @@
 #include <mach/nand.h>
 #include <mach/mmc.h>
 #include <mach/usb.h>
+#include <mach/aemif.h>
 
 #define DM644X_EVM_PHY_MASK		(0x2)
 #define DM644X_EVM_MDIO_FREQUENCY	(2200000) /* PHY bus frequency */
@@ -137,11 +138,22 @@ static struct mtd_partition davinci_evm_nandflash_partition[] = {
 	 */
 };
 
+static struct davinci_aemif_timing davinci_evm_nandflash_timing = {
+	.wsetup		= 20,
+	.wstrobe	= 40,
+	.whold		= 20,
+	.rsetup		= 10,
+	.rstrobe	= 40,
+	.rhold		= 10,
+	.ta		= 40,
+};
+
 static struct davinci_nand_pdata davinci_evm_nandflash_data = {
 	.parts		= davinci_evm_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(davinci_evm_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
 	.options	= NAND_USE_FLASH_BBT,
+	.timing		= &davinci_evm_nandflash_timing,
 };
 
 static struct resource davinci_evm_nandflash_resource[] = {
-- 
1.7.2.1
