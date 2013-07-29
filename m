From: matt.porter@linaro.org (Matt Porter)
Date: Mon, 29 Jul 2013 09:20:30 -0400
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <20130729093000.GI3528@e106331-lin.cambridge.arm.com>
References: <2043662.BcW19XTTMG@lenovo> <20130719020611.GA4941@glitch>
 <20130723185733.GB6811@ohporter.com>
 <CAGVrzcYnoN9NnJGvubS7=bVJDk37xSt4BimtvDWghe7OHEWALQ@mail.gmail.com>
 <20130724231106.GB29801@glitch>
 <CAGVrzcYudfgqs_eafje4BT2z2qE0kSJPx1B-xrq0WxtUkGxSFw@mail.gmail.com>
 <20130726000412.GH5022@linaro.org> <51F2F554.8030709@broadcom.com>
 <51F2F885.2040002@wwwdotorg.org>
 <20130729093000.GI3528@e106331-lin.cambridge.arm.com>
Message-ID: <20130729132029.GI5022@ohporter.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 10:30:00AM +0100, Mark Rutland wrote:
> On Fri, Jul 26, 2013 at 11:30:29PM +0100, Stephen Warren wrote:
> > I'm CC'ing in the DT bindings maintainers in case they have any comment.
> > 
> > On 07/26/2013 04:16 PM, Christian Daudt wrote:
> > > On 13-07-25 05:04 PM, Matt Porter wrote:
> > >> On Thu, Jul 25, 2013 at 11:23:21PM +0100, Florian Fainelli wrote:
> > >>> 2013/7/25 Domenico Andreoli <cavokz@gmail.com>:
> > >>>> On Tue, Jul 23, 2013 at 08:05:28PM +0100, Florian Fainelli wrote:
> > >>>>> 2013/7/23 Matt Porter <matt.porter@linaro.org>:
> > >>>>>> On Fri, Jul 19, 2013 at 04:06:11AM +0200, Domenico Andreoli wrote:
> > >>>>>> It's pretty easy to see that the "ti" vendor prefix has no
> > >>>>>> relation at
> > >>>>>> all to their TXN symbol so that blows that convention out of the
> > >>>>>> water.
> > >>>>>> Rather, the prefix is based on somebody's notion of how that vendor's
> > >>>>>> part are normally referred to. In TI-land, it's TI AM335x or TI OMAP,
> > >>>>>> never TXN OMAP. :)
> > >>>>>>
> > >>>>>> For Broadcom, every part is BCMxxxxx so "bcm" is appropriate.
> > >>>>> It was appropriate before being the "wrong" vendor prefix was
> > >>>>> allocated, now that "brcm" has been allocated we should stick to it
> > >>>>> because otherwise we will break existing and on-going DT work.
> > >>>> I still prefer bcm to brcm and I find enough evidence that bcm would be
> > >>>> better in the long term.
> > >>>>
> > >>>> So if Broadcomers can agree on bcm, now it's still the cheapest time to
> > >>>> fix in that direction, later will not be better.
> > >>> If we are to fix it in stone, once and for all, let's go for the full
> > >>> name
> > >>> which would avoid any kind of future confusion (this also seems to be
> > >>> the
> > >>> tendency with new vendor prefixes these days). That way we could make
> > >>> everyone happy with say: "broadcom,bcm2835". Would that work for
> > >>> everyone?
> > >> I really like that.
> > >>
> > >> -Matt
> > >>
> > > broadcom works for me also.
> > >  thanks,
> > >    csd
> > 
> > I have no strong objection at this point in principle to renaming the
> > vendor prefix used by the RPi support, although it will cause a bunch of
> > pointless churn in the drivers to match the new compatible values,  and
> > in the pinctrl bindings for the custom properties there...
> > 
> 
> I'd be happy to have "broadcom" for all *new* bindings, as it's already
> in some bindings alongside "bcm" and "brcm", and is certainly the
> clearest of the available options.
> 
> However, given the strong feelings of many against breaking existing
> dts, we need to support the existing instances of "bcm" and "brcm" in

Whoa, how would existing dts break? At this instant in time, all the
bindings and dts are still in the kernel tree. A series to address this
make all bindings, drivers, and dts consistent in one shot.

> bindings. This doesn't preclude us also supporting "broadcom,$DEVICE"
> alongside the existing "bcm,$DEVICE" and/or "brcm,$DEVICE" for those
> that have a strong desire for consistency in future dts, unless there's
> a feeling that creates too much churn.

As it stands now, "bcm" is 100% unacceptable. It is not captured in
vendor-prefixes.txt and thus all the drivers/dts using it should have
been rejected. It *has* to be fixed by either 1) adding the additional
prefix to vendor-prefixes.txt 2) changing it to the registered prefix
"brcm" 3) changing to another unified prefix
 
> In the end, this is a purely cosmetic change, so we can live with it
> as-is at the cost of another entry in an FAQ somewhere.
 
The only argument I have against this is that DT bindings that went
upstream in the last 6 months or more really should be considered more of
staging quality. They've had little oversight as has been illuminated in
recent events leading to the maintainership change. Since mistakes were
made in keeping to the vision of bindings being specification quality
and set in stone, it makes little sense to me to create this spec filled
with multiple legacy names. Especially at a point where the binding
maintainership and process is just starting to mature.

With that said, we can fix the current broken state of the "bcm"
bindings with a one line patch to vendor-prefixes.txt. If avoiding
churn is the highest priority I'd be happy to do that and just
end this discussion.

-Matt
