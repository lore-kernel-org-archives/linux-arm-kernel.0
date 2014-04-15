From: alexanders83@web.de (Alexander Stein)
Date: Tue, 15 Apr 2014 21:17:13 +0200
Subject: [PATCH 3/4] ALSA: sound/atmel/ac97c.c: Add device tree
 support
In-Reply-To: <20140414232134.GB2967@piout.net>
References: <1397293707-26890-1-git-send-email-alexanders83@web.de>
 <11572820.ByGz2BLudS@kongar> <20140414232134.GB2967@piout.net>
Message-ID: <1507201.Sg3DHX4q4v@kongar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 April 2014, 01:21:34 wrote Alexandre Belloni:
> On 13/04/2014 at 10:32:09 +0200, Alexander Stein wrote :
> > On Saturday 12 April 2014, 14:48:17 wrote Alexander Shiyan:
> > > Sat, 12 Apr 2014 12:42:18 +0200 ?? Alexander Stein <alexanders83@web.de>:
> > > > On Saturday 12 April 2014, 14:31:28 wrote Alexander Shiyan:
> > > > > Sat, 12 Apr 2014 11:08:26 +0200 ?? Alexander Stein <alexanders83@web.de>:
> > > > > > Signed-off-by: Alexander Stein <alexanders83@web.de>
> > > > > > ---
> > > > > >  .../devicetree/bindings/sound/atmel_ac97c.txt      | 20 +++++++++
> > > > > >  sound/atmel/ac97c.c                                | 52 ++++++++++++++++++++--
> > > > > >  2 files changed, 69 insertions(+), 3 deletions(-)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/sound/atmel_ac97c.txt
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/sound/atmel_ac97c.txt b/Documentation/devicetree/bindings/sound/atmel_ac97c.txt
> > > > > > new file mode 100644
> > > > > > index 0000000..9839403
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/sound/atmel_ac97c.txt
> > > > > > @@ -0,0 +1,20 @@
> > > > > > +* Atmel AC97 controller
> > > > > > +
> > > > > > +Required properties:
> > > > > > +  - compatible: "atmel,atmel_ac97c"
> > > > > > +  - reg: Address and length of the register set for the device
> > > > > > +  - interrupts: Should contain AC97 interrupt
> > > > > > +  - atmel,reset-pin: GPIO for resetting the codec
> > > > > 
> > > > > Why standard "gpios" property cannot be used here?
> > > > 
> > > > I guess they can. I have no experience defining a devicetree binding, so I just stuck to the platformdata member name.
> > > > If this is the recommended way, I'll gladly change that.
> > > 
> > > Another question is whether this property should refer to the controller,
> > > as it is clear that it refers to the codec ....
> > 
> > AFAICT the codec itself has no representation in the devicetree. It gets detected by the controller which uses the reset GPIO.
> >
> 
> Yeah, maybe we can already go for ac97-gpios, there. It actually takes a
> list of gpios: ac97-sync, ac97-sdata and ac97-reset. You may want to
> have a look at Documentation/devicetree/bindings/sound/soc-ac97link.txt
> and snd_soc_set_ac97_ops_of_reset(), snd_soc_ac97_parse_pinctl() in
> sound/soc/core.c
> 
> The goal would be to be able to keep the same bindings when switching
> over to ASoC.

Those bindings are only for the description an AC97 codec attached, right?
I'm just wondering what is ac97-sdata actually?
The datasheet to my microcontroller (atmel ac97c) has 4 signals:
* AC97CK - this would be omitted in the description as it's fixed 12,288MHz
* AC97RX - sdata_in
* AC97FS - is this ac97-sync?
* AC97TX - sdata_out

ac97-reset would be board-specific. Is ac97-reset one of those AC97TX or AC97RX?

Best regards,
Alexander

PS: I splitted Patch 3 to separate the device-tree binding and removed the device match as you suggested.
