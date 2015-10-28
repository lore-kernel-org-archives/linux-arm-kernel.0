From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 28 Oct 2015 09:13:45 +0000
Subject: [PATCH v3 1/2] mtd: brcmnand: Force 8bit mode before doing
 nand_scan_ident()
In-Reply-To: <20151028001443.GX13239@google.com>
References: <1445577373-21252-1-git-send-email-anup.patel@broadcom.com>
 <1445577373-21252-2-git-send-email-anup.patel@broadcom.com>
 <20151028001443.GX13239@google.com>
Message-ID: <39063E8F96E11742B35A201CC5D095B7AFFBBB@SJEXCHMB10.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Brian Norris [mailto:computersforpeace at gmail.com]
> Sent: 28 October 2015 05:45
> To: Anup Patel
> Cc: David Woodhouse; Linux MTD; Rob Herring; Pawel Moll; Mark Rutland;
> Catalin Marinas; Will Deacon; Sudeep Holla; Ian Campbell; Kumar Gala; Ray Jui;
> Scott Branden; Florian Fainelli; Pramod Kumar; Vikram Prakash; Sandeep
> Tripathy; Linux ARM Kernel; Device Tree; Linux Kernel; bcm-kernel-feedback-list
> Subject: Re: [PATCH v3 1/2] mtd: brcmnand: Force 8bit mode before doing
> nand_scan_ident()
> 
> On Fri, Oct 23, 2015 at 10:46:12AM +0530, Anup Patel wrote:
> > Just like other NAND controllers, the NAND READID command only works
> > in 8bit mode for all versions of BRCMNAND controller.
> >
> > This patch forces 8bit mode for each NAND CS in brcmnand_init_cs()
> > before doing nand_scan_ident() to ensure that BRCMNAND controller is
> > in 8bit mode when NAND READID command is issued.
> >
> > Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> > Reviewed-by: Ray Jui <rjui@broadcom.com>
> > Reviewed-by: Scott Branden <sbranden@broadcom.com>
> > ---
> >  drivers/mtd/nand/brcmnand/brcmnand.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c
> > b/drivers/mtd/nand/brcmnand/brcmnand.c
> > index 4cba03d..0be8ef9 100644
> > --- a/drivers/mtd/nand/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/brcmnand/brcmnand.c
> > @@ -1888,6 +1888,7 @@ static int brcmnand_init_cs(struct brcmnand_host
> *host)
> >  	struct mtd_info *mtd;
> >  	struct nand_chip *chip;
> >  	int ret;
> > +	u16 cfg_offs;
> >  	struct mtd_part_parser_data ppdata = { .of_node = dn };
> >
> >  	ret = of_property_read_u32(dn, "reg", &host->cs); @@ -1930,6
> > +1931,14 @@ static int brcmnand_init_cs(struct brcmnand_host *host)
> >
> >  	chip->controller = &ctrl->controller;
> >
> > +	/*
> > +	 * The bootloader might have configured 16bit mode but
> > +	 * NAND READID command only works in 8bit mode. We force
> > +	 * 8bit mode here to ensure that NAND READID commands works.
> > +	 */
> > +	cfg_offs = brcmnand_cs_offset(ctrl, host->cs, BRCMNAND_CS_CFG);
> > +	nand_writereg(ctrl, cfg_offs, nand_readreg(ctrl, cfg_offs) &
> > +~BIT(23));
> 
> Can we get a new enum for cfg bits? Unfortunately, I never managed that in
> brcmnand_set_cfg(); just magic numbers :( But I'd like to stop that if we're going
> to have to touch these bits outside of brcmnand_set_cfg().

Even I felt the need to have enum for cfg bits, just like other parts of the
BRCM NAND driver.

> 
> > +
> >  	if (nand_scan_ident(mtd, 1, NULL))
> >  		return -ENXIO;
> >
> 
> How about the following, as a preparatory patch? Only compile tested.
> 
> From c5423a86dbfa33b550d2b170bda3c12ecf4d5313 Mon Sep 17 00:00:00
> 2001
> From: Brian Norris <computersforpeace@gmail.com>
> Date: Tue, 27 Oct 2015 17:12:13 -0700
> Subject: [PATCH] mtd: brcmnand: factor out CFG and CFG_EXT bitfields
> 
> These used magic numbers. Shame on me.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Anup Patel <anup.patel@broadcom.com>
> ---
>  drivers/mtd/nand/brcmnand/brcmnand.c | 38
> +++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c
> b/drivers/mtd/nand/brcmnand/brcmnand.c
> index d694d876631e..c93fbc3869ee 100644
> --- a/drivers/mtd/nand/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/brcmnand/brcmnand.c
> @@ -344,6 +344,28 @@ static const u8 brcmnand_cs_offsets_cs0[] = {
>  	[BRCMNAND_CS_TIMING2]		= 0x14,
>  };
> 
> +/*
> + * Bitfields for the CFG and CFG_EXT registers. Pre-v7.1 controllers
> +only had
> + * one config register, but once the bitfields overflowed, newer
> +controllers
> + * (v7.1 and newer) added a CFG_EXT register and shuffled a few fields around.
> + */
> +enum {
> +	CFG_BLK_ADR_BYTES_SHIFT		= 8,
> +	CFG_COL_ADR_BYTES_SHIFT		= 12,
> +	CFG_FUL_ADR_BYTES_SHIFT		= 16,
> +	CFG_BUS_WIDTH_SHIFT		= 23,
> +	CFG_BUS_WIDTH			=
> BIT(CFG_BUS_WIDTH_SHIFT),
> +	CFG_DEVICE_SIZE_SHIFT		= 24,
> +
> +	/* Only for pre-v7.1 (with no CFG_EXT register) */
> +	CFG_PAGE_SIZE_SHIFT		= 20,
> +	CFG_BLK_SIZE_SHIFT		= 28,
> +
> +	/* Only for v7.1+ (with CFG_EXT register) */
> +	CFG_EXT_PAGE_SIZE_SHIFT		= 0,
> +	CFG_EXT_BLK_SIZE_SHIFT		= 4,
> +};
> +
>  /* BRCMNAND_INTFC_STATUS */
>  enum {
>  	INTFC_FLASH_STATUS		= GENMASK(7, 0),
> @@ -1710,17 +1732,19 @@ static int brcmnand_set_cfg(struct brcmnand_host
> *host,
>  	}
>  	device_size = fls64(cfg->device_size) -
> fls64(BRCMNAND_MIN_DEVSIZE);
> 
> -	tmp = (cfg->blk_adr_bytes << 8) |
> -		(cfg->col_adr_bytes << 12) |
> -		(cfg->ful_adr_bytes << 16) |
> -		(!!(cfg->device_width == 16) << 23) |
> -		(device_size << 24);
> +	tmp = (cfg->blk_adr_bytes << CFG_BLK_ADR_BYTES_SHIFT) |
> +		(cfg->col_adr_bytes << CFG_BLK_ADR_BYTES_SHIFT) |
> +		(cfg->ful_adr_bytes << CFG_FUL_ADR_BYTES_SHIFT) |
> +		(!!(cfg->device_width == 16) << CFG_BUS_WIDTH_SHIFT) |
> +		(device_size << CFG_DEVICE_SIZE_SHIFT);
>  	if (cfg_offs == cfg_ext_offs) {
> -		tmp |= (page_size << 20) | (block_size << 28);
> +		tmp |= (page_size << CFG_PAGE_SIZE_SHIFT) |
> +		       (block_size << CFG_BLK_SIZE_SHIFT);
>  		nand_writereg(ctrl, cfg_offs, tmp);
>  	} else {
>  		nand_writereg(ctrl, cfg_offs, tmp);
> -		tmp = page_size | (block_size << 4);
> +		tmp = (page_size << CFG_EXT_PAGE_SIZE_SHIFT) |
> +		      (block_size << CFG_EXT_BLK_SIZE_SHIFT);
>  		nand_writereg(ctrl, cfg_ext_offs, tmp);
>  	}

Your patch looks good to me. I will base this patch upon your
patch and test it at my end.

I will send a revised patchset which will include your patch (preserving
your authorship) and tested on NS2 SVK.

Thanks,
Anup
