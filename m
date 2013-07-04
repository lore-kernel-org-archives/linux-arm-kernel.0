From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Jul 2013 04:44:39 -0700
Subject: [PATCH 1/4] arm: omap: Add phy binding info for musb in plat data
In-Reply-To: <1371631951-369-2-git-send-email-kishon@ti.com>
References: <1371631951-369-1-git-send-email-kishon@ti.com>
 <1371631951-369-2-git-send-email-kishon@ti.com>
Message-ID: <20130704114439.GA5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [130619 01:58]:
> In order for controllers to get PHY in case of non dt boot, the phy
> binding information (phy label) should be added in the platform
> data of the controller.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/usb-musb.c |    6 +++++-
>  include/linux/usb/musb.h       |    3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index 3242a55..5ddbe39 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -85,8 +85,12 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
>  	musb_plat.mode = board_data->mode;
>  	musb_plat.extvbus = board_data->extvbus;
>  
> -	if (cpu_is_omap44xx())
> +	if (cpu_is_omap44xx()) {
>  		musb_plat.has_mailbox = true;
> +		musb_plat.phy_name = "omap-usb2";
> +	} else if (cpu_is_omap34xx()) {
> +		musb_plat.phy_name = "twl4030";
> +	}
>  
>  	if (soc_is_am35xx()) {
>  		oh_name = "am35x_otg_hs";

Care to refresh this patch against the current mainline tree?
Now omap4 is DT only, so this part won't apply. Mostly I'm wondering
what the phy_name should be for am35xx that's not covered by this
patch.

Also let me know if the last patch is safe to queue alone as a fix
or if it depends on the driver related changes in this series.

Regards,

Tony
