From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 24 Aug 2015 15:03:05 +0200
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <55DB1281.9070502@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <55DA9B72.1030804@samsung.com> <55DB1281.9070502@rock-chips.com>
Message-ID: <18468783.Lfl8UEMQ1s@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Montag, 24. August 2015, 20:48:01 schrieb Yakir Yang:
> ? 08/24/2015 12:20 PM, Krzysztof Kozlowski ??:
> > On 24.08.2015 11:42, Yakir Yang wrote:
> >> Hi Krzysztof,
> >> 
> >> ? 08/23/2015 07:43 PM, Krzysztof Kozlowski ??:
> >>> 2015-08-24 8:23 GMT+09:00 Rob Herring <robherring2@gmail.com>:
> >>>> On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com> wrote:
> >>>>> Analogix dp driver is split from exynos dp driver, so we just
> >>>>> make an copy of exynos_dp.txt, and then simplify exynos_dp.txt
> >>>>> 
> >>>>> Beside update some exynos dtsi file with the latest change
> >>>>> according to the devicetree binding documents.
> >>>> 
> >>>> You can't just change the exynos bindings and break compatibility. Is
> >>>> there some agreement with exynos folks to do this?
> >>> 
> >>> No, there is no agreement. This wasn't even sent to Exynos maintainers.
> >> 
> >> Sorry about this one, actually I have add Exynos maintainers in version
> >> 1 & version 2,
> >> but lose some maintainers in version 3, I would fix it in bellow
> >> versions.
> >> 
> >>> Additionally the patchset did not look interesting to me because of
> >>> misleading subject - Documentation instead of "ARM: dts:".
> >>> 
> >>> Yakir, please:
> >>> 1. Provide backward compatibility. Mark old properties as deprecated
> >>> but still support them.
> >> 
> >> Do you mean that I should keep the old properties declare in
> >> exynos-dp.txt,
> >> but just mark them as deprecated flag.
> > 
> > That is one of ways how to do this. However more important is that
> > driver should still support old bindings so such code:
> > -       if (of_property_read_u32(dp_node, "samsung,color-space",
> > +       if (of_property_read_u32(dp_node, "analogix,color-space",
> > 
> > is probably wrong. Will the driver support old DTB in the same way as it
> > was supporting before the change?
> 
> Okay, I got your means. So document is not the focus, the most important
> is that
> driver should support the old dts prop. If so the new analogix dp driver
> should keep
> the "samsung,color-space", rather then just mark it with [DEPRECATED] flag.
> 
> But from your follow suggest, I think you agree to update driver code,
> and just mark
> old prop with deprecated flag. If so I think such code would not be wrong
> 
> -       if (of_property_read_u32(dp_node, "samsung,color-space",
> +      if (of_property_read_u32(dp_node, "analogix,color-space",

In a generic driver, the property should have either none, or the analogix 
prefix. But DT-properties need to be backwards compatible, meaning an older 
Exynos devicetree should run unmodified with a newer kernel.

So the common course of action is to mark the old one as deprecated but still 
test for both, so something like:

       if (of_property_read_u32(dp_node, "analogix,color-space",
                                 &dp_video_config->color_space))
	       if (of_property_read_u32(dp_node, "samsung,color-space",
                	                 &dp_video_config->color_space)) {

                	dev_err(dev, "failed to get color-space\n");
                	return ERR_PTR(-EINVAL);
        	}
