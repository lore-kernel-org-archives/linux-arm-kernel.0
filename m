From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 22:38:08 +0100
Subject: [PATCH] mtd: nuc900_nand: read correct SMISR register
Message-ID: <9019174.GYajdpGP8V@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nuc900_nand driver has always passed an incorrect register
address in its nuc900_check_rb() function, which cannot possibly
work, and in some configurations gives us a build warning:

drivers/mtd/nand/nuc900_nand.c: In function 'nuc900_check_rb':
drivers/mtd/nand/nuc900_nand.c:27:23: warning: passing argument 1 of '__raw_readl' makes pointer from integer without a cast [-Wint-conversion]
 #define REG_SMISR     0xac
drivers/mtd/nand/nuc900_nand.c:118:20: note: in expansion of macro 'REG_SMISR'
  val = __raw_readl(REG_SMISR);

This makes sure we actually read from the register rather than
from (void *)0x000000ac in user space.

I suspect nobody noticed this before because the nuc900_nand_devready()
function never gets called, or nobody uses this driver on an upstream
kernel. Possibly even both.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 220ddfcf29f5..dbc5b571c2bb 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -113,7 +113,7 @@ static int nuc900_check_rb(struct nuc900_nand *nand)
 {
 	unsigned int val;
 	spin_lock(&nand->lock);
-	val = __raw_readl(REG_SMISR);
+	val = __raw_readl(nand->reg + REG_SMISR);
 	val &= READYBUSY;
 	spin_unlock(&nand->lock);
 
