From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 16 Oct 2018 14:17:54 +0200
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
In-Reply-To: <20181016140411.3f06e449@bbrezillon>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
 <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181016140411.3f06e449@bbrezillon>
Message-ID: <20181016141754.38dfcf90@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Oct 2018 14:04:11 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Tue, 16 Oct 2018 09:51:47 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > Hi Tudor,
> > 
> > This patch is breaking the 1-4-4 Read protocol for the spansion flash "s25fl512s".
> > 
> > Without this patch read request command for Quad mode, 4-byte enable, is coming as 0xEC i.e. SPINOR_OP_READ_1_4_4_4B.
> > But after applying this patch, read request command for Quad mode is coming as 0x6C i.e. SPINOR_OP_READ_1_1_4_4B.
> > 
> > This flash also supports non-uniform erase.
> > Can you please check and provide some suggestion?  
> 
> Are you sure the regression comes from this patch? I suspect your bug
> comes from 41fe242979e4 ("mtd: spi-nor: fsl-quadspi: fix read error for
> flash size larger than 16MB").

I guess you're testing with an fsl-qspi controller, right? Can you try
with this patch?

--->8---

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 1ff3430f82c8..c47fe70c9f98 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -477,9 +477,6 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
 {
        switch (cmd) {
-       case SPINOR_OP_READ_1_1_4:
-       case SPINOR_OP_READ_1_1_4_4B:
-               return SEQID_READ;
        case SPINOR_OP_WREN:
                return SEQID_WREN;
        case SPINOR_OP_WRDI:
@@ -490,8 +487,6 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
                return SEQID_SE;
        case SPINOR_OP_CHIP_ERASE:
                return SEQID_CHIP_ERASE;
-       case SPINOR_OP_PP:
-               return SEQID_PP;
        case SPINOR_OP_RDID:
                return SEQID_RDID;
        case SPINOR_OP_WRSR:
@@ -503,7 +498,11 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
        case SPINOR_OP_BRWR:
                return SEQID_BRWR;
        default:
-               if (cmd == q->nor[0].erase_opcode)
+               if (cmd == q->nor[0].read_opcode)
+                       return SEQID_READ;
+               else if (cmd == q->nor[0].program_opcode)
+                       return SEQID_PP;
+               else if (cmd == q->nor[0].erase_opcode)
                        return SEQID_SE;
                dev_err(q->dev, "Unsupported cmd 0x%.2x\n", cmd);
                break;
