From: tony@atomide.com (Tony Lindgren)
Date: Sun, 10 Jun 2012 23:29:06 -0700
Subject: [PATCHv2 07/12] ARM: OMAP4+: AESS: enable internal auto-gating
 during initial setup
In-Reply-To: <20120611004611.20034.60143.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004611.20034.60143.stgit@dusk>
Message-ID: <20120611062905.GS12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Few comments below on making the platform_data work better along
with other archs.

* Paul Walmsley <paul@pwsan.com> [120610 17:56]:
> Enable the AESS auto-gating control bit during AESS hwmod setup.  This
> fixes the following boot warning on OMAP4:
...

> --- /dev/null
> +++ b/include/linux/platform_data/aess.h

This should be include/linux/platform_data/omap-aess.h or similar as
there are other aess controllers too.

> +/*
> + * AESS_AUTO_GATING_ENABLE_OFFSET: offset in bytes of the AESS IP
> + *     block's AESS_AUTO_GATING_ENABLE__1 register from the IP block's
> + *     base address
> + */
> +#define AESS_AUTO_GATING_ENABLE_OFFSET			0x07c
> +
> +/* Register bitfields in the AESS_AUTO_GATING_ENABLE__1 register */
> +#define AESS_AUTO_GATING_ENABLE_SHIFT			0

Also these should be OMAP_AESS_AUTOGATING etc, or even better,
XYZ_AESS_AUTOGATING where XYZ is the type of the AESS controller.


> +/**
> + * aess_enable_autogating - enable AESS internal autogating
> + * @oh: struct omap_hwmod *
> + *
> + * Enable internal autogating on the AESS.  This allows the AESS to
> + * indicate that it is idle to the OMAP PRCM.  Returns 0.
> + */
> +static void aess_enable_autogating(void __iomem *base)
> +{
> +	u32 v;
> +
> +	/* Set AESS_AUTO_GATING_ENABLE__1.ENABLE to allow idle entry */
> +	v = 1 << AESS_AUTO_GATING_ENABLE_SHIFT;
> +	writel(v, base + AESS_AUTO_GATING_ENABLE_OFFSET);
> +}

This should be static inline function as it's in the header, and again
something like omap_aess_enable_autogating.

> +/**
> + * hwmod_aess_preprogram - enable AESS internal autogating (called by hwmod)
> + * @oh: struct omap_hwmod *
> + *
> + * The AESS will not IdleAck to the PRCM until its internal autogating
> + * is enabled.  Since internal autogating is disabled by default after
> + * AESS reset, we must enable autogating after the hwmod code resets
> + * the AESS.  Returns 0.
> + */
> +static int __maybe_unused hwmod_aess_preprogram(struct omap_hwmod *oh)
> +{
> +	void __iomem *va;
> +
> +	va = omap_hwmod_get_mpu_rt_va(oh);
> +	if (!va)
> +		return -EINVAL;
> +
> +	aess_enable_autogating(va);
> +
> +	return 0;
> +}

Then this function should not be in this header, instead it should be a
static function somewhere in the omap hwmod code in some .c file. That's
because this header should only have omap aess specific driver code, no
hwmod code should be needed here.

Regards,

Tony
