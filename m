From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 24 Feb 2015 09:41:58 +0100
Subject: Ask for help. ARM:mvebu (CM-A510),
 add sound support using TLV320AIC23 audio-codec
In-Reply-To: <54EB8D34.7040003@gmail.com>
References: <54EB8D34.7040003@gmail.com>
Message-ID: <54EC3956.4070505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding alsa-devel and Jean-Francois]

Gabriel,

you should try to add people and lists you expect help from.

On 23.02.2015 21:27, Gabriel Dobato wrote:
> I am trying to set the sound system using "simple-audio-card" and
> TLV320AIC23B audio codec in  Compulab CM-510 SoM.
>
> This is my structure in DT, according to
> ./KERNEL/Documentation/devicetree/bindings/sound/simple-card.txt,
> /KERNEL/Documentation/devicetree/bindings/sound/widgets.txt and the
> source code of the audio-codec ./KERNEL/sound/soc/codecs/tlv320aic23.c :
>
>   sound {
>                  compatible = "simple-audio-card";
>                  simple-audio-card,name = "OnboardTLV320AIC23B";
>                  simple-audio-card,format = "i2s";
>                  simple-audio-card,bitclock-master = <&dailink_master>;
>                  simple-audio-card,frame-master = <&dailink_master>;
>                  simple-audio-card,widgets =
>                          "Microphone", "Mic Input",
>                          "Line", "Line Input",
>                          "Line", "Line Out",
>                          "Speaker", "Speaker",
>                          "Headphone", "Headphone Jack";
>
>                  simple-audio-card,routing =
>                          "Line Out", "LOUT",
>                          "Line Out", "ROUT",
>                          "Line Out", "RHPOUT",
>                          "Line Out", "LHPOUT",
>                          "LLINEIN","Line Input",
>                          "RLINEIN","Line Input",
>                           "MICIN","Mic Input";
>                  simple-audio-card,cpu {
>                                  sound-dai = <&audio0 0>;
>                          };
>                  dailink_master: simple-audio-card,codec {
>                                  sound-dai = <&opt_audio>;
>                          };
>                  };
> };
>
> /* TLV320AIC23 */
> &opt_audio {
>              status = "okay";
>              #sound-dai-cells= <0>;
>   };

The full node looks like:
opt_audio: audio at 1a {
	compatible = "ti,tlv320aic23";
	reg = <0x1a>;
	#sound-dai-cells= <0>;
	status = "okay";
};

> And this is the kernel trace:
>
> ...
> tlv320aic23-codec 0-001a: Control not supported for path LLINEIN ->
> [NULL] -> Line Input
> tlv320aic23-codec 0-001a: ASoC: no dapm match for LLINEIN --> NULL -->
> Line Input
> tlv320aic23-codec 0-001a: ASoC: Failed to add route LLINEIN -> NULL ->
> Line Input
> tlv320aic23-codec 0-001a: Control not supported for path RLINEIN ->
> [NULL] -> Line Input
> tlv320aic23-codec 0-001a: ASoC: no dapm match for RLINEIN --> NULL -->
> Line Input
> tlv320aic23-codec 0-001a: ASoC: Failed to add route RLINEIN -> NULL ->
> Line Input
> tlv320aic23-codec 0-001a: Control not supported for path MICIN -> [NULL]
> -> Mic Input
> tlv320aic23-codec 0-001a: ASoC: no dapm match for MICIN --> NULL --> Mic
> Input
> tlv320aic23-codec 0-001a: ASoC: Failed to add route MICIN -> NULL -> Mic
> Input
> usb 2-1.2: new high-speed USB device number 3 using orion-ehci
> asoc-simple-card sound: tlv320aic23-hifi <-> i2s mapping ok
> ...
>
> ALSA device list:
>    #0: OnboardTLV320AIC23B
> ...
>
> [....] Setting up ALSA...amixer: Invalid command!

It doesn't help much without knowing what amixer is trying to do.

> I think I have written the node according to the documentation, but
> probably I miss something.

Looking at sound/soc/codecs/tlv320aic23.c:

static const struct snd_soc_dapm_route tlv320aic23_intercon[] = {
	/* Output Mixer */
	{"Output Mixer", "Line Bypass Switch", "Line Input"},
	{"Output Mixer", "Playback Switch", "DAC"},
	{"Output Mixer", "Mic Sidetone Switch", "Mic Input"},

	/* Outputs */
	{"RHPOUT", NULL, "Output Mixer"},
	{"LHPOUT", NULL, "Output Mixer"},
	{"LOUT", NULL, "Output Mixer"},
	{"ROUT", NULL, "Output Mixer"},

	/* Inputs */
	{"Line Input", "NULL", "LLINEIN"},
	{"Line Input", "NULL", "RLINEIN"},

	{"Mic Input", "NULL", "MICIN"},

	/* input mux */
	{"Capture Source", "Line", "Line Input"},
	{"Capture Source", "Mic", "Mic Input"},
	{"ADC", NULL, "Capture Source"},

};

The lines with the failing routes really look suspicious, i.e.
there is strings "NULL" where I'd expect plain NULL.

What happens if you amend the three lines and replace the "NULL"
with NULL?

Sebastian
