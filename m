From: kishon@ti.com (kishon)
Date: Wed, 30 Jan 2013 11:36:42 +0530
Subject: [RESEND PATCH v5 3/7] usb: chipidea: add otg id switch and vbus
 connect/disconnect detect
In-Reply-To: <1358733418-17969-4-git-send-email-peter.chen@freescale.com>
References: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
 <1358733418-17969-4-git-send-email-peter.chen@freescale.com>
Message-ID: <5108B872.6050706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 21 January 2013 07:26 AM, Peter Chen wrote:
> The main design flow is the same with msm otg driver, that is the id and
> vbus interrupt are handled at core driver, others are handled by
> individual drivers.
>
> - At former design, when switch usb role from device->host, it will call
> udc_stop, it will remove the gadget driver, so when switch role
> from host->device, it can't add gadget driver any more.
> At new design, when role switch occurs, the gadget just calls
> usb_gadget_vbus_disconnect/usb_gadget_vbus_connect as well as
> reset controller, it will not free any device/gadget structure
>
> - Add vbus connect and disconnect to core interrupt handler, it can
> notify udc driver by calling usb_gadget_vbus_disconnect
> /usb_gadget_vbus_connect.
>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>   drivers/usb/chipidea/bits.h |   10 +++
>   drivers/usb/chipidea/ci.h   |    8 ++-
>   drivers/usb/chipidea/core.c |  177 ++++++++++++++++++++++++++++++++++++++----
>   drivers/usb/chipidea/otg.c  |   28 +++++---
>   drivers/usb/chipidea/otg.h  |    3 +
>   drivers/usb/chipidea/udc.c  |    2 +
>   6 files changed, 200 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
> index 050de85..ba9c6ef 100644
> --- a/drivers/usb/chipidea/bits.h
> +++ b/drivers/usb/chipidea/bits.h
> @@ -65,11 +65,21 @@
>   #define OTGSC_ASVIS	      BIT(18)
>   #define OTGSC_BSVIS	      BIT(19)
>   #define OTGSC_BSEIS	      BIT(20)
> +#define OTGSC_1MSIS	      BIT(21)
> +#define OTGSC_DPIS	      BIT(22)
>   #define OTGSC_IDIE	      BIT(24)
>   #define OTGSC_AVVIE	      BIT(25)
>   #define OTGSC_ASVIE	      BIT(26)
>   #define OTGSC_BSVIE	      BIT(27)
>   #define OTGSC_BSEIE	      BIT(28)
> +#define OTGSC_1MSIE	      BIT(29)
> +#define OTGSC_DPIE	      BIT(30)
> +#define OTGSC_INT_EN_BITS	(OTGSC_IDIE | OTGSC_AVVIE | OTGSC_ASVIE \
> +				| OTGSC_BSVIE | OTGSC_BSEIE | OTGSC_1MSIE \
> +				| OTGSC_DPIE)
> +#define OTGSC_INT_STATUS_BITS	(OTGSC_IDIS | OTGSC_AVVIS | OTGSC_ASVIS	\
> +				| OTGSC_BSVIS | OTGSC_BSEIS | OTGSC_1MSIS \
> +				| OTGSC_DPIS)
>
>   /* USBMODE */
>   #define USBMODE_CM            (0x03UL <<  0)
> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> index 8702871..325d790 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -130,6 +130,7 @@ struct hw_bank {
>    * @transceiver: pointer to USB PHY, if any
>    * @hcd: pointer to usb_hcd for ehci host driver
>    * @otg: for otg support
> + * @events: events for otg, and handled at ci_role_work
>    */
>   struct ci13xxx {
>   	struct device			*dev;
> @@ -140,6 +141,7 @@ struct ci13xxx {
>   	enum ci_role			role;
>   	bool				is_otg;
>   	struct work_struct		work;
> +	struct delayed_work		dwork;
>   	struct workqueue_struct		*wq;
>
>   	struct dma_pool			*qh_pool;
> @@ -165,7 +167,9 @@ struct ci13xxx {
>   	bool				global_phy;
>   	struct usb_phy			*transceiver;
>   	struct usb_hcd			*hcd;
> -	struct usb_otg      otg;
> +	struct usb_otg      		otg;
You have added *otg* in previous patch and added a tab for *otg* in this 
patch.

> +	bool				id_event;
> +	bool				b_sess_valid_event;
>   };
>
>   static inline struct ci_role_driver *ci_role(struct ci13xxx *ci)
> @@ -314,4 +318,6 @@ int hw_port_test_set(struct ci13xxx *ci, u8 mode);
>
>   u8 hw_port_test_get(struct ci13xxx *ci);
>
> +void ci_handle_vbus_change(struct ci13xxx *ci);
> +
>   #endif	/* __DRIVERS_USB_CHIPIDEA_CI_H */
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index aebf695..f8f8484 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -73,6 +73,7 @@
>   #include "bits.h"
>   #include "host.h"
>   #include "debug.h"
> +#include "otg.h"
>
>   /* Controller register map */
>   static uintptr_t ci_regs_nolpm[] = {
> @@ -199,6 +200,14 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
>   	if (ci->hw_ep_max > ENDPT_MAX)
>   		return -ENODEV;
>
> +	/* Disable all interrupts bits */
> +	hw_write(ci, OP_USBINTR, 0xffffffff, 0);
> +	ci_disable_otg_interrupt(ci, OTGSC_INT_EN_BITS);
> +
> +	/* Clear all interrupts status bits*/
> +	hw_write(ci, OP_USBSTS, 0xffffffff, 0xffffffff);
> +	ci_clear_otg_interrupt(ci, OTGSC_INT_STATUS_BITS);
> +
>   	dev_dbg(ci->dev, "ChipIdea HDRC found, lpm: %d; cap: %p op: %p\n",
>   		ci->hw_bank.lpm, ci->hw_bank.cap, ci->hw_bank.op);
>
> @@ -265,24 +274,124 @@ static enum ci_role ci_otg_role(struct ci13xxx *ci)
>   }
>
>   /**
> - * ci_role_work - perform role changing based on ID pin
> - * @work: work struct
> + * hw_wait_reg: wait the register value
> + *
> + * Sometimes, it needs to wait register value before going on.
> + * Eg, when switch to device mode, the vbus value should be lower
> + * than OTGSC_BSV before connects to host.
> + *
> + * @ci: the controller
> + * @reg: register index
> + * @mask: mast bit
> + * @value: the bit value to wait
> + * @timeout: timeout to indicate an error
> + *
> + * This function returns an error code if timeout
>    */
> -static void ci_role_work(struct work_struct *work)
> +static int hw_wait_reg(struct ci13xxx *ci, enum ci13xxx_regs reg, u32 mask,
> +				u32 value, unsigned long timeout)
> +{
> +	unsigned long elapse = jiffies + timeout;
> +
> +	while (hw_read(ci, reg, mask) != value) {
> +		if (time_after(jiffies, elapse)) {
> +			dev_err(ci->dev, "timeout waiting for %08x in %d\n",
> +					mask, reg);
> +			return -ETIMEDOUT;
> +		}
> +		msleep(20);
> +	}
> +
> +	return 0;
> +}
> +
> +#define CI_VBUS_STABLE_TIMEOUT 500

Just curious.. how was this timeout value obtained?

Thanks
Kishon
