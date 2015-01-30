From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 30 Jan 2015 09:16:22 +0100
Subject: 3.19 on Nokia n900: audio quality awful
In-Reply-To: <20150129204218.GC3962@amd>
References: <20150106170433.GA5408@amd> <54CA173F.1070301@ti.com>
 <20150129204218.GC3962@amd>
Message-ID: <201501300916.22364@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 January 2015 21:42:18 Pavel Machek wrote:
> Hi!
> 
> > >> I did this:
> > >> 
> > >> I'm not sure which one is "main" microphone and which is
> > >> headset, but I guess 2V should be "close enough" to 2.5V
> > >> to produce something different from zeros..?
> > > 
> > > Main or integrated is digital microphone which does AD
> > > conversion itself and headset is analogue. If DMIC is
> > > without bias codec will sample plain zeros from DMIC
> > > input but analogue input should always produce some
> > > random LSB bits from codec's AD converter.
> > > 
> > > If codec produces zeros also from analogue input then I
> > > suppose codec ADC is not powered up or similar. One way
> > > to hunt regression if bisecting is not possible due
> > > reason or another is to dump and diff codec registers
> > > from /sys/kernel/debug/regmap/ using both working commit
> > >
> > >and head.
> 
> I tried 2.6.28... where recording was, but it does not support
> regmap. Then I tried 3.14, but could not get recording to work
> there.
> 
> > >>  	tlv320aic3x_aux: tlv320aic3x at 19 {
> > >> 
> > >> @@ -502,6 +504,8 @@
> > >> 
> > >>  		DRVDD-supply = <&vmmc2>;
> > >>  		IOVDD-supply = <&vio>;
> > >>  		DVDD-supply = <&vio>;
> > >> 
> > >> +
> > >> +		ai3x-micbias-vg = <1>;
> > >> 
> > >>  	};
> > > 
> > > This should be 2, i.e. 2.5 V according to
> > > Documentation/devicetree/bindings/sound/tlv320aic3x.txt. I
> > > think 2 V is too low for some headset mics and that was
> > > the reason for 2.5 V.
> 
> Ok, tried that, but no change.
> 
> > Can you also try this patch to correct the DAPM route for the 
rx51:
> Yes, with the patch below (and dts updates I did) recording
> works.
> 
> Another interesting note is that audio quality is not that
> horrible when playing 8 kHz, mono signal... it is mostly what
> I'd expect. Playing 44.1kHz, stereo mp3 .. is not good.
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> 
> Thanks,
> 									Pavel
> 
> > diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> > index 04896d6252a2..7f299357c2d2 100644
> > --- a/sound/soc/omap/rx51.c
> > +++ b/sound/soc/omap/rx51.c
> > @@ -250,14 +250,14 @@ static const struct snd_soc_dapm_route
> > audio_map[] = {
> > 
> >  	{"FM Transmitter", NULL, "LLOUT"},
> >  	{"FM Transmitter", NULL, "RLOUT"},
> > 
> > -	{"DMic Rate 64", NULL, "Mic Bias"},
> > -	{"Mic Bias", NULL, "DMic"},
> > +	{"DMic Rate 64", NULL, "DMic"},
> > +	{"DMic", NULL, "Mic Bias"},
> > 
> >  	{"b LINE2R", NULL, "MONO_LOUT"},
> >  	{"Earphone", NULL, "b HPLOUT"},
> > 
> > -	{"LINE1L", NULL, "b Mic Bias"},
> > -	{"b Mic Bias", NULL, "HS Mic"}
> > +	{"LINE1L", NULL, "HS Mic"},
> > +	{"HS Mic", NULL, "b Mic Bias"},
> > 
> >  };
> >  
> >  static const char * const spk_function[] = {"Off", "On"};

Can you try DT and non-DT boot of 3.19? If there is difference?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/32aa80ed/attachment.sig>
