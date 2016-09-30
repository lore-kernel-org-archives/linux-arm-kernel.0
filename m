From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 30 Sep 2016 12:04:46 +0200
Subject: [PATCH v3 1/9] mtd:fsl-quadspi:use the property fields of SPI-NOR
In-Reply-To: <1471505884-33996-1-git-send-email-B56489@freescale.com>
References: <1471505884-33996-1-git-send-email-B56489@freescale.com>
Message-ID: <22010794-652a-4f1e-21ec-4f0025073a82@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yunhui,

Indeed it's a really good thing to update the Freescale QSPI controller driver
so it relies more on the settings chosen in spi-nor.c: it avoids duplicating
the code. spi-nor.c is supposed to select all the instruction codes and memory
settings according to both the (Q)SPI memory and the controller capabilities.
The controller driver should only be responsible for sending the SPI commands
but should neither modify those commands nor be aware of the actual memory
connected to it.

So the idea of this patch is great :)

Best regards,

Cyrille

Le 18/08/2016 ? 09:37, Yunhui Cui a ?crit :
> We can get the read/write/erase opcode from the spi nor framework
> directly. This patch uses the information stored in the SPI-NOR to
> remove the hardcode in the fsl_qspi_init_lut().
> 
> Signed-off-by: Yunhui Cui <B56489@freescale.com>
> Signed-off-by: Yunhui Cui <yunhui.cui@nxp.com>
Reviewed-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  drivers/mtd/spi-nor/fsl-quadspi.c | 40 ++++++++++++---------------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
> index 5c82e4e..5ad6402 100644
> --- a/drivers/mtd/spi-nor/fsl-quadspi.c
> +++ b/drivers/mtd/spi-nor/fsl-quadspi.c
> @@ -373,9 +373,13 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
>  	void __iomem *base = q->iobase;
>  	int rxfifo = q->devtype_data->rxfifo;
>  	u32 lut_base;
> -	u8 cmd, addrlen, dummy;
>  	int i;
>  
> +	struct spi_nor *nor = &q->nor[0];
> +	u8 addrlen = (nor->addr_width == 3) ? ADDR24BIT : ADDR32BIT;
> +	u8 read_op = nor->read_opcode;
> +	u8 read_dm = nor->read_dummy;
> +
>  	fsl_qspi_unlock_lut(q);
>  
>  	/* Clear all the LUT table */
> @@ -385,20 +389,10 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
>  	/* Quad Read */
>  	lut_base = SEQID_QUAD_READ * 4;
>  
> -	if (q->nor_size <= SZ_16M) {
> -		cmd = SPINOR_OP_READ_1_1_4;
> -		addrlen = ADDR24BIT;
> -		dummy = 8;
> -	} else {
> -		/* use the 4-byte address */
> -		cmd = SPINOR_OP_READ_1_1_4;
> -		addrlen = ADDR32BIT;
> -		dummy = 8;
> -	}
> -
> -	qspi_writel(q, LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
> +	qspi_writel(q, LUT0(CMD, PAD1, read_op) | LUT1(ADDR, PAD1, addrlen),
>  			base + QUADSPI_LUT(lut_base));
> -	qspi_writel(q, LUT0(DUMMY, PAD1, dummy) | LUT1(FSL_READ, PAD4, rxfifo),
> +	qspi_writel(q, LUT0(DUMMY, PAD1, read_dm) |
> +		    LUT1(FSL_READ, PAD4, rxfifo),
>  			base + QUADSPI_LUT(lut_base + 1));
>  
>  	/* Write enable */
> @@ -409,16 +403,8 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
>  	/* Page Program */
>  	lut_base = SEQID_PP * 4;
>  
> -	if (q->nor_size <= SZ_16M) {
> -		cmd = SPINOR_OP_PP;
> -		addrlen = ADDR24BIT;
> -	} else {
> -		/* use the 4-byte address */
> -		cmd = SPINOR_OP_PP;
> -		addrlen = ADDR32BIT;
> -	}
> -
> -	qspi_writel(q, LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
> +	qspi_writel(q, LUT0(CMD, PAD1, nor->program_opcode) |
> +		    LUT1(ADDR, PAD1, addrlen),
>  			base + QUADSPI_LUT(lut_base));
>  	qspi_writel(q, LUT0(FSL_WRITE, PAD1, 0),
>  			base + QUADSPI_LUT(lut_base + 1));
> @@ -432,10 +418,8 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
>  	/* Erase a sector */
>  	lut_base = SEQID_SE * 4;
>  
> -	cmd = q->nor[0].erase_opcode;
> -	addrlen = q->nor_size <= SZ_16M ? ADDR24BIT : ADDR32BIT;
> -
> -	qspi_writel(q, LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
> +	qspi_writel(q, LUT0(CMD, PAD1, nor->erase_opcode) |
> +		    LUT1(ADDR, PAD1, addrlen),
>  			base + QUADSPI_LUT(lut_base));
>  
>  	/* Erase the whole chip */
> 
