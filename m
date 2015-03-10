From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Mar 2015 13:07:43 +0100
Subject: [PATCH 1/2] soc: mediatek: Add PMIC wrapper for MT8135 and
 MT8173 SoCs
In-Reply-To: <1425986519.28516.59.camel@mtksdaap41>
References: <1424606567-29708-1-git-send-email-s.hauer@pengutronix.de>
 <1424606567-29708-2-git-send-email-s.hauer@pengutronix.de>
 <CABuKBe+goUnNUtK1+-VGNq9w-NUgQOA5d5h_0Yx9VwuXr6-A6g@mail.gmail.com>
 <20150309103835.GB31289@pengutronix.de>
 <1425986519.28516.59.camel@mtksdaap41>
Message-ID: <20150310120743.GG24885@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 07:21:59PM +0800, fan.chen wrote:
> On Mon, 2015-03-09 at 11:38 +0100, Sascha Hauer wrote:
> > > > +
> > > > +       switch (ck_mhz) {
> > > > +       case 18:
> > > > +               if (pwrap_is_mt8135(wrp))
> > > > +                       pwrap_writel(wrp, 0xc, PWRAP_CSHEXT);
> > > 
> > > If the pmic-wrapper is unique to every SoC, we should think of
> > > providing a different way to distinguish between the implementations.
> > > Otherwise we will bloat up the code with SoC specific conditionals.
> > 
> > I am happy to replace this with pwrap_is_v2() or even with additional
> > function hooks in struct pmic_wrapper_type once it's clear how other
> > pmic wrapper are different. Without this knowledge it's hard to predict
> > what the right weapon is to abstract between SoC differences.
> > 
> > Sascha
> > 
> Per function similarity, the pmic-wrapper of a new soc usually comes
> from an existing soc and have some modifications on it. (it does not
> have exactly the same version shared between SoCs so far)

So you don't have some internal versioning scheme, right? In that case the
SoC name is the best we can use as a version.

> In this case, MT8173's pmic wrapper is derived from MT8135 and they
> share much common implementation.
> For other SOCs like 6582/6592, they would have different init flows, but
> the pwrap-read/write part has very similar protocol. 
> The driver is originally intended for MT8135/MT8173 since they share quite common init flow.

Originally there were two drivers for both SoCs, it was me who merged
them.

> For other SOCs, they won't fit in current MT8135/MT173 init flow.
> Should we move pmic-wrapper init part to a chip-specific file and leave
> only common part (pmic read/write protocol) for all SoC here? ex:

Putting these into separate files doesn't change much. If this becomes
necessary because otherwise the driver grows too big it can always be
done. For now I have created an abstraction which fits for two SoC
derivates. If more derivates come then the abstraction has to grow with
the situation. Yes, we don't want to end up with stuff like
if (is_mt8173() || is_mt8135() || (is_mt6xxx() && !is_mt6533())).
Everytime another is_mtxy() is added we have to look if it's still the
right thing to be do or if function pointers in SoC specific data
structs are better, or maybe a completely other approach.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
