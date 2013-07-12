From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 12 Jul 2013 11:12:01 +0300
Subject: [PATCH v12 06/13] usb: chipidea: add otg_cap attribute for otg
 capable
In-Reply-To: <1373524041-10482-7-git-send-email-peter.chen@freescale.com>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <1373524041-10482-7-git-send-email-peter.chen@freescale.com>
Message-ID: <871u742o4u.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> Since we need otgsc to know vbus's status at some chipidea
> controllers even it is peripheral-only mode. Besides, some
> SoCs (eg, AR9331 SoC) don't have otgsc register even
> the DCCPARAMS_DC and DCCPARAMS_HC are both 1 at CAP_DCCPARAMS.
> We inroduce otg_cap attribute to indicate if the controller
> is otg capable, defaultly, we follow the rule that if DCCPARAMS_DC
> and DCCPARAMS_HC are both 1 at CAP_DCCPARAMS are otg capable, but if there
> is exception, the platform can override it by device tree or platform data.
>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---

[...]

> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index 118bf66..0a906b4 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -7,6 +7,12 @@
>  
>  #include <linux/usb/otg.h>
>  
> +enum usb_otg_cap {
> +	OTG_CAP_ATTR_IS_NOT_EXISTED = 0,
> +	OTG_CAP_ATTR_IS_TRUE,
> +	OTG_CAP_ATTR_IS_FALSE,
> +};

We don't really need all three, do we? We only need to know if the
controller *can't* do otg. The rest we can infer from dr_mode and
DCCPARAMS. So it can be another bit in flags rather than a separate
field in platdata.

Regards,
--
Alex
