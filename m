From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Sat, 20 Mar 2010 10:55:07 +0200
Subject: [PATCH] MTD: Fix Orion NAND driver compilation with ARM OABI
Message-ID: <20100320085507.4038.96426.stgit@pauliusz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We must tell GCC to use even register for variable passed
to ldrd instruction. Without this patch GCC 4.2.1 puts this
variable to r2/r3 on EABI and r3/r4 on OABI, so force it to
r2/r3. This does not change anything when EABI and OABI
compilation works OK.

Without this patch and with OABI I get:
  CC      drivers/mtd/nand/orion_nand.o
/tmp/ccMkwOCs.s: Assembler messages:
/tmp/ccMkwOCs.s:63: Error: first destination register must be even -- `ldrd r3,[ip]'
make[5]: *** [drivers/mtd/nand/orion_nand.o] Error 1

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---

 drivers/mtd/nand/orion_nand.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index f59c074..cb5175e 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -60,7 +60,12 @@ static void orion_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 	}
 	buf64 = (uint64_t *)buf;
 	while (i < len/8) {
-		uint64_t x;
+		/*
+		 * force x variable to r2/r3 registers since ldrd instruction
+		 * requires first register to be even.
+		 */
+		register uint64_t x asm ("r2");
+
 		asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
 		buf64[i++] = x;
 	}
