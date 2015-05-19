From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 May 2015 13:15:58 +0200
Subject: [PATCH v4 2/7] mmc: mediatek: Add Mediatek MMC driver
In-Reply-To: <1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
 <1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <20150519111558.GD6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 02:36:46PM +0800, Chaotian Jing wrote:
> Add Mediatek MMC driver code
> Support eMMC/SD/SDIO
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/Kconfig  |    8 +
>  drivers/mmc/host/Makefile |    1 +
>  drivers/mmc/host/mtk-sd.c | 1422 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1431 insertions(+)
>  create mode 100644 drivers/mmc/host/mtk-sd.c
> 
> +
> +	host->src_clk = devm_clk_get(&pdev->dev, "source");
> +	if (IS_ERR(host->src_clk)) {
> +		ret = PTR_ERR(host->src_clk);
> +		goto host_free;
> +	}
> +
> +	host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> +	if (IS_ERR(host->h_clk)) {
> +		/* host->h_clk is optional, Only for MSDC0/3 at MT8173 */
> +		dev_dbg(&pdev->dev,
> +				"Invalied hclk from the device tree!\n");
> +	}

s/Invalied/Invalid/

According to my reference manual the controller always needs a hclk. It
seems on some controllers it is just not software controllable. If
that's the case you should always provide a hclk to the driver and make
this clock mandatory.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
