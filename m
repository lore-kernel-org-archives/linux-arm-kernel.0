From: nm@ti.com (Menon, Nishanth)
Date: Wed, 22 Feb 2012 19:37:30 -0600
Subject: [PATCHv5 03/14] arm: omap3+: voltage: parameter segregation
In-Reply-To: <1329833098-19900-4-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
 <1329833098-19900-4-git-send-email-t-kristo@ti.com>
Message-ID: <CAOMWX4d+M9oagDtmSqG=X8Ln4kUEyLaqpfB9Pz0Y+6RmK=sjYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 08:04, Tero Kristo <t-kristo@ti.com> wrote:
[...]
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 949938d..940a0d6 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h

[...]
> @@ -171,6 +169,18 @@ struct omap_voltdm_pmic {
> ? ? ? ?u8 (*uv_to_vsel) (unsigned long uV);
> ?};
>
> +struct omap_vp_param {
> + ? ? ? u32 vddmax;
> + ? ? ? u32 vddmin;
> +};
> +

Thinking a little deeper about this(SoC level vdd min and max) on a
slightly different angle- core of the question that intend to answer
are:
 - what is the least voltage we want to allow in active transtion? it
should not be lower than retention voltage.
- what is the max voltage we want to allow in active transition? it
should be the max Nom voltage of all the OPPs for that domain.

In effect, why do we even need to register
"voltdm->vp_param->vdd[min|max]"? We already have that info - right?
On the other hand it might be safer to do this way to handle quirks in
future SoCs.. but thought I'd spit it out anyways..

> +struct omap_vc_param {
and elsewhere - please add kernel-doc struct documentation as well
when new structs are introduced?
> + ? ? ? u32 on;
> + ? ? ? u32 onlp;
> + ? ? ? u32 ret;
> + ? ? ? u32 off;
> +};
> +
[...]

Regards,
Nishanth Menon
