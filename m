From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 23 Oct 2017 10:13:24 +0200
Subject: [PATCH] firmware: meson-sm: use generic compatible
In-Reply-To: <CAL_JsqKON3mKrkjg1gR-JjM_YarWMdGRURTx39MVgC=beCKz3g@mail.gmail.com>
References: <20171012134743.10625-1-jbrunet@baylibre.com>
 <20171017204959.kfbhn2yxhv2sb5qg@rob-hp-laptop>
 <7h8tg7zb6t.fsf@baylibre.com>
 <CAL_JsqJ-XAqMA_zjxrJNAtysQsXzmWYUFqLJtKX2wUJ0oebtuw@mail.gmail.com>
 <1508488253.3616.28.camel@baylibre.com>
 <CAL_JsqKON3mKrkjg1gR-JjM_YarWMdGRURTx39MVgC=beCKz3g@mail.gmail.com>
Message-ID: <1508746404.3587.26.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-10-20 at 14:34 -0500, Rob Herring wrote:
> On Fri, Oct 20, 2017 at 3:30 AM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > On Thu, 2017-10-19 at 16:18 -0500, Rob Herring wrote:
> > > On Thu, Oct 19, 2017 at 5:25 AM, Kevin Hilman <khilman@baylibre.com>
> > > wrote:
> > > > Rob Herring <robh@kernel.org> writes:
> > > > 
> > > > > On Thu, Oct 12, 2017 at 03:47:43PM +0200, Jerome Brunet wrote:
> > > > > > The meson secure monitor seems to be compatible with more SoCs than
> > > > > > initially thought. Let's use the most generic compatible he have in
> > > > > > DT instead of the gxbb specific one
> > > > > > 
> > > > > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/firmware/meson/meson_sm.txt | 4
> > > > > > ++--
> > > > > >  drivers/firmware/meson/meson_sm.c                             | 4
> > > > > > ++--
> > > > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > > > 
> > > > > Seems like a pointless, not backwards compatible change to me.
> > > > 
> > > > I've verified that it's backwards compatible with existing upstream DTs.
> > > 
> > > Perhaps if you all are documenting only what the driver uses, not what
> > > the dts can have as Jerome said.
> > > 
> > > > > end, it's just a string to match on. Who cares what the string is.
> > > > 
> > > > As platform maintiner, I very much care what the strings are and I want
> > > > it to be coherent with the platform generic names, and I want the
> > > > SoC-specific strings to correspond to the actual SoC names.
> > > 
> > > The most specific compatible should be, absolutely. The fallbacks can
> > > be anything really. Ideally, they are the compatible string for the
> > > 1st SoC with "the same" compatible IP. Could be another vendor
> > > entirely even because mergers happen.
> > 
> > Then what's your problem with these patches again ?
> 
> Removal of the SoC specific compatible and breaking compatibility.
> Kevin says compatibility is not broken, but it obviously it based on
> the example and the driver change. So that can only mean your dts file
> doesn't match the example.

I believe it does, but I suppose I have missed something.

Currently the driver only matches on:
.compatible = "amlogic,meson-gxbb-sm" (drivers/firmware/meson_sm.c)

The only device-tree file using it is 
meson-gx.dtsi: compatible = "amlogic,meson-gx-sm", "amlogic,meson-gxbb-sm";

So:
1) yes the order is backward (thx for pointing this out)
2) by changing the compatible matched by the driver from "amlogic,meson-gxbb-sm" 
to "amlogic,meson-gx-sm", I don't think I am breaking anything. Feel free to
point out why this is wrong because I don't get it. 

> 
> > I am just asking the driver to match the generic binding instead of the SoC
> > specific, because we are also using it on other SoC, as explain in the patch
> > comment. Does not seems that "pointless" to me.
> > 
> > Right now the driver match only on: vendor,soc-one
> > in dts, we have compatible = "vendor,family", "vendor,soc-one"
> 
> That's backwards if I understand this right. It should be most
> specific first, but that's a separate issue.
> 
> > but it is compatible with soc-two as well.
> > to match we would have to put "vendor,soc-one" as well which is a mess
> 
> Why? That's how DT works and every other platform follows. Either you have:
> 
> "vendor,soc-one", "vendor,family"
> "vendor,soc-two", "vendor,family"
> 
> or
> 
> "vendor,soc-one"
> "vendor,soc-two", "vendor,soc-one"
> 
> The latter is how DT has existed and worked for 20+ years. The former
> is what we allow because for some reason people have such an aversion
> to saying soc2 is compatible with soc1.
> 
> Either one is fine, but the documentation must be clear what the
> constraints are for the dts file. For example, "vendor,soc-two" or
> "vendor,family" alone are not valid. There's plenty of examples to

except that the DT file where it is used is a soc family dtsi.
meson-gx.dtsi is the common DT for gxbb and gxl family. Wouldn't it make sense 
to have the SoC generic compatible alone here ? and override it in the SoC DT if
necessary ? 

> follow. Renesas is one using "vendor,family" extensively.
> 
> > By expressing correctly what the driver is compatible with, "vendor,family"
> > we can dts that makes sense for soc-two as well
> > compatible = "vendor,family", "vendor,soc-two"

Honestly, I don't care which of the 2 solutions we take. The important thing for
me is to eliminate the confusion introduced by the generic-compatible being here
and useless. The driver is indeed generic, but the related compatible is not
matched. This makes no sense.

So either:
* we use "vendor,soc-one", "vendor,family" model: I believe this what I'm trying
 to do here. For this, we need to match the soc generic compatible in the
driver.

* we use the "vendor,soc-two", "vendor,soc-one" model : The driver keeps on
matching the SoC specific compatible. We won't ever match the generic one with
this model, what is the point of keeping it around in DT ? Should we remove it ?

Maybe the later is better, it would end up just being a removal of an
undocumented property from DT.

> 
> Binding docs may live in the kernel, but they are separate from
> drivers. They describe the constraints of the dts files. There's no
> reason to document what the driver wants because I can read the driver
> source. I can't say the same thing about the dts file. The dts may not
> come from the kernel and one dts file is not all possible options for
> a given binding.
> 
> Rob
