From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 11 Jun 2012 10:03:33 -0500
Subject: [PATCH 4/5] MFD: OMAP3EVM: USB: cosmetic fix to failed parent
 clk set
In-Reply-To: <1339423216-1323-5-git-send-email-zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-5-git-send-email-zumeng.chen@gmail.com>
Message-ID: <4FD608C5.9000900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/11/2012 09:00 AM, Zumeng Chen wrote:
> A typo fix for this cosmetic change and mute a failed message from
> a unnecessary setting of some parent clk for usbhs_omap on OMAP3EVM.
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> ---
>  drivers/mfd/omap-usb-host.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 7e96bb2..9aaaf3c 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -698,8 +698,9 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>  		goto err_usbtll_p2_fck;
>  	}
>  
> +#ifndef CONFIG_MACH_OMAP3EVM
> +	/* for OMAP3 , the clk set parent fails */
>  	if (is_ehci_phy_mode(pdata->port_mode[0])) {
> -		/* for OMAP3 , the clk set paretn fails */
>  		ret = clk_set_parent(omap->utmi_p1_fck,
>  					omap->xclk60mhsp1_ck);
>  		if (ret != 0)

This begs the question, why is port_mode[0] set to ehci phy mode if this
is failing? Something does not seem right here but this does not look
like the right fix.

Cheers
Jon
