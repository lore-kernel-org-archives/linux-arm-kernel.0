From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 12 May 2016 23:21:42 +0300
Subject: [PATCH 2/2] musb: sunxi: Set state to A_WAIT_VRISE when enabling
 VBus
In-Reply-To: <1463077869-13224-2-git-send-email-hdegoede@redhat.com>
References: <1463077869-13224-1-git-send-email-hdegoede@redhat.com>
 <1463077869-13224-2-git-send-email-hdegoede@redhat.com>
Message-ID: <b60f2279-77e8-c7c3-c857-a2dfef20d3d6@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/12/2016 09:31 PM, Hans de Goede wrote:

> When the board is powering attached usb devices via the otg port
> sometimes / on some devices it takes slightly too long for the VBus

    I think it's either VBUS or Vbus, not this strange spelling.

> detection code in phy-sun4i-usb.c to signal that VBus is high after
> enabling VBus and the musb hardware signals a MUSB_INTR_VBUSERROR
> interrupt.
>
> This commit sets the otg state to A_WAIT_VRISE upon enabling Vbus
> making musb_stage0_irq() ignore the first VBUSERR_RETRY_COUNT
> VBUSERROR interrupts, fixing connection issues in these cases.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/usb/musb/sunxi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index 2c33d9b..2ee48fb 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -112,7 +112,7 @@ static void sunxi_musb_work(struct work_struct *work)
>  		if (test_bit(SUNXI_MUSB_FL_HOSTMODE, &glue->flags)) {
>  			set_bit(SUNXI_MUSB_FL_VBUS_ON, &glue->flags);
>  			musb->xceiv->otg->default_a = 1;
> -			musb->xceiv->otg->state = OTG_STATE_A_IDLE;
> +			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
>  			MUSB_HST_MODE(musb);
>  			devctl |= MUSB_DEVCTL_SESSION;
>  		} else {
> @@ -145,9 +145,10 @@ static void sunxi_musb_set_vbus(struct musb *musb, int is_on)
>  {
>  	struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
>
> -	if (is_on)
> +	if (is_on) {
>  		set_bit(SUNXI_MUSB_FL_VBUS_ON, &glue->flags);
> -	else
> +		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> +	} else
>  		clear_bit(SUNXI_MUSB_FL_VBUS_ON, &glue->flags);

   CodingStyle, all *if* branches should use {} if one uses {}.

[...]

MBR, Sergei
