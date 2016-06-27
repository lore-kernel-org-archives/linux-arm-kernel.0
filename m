From: jun.li@nxp.com (Jun Li)
Date: Mon, 27 Jun 2016 08:04:39 +0000
Subject: [PATCH 04/21] usb: chipidea: Only read/write OTGSC from one place
In-Reply-To: <20160626072838.28082-5-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-5-stephen.boyd@linaro.org>
Message-ID: <AM4PR04MB213088094DF074BB5CB3DD0689210@AM4PR04MB2130.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> -----Original Message-----
> From: linux-usb-owner at vger.kernel.org [mailto:linux-usb-
> owner at vger.kernel.org] On Behalf Of Stephen Boyd
> Sent: Sunday, June 26, 2016 3:28 PM
> To: linux-usb at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> linux-arm-msm at vger.kernel.org; Andy Gross <andy.gross@linaro.org>; Bjorn
> Andersson <bjorn.andersson@linaro.org>; Neil Armstrong
> <narmstrong@baylibre.com>; Arnd Bergmann <arnd@arndb.de>; Felipe Balbi
> <balbi@kernel.org>; Peter Chen <peter.chen@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Ivan T. Ivanov <iivanov.xz@gmail.com>
> Subject: [PATCH 04/21] usb: chipidea: Only read/write OTGSC from one place
> 
> With the id and vbus detection done via extcon we need to make sure we
> poll the status of OTGSC properly by considering what the extcon is saying,
> and not just what the register is saying. Let's move this hw_wait_reg()
> function to the only place it's used and simplify it for polling the OTGSC
> register. Then we can make certain we only use the hw_read_otgsc() API to
> read OTGSC, which will make sure we properly handle extcon events.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Ivan T. Ivanov" <iivanov.xz@gmail.com>
> Fixes: 3ecb3e09b042 ("usb: chipidea: Use extcon framework for VBUS and ID
> detect")
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/core.c | 32 --------------------------------
> drivers/usb/chipidea/otg.c  | 35 +++++++++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 69426e644d17..01390e02ee53 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -516,38 +516,6 @@ int hw_device_reset(struct ci_hdrc *ci)
>  	return 0;
>  }
> 
> -/**
> - * hw_wait_reg: wait the register value
> - *
> - * Sometimes, it needs to wait register value before going on.
> - * Eg, when switch to device mode, the vbus value should be lower
> - * than OTGSC_BSV before connects to host.
> - *
> - * @ci: the controller
> - * @reg: register index
> - * @mask: mast bit
> - * @value: the bit value to wait
> - * @timeout_ms: timeout in millisecond
> - *
> - * This function returns an error code if timeout
> - */
> -int hw_wait_reg(struct ci_hdrc *ci, enum ci_hw_regs reg, u32 mask,
> -				u32 value, unsigned int timeout_ms)
> -{
> -	unsigned long elapse = jiffies + msecs_to_jiffies(timeout_ms);
> -
> -	while (hw_read(ci, reg, mask) != value) {
> -		if (time_after(jiffies, elapse)) {
> -			dev_err(ci->dev, "timeout waiting for %08x in %d\n",
> -					mask, reg);
> -			return -ETIMEDOUT;
> -		}
> -		msleep(20);
> -	}
> -
> -	return 0;
> -}
> -
>  static irqreturn_t ci_irq(int irq, void *data)  {
>  	struct ci_hdrc *ci = data;
> diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c index
> 03b6743461d1..763a8332b009 100644
> --- a/drivers/usb/chipidea/otg.c
> +++ b/drivers/usb/chipidea/otg.c
> @@ -104,7 +104,32 @@ void ci_handle_vbus_change(struct ci_hdrc *ci)
>  		usb_gadget_vbus_disconnect(&ci->gadget);
>  }
> 
> -#define CI_VBUS_STABLE_TIMEOUT_MS 5000
> +/**
> + * Sometimes, it needs to wait register value before going on.
> + * Eg, when switch to device mode, the vbus value should be lower
> + * than OTGSC_BSV before connects to host.

This should be updated since this API is dedicated for BSV now.

> + *
> + * @ci: the controller
> + *
> + * This function returns an error code if timeout  */ static int
> +hw_wait_otgsc_bsv(struct ci_hdrc *ci) {
> +	unsigned long elapse = jiffies + msecs_to_jiffies(5000);
> +	u32 mask = OTGSC_BSV;
> +
> +	while (!hw_read_otgsc(ci, mask)) {

Reverse logic, should be:
while (hw_read_otgsc(ci, mask)) {

Li Jun

> +		if (time_after(jiffies, elapse)) {
> +			dev_err(ci->dev, "timeout waiting for %08x in OTGSC\n",
> +					mask);
> +			return -ETIMEDOUT;
> +		}
> +		msleep(20);
> +	}
> +
> +	return 0;
> +}
> +
>  static void ci_handle_id_switch(struct ci_hdrc *ci)  {
>  	enum ci_role role = ci_otg_role(ci);
> @@ -116,9 +141,11 @@ static void ci_handle_id_switch(struct ci_hdrc *ci)
>  		ci_role_stop(ci);
> 
>  		if (role == CI_ROLE_GADGET)
> -			/* wait vbus lower than OTGSC_BSV */
> -			hw_wait_reg(ci, OP_OTGSC, OTGSC_BSV, 0,
> -					CI_VBUS_STABLE_TIMEOUT_MS);
> +			/*
> +			 * wait vbus lower than OTGSC_BSV before connecting
> +			 * to host
> +			 */
> +			hw_wait_otgsc_bsv(ci);
> 
>  		ci_role_start(ci, role);
>  	}
> --
> 2.9.0.rc2.8.ga28705d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
