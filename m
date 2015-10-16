From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 16 Oct 2015 14:38:56 +0530
Subject: [PATCH v2 3/4] mtd: brcmnand: Force 8bit mode before doing
 nand_scan_ident()
In-Reply-To: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
References: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1444986537-28387-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like other NAND controllers, the NAND READID command only works
in 8bit mode for all versions of BRCMNAND controller.

This patch forces 8bit mode for each NAND CS in brcmnand_init_cs()
before doing nand_scan_ident() to ensure that BRCMNAND controller
is in 8bit mode when NAND READID command is issued.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/mtd/nand/brcmnand/brcmnand.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 4cba03d..0be8ef9 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1888,6 +1888,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host)
 	struct mtd_info *mtd;
 	struct nand_chip *chip;
 	int ret;
+	u16 cfg_offs;
 	struct mtd_part_parser_data ppdata = { .of_node = dn };
 
 	ret = of_property_read_u32(dn, "reg", &host->cs);
@@ -1930,6 +1931,14 @@ static int brcmnand_init_cs(struct brcmnand_host *host)
 
 	chip->controller = &ctrl->controller;
 
+	/*
+	 * The bootloader might have configured 16bit mode but
+	 * NAND READID command only works in 8bit mode. We force
+	 * 8bit mode here to ensure that NAND READID commands works.
+	 */
+	cfg_offs = brcmnand_cs_offset(ctrl, host->cs, BRCMNAND_CS_CFG);
+	nand_writereg(ctrl, cfg_offs, nand_readreg(ctrl, cfg_offs) & ~BIT(23));
+
 	if (nand_scan_ident(mtd, 1, NULL))
 		return -ENXIO;
 
-- 
1.9.1
