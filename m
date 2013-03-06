From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 Mar 2013 13:29:16 +0200
Subject: [PATCH v11 6/9] usb: chipidea: add vbus regulator control
In-Reply-To: <1362563800-16673-7-git-send-email-peter.chen@freescale.com>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-7-git-send-email-peter.chen@freescale.com>
Message-ID: <20130306112916.GT28587@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 06, 2013 at 05:56:37PM +0800, Peter Chen wrote:
> For boards which have board level vbus control (eg, gpio), we
> need to operation vbus according to below rules:
> - For host, the vbus should always be on.
> - For otg, the vbus needs to be turned on/off when usb role switches.
> 
> We put vbus operation to host as host is the only vbus user,
> When we are at host mode, the vbus is on, when we are not at
> host mode, vbus should be off.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/chipidea/ci.h    |    2 ++
>  drivers/usb/chipidea/core.c  |   24 ++++++++----------------
>  drivers/usb/chipidea/host.c  |   23 ++++++++++++++++++++++-
>  include/linux/usb/chipidea.h |    1 +
>  4 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> index a3777a1..8826cdb 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -133,6 +133,7 @@ struct hw_bank {
>   * @id_event: indicates there is a id event, and handled at ci_otg_work
>   * @b_sess_valid_event: indicates there is a vbus event, and handled
>   * at ci_otg_work
> + * @reg_vbus: used to control internal vbus regulator
>   */
>  struct ci13xxx {
>  	struct device			*dev;
> @@ -172,6 +173,7 @@ struct ci13xxx {
>  	struct usb_otg      		otg;
>  	bool				id_event;
>  	bool				b_sess_valid_event;
> +	struct regulator		*reg_vbus;
>  };
>  
>  static inline struct ci_role_driver *ci_role(struct ci13xxx *ci)
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index c563e17..e0ff335 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -63,6 +63,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/otg.h>
> @@ -364,17 +365,10 @@ static void ci_handle_id_switch(struct ci13xxx *ci)
>  		hw_device_reset(ci, USBMODE_CM_IDLE);
>  
>  		/* 2. Turn on/off vbus according to coming role */
> -		if (role == CI_ROLE_GADGET) {
> -			otg_set_vbus(&ci->otg, false);
> +		if (role == CI_ROLE_GADGET)
>  			/* wait vbus lower than OTGSC_BSV */
>  			hw_wait_reg(ci, OP_OTGSC, OTGSC_BSV, 0,
>  					CI_VBUS_STABLE_TIMEOUT);
> -		} else if (role == CI_ROLE_HOST) {
> -			otg_set_vbus(&ci->otg, true);
> -			/* wait vbus higher than OTGSC_AVV */
> -			hw_wait_reg(ci, OP_OTGSC, OTGSC_AVV, OTGSC_AVV,
> -					CI_VBUS_STABLE_TIMEOUT);
> -		}
>  
>  		/* 3. Begin the new role */
>  		ci_role_start(ci, role);
> @@ -416,17 +410,14 @@ static void ci_delayed_work(struct work_struct *work)
>  	struct delayed_work *dwork = to_delayed_work(work);
>  	struct ci13xxx *ci = container_of(dwork, struct ci13xxx, dwork);
>  
> +	/*
> +	 * If it is gadget mode, the vbus operation should be done like below:
> +	 * 1. Enable vbus detect
> +	 * 2. If it has already connected to host, notify udc
> +	 */
>  	if (ci->role == CI_ROLE_GADGET) {
> -		/*
> -		 * if it is device mode:
> -		 * - Enable vbus detect
> -		 * - If it has already connected to host, notify udc
> -		 */
>  		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
>  		ci_handle_vbus_change(ci);
> -	} else if (ci->is_otg && (ci->role == CI_ROLE_HOST)) {
> -		/* USB Device at the MicroB to A cable */
> -		otg_set_vbus(&ci->otg, true);
>  	}
>  }
>  
> @@ -603,6 +594,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  
>  	ci->dev = dev;
>  	ci->platdata = dev->platform_data;
> +	ci->reg_vbus = ci->platdata->reg_vbus;

nak, teach ci_hdrc_probe() how to get its own regulator.

>  	if (ci->platdata->phy)
>  		ci->transceiver = ci->platdata->phy;

this should happen for PHYs as well btw.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130306/dc8a4ed3/attachment.sig>
