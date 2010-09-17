From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Sep 2010 10:55:04 -0700
Subject: [PATCH RESEND v4 1/4] omap3: nand: prefetch in irq mode support
In-Reply-To: <1284624059-1741-2-git-send-email-s-ghorai@ti.com>
References: <1284624059-1741-1-git-send-email-s-ghorai@ti.com>
	<1284624059-1741-2-git-send-email-s-ghorai@ti.com>
Message-ID: <20100917175504.GG29610@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sukumar Ghorai <s-ghorai@ti.com> [100916 00:53]:
> This patch enable prefetch-irq mode for NAND.
> 
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -467,6 +485,152 @@ static void omap_write_buf_dma_pref(struct mtd_info *mtd,
>  		omap_nand_dma_transfer(mtd, (u_char *) buf, len, 0x1);
>  }
>  
> +/*
> + * omap_nand_irq - GMPC irq handler
> + * @this_irq: gpmc irq number
> + * @dev: omap_nand_info structure pointer is passed here
> + */
> +static irqreturn_t omap_nand_irq(int this_irq, void *dev)
> +{
> +	struct omap_nand_info *info = (struct omap_nand_info *) dev;
> +	u32 bytes;
> +	u32 irq_stat;
> +
> +	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
> +	bytes = gpmc_read_status(GPMC_PREFETCH_FIFO_CNT);
> +	bytes = bytes  & 0xFFFC; /* io in multiple of 4 bytes */
> +	if (info->iomode == OMAP_NAND_IO_WRITE) { /* checks for write io */
> +		if (irq_stat & 0x2)
> +			goto done;
> +
> +		if (info->buf_len & (info->buf_len < bytes))
> +			bytes = info->buf_len;
> +		else if (!info->buf_len)
> +			bytes = 0;
> +		iowrite32_rep(info->nand.IO_ADDR_W,
> +						(u32 *)info->buf, bytes >> 2);
> +		info->buf = info->buf + bytes;
> +		info->buf_len -= bytes;
> +
> +	} else {
> +		ioread32_rep(info->nand.IO_ADDR_R,
> +						(u32 *)info->buf, bytes >> 2);
> +		info->buf = info->buf + bytes;
> +
> +		if (irq_stat & 0x2)
> +			goto done;
> +	}
> +	gpmc_cs_configure(info->gpmc_cs, GPMC_SET_IRQ_STATUS, irq_stat);
> +	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
> +
> +	return IRQ_HANDLED;
> +
> +done:
> +	complete(&info->comp);
> +	/* disable irq */
> +	gpmc_cs_configure(info->gpmc_cs, GPMC_ENABLE_IRQ, 0);
> +
> +	/* clear status */
> +	gpmc_cs_configure(info->gpmc_cs, GPMC_SET_IRQ_STATUS, irq_stat);
> +	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
> +
> +	return IRQ_HANDLED;
> +}

This handler should be in gpmc.c as it may be needed for other GPMC
connected devices on the same system. You can use chained irq handlers
to allow all the drivers to use the interrupt then.

Regards,

Tony
