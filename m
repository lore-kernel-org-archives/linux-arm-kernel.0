From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 10 Jan 2017 17:20:38 +0900
Subject: [PATCH v2] usb: musb: sunxi: Uses the resource-managed extcon API
 when registering extcon notifier
In-Reply-To: <1483071550-8683-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20161230041914epcas5p24826e70fd5de710818687e55579757ba@epcas5p2.samsung.com>
 <1483071550-8683-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <58749956.1030800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

This patch got the acked-by from Bin Liu and.
Could you please apply this patch?

On 2016? 12? 30? 13:19, Chanwoo Choi wrote:
> This patch just uses the resource-managed extcon API when registering
> the extcon notifier.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Bin Liu <b-liu@ti.com>
> ---
> Changes from v1:
> - Rebase this patch based on v4.10-rc1.
> - Add acked-by tag from Maxime Ripard and Bin Lin.
> - Drop the phy/power-supply/chipidea patches.
> 
>  drivers/usb/musb/sunxi.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index d0be0eadd0d9..2332294dee0f 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -251,14 +251,14 @@ static int sunxi_musb_init(struct musb *musb)
>  	writeb(SUNXI_MUSB_VEND0_PIO_MODE, musb->mregs + SUNXI_MUSB_VEND0);
>  
>  	/* Register notifier before calling phy_init() */
> -	ret = extcon_register_notifier(glue->extcon, EXTCON_USB_HOST,
> -				       &glue->host_nb);
> +	ret = devm_extcon_register_notifier(glue->dev, glue->extcon,
> +					EXTCON_USB_HOST, &glue->host_nb);
>  	if (ret)
>  		goto error_reset_assert;
>  
>  	ret = phy_init(glue->phy);
>  	if (ret)
> -		goto error_unregister_notifier;
> +		goto error_reset_assert;
>  
>  	musb->isr = sunxi_musb_interrupt;
>  
> @@ -267,9 +267,6 @@ static int sunxi_musb_init(struct musb *musb)
>  
>  	return 0;
>  
> -error_unregister_notifier:
> -	extcon_unregister_notifier(glue->extcon, EXTCON_USB_HOST,
> -				   &glue->host_nb);
>  error_reset_assert:
>  	if (test_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags))
>  		reset_control_assert(glue->rst);
> @@ -293,9 +290,6 @@ static int sunxi_musb_exit(struct musb *musb)
>  
>  	phy_exit(glue->phy);
>  
> -	extcon_unregister_notifier(glue->extcon, EXTCON_USB_HOST,
> -				   &glue->host_nb);
> -
>  	if (test_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags))
>  		reset_control_assert(glue->rst);
>  
> 


-- 
Best Regards,
Chanwoo Choi
S/W Center, Samsung Electronics
