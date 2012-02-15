From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Feb 2012 10:37:22 -0800
Subject: [PATCH] mtd/gpmi : add gpmi support for mx6q
In-Reply-To: <1328505606-27981-1-git-send-email-b32955@freescale.com>
References: <1328505606-27981-1-git-send-email-b32955@freescale.com>
Message-ID: <20120215183720.GA2399@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2012 at 01:20:06PM +0800, Huang Shijie wrote:
> add gpmi support to mx6q.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/mtd/nand/gpmi-nand/bch-regs.h  |   42 ++++++++++++++++++++++++-------
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |   14 ++++++----
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    3 ++
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    2 +
>  4 files changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mtd/nand/gpmi-nand/bch-regs.h b/drivers/mtd/nand/gpmi-nand/bch-regs.h
> index 4effb8c..a092451 100644
> --- a/drivers/mtd/nand/gpmi-nand/bch-regs.h
> +++ b/drivers/mtd/nand/gpmi-nand/bch-regs.h
> @@ -51,15 +51,26 @@
>  
>  #define BP_BCH_FLASH0LAYOUT0_ECC0		12
>  #define BM_BCH_FLASH0LAYOUT0_ECC0	(0xf << BP_BCH_FLASH0LAYOUT0_ECC0)
> -#define BF_BCH_FLASH0LAYOUT0_ECC0(v)		\
> -	(((v) << BP_BCH_FLASH0LAYOUT0_ECC0) & BM_BCH_FLASH0LAYOUT0_ECC0)
> +#define MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0		11
> +#define MX6Q_BM_BCH_FLASH0LAYOUT0_ECC0	(0x1f << MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0)
> +#define BF_BCH_FLASH0LAYOUT0_ECC0(v, x)				\
> +	(GPMI_IS_MX6Q(x)					\
> +		? (((v) << MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0)	\
> +			& MX6Q_BM_BCH_FLASH0LAYOUT0_ECC0)	\
> +		: (((v) << BP_BCH_FLASH0LAYOUT0_ECC0)		\
> +			& BM_BCH_FLASH0LAYOUT0_ECC0)		\
> +	)
>  
>  #define BP_BCH_FLASH0LAYOUT0_DATA0_SIZE		0
>  #define BM_BCH_FLASH0LAYOUT0_DATA0_SIZE		\
>  			(0xfff << BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)
> -#define BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(v)	\
> -	(((v) << BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)\
> -					 & BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)
> +#define MX6Q_BM_BCH_FLASH0LAYOUT0_DATA0_SIZE	\
> +			(0x3ff << BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)
> +#define BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(v, x)				\
> +	(GPMI_IS_MX6Q(x)						\
> +		? (((v) >> 2) & MX6Q_BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)	\
> +		: ((v) & BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)		\
> +	)
>  
>  #define HW_BCH_FLASH0LAYOUT1			0x00000090
>  
> @@ -72,13 +83,24 @@
>  
>  #define BP_BCH_FLASH0LAYOUT1_ECCN		12
>  #define BM_BCH_FLASH0LAYOUT1_ECCN	(0xf << BP_BCH_FLASH0LAYOUT1_ECCN)
> -#define BF_BCH_FLASH0LAYOUT1_ECCN(v)		\
> -	(((v) << BP_BCH_FLASH0LAYOUT1_ECCN) & BM_BCH_FLASH0LAYOUT1_ECCN)
> +#define MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN		11
> +#define MX6Q_BM_BCH_FLASH0LAYOUT1_ECCN	(0x1f << MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN)
> +#define BF_BCH_FLASH0LAYOUT1_ECCN(v, x)				\
> +	(GPMI_IS_MX6Q(x)					\
> +		? (((v) << MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN)	\
> +			& MX6Q_BM_BCH_FLASH0LAYOUT1_ECCN)	\
> +		: (((v) << BP_BCH_FLASH0LAYOUT1_ECCN)		\
> +			& BM_BCH_FLASH0LAYOUT1_ECCN)		\
> +	)
>  
>  #define BP_BCH_FLASH0LAYOUT1_DATAN_SIZE		0
>  #define BM_BCH_FLASH0LAYOUT1_DATAN_SIZE		\
>  			(0xfff << BP_BCH_FLASH0LAYOUT1_DATAN_SIZE)
> -#define BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(v)	\
> -	(((v) << BP_BCH_FLASH0LAYOUT1_DATAN_SIZE) \
> -					 & BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)
> +#define MX6Q_BM_BCH_FLASH0LAYOUT1_DATAN_SIZE	\
> +			(0x3ff << BP_BCH_FLASH0LAYOUT1_DATAN_SIZE)
> +#define BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(v, x)				\
> +	(GPMI_IS_MX6Q(x)						\
> +		? (((v) >> 2) & MX6Q_BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)	\
> +		: ((v) & BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)		\
> +	)
>  #endif
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> index 28f8df0..fd39350 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> @@ -223,13 +223,13 @@ int bch_set_geometry(struct gpmi_nand_data *this)
>  	/* Configure layout 0. */
>  	writel(BF_BCH_FLASH0LAYOUT0_NBLOCKS(block_count)
>  			| BF_BCH_FLASH0LAYOUT0_META_SIZE(metadata_size)
> -			| BF_BCH_FLASH0LAYOUT0_ECC0(ecc_strength)
> -			| BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(block_size),
> +			| BF_BCH_FLASH0LAYOUT0_ECC0(ecc_strength, this)
> +			| BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(block_size, this),
>  			r->bch_regs + HW_BCH_FLASH0LAYOUT0);
>  
>  	writel(BF_BCH_FLASH0LAYOUT1_PAGE_SIZE(page_size)
> -			| BF_BCH_FLASH0LAYOUT1_ECCN(ecc_strength)
> -			| BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(block_size),
> +			| BF_BCH_FLASH0LAYOUT1_ECCN(ecc_strength, this)
> +			| BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(block_size, this),
>  			r->bch_regs + HW_BCH_FLASH0LAYOUT1);
>  
>  	/* Set *all* chip selects to use layout 0. */
> @@ -803,7 +803,8 @@ int gpmi_is_ready(struct gpmi_nand_data *this, unsigned chip)
>  	if (GPMI_IS_MX23(this)) {
>  		mask = MX23_BM_GPMI_DEBUG_READY0 << chip;
>  		reg = readl(r->gpmi_regs + HW_GPMI_DEBUG);
> -	} else if (GPMI_IS_MX28(this)) {
> +	} else if (GPMI_IS_MX28(this) || GPMI_IS_MX6Q(this)) {
> +		/* MX28 shares the same R/B register as MX6Q. */
>  		mask = MX28_BF_GPMI_STAT_READY_BUSY(1 << chip);
>  		reg = readl(r->gpmi_regs + HW_GPMI_STAT);
>  	} else
> @@ -1066,8 +1067,9 @@ int gpmi_read_page(struct gpmi_nand_data *this,
>  		| BF_GPMI_CTRL0_ADDRESS(address)
>  		| BF_GPMI_CTRL0_XFER_COUNT(geo->page_size);
>  	pio[1] = 0;
> +	pio[2] = 0; /* set GPMI_HW_GPMI_ECCCTRL, disable the BCH. */
>  	desc = channel->device->device_prep_slave_sg(channel,
> -				(struct scatterlist *)pio, 2,
> +				(struct scatterlist *)pio, 3,
>  				DMA_TRANS_NONE,
>  				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc) {
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> index 493ec2f..90545e2 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -1582,6 +1582,9 @@ static const struct platform_device_id gpmi_ids[] = {
>  	}, {
>  		.name = "imx28-gpmi-nand",
>  		.driver_data = IS_MX28,
> +	}, {
> +		.name = "imx6q-gpmi-nand",
> +		.driver_data = IS_MX6Q,
>  	}, {},
>  };
>  
The imx6q only supports DT boot, but I do not see you are adding DT
probe for the driver, so I'm wondering how you tested the driver on
imx6q.

-- 
Regards,
Shawn

> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> index 1c7fdbb..a302dd1 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> @@ -268,6 +268,8 @@ extern int gpmi_read_page(struct gpmi_nand_data *,
>  /* Use the platform_id to distinguish different Archs. */
>  #define IS_MX23			0x1
>  #define IS_MX28			0x2
> +#define IS_MX6Q			0x8
>  #define GPMI_IS_MX23(x)		((x)->pdev->id_entry->driver_data == IS_MX23)
>  #define GPMI_IS_MX28(x)		((x)->pdev->id_entry->driver_data == IS_MX28)
> +#define GPMI_IS_MX6Q(x)		((x)->pdev->id_entry->driver_data == IS_MX6Q)
>  #endif
> -- 
> 1.7.0.4
