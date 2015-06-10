From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 10 Jun 2015 13:24:48 +0200
Subject: [PATCH v3 2/2] mtd: nand: sunxi: Set serial access mode correctly
In-Reply-To: <1433924948-19288-2-git-send-email-r.spliet@ultimaker.com>
References: <1433924948-19288-1-git-send-email-r.spliet@ultimaker.com>
 <1433924948-19288-2-git-send-email-r.spliet@ultimaker.com>
Message-ID: <20150610132448.22cb14c5@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Jun 2015 10:29:08 +0200
Roy Spliet <r.spliet@ultimaker.com> wrote:

> Replaces the hard coded "always use EDO" policy with that prescribed
> by the ONFI 3.1 specification that EDO mode should always be used if tRC
> is below 30ns.
> 
> Signed-off-by: Roy Spliet <r.spliet@ultimaker.com>
> ---
>  drivers/mtd/nand/sunxi_nand.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index 68090b7..d98e98c 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -99,6 +99,9 @@
>  				 NFC_CMD_INT_ENABLE | \
>  				 NFC_DMA_INT_ENABLE)
>  
> +/* define bit use in NFC_TIMING_CTL */
> +#define NFC_TIMING_CTL_EDO	BIT(8)
> +
>  /* define bit use in NFC_TIMING_CFG */
>  #define NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD)		\
>  	((tWB) & 0x3) | (((tADL) & 0x3) << 2) |			\
> @@ -226,6 +229,7 @@ struct sunxi_nand_chip {
>  	struct mtd_info mtd;
>  	unsigned long clk_rate;
>  	u32 timing_cfg;
> +	int serial_mode_edo;

How about directly storing the timing_ctl value (declaring an
unsigned long timing_ctl field) ? This way, if we need
to set other fields in the same register we won't have to add new
fields to the structure.

>  	int selected;
>  	int nsels;
>  	struct sunxi_nand_chip_sel sels[0];
> @@ -380,7 +384,7 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
>  	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
>  	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
>  	struct sunxi_nand_chip_sel *sel;
> -	u32 ctl;
> +	u32 ctl, timing_ctl;
>  
>  	if (chip > 0 && chip >= sunxi_nand->nsels)
>  		return;
> @@ -412,6 +416,9 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
>  		}
>  	}
>  
> +	timing_ctl = sunxi_nand->serial_mode_edo ? NFC_TIMING_CTL_EDO : 0;
> +
> +	writel(timing_ctl, nfc->regs + NFC_REG_TIMING_CTL);
>  	writel(sunxi_nand->timing_cfg, nfc->regs + NFC_REG_TIMING_CFG);
>  	writel(ctl, nfc->regs + NFC_REG_CTL);
>  
> @@ -937,6 +944,13 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
>  	/* TODO: A83 has some more bits for CDQSS, CS, CLHZ, CCS, WC */
>  	chip->timing_cfg = NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD);
>  
> +	/*
> +	 * ONFI specification 3.1, paragraph 4.15.2 dictates that EDO data
> +	 * output cycle timings shall be used if the host drives tRC less than
> +	 * 30 ns.
> +	 */
> +	chip->serial_mode_edo = (timings->tRC_min < 30000);
> +

Oh, that's good to know.

Thanks,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
