From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Apr 2015 12:22:55 +0200
Subject: [PATCH v4 09/11] ARM: imx: add imx7d clk tree support
In-Reply-To: <1429563933-3129-10-git-send-email-Frank.Li@freescale.com>
References: <1429563933-3129-1-git-send-email-Frank.Li@freescale.com>
 <1429563933-3129-10-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150421102255.GW6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 05:05:31AM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Add i.MX7D clk tree support.
> 
> +
> +	clk_register_clkdev(clks[IMX7D_GPT1_ROOT_CLK], "ipg", "imx-gpt.0");
> +	clk_register_clkdev(clks[IMX7D_GPT_3M_CLK], "gpt_3m", "imx-gpt.0");

What are these good for? These shouldn't be here.

> +
> +	for (i = 0; i < IMX7D_END_CLK; i++)
> +		clk_prepare_enable(clks[i]);

Hey, no. You enable *all* clocks here which is certainly wrong. They
will never be turned off.

> @@ -309,12 +316,20 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
>  	case IMX_PLLV3_ENET:
>  		ops = &clk_pllv3_enet_ops;
>  		break;
> +	case IMX_PLLV3_SYSV2:
> +		ops = &clk_pllv3_ops;
> +		break;
>  	default:
>  		ops = &clk_pllv3_ops;
>  	}
>  	pll->base = base;
>  	pll->div_mask = div_mask;
>  
> +	if (cpu_is_imx7d() && strcmp(name, "pll_enet_main") == 0)
> +		pll->powerdown = ENET_PLL_POWER;
> +	else
> +		pll->powerdown = BM_PLL_POWER;

You should probably add a new PLL type, like IMX_PLLV3_ENET_IMX7 or such
instead of using cpu_is_ and strcmp.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
