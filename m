From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Feb 2016 21:32:58 +0100
Subject: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
In-Reply-To: <20160220195925.GF18327@sirena.org.uk> (Mark Brown's message of
 "Sun, 21 Feb 2016 04:59:25 +0900")
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk> <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk>
Message-ID: <87twl3xgud.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Sat, Feb 20, 2016 at 07:22:04PM +0100, Robert Jarzmik wrote:
>> Mark Brown <broonie@kernel.org> writes:
Removed DT people from this conversation.

>> > Instead we should be probing at runtime (as the non-ASoC AC'97 code does) or
>> > something similar.
>
>> When you say "non-ASoC AC'97 code", which file are you referring to ? Is it
>> sound/pci/ac97/ac97_codec.c ?
>
> Yes.
>
>> If so is there already a table of tuples (AC97_VENDOR_ID1, AC97_VENDOR_ID2) ->
>> (platform device, platform device data) and a matching mechanism already
>> available to the ASoC drivers ?
>
> ASoC doesn't really support the enumeration very well, you can use
> ac97.c as the CODEC but that's about it.

> There is a generic AC'97 PXA driver in sound/arm, if your system can use that
> that'd be a better route to DT integration for it I think.
I'm open on the topic.

Historically, I use sound/soc/pxa/pxa2xx-ac97.c since 2008. I know it works, but
if you think I should examine sound/arm/pxa2xx-ac97.c, let's do that.

> Did you try that, if there are problems with that perhaps we can improve that
> driver, it should be simpler.
I will. By now I fail to see how this will help in the wm9713 probing and
detection ...

Until I make the try, here is what I have as a device-tree extract in [1], which
is my candidate for sound/soc/pxa/zylonite.c replacement.. If we conclude that
wm9713 shouldn't be in device-tree, then I'm curious how the DAI bindings
(simple-audio-card,dai-link*) should be handled.

Cheers.

-- 
Robert

[1] Zylonite DT extract
	ssp3: ssp at 41900000 {
		compatible = "mrvl,pxa3xx-ssp";
		reg = <0x41900000 0x40>;
		interrupts = <0>;
		clocks = < &clks CLK_SSP3 >;
		dmas = <&pdma 66 3
			&pdma 67 3>;
		dma-names = "rx", "tx";
		pinctrl-names = "default";
		pinctrl-0 = < &pmux_ssp3_low_default
			      &pmux_ssp3_float_default >;
		status = "okay";
	};

	ssp_dai0: ssp_dai at 0 {
		compatible = "mrvl,pxa-ssp-dai";
		port = <&ssp3>;
		#sound-dai-cells = <0>;
	};
	ac97: sound at 40500000 {
	      	compatible = "marvell,pxa2xx-ac97";
		reg = < 0x40500000 0x1000 >;
		interrupts = <14>;
		reset-gpio = <&gpio 113 GPIO_ACTIVE_HIGH>;
		#sound-dai-cells = <1>;
		pinctrl-names = "default";
		pinctrl-0 = < &pmux_ac97_default >;
		status = "okay";
	};

	pxa_pcm_audio: snd_soc_pxa_audio {
		compatible = "mrvl,pxa-pcm-audio";
		#sound-dai-cells = <1>;
	};
	pxa_ssp_dai: snd_soc_pxa_audio {
		compatible = "mrvl,pxa-pcm-audio";
		#sound-dai-cells = <1>;
	};

	wm9713: wm9713 at 0 {
		compatible = "wlf,wm9713";
		#sound-dai-cells = <1>;
		pinctrl-names = "default";
		pinctrl-0 = < &pmux_wm9713_default >;
		status = "okay";
	};

	sound {
		compatible = "simple-audio-card";
		simple-audio-card,name = "Zylonite-Sound-Card";
		simple-audio-card,format = "ac97";
		simple-audio-card,widgets =
			"Headphone", "Headphone",
			"Microphone", "Headset Microphone",
			"Microphone", "Handset Microphone",
			"Speaker", "Multiactor",
			"Speaker", "Headset Earpiece";
		simple-audio-card,routing =
			"Headphone", "HPL",		/* Headphone output */
			"Headphone", "HPR",		/* connected to HPL/HPR */
			"Headset Earpiece", "OUT3",	/* On-board earpiece */
			"MIC2A", "Mic Bias",			/* Headphone mic */
			"Mic Bias", "Headset Microphone",	/* Headphone mic */
			"MIC1", "Mic Bias",			/* On-board mic */
			"Mic Bias", "Handset Microphone",	/* On-board mic */
			"Multiactor", "SPKL",		/* Multiactor differentially */
			"Multiactor", "SPKR";		/* connected over SPKL/SPKR */
	
		simple-audio-card,dai-link at 0 {		/* AC97 */
			format = "ac97";
			cpu {
				sound-dai = <&ac97 0>;
			};
			codec {
				sound-dai = <&wm9713 0>;
			};
			plat {
				sound-dai = <&pxa_pcm_audio 0>;
			};
		};
		simple-audio-card,dai-link at 1 {		/* AC97 Aux */
			format = "ac97";
			cpu {
				sound-dai = <&ac97 1>;
			};
			codec {
				sound-dai = <&wm9713 1>;
			};
			plat {
				sound-dai = <&pxa_pcm_audio 0>;
			};
		};
		simple-audio-card,dai-link at 2 {		/* AC97 Voice */
			format = "i2s";
			cpu {
				sound-dai = <&ssp_dai0>;
			};
			codec {
				sound-dai = <&wm9713 2>;
			};
			plat {
				sound-dai = <&pxa_pcm_audio 0>;
			};
		};
	};
