From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Oct 2015 08:29:58 +0200
Subject: [PATCH 3/4] mmc: mediatek: Add tune support
In-Reply-To: <1444729078-26585-4-git-send-email-chaotian.jing@mediatek.com>
References: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
 <1444729078-26585-4-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <20151015062958.GG7825@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 13, 2015 at 05:37:57PM +0800, Chaotian Jing wrote:
> @@ -1260,6 +1547,16 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  		goto host_free;
>  	}
>  
> +	host->src_clk_parent = clk_get_parent(host->src_clk);
> +	host->hs400_src = devm_clk_get(&pdev->dev, "400mhz");
> +	if (IS_ERR(host->hs400_src)) {
> +		dev_dbg(&pdev->dev, "Cannot find 400mhz at dts!\n");
> +	} else if (clk_set_parent(host->src_clk_parent, host->hs400_src) < 0) {
> +		dev_err(host->dev, "Failed to set 400mhz source clock!\n");
> +		ret = -EINVAL;
> +		goto host_free;
> +	}

This is a static setup. We have device tree bindings for doing this.
Please look for assigned-clocks and assigned-clock-parents. Doing stuff
like this in the driver almost certainly leads to problems because the
next SoC will have different requirements here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
