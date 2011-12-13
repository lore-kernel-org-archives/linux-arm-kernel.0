From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 13 Dec 2011 14:33:43 -0700 (MST)
Subject: [PATCHv11 1/8] ARM: OMAP2+: hwmod: Add API to enable IO ring
 wakeup.
In-Reply-To: <alpine.DEB.2.00.1112131354380.12046@utopia.booyaka.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-2-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1112131354380.12046@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1112131431310.12046@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Govindraj, Tero,

another question about this patch:

On Tue, 13 Dec 2011, Paul Walmsley wrote:

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 207a2ff..ec19841 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -381,6 +381,43 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
>  }
>  
>  /**
> + * _set_ioring_wakeup - enable/disable IO pad wakeup flag for dynamic muxing
> + * @oh: struct omap_hwmod *
> + * @set_wake: bool value indicating to set (true) or clear (false) wakeup enable
> + *
> + * Set or clear the I/O pad wakeup flag in the dynamic mux entries for
> + * the hwmod @oh.  This function does not change anything in the
> + * hardware.  Rather, the @oh->mux->pads_dynamic array is changed, and
> + * these settings are later written to the SCM PADCTRL registers when
> + * the hwmod is enabled or idled.  No return value.
> + *
> + * XXX Shouldn't the dynamic pad changes affect hwmod shutdown as
> + * well?
> + * XXX Shouldn't this function update the hardware SCM PADCONF registers if
> + * anything has changed?
> + */
> +static void _set_ioring_wakeup(struct omap_hwmod *oh, bool set_wake)
> +{
> +	struct omap_device_pad *pad;
> +	int j;
> +
> +	if (!oh->mux || !oh->mux->enabled)
> +		return;
> +
> +	for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
> +		pad = oh->mux->pads_dynamic[j];
> +
> +		if (!(pad->flags & OMAP_DEVICE_PAD_WAKEUP))
> +			continue;
> +
> +		if (set_wake)
> +			pad->idle |= OMAP_WAKEUP_EN;
> +		else
> +			pad->idle &= ~OMAP_WAKEUP_EN;
> +	}
> +}

It appears that this loop only affects dynamic mux entries.  Should it 
also affect static mux entries?


- Paul
