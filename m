From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  9 Jul 2018 17:57:03 +0200
Subject: [PATCH 2/3] mtd: atmel nand: fix build warning on 64-bit
In-Reply-To: <20180709155730.2422841-1-arnd@arndb.de>
References: <20180709155730.2422841-1-arnd@arndb.de>
Message-ID: <20180709155730.2422841-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Build-testing this driver on a 64-bit architecture produces a
harmless warning:

drivers/mtd/nand/raw/atmel/nand-controller.c: In function 'atmel_smc_nand_controller_init':
drivers/mtd/nand/raw/atmel/nand-controller.c:2053:21: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

To cast the pointer correctly, the destination type should be
uintptr_t rather than a 32-bit int.

Fixes: c2f3d0b913a5 ("mtd: rawnand: atmel: Allow selection of this driver when COMPILE_TEST=y")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index e686fe73159e..e8f7549d0354 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2050,7 +2050,7 @@ atmel_smc_nand_controller_init(struct atmel_smc_nand_controller *nc)
 		return ret;
 	}
 
-	nc->ebi_csa_offs = (unsigned int)match->data;
+	nc->ebi_csa_offs = (uintptr_t)match->data;
 
 	/*
 	 * The at91sam9263 has 2 EBIs, if the NAND controller is under EBI1
-- 
2.9.0
