From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue, 14 Jul 2015 16:11:19 +0200
Subject: [PATCH v1 3/7] mtd: fsl-quadspi: Support both 24- and 32-bit
 addressed commands.
In-Reply-To: <1436386881-28088-4-git-send-email-cory.tusar@pid1solutions.com>
References: <1436386881-28088-1-git-send-email-cory.tusar@pid1solutions.com>
 <1436386881-28088-4-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <1991808.GxeN5ENdEz@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Cory,

On Wednesday 08 July 2015 16:21:17, Cory Tusar wrote:
> The current fsl-quadspi implementation assumes that all connected
> devices are of the same size and type.  This commit adds lookup table
> entries for both 24- and 32-bit addressed variants of the read, sector
> erase, and page program operations as a precursor to later changes which
> generalize the flash layout parsing logic and allow for non-contiguous
> and non-homogeneous chip combinations.
> 
> Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
> 
> [...]
>  /* Get the SEQID for the command */
> -static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
> +static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd, u8 addr_width)
>  {
>  	switch (cmd) {
>  	case SPINOR_OP_READ_1_1_4:
> -		return SEQID_QUAD_READ;
> +		if (addr_width == 3)
> +			return SEQID_QUAD_READ_24;
> +		if (addr_width == 4)
> +			return SEQID_QUAD_READ_32;
> +		dev_err(q->dev, "Unsupported addr_width (%d) for cmd 0x%.2x\n",
> +			addr_width, cmd);
> +		break;

Does this actually work? What if q->nor[0].read_opcode is SPINOR_OP_READ4_1_1_4 (set in spi-nor.c for flashes using 4 byte address commands)?

>  	case SPINOR_OP_WREN:
>  		return SEQID_WREN;
>  	case SPINOR_OP_WRDI:
> @@ -403,11 +394,23 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
>  	case SPINOR_OP_RDSR:
>  		return SEQID_RDSR;
>  	case SPINOR_OP_SE:
> -		return SEQID_SE;
> +		if (addr_width == 3)
> +			return SEQID_SE_24;
> +		if (addr_width == 4)
> +			return SEQID_SE_32;
> +		dev_err(q->dev, "Unsupported addr_width (%d) for cmd 0x%.2x\n",
> +			addr_width, cmd);
> +		break;

Same as for read command.

>  	case SPINOR_OP_CHIP_ERASE:
>  		return SEQID_CHIP_ERASE;
>  	case SPINOR_OP_PP:
> -		return SEQID_PP;
> +		if (addr_width == 3)
> +			return SEQID_PP_24;
> +		if (addr_width == 4)
> +			return SEQID_PP_32;
> +		dev_err(q->dev, "Unsupported addr_width (%d) for cmd 0x%.2x\n",
> +			addr_width, cmd);
> +		break;

See above too.

>  	case SPINOR_OP_RDID:
>  		return SEQID_RDID;
>  	case SPINOR_OP_WRSR:
> @@ -456,7 +459,7 @@ fsl_qspi_runcmd(struct fsl_qspi *q, u8 cmd, unsigned int addr, int len)
>  	} while (1);
>  
>  	/* trigger the LUT now */
> -	seqid = fsl_qspi_get_seqid(q, cmd);
> +	seqid = fsl_qspi_get_seqid(q, cmd, q->nor[0].addr_width);
>  	writel((seqid << QUADSPI_IPCR_SEQID_SHIFT) | len, base + QUADSPI_IPCR);
>  
>  	/* Wait for the interrupt. */
> @@ -601,9 +604,10 @@ static void fsl_qspi_init_abh_read(struct fsl_qspi *q)
>  	writel(0, base + QUADSPI_BUF2IND);
>  
>  	/* Set the default lut sequence for AHB Read. */
> -	seqid = fsl_qspi_get_seqid(q, q->nor[0].read_opcode);
> +	seqid = fsl_qspi_get_seqid(q, q->nor[0].read_opcode,
> +			q->nor[0].addr_width);
>  	writel(seqid << QUADSPI_BFGENCR_SEQID_SHIFT,

Those changes can then be skipped you explicitly do switch/case for 4 byte address commands.

Best reagrds,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082
