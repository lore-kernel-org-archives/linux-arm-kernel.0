From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 08 Aug 2018 08:30:17 +0200
Subject: [PATCH 1/2] iommu/rockchip: Handle errors returned from PM
 framework
In-Reply-To: <5aa8d184-0c58-3471-a661-8a66a93271c7@arm.com>
References: <20180807085406.3863-1-marc.zyngier@arm.com>
 <3265383.PcPThIO4HC@phil> <5aa8d184-0c58-3471-a661-8a66a93271c7@arm.com>
Message-ID: <8919220.oqSeQNaOOv@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 7. August 2018, 16:25:53 CEST schrieb Marc Zyngier:
> On 07/08/18 14:15, Heiko Stuebner wrote:
> > Am Dienstag, 7. August 2018, 14:31:49 CEST schrieb Marc Zyngier:
> >> On 07/08/18 13:09, Heiko Stuebner wrote:
> >>> Hi Marc,
> >>>
> >>> Am Dienstag, 7. August 2018, 10:54:05 CEST schrieb Marc Zyngier:
> >>>> pm_runtime_get_if_in_use can fail: either PM has been disabled
> >>>> altogether (-EINVAL), or the device hasn't been enabled yet (0).
> >>>> Sadly, the Rockchip IOMMU driver tends to conflate the two things
> >>>> by considering a non-zero return value as successful.
> >>>>
> >>>> This has the consequence of hiding other bugs, so let's handle this
> >>>> case throughout the driver, with a WARN_ON_ONCE so that we can try
> >>>> and work out what happened.
> >>>>
> >>>> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
> >>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >>>
> >>> I'm still not sure about the !CONFIG_PM case, as it was probably silently
> >>> working in that case before
> >>
> >> Do we agree that this is an orthogonal problem though?
> > 
> > Nope ;-) .... I.e. right now the code ignores the -EINVAL from disabled PM
> > and continues, possibly even handling the irq correctly.
> 
> Ah, I now see what you mean. Yeah, this is a bit rubbish. It would have
> been better if the API returned something more sensible in that case,
> but that's a bit late...
> 
> > If it actually worked is a different matter, as I guess nobody really tried
> > with !PM in the past.
> 
> I don't think anyone noticed. !CONFIG_PM on something like rk3399
> probably isn't very popular, and certainly comes for free on a
> multiplatform kernel.
> 
> > Now with error-handling we always return IRQ_NONE for !PM.
> 
> Yup.
> 
> >>> But on the other hand we're also already running over it in other places
> >>> like in the iommu-shutdown and I guess if someone _really_ disabled
> >>> CONFIG_PM, a lot of additional stuff would fail anyway.
> >>>
> >>> So should we wrap that in some #ifdef magic, just ignore it or simply
> >>> select PM similar to what Tegra, Renesas and Vexpress seem to do?
> >>>
> >>> I guess I like the 3rd option best ;-)
> >>
> >> It probably doesn't hurt. At what level do you want it? As a dependency
> >> to the IOMMU? or to the platform?
> > 
> > I guess it might be best to go the Tegra, etc way. Whoever in their right
> > mind would want to drive a mobile platform without any form for power
> > management ;-) .
> > 
> > I can do these patches for arm32+arm64 myself ... I just wanted to put
> > that thought out there - in case that was just a stupid idea of mine :-D .
> 
> Not stupid at all. Regarding this very patch: where do you want me to
> take it?

If you want to add select PM for Rockchip yourself (32+64 bit), just send
them regularly and maybe include arm at kernel.org directly, so they can
apply them directly, with just a reviewed-by tag from me.


Heiko
