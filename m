From: jbrunet@baylibre.com (jbrunet at baylibre.com)
Date: Thu, 26 Jul 2018 00:07:21 +0200
Subject: [PATCH 10/14] arm64: dts: meson-axg: add linein codec
In-Reply-To: <CAFBinCAgMhVOpCipV2D_UPqX7z0bcT=qnfRXTWpO7zigzS_TAQ@mail.gmail.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
 <20180724125238.14567-11-jbrunet@baylibre.com>
 <CAFBinCAgMhVOpCipV2D_UPqX7z0bcT=qnfRXTWpO7zigzS_TAQ@mail.gmail.com>
Message-ID: <90780f5a6b974ee9a4f9f9f2580fc83ef6bdd805.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-07-25 at 21:18 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Tue, Jul 24, 2018 at 3:09 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > 
> > Add the es7241 analog to digital converter which is fed by the
> > lienin jack of the s400
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > index 7489b88f27d7..fb101a1c6660 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > @@ -178,6 +178,16 @@
> >                         gpios = <&gpio_speaker 2 0>;
> >                 };
> >         };
> > +
> > +       linein: audio-codec at 0 {
> 
> there is a unit-address but no reg property - I am wondering if this is allowed?
> for the regulators we're using regulator-<unique-name> instead of
> regulator@<unique number>
> 
> (this applies to other patches in this series as well)

I did that because I tried to keep node-name generic as described in the DT
spec. The idea of numbering the nodes (without a reg property) in such a way
came from :
Documentation/devicetree/bindings/sound/simple-card.txt:
=> look at the multi dai link example. I'm doing exactly the same on the axg
card's dai-links. Nothing new here.

that being said, section 2.2.1 of the DT specs says:

" If the node has no reg property, the @unit-address must be omitted and the
node-name alone differentiates the node from other nodes at the same level in
the tree "

So apparently, this is used but not ok ?
I could make 'linein' the node-name instead of the label but that wouldn't be
very generic.
We could also have dai-link-2 instead dai-link at 2 (audio-codec-3 instead of 
audio-codec at 3). I seems to be OK with the spec, but it also looks weird ...

Rob, do you have opinion on this ? 

> 
> > +               #sound-dai-cells = <0>;
> > +               compatible = "everest,es7241";
> > +               VDDA-supply = <&vcc_3v3>;
> > +               VDDP-supply = <&vcc_3v3>;
> > +               VDDD-supply = <&vcc_3v3>;
> > +               status = "okay";
> > +               sound-name-prefix = "Linein";
> 
> SPDIF output uses capital letters "SPDIFOUT"
> I am not familiar with the sound subsystem (thus I'm not sure where
> this shows up) so I am wondering if the naming should be consistent?

This string is used to prefix the name of the different widgets and controls
provided. It is useful when several devices provides component and control with
the same names. It happens when several instances of a component are used but
also with classic names, such as "Playback"

I don't think there is a rule regarding capitalization.
Some name are all capital in ASoC, some just have the first letter in upper
case. It doesn't change anything technically, and I personally don't care.

> 
> Regards
> Martin
