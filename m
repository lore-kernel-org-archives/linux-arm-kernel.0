From: b-liu@ti.com (Bin Liu)
Date: Wed, 21 Sep 2016 21:33:44 -0500
Subject: [PATCH 2/2] musb: sunxi: Force session end on babble errors in
 host-mode
In-Reply-To: <20160918165018.24547-2-hdegoede@redhat.com>
References: <20160918165018.24547-1-hdegoede@redhat.com>
 <20160918165018.24547-2-hdegoede@redhat.com>
Message-ID: <20160922023344.GE3981@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Sep 18, 2016 at 06:50:18PM +0200, Hans de Goede wrote:
> The sunxi musb has a bug where sometimes it will generate a babble
> error on device disconnect instead of a disconnect irq. When this
> happens the musb-controller switches from host mode to device mode
> (it clears MUSB_DEVCTL_SESSION and sets MUSB_DEVCTL_BDEVICE) and
> gets stuck in this state.
> 
> Clearing this requires reporting Vbus low for 200 or more ms, but
> on some devices Vbus is simply always high (host-only mode, no Vbus
> control).
> 
> This commit calls sun4i_usb_phy_force_session_end() on babble errors
> in host-mode, fixing the musb controller being stuck in this state
> on systems without Vbus control; and also fixes the need to unplug
> the usb-b -> usb-a cable to get out of this state on systems with
> Vbus control.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/usb/musb/sunxi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index 1408245..5079d90 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -192,8 +192,18 @@ static irqreturn_t sunxi_musb_interrupt(int irq, void *__hci)
>  	 * normally babble never happens treat it as disconnect.
>  	 */
>  	if ((musb->int_usb & MUSB_INTR_BABBLE) && is_host_active(musb)) {

musb_interrupt() handle BABBLE in host mode, and has a glue hook
musb_platform_recover() in musb_recover_from_babble().

Maybe you can use it?

> +		struct sunxi_glue *glue =
> +				dev_get_drvdata(musb->controller->parent);
> +
> +		dev_warn(musb->controller->parent, "babble, treating as disconnect\n");
> +
>  		musb->int_usb &= ~MUSB_INTR_BABBLE;
>  		musb->int_usb |= MUSB_INTR_DISCONNECT;
> +		/*
> +		 * Fix the musb controller sometimes getting stuck in
> +		 * bdevice state after a babble error.
> +		 */
> +		sun4i_usb_phy_force_session_end(glue->phy);

As I commented in PATCH 1/2, can you somehow reuse
sun4i_usb_phy_set_mode() instead?

>  	}
>  
>  	if ((musb->int_usb & MUSB_INTR_RESET) && !is_host_active(musb)) {
> -- 
> 2.9.3

Regards,
-Bin.
