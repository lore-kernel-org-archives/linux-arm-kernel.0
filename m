From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 26 Aug 2016 09:46:53 +0200
Subject: [PATCH] mtd: mxc_nand: Set timing for v2 controllers
In-Reply-To: <1471948445-29936-1-git-send-email-s.hauer@pengutronix.de>
References: <1471948445-29936-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160826094653.762be9fb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, 23 Aug 2016 12:34:05 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> So far we relied on reset default or the bootloader to configure a
> suitable clk rate for the Nand controller. This works but we can
> optimize the timing for better performance. This sets the clk rate for
> v2 controllers (i.MX25/35) based on the timing mode read from the ONFI
> parameter page. This may also enable the symmetric mode (aks EDO mode)
> if necessary which reads one word per clock cycle.
> Tested on an i.MX25 with a Micron MT29F4G08ABBDAHC attached.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mtd/nand/mxc_nand.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 5173fad..725223c 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -1012,6 +1012,45 @@ static void preset_v1(struct mtd_info *mtd)
>  	writew(0x4, NFC_V1_V2_WRPROT);
>  }
>  
> +static void mxc_nand_v2_set_timing(struct mtd_info *mtd, uint16_t *config1)
> +{
> +	struct nand_chip *nand_chip = mtd->priv;
> +	struct mxc_nand_host *host = nand_chip->priv;
> +	int mode, ret, tRC_min_ns;
> +	unsigned long rate;
> +	const struct nand_sdr_timings *timings;
> +
> +	mode = onfi_get_async_timing_mode(nand_chip);
> +	if (mode == ONFI_TIMING_MODE_UNKNOWN)
> +		return;
> +
> +	mode = fls(mode) - 1;
> +	if (mode < 0)
> +		mode = 0;
> +
> +	timings = onfi_async_timing_mode_to_sdr_timings(mode);
> +	if (IS_ERR(timings))
> +		return;
> +

AFAIR, you should apply the new mode on the NAND side
(ONFI_FEATURE_ADDR_TIMING_MODE) before applying the new config to the
controller.

See what's done here [1].

Note that on all the NANDs I tested, it seems to work even if you don't
set ONFI_FEATURE_ADDR_TIMING_MODE, but the ONFI Spec describes the
procedure as:

1/ detect supported modes
2/ select one
3/ apply it to the NAND using set(ONFI_FEATURE_ADDR_TIMING_MODE)
4/ release the CS
5/ adjust the controller setting to match the new config

On a side note, I really think we should handle this timing selection in
the core, and only ask the NAND controller drivers to adapt the
controller settings.

Thanks,

Boris

> +	tRC_min_ns = timings->tRC_min / 1000;
> +	rate = 1000000000 / tRC_min_ns;
> +
> +	if (clk_round_rate(host->clk, rate) > 33333333)
> +		/*
> +		 * If tRC is smaller than 30ns (that is, the rate is higher
> +		 * than 33.333MHz) we have to use EDO timing.
> +		 */
> +		*config1 |= NFC_V2_CONFIG1_ONE_CYCLE;
> +	else
> +		/* Otherwise we have two clock cycles per access. */
> +		rate *= 2;
> +
> +	ret = clk_set_rate(host->clk, rate);
> +	if (ret)
> +		/* Don't worry, continue with old rate */
> +		dev_err(host->dev, "failed to set clk rate: %d\n", ret);
> +}
> +
>  static void preset_v2(struct mtd_info *mtd)
>  {
>  	struct nand_chip *nand_chip = mtd_to_nand(mtd);
> @@ -1020,6 +1059,8 @@ static void preset_v2(struct mtd_info *mtd)
>  
>  	config1 |= NFC_V2_CONFIG1_FP_INT;
>  
> +	mxc_nand_v2_set_timing(mtd, &config1);
> +
>  	if (!host->devtype_data->irqpending_quirk)
>  		config1 |= NFC_V1_V2_CONFIG1_INT_MSK;
>  

[1]http://lxr.free-electrons.com/source/drivers/mtd/nand/sunxi_nand.c#L1406
