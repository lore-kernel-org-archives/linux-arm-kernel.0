From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:49 -0700
Subject: [PATCH 25/47] davinci: dm6467t evm: setup NAND flash timing
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-26-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Setup NAND flash timing on DM6467T EVM.

Without the timing setup, the NAND flash on DM6467T
RevC EVM reports a number of random bad blocks because
of read errors.

Also, with this, copying a 100M file on RevB EVM takes
~35 sec against 1 minute 30 seconds earlier.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 4502f34..5a29955 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -42,6 +42,7 @@
 #include <mach/nand.h>
 #include <mach/clock.h>
 #include <mach/cdce949.h>
+#include <mach/aemif.h>
 
 #include "clock.h"
 
@@ -71,6 +72,16 @@ static struct mtd_partition davinci_nand_partitions[] = {
 	}
 };
 
+static struct davinci_aemif_timing dm6467tevm_nandflash_timing = {
+	.wsetup		= 29,
+	.wstrobe	= 24,
+	.whold		= 14,
+	.rsetup		= 19,
+	.rstrobe	= 33,
+	.rhold		= 0,
+	.ta		= 29,
+};
+
 static struct davinci_nand_pdata davinci_nand_data = {
 	.mask_cle 		= 0x80000,
 	.mask_ale 		= 0x40000,
@@ -763,6 +774,9 @@ static __init void evm_init(void)
 	dm646x_init_mcasp0(&dm646x_evm_snd_data[0]);
 	dm646x_init_mcasp1(&dm646x_evm_snd_data[1]);
 
+	if (machine_is_davinci_dm6467tevm())
+		davinci_nand_data.timing = &dm6467tevm_nandflash_timing;
+
 	platform_device_register(&davinci_nand_device);
 
 	dm646x_init_edma(dm646x_edma_rsv);
-- 
1.7.2.1
