From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 20 May 2015 16:03:48 +0200
Subject: [PATCH v5 05/12] mtd: pxa3xx_nand: rework flash detection and
 timing setup
In-Reply-To: <5557BE85.4050208@vanguardiasur.com.ar>
References: <1431356341-31640-1-git-send-email-antoine.tenart@free-electrons.com>
 <1431356341-31640-6-git-send-email-antoine.tenart@free-electrons.com>
 <5557BE85.4050208@vanguardiasur.com.ar>
Message-ID: <20150520140348.GL22054@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel,

On Sat, May 16, 2015 at 07:02:45PM -0300, Ezequiel Garcia wrote:
> On 05/11/2015 11:58 AM, Antoine Tenart wrote:

> > -
> >  	ndcr |= (pdata->enable_arbiter) ? NDCR_ND_ARB_EN : 0;
> >  	ndcr |= (host->col_addr_cycles == 2) ? NDCR_RA_START : 0;
> > -	ndcr |= (f->page_per_block == 64) ? NDCR_PG_PER_BLK : 0;
> > -	ndcr |= (f->page_size == 2048) ? NDCR_PAGE_SZ : 0;
> > -	ndcr |= (f->flash_width == 16) ? NDCR_DWIDTH_M : 0;
> > -	ndcr |= (f->dfc_width == 16) ? NDCR_DWIDTH_C : 0;
> > +	ndcr |= (chip->page_shift == 6) ? NDCR_PG_PER_BLK : 0;
> > +	ndcr |= (mtd->writesize == 2048) ? NDCR_PAGE_SZ : 0;
> 
> By the time you call this, there's no detected flash, so there's
> no geometry information such as mtd->writesize, chip->page_shift, etc.

I'll move this to pxa3xx_nand_init_timings().

> > @@ -1577,64 +1558,20 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
> >  		return ret;
> >  	}
> >  
> > -	chip->cmdfunc(mtd, NAND_CMD_READID, 0, 0);
> > -	id = *((uint16_t *)(info->data_buff));
> > -	if (id != 0)
> > -		dev_info(&info->pdev->dev, "Detect a flash id %x\n", id);
> > -	else {
> > -		dev_warn(&info->pdev->dev,
> > -			 "Read out ID 0, potential timing set wrong!!\n");
> > -
> > -		return -EINVAL;
> > -	}
> > -
> > -	num = ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1;
> > -	for (i = 0; i < num; i++) {
> > -		if (i < pdata->num_flash)
> > -			f = pdata->flash + i;
> > -		else
> > -			f = &builtin_flash_types[i - pdata->num_flash + 1];
> > -
> > -		/* find the chip in default list */
> > -		if (f->chip_id == id)
> > -			break;
> > -	}
> > -
> > -	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1)) {
> > -		dev_err(&info->pdev->dev, "ERROR!! flash not defined!!!\n");
> > -
> > -		return -EINVAL;
> > -	}
> > -
> > -	ret = pxa3xx_nand_config_flash(info, f);
> 
> This second call to pxa3xx_nand_config_flash was in charge of re-configuring
> the device after proper identification.
> 
> I'd say a proper approach is to configure default parameters,
> call nand_scan_ident, and finally re-configure using the detected values.

That's what is done already, default parameters are setup in
pxa3xx_nand_sensing(), using onfi_async_timing_mode_to_sdr_timings(0).
Then once the device is recognized, the proper timings are used by
calling pxa3xx_nand_init_timings().

Did I miss something here?

> READ_ID should only needs a few parameters to work (e.g. read_id_bytes),
> and those are the ones that need an initial default. The rest can remain
> null until the device is known.
> 
> Regarding read_id_bytes default value, using '4' makes sense and should
> work in all cases.

I agree.

> > -	if (ret) {
> > -		dev_err(&info->pdev->dev, "ERROR! Configure failed\n");
> > -		return ret;
> > -	}
> > -
> > -	memset(pxa3xx_flash_ids, 0, sizeof(pxa3xx_flash_ids));
> > -
> > -	pxa3xx_flash_ids[0].name = f->name;
> > -	pxa3xx_flash_ids[0].dev_id = (f->chip_id >> 8) & 0xffff;
> > -	pxa3xx_flash_ids[0].pagesize = f->page_size;
> > -	chipsize = (uint64_t)f->num_blocks * f->page_per_block * f->page_size;
> > -	pxa3xx_flash_ids[0].chipsize = chipsize >> 20;
> > -	pxa3xx_flash_ids[0].erasesize = f->page_size * f->page_per_block;
> > -	if (f->flash_width == 16)
> > -		pxa3xx_flash_ids[0].options = NAND_BUSWIDTH_16;
> > -	pxa3xx_flash_ids[1].name = NULL;
> > -	def = pxa3xx_flash_ids;
> >  KEEP_CONFIG:
> > -	if (info->reg_ndcr & NDCR_DWIDTH_M)
> > -		chip->options |= NAND_BUSWIDTH_16;
> > -
> >  	/* Device detection must be done with ECC disabled */
> >  	if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370)
> >  		nand_writel(info, NDECCCTRL, 0x0);
> >  
> > -	if (nand_scan_ident(mtd, 1, def))
> > +	if (nand_scan_ident(mtd, 1, NULL))
> >  		return -ENODEV;
> >  
> 
> We only want to configure timings if keep_config is false. Otherwise,
> this breaks on platforms that don't have timings and don't support ONFI.

Right, I'll fix this.

> 
> > +	ret = pxa3xx_nand_init_timings(host);
> > +	if (ret) {
> > +		dev_err(&info->pdev->dev, "Failed to set timings: %d\n", ret);
> > +		return ret;
> > +	}
> > +

> > @@ -1732,6 +1669,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
> >  		host->mtd = mtd;
> >  		host->cs = cs;
> >  		host->info_data = info;
> > +		host->read_id_bytes = 4;
> >  		mtd->priv = host;
> >  		mtd->owner = THIS_MODULE;
> >  
> 
> Aside from this comments, I really like this four patches. They clean most of
> the mess and introduce proper timing configuration. In fact, this cleanup
> might help removing the keep_config property on mvebu boards.

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
