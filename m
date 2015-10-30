From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 30 Oct 2015 06:58:59 +0000
Subject: [PATCH v4 2/3] mtd: brcmnand: Force 8bit mode before doing
 nand_scan_ident()
In-Reply-To: <1446185938-17520-3-git-send-email-anup.patel@broadcom.com>
References: <1446185938-17520-1-git-send-email-anup.patel@broadcom.com>
 <1446185938-17520-3-git-send-email-anup.patel@broadcom.com>
Message-ID: <39063E8F96E11742B35A201CC5D095B7B021B5@SJEXCHMB10.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Anup Patel [mailto:anup.patel at broadcom.com]
> Sent: 30 October 2015 11:49
> To: David Woodhouse; Brian Norris; Linux MTD
> Cc: Rob Herring; Pawel Moll; Mark Rutland; Catalin Marinas; Will Deacon;
> Sudeep Holla; Ian Campbell; Kumar Gala; Ray Jui; Scott Branden; Florian Fainelli;
> Pramod Kumar; Vikram Prakash; Sandeep Tripathy; Linux ARM Kernel; Device
> Tree; Linux Kernel; bcm-kernel-feedback-list; Anup Patel
> Subject: [PATCH v4 2/3] mtd: brcmnand: Force 8bit mode before doing
> nand_scan_ident()
> 
> Just like other NAND controllers, the NAND READID command only works in 8bit
> mode for all versions of BRCMNAND controller.
> 
> This patch forces 8bit mode for each NAND CS in brcmnand_init_cs() before
> doing nand_scan_ident() to ensure that BRCMNAND controller is in 8bit mode
> when NAND READID command is issued.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  drivers/mtd/nand/brcmnand/brcmnand.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c
> b/drivers/mtd/nand/brcmnand/brcmnand.c
> index dda96fa..641591d 100644
> --- a/drivers/mtd/nand/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/brcmnand/brcmnand.c
> @@ -1912,6 +1912,7 @@ static int brcmnand_init_cs(struct brcmnand_host
> *host)
>  	struct mtd_info *mtd;
>  	struct nand_chip *chip;
>  	int ret;
> +	u16 cfg_offs;
>  	struct mtd_part_parser_data ppdata = { .of_node = dn };
> 
>  	ret = of_property_read_u32(dn, "reg", &host->cs); @@ -1954,6
> +1955,15 @@ static int brcmnand_init_cs(struct brcmnand_host *host)
> 
>  	chip->controller = &ctrl->controller;
> 
> +	/*
> +	 * The bootloader might have configured 16bit mode but
> +	 * NAND READID command only works in 8bit mode. We force
> +	 * 8bit mode here to ensure that NAND READID commands works.
> +	 */
> +	cfg_offs = brcmnand_cs_offset(ctrl, host->cs, BRCMNAND_CS_CFG);
> +	nand_writereg(ctrl, cfg_offs,
> +		      nand_readreg(ctrl, cfg_offs) & CFG_BUS_WIDTH);

This should have been "nand_readreg(ctrl, cfg_offs) & ~CFG_BUS_WIDTH".

My bad ...

--
Anup
