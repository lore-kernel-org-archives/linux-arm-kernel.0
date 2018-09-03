From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 03 Sep 2018 11:57:25 +0200
Subject: [PATCH 2/3] arm64: dts: meson-axg: s400: add dmic codec
In-Reply-To: <CAOMZO5BOMOB6LaRs1fnmm-Ghu7pMkXW=sH_NOEWK3pqHAbUMCg@mail.gmail.com>
References: <20180831150218.8307-1-jbrunet@baylibre.com>
 <20180831150218.8307-3-jbrunet@baylibre.com>
 <CAOMZO5BOMOB6LaRs1fnmm-Ghu7pMkXW=sH_NOEWK3pqHAbUMCg@mail.gmail.com>
Message-ID: <b0efc5cf9cf4f7e05097fcd0ea6fd61ba8ff3476.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-09-01 at 18:24 -0300, Fabio Estevam wrote:
> Hi Jerome,
> 
> On Fri, Aug 31, 2018 at 12:02 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > There are 7 digital mics on the MIC daughter board attached
> > to the s400 board, so add the digital microphone codec to
> > its DTS
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > index ff64c429d432..f3e16cbbc61e 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > @@ -86,6 +86,15 @@
> >                 sound-name-prefix = "DIT";
> >         };
> > 
> > +       dmics: audio-codec at 3 {
> 
> You pass @3 without a corresponding reg = <3>, which causes dtc
> warnings with W=1.

Hi Fabio,

Thanks for pointing this out.
Martin also raised concerns about this but, unfortunately, we did not get to the
bottom of it:

https://lkml.kernel.org/r/
90780f5a6b974ee9a4f9f9f2580fc83ef6bdd805.camel at baylibre.com

In a nutshell, I numbered nodes (w/o a reg prop) to keep generic names as
suggested in the DT spec.

The idea came after working on sound cards, if you check
Documentation/devicetree/bindings/sound/simple-card.txt, you'll see this kind of
numbering is even in documentation examples.

This is used by arch/arm/boot/dts/armada-370-db.dts. This is just an example I
picked randomly, I'm not trying to single out the marvell folks here (or ASoC
simple card). I'm actually doing exactly the same kind of multi link stuff on
the amlogic cards.

This looks to be a wide spread practice. Running `make dtbs W=1` on ARM and
ARM64 arch, I've seen dozen of 'node has a unit name, but no reg property'
examples, on things like clocks, buttons, leds, pinctrl, etc ...

that being said, section 2.2.1 of the DT specs says:

" If the node has no reg property, the @unit-address must be omitted and the
node-name alone differentiates the node from other nodes at the same level in
the tree "

So apparently, this is used but not ok ?
Maybe we should simply replace the '@' with a '-' everywhere this occurs ?

If possible, I'd like to get the opinion of the DT gurus about this issue.
Cheers

Jerome
