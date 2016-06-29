From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 29 Jun 2016 14:26:00 +0800
Subject: [PATCH 09/21] usb: chipidea: Add support for ULPI PHY bus
In-Reply-To: <20160626072838.28082-10-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-10-stephen.boyd@linaro.org>
Message-ID: <20160629062600.GD25236@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 12:28:26AM -0700, Stephen Boyd wrote:
> Some phys for the chipidea controller are controlled via the ULPI
> viewport. Add support for the ULPI bus so that these sorts of
> phys can be probed and read/written automatically without having
> to duplicate the viewport logic in each phy driver.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/Kconfig  |   7 +++
>  drivers/usb/chipidea/Makefile |   1 +
>  drivers/usb/chipidea/ci.h     |  20 ++++++++
>  drivers/usb/chipidea/core.c   |  30 ++++++++---
>  drivers/usb/chipidea/ulpi.c   | 113 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 165 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/usb/chipidea/ulpi.c
> 
> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
> index 3644a3500b70..4f8c342a8865 100644
> --- a/drivers/usb/chipidea/Kconfig
> +++ b/drivers/usb/chipidea/Kconfig
> @@ -37,4 +37,11 @@ config USB_CHIPIDEA_HOST
>  	  Say Y here to enable host controller functionality of the
>  	  ChipIdea driver.
>  
> +config USB_CHIPIDEA_ULPI
> +	bool "ChipIdea ULPI PHY support"
> +	depends on USB_ULPI_BUS=y || USB_ULPI_BUS=USB_CHIPIDEA
> +	help
> +	  Say Y here if you have a ULPI PHY attached to your ChipIdea
> +	  controller.
> +
>  endif
> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> index 518e445476c3..39fca5715ed3 100644
> --- a/drivers/usb/chipidea/Makefile
> +++ b/drivers/usb/chipidea/Makefile
> @@ -4,6 +4,7 @@ ci_hdrc-y				:= core.o otg.o debug.o
>  ci_hdrc-$(CONFIG_USB_CHIPIDEA_UDC)	+= udc.o
>  ci_hdrc-$(CONFIG_USB_CHIPIDEA_HOST)	+= host.o
>  ci_hdrc-$(CONFIG_USB_OTG_FSM)		+= otg_fsm.o
> +ci_hdrc-$(CONFIG_USB_CHIPIDEA_ULPI)	+= ulpi.o
>  
>  # Glue/Bridge layers go here
>  
> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> index f87805235caa..14aa20525547 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -18,6 +18,8 @@
>  #include <linux/usb.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/otg-fsm.h>
> +#include <linux/usb/otg.h>
> +#include <linux/ulpi/interface.h>
>  
>  /******************************************************************************
>   * DEFINE
> @@ -52,6 +54,7 @@ enum ci_hw_regs {
>  	OP_ENDPTLISTADDR,
>  	OP_TTCTRL,
>  	OP_BURSTSIZE,
> +	OP_ULPI_VIEWPORT,
>  	OP_PORTSC,
>  	OP_DEVLC,
>  	OP_OTGSC,
> @@ -187,6 +190,7 @@ struct hw_bank {
>   * @test_mode: the selected test mode
>   * @platdata: platform specific information supplied by parent device
>   * @vbus_active: is VBUS active
> + * @ulpi: pointer to ULPI device, if any

One more kernel-doc

>   * @phy: pointer to PHY, if any
>   * @usb_phy: pointer to USB PHY, if any and if using the USB PHY framework
>   * @hcd: pointer to usb_hcd for ehci host driver
> @@ -236,6 +240,10 @@ struct ci_hdrc {
>  
>  	struct ci_hdrc_platform_data	*platdata;
>  	int				vbus_active;
> +#ifdef CONFIG_USB_CHIPIDEA_ULPI
> +	struct ulpi			*ulpi;
> +	struct ulpi_ops 		ulpi_ops;
> +#endif
>  	struct phy			*phy;
>  	/* old usb_phy interface */
>  	struct usb_phy			*usb_phy;
> @@ -418,6 +426,17 @@ static inline bool ci_otg_is_fsm_mode(struct ci_hdrc *ci)
>  #endif
>  }
>  

Others are ok, but I can't accept you change current PHY initialization
at your previous patch, so you may need to refine this patch a little.

-- 

Best Regards,
Peter Chen
