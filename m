From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 24 Jan 2013 17:25:17 +0200
Subject: [RESEND PATCH v5 3/7] usb: chipidea: add otg id switch and vbus
 connect/disconnect detect
In-Reply-To: <1358733418-17969-4-git-send-email-peter.chen@freescale.com>
References: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
 <1358733418-17969-4-git-send-email-peter.chen@freescale.com>
Message-ID: <87y5fimwma.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

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

[snip]

> @@ -483,6 +614,17 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  		goto rm_wq;
>  	}
>  
> +	otgsc = hw_read(ci, OP_OTGSC, ~0);
> +	/*
> +	 * if it is device mode:
> +	 * - Enable vbus detect
> +	 * - If it has already connected to host, notify udc
> +	 */
> +	if (ci->role == CI_ROLE_GADGET) {
> +		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
> +		ci_handle_vbus_change(ci);
> +	}
> +

Actually, this doesn't work, neither here, nor in udc_start(), where the
next patch moves it. If you start in host role with A plug, unplug it,
plug B and load a gadget module, it won't start till you replug the
cable, which is where vbus detection happens. So, when you say that vbus
detection is "fully tested", what is the test case set that you're
using?

One obvious fix is to move ci_handle_vbus_change() call to
ci13xxx_start(), but I need to think about the whole thing a bit more.

Regards,
--
Alex
