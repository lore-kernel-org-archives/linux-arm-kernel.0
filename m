From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 1 Dec 2016 19:47:12 +0530
Subject: [PATCH v2] ARM: davinci: da8xx: Fix sleeping function called from
 invalid context
In-Reply-To: <1480438111-11801-1-git-send-email-abailon@baylibre.com>
References: <1480438111-11801-1-git-send-email-abailon@baylibre.com>
Message-ID: <ed09fc5e-395a-5e72-4928-5e85cdc7f2c3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 November 2016 10:18 PM, Alexandre Bailon wrote:
> Everytime the usb20 phy is enabled, there is a
> "sleeping function called from invalid context" BUG.
> 
> clk_enable() from arch/arm/mach-davinci/clock.c uses spin_lock_irqsave()
> before to invoke the callback usb20_phy_clk_enable().

"before invocation of the callback"? (doesn't read right otherwise)

> usb20_phy_clk_enable() uses clk_get() and clk_enable_prepapre()

clk_prepare_enable()

> which may sleep.
> Move clk_get() to da8xx_register_usb20_phy_clk() and
> replace clk_prepare_enable() by clk_enable().
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

> @@ -287,9 +281,15 @@ int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
>  	struct clk *parent;
>  	int ret = 0;
>  
> +	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
> +	if (IS_ERR(usb20_clk))
> +		return PTR_ERR(parent);

Typo here. Should be PTR_ERR(usb20_clk)

Thanks,
Sekhar
