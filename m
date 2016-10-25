From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 25 Oct 2016 15:42:59 +0530
Subject: [PATCH/RFT v2 07/17] ARM: davinci: da8xx: Enable the usb20 "per"
 clk on phy_clk_enable
In-Reply-To: <20161024164634.4330-8-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-8-ahaslam@baylibre.com>
Message-ID: <833b6b60-4504-dac7-ccbb-bc08c985ad01@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 October 2016 10:16 PM, ahaslam at baylibre.com wrote:
> diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
> index 9e41a7f..982e105 100644
> --- a/arch/arm/mach-davinci/usb-da8xx.c
> +++ b/arch/arm/mach-davinci/usb-da8xx.c
> @@ -53,11 +53,19 @@ int __init da8xx_register_usb_refclkin(int rate)
>  
>  static void usb20_phy_clk_enable(struct clk *clk)
>  {
> +	struct clk *usb20_clk;
>  	u32 val;
>  	u32 timeout = 500000; /* 500 msec */
>  
>  	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
>  
> +	usb20_clk = clk_get(NULL, "usb20");

We should not be using a NULL device pointer here. Can you pass the musb
device pointer available in the same file? Also, da850_clks[] in da850.c
needs to be fixed to add the matching device name.

> +	if (IS_ERR(usb20_clk)) {
> +		pr_err("could not get usb20 clk\n");
> +		return;
> +	}

Thanks,
Sekhar
