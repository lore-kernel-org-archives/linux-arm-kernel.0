From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Dec 2012 11:47:58 +0100
Subject: [PATCH v4 2/7] usb: chipidea: add otg file
In-Reply-To: <1356591603-23323-3-git-send-email-peter.chen@freescale.com>
References: <1356591603-23323-1-git-send-email-peter.chen@freescale.com>
 <1356591603-23323-3-git-send-email-peter.chen@freescale.com>
Message-ID: <20121227104758.GV26326@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 02:59:58PM +0800, Peter Chen wrote:
> Implement struct usb_otg, In that way, calling otg_set_peripheral
> will not be failed at udc.c.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
> Changes for v4:
> - Some tiny changes, like delete unused header files
> 
>  drivers/usb/chipidea/Makefile |    2 +-
>  drivers/usb/chipidea/ci.h     |    2 +
>  drivers/usb/chipidea/otg.c    |   60 +++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/chipidea/otg.h    |    6 ++++
>  4 files changed, 69 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> index d92ca32..11f513c 100644
> --- a/drivers/usb/chipidea/Makefile
> +++ b/drivers/usb/chipidea/Makefile
> @@ -2,7 +2,7 @@ ccflags-$(CONFIG_USB_CHIPIDEA_DEBUG) := -DDEBUG
>  
>  obj-$(CONFIG_USB_CHIPIDEA)		+= ci_hdrc.o
>  
> -ci_hdrc-y				:= core.o
> +ci_hdrc-y				:= core.o otg.o
>  ci_hdrc-$(CONFIG_USB_CHIPIDEA_UDC)	+= udc.o
>  ci_hdrc-$(CONFIG_USB_CHIPIDEA_HOST)	+= host.o
>  ci_hdrc-$(CONFIG_USB_CHIPIDEA_DEBUG)	+= debug.o
> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> index d738603..8702871 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -129,6 +129,7 @@ struct hw_bank {
>   * @vbus_active: is VBUS active
>   * @transceiver: pointer to USB PHY, if any
>   * @hcd: pointer to usb_hcd for ehci host driver
> + * @otg: for otg support
>   */
>  struct ci13xxx {
>  	struct device			*dev;
> @@ -164,6 +165,7 @@ struct ci13xxx {
>  	bool				global_phy;
>  	struct usb_phy			*transceiver;
>  	struct usb_hcd			*hcd;
> +	struct usb_otg      otg;

I'd really like to know how this is going to proceed.

The ULPI driver currently allocates a struct usb_otg and sets
otg->set_host and otg->set_vbus. Since now the chipidea driver uses its
own struct usb_otg, this will not work with ULPI support.

I see some ways out of this:

- Use a pointer above instead of an own struct usb_otg in the ci driver.
- move the set_host and set_vbus callbacks to struct usb_phy.

I'd like to have this solved before we merge this patch.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
