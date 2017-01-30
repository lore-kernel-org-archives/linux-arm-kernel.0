From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 30 Jan 2017 13:44:27 +0100
Subject: [PATCH 09/14] mtd: nand: sunxi: simplify optional reset handling
In-Reply-To: <20170130114116.22089-9-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-9-p.zabel@pengutronix.de>
Message-ID: <20170130134427.14487373@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Mon, 30 Jan 2017 12:41:11 +0100
Philipp Zabel <p.zabel@pengutronix.de> wrote:

> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
> 
> This allows to return errors from devm_reset_control_get_optional and to
> call reset_control_(de)assert unconditionally.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Icenowy Zheng <icenowy@aosc.xyz>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>

I didn't find commit bb475230b8e5 in mainline, so I guess you plan to
take this patch in your own tree. Let me know if this is not the case.

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/mtd/nand/sunxi_nand.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index e40482a65de66..c6769b52c666a 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -2196,16 +2196,15 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
>  		goto out_ahb_clk_unprepare;
>  
>  	nfc->reset = devm_reset_control_get_optional(dev, "ahb");
> -	if (!IS_ERR(nfc->reset)) {
> -		ret = reset_control_deassert(nfc->reset);
> -		if (ret) {
> -			dev_err(dev, "reset err %d\n", ret);
> -			goto out_mod_clk_unprepare;
> -		}
> -	} else if (PTR_ERR(nfc->reset) != -ENOENT) {
> +	if (IS_ERR(nfc->reset)) {
>  		ret = PTR_ERR(nfc->reset);
>  		goto out_mod_clk_unprepare;
>  	}
> +	ret = reset_control_deassert(nfc->reset);
> +	if (ret) {
> +		dev_err(dev, "reset err %d\n", ret);
> +		goto out_mod_clk_unprepare;
> +	}
>  
>  	ret = sunxi_nfc_rst(nfc);
>  	if (ret)
> @@ -2246,8 +2245,7 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
>  	if (nfc->dmac)
>  		dma_release_channel(nfc->dmac);
>  out_ahb_reset_reassert:
> -	if (!IS_ERR(nfc->reset))
> -		reset_control_assert(nfc->reset);
> +	reset_control_assert(nfc->reset);
>  out_mod_clk_unprepare:
>  	clk_disable_unprepare(nfc->mod_clk);
>  out_ahb_clk_unprepare:
> @@ -2262,8 +2260,7 @@ static int sunxi_nfc_remove(struct platform_device *pdev)
>  
>  	sunxi_nand_chips_cleanup(nfc);
>  
> -	if (!IS_ERR(nfc->reset))
> -		reset_control_assert(nfc->reset);
> +	reset_control_assert(nfc->reset);
>  
>  	if (nfc->dmac)
>  		dma_release_channel(nfc->dmac);
