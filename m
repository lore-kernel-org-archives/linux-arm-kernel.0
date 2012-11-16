From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 16 Nov 2012 14:51:03 +0200
Subject: [PATCH 7/9] usb: chipidea: udc: add force-full-speed option
In-Reply-To: <1352909950-32555-8-git-send-email-m.grzeschik@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-8-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <87wqxl679k.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik <m.grzeschik@pengutronix.de> writes:

> This patch makes it possible to set the chipidea udc
> into full-speed only mode. It can be set by the oftree
> property "force-full-speed".
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/usb/chipidea/bits.h  |    1 +
>  drivers/usb/chipidea/core.c  |    5 +++++
>  include/linux/usb/chipidea.h |    1 +
>  3 files changed, 7 insertions(+)
>
> diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
> index 3cded5f..85b6b09 100644
> --- a/drivers/usb/chipidea/bits.h
> +++ b/drivers/usb/chipidea/bits.h
> @@ -51,6 +51,7 @@
>  #define PORTSC_PTS            (BIT(31) | BIT(30))
>  #define PORTSC_PTW            BIT(28)
>  #define PORTSC_STS            BIT(29)
> +#define PORTSC_PFSC           BIT(24)

Same for this one, it's in DEVLC in my spec.

>  
>  /* DEVLC */
>  #define DEVLC_PSPD            (0x03UL << 25)
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 7e80f1b..bc99cea 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -230,6 +230,9 @@ void hw_portsc_configure(struct ci13xxx *ci)
>  		hw_write(ci, OP_PORTSC, PORTSC_PTS, 0x3 << ffs_nr(PORTSC_PTS));
>  		hw_write(ci, OP_PORTSC, PORTSC_STS, 0x1 << ffs_nr(PORTSC_STS));
>  	}
> +
> +	if (ci->platdata->flags & CI13XXX_PORTSC_PFSC)
> +		hw_write(ci, OP_PORTSC, PORTSC_PFSC, 0x1 << ffs_nr(PORTSC_PFSC));
>  }
>  
>  /**
> @@ -566,6 +569,8 @@ void ci13xxx_get_dr_flags(struct device_node *of_node, struct ci13xxx_platform_d
>  		pr_err("no phy interface defined\n");
>  	}
>  
> +	if (of_find_property(of_node, "force-full-speed", NULL))
> +		pdata->flags |= CI13XXX_PORTSC_PFSC;
>  }
>  EXPORT_SYMBOL_GPL(ci13xxx_get_dr_flags);
>  
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index cafca23..9ffe105 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -26,6 +26,7 @@ struct ci13xxx_platform_data {
>  #define CI13XXX_PORTSC_PTS_UTMI		BIT(8)
>  #define CI13XXX_PORTSC_PTS_ULPI		BIT(9)
>  #define CI13XXX_PORTSC_PTS_FSLS		BIT(10)
> +#define CI13XXX_PORTSC_PFSC		BIT(11)

Btw, these can be more descriptive and don't need _PORTSC_ prefix, like
"CI13XXX_FORCE_FULLSPEED".

Regards,
--
Alex
