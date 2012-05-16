From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 16 May 2012 14:11:08 +0300
Subject: [PATCH] usb: chipidea: improve the validation of endpoint count
In-Reply-To: <1337130885-32118-1-git-send-email-marex@denx.de>
References: <1337090303-16046-3-git-send-email-richard.zhao@freescale.com>
 <1337130885-32118-1-git-send-email-marex@denx.de>
Message-ID: <87bolocreb.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marex@denx.de> writes:

> The endpoint count is zero for host-only controller. On the other hand,
> the endpoint count is non-zero for OTG capable controller.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Richard Zhao <richard.zhao@freescale.com>
> Cc: alexander.shishkin at linux.intel.com
> Cc: B20596 at freescale.com
> Cc: B29397 at freescale.com
> Cc: dong.aisheng at linaro.org
> Cc: fabio.estevam at freescale.com
> Cc: gregkh at linuxfoundation.org
> Cc: kernel at pengutronix.de
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: marex at denx.de
> Cc: shawn.guo at linaro.org
> To: linux-usb at vger.kernel.org
> ---
>  drivers/usb/chipidea/core.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index f568b8e..b29a204 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -174,6 +174,7 @@ u8 hw_port_test_get(struct ci13xxx *ci)
>  static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
>  {
>  	u32 reg;
> +	int dc;
>  
>  	/* bank is a module variable */
>  	ci->hw_bank.abs = base;
> @@ -195,7 +196,12 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
>  		ffs_nr(DCCPARAMS_DEN);
>  	ci->hw_ep_max = reg * 2;   /* cache hw ENDPT_MAX */
>  
> -	if (ci->hw_ep_max == 0 || ci->hw_ep_max > ENDPT_MAX)
> +	dc = hw_read(ci, CAP_DCCPARAMS, DCCPARAMS_DC);
> +
> +	if (dc && (ci->hw_ep_max == 0 || ci->hw_ep_max > ENDPT_MAX))
> +		return -ENODEV;
> +
> +	if (!dc && (ci->hw_ep_max != 0))
>  		return -ENODEV;

According to the spec, this doesn't happen. And taking into account the
size of the bitfield encoding the number of endpoints, the (hw_ep_max >
ENDPT_MAX) check doesn't make much sense either. Again, according to the
spec, this field really encodes the number of hardware endpoints
(meaning both OUT and IN is one hw endpoint) and the valid values for
this field are 0-16, so even comparing it against ENDPT_MAX makes little
sense.

Having said that, there is already a check in udc.c for the DC bit and
it should be enough. If any particular controller reports wrong number
of endpoints, it needs to be considered separately.

Regards,
--
Alex
