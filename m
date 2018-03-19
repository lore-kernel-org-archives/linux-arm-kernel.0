From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Mon, 19 Mar 2018 13:19:10 +0900
Subject: [PATCH] ASoC: uniphier: evea: add switch for changing source of
 line-in
In-Reply-To: <20180314162609.GV2186@sirena.org.uk>
References: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
 <20180314162609.GV2186@sirena.org.uk>
Message-ID: <001101d3bf39$6e3933c0$4aab9b40$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Thursday, March 15, 2018 1:26 AM
> To: Suzuki, Katsuhiro <suzuki.katsuhiro@socionext.com>
> Cc: alsa-devel at alsa-project.org; Masami Hiramatsu
<masami.hiramatsu@linaro.org>;
> Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH] ASoC: uniphier: evea: add switch for changing source of
line-in
> 
> On Wed, Mar 14, 2018 at 09:39:00PM +0900, Katsuhiro Suzuki wrote:
> > This patch adds mixer switch for changing audio source of line-in.
> > We can choose one of LIN1, 2, 3, default is LIN1.
> 
> I'll apply for now but this should really be a DAPM control so that we
> can power down things connected to the disconnected line inputs when
> recording.

Thanks a lot for your suggestion. I tried to change the implementation to DAPM
control as follows:

----------
static const char * const linsw1_sel1_text[] = {
	"LIN1", "LIN2", "LIN3"
};

static SOC_ENUM_SINGLE_DECL(linsw1_sel1_enum,
	ALINSW1, ALINSW1_SEL1_SHIFT,
	linsw1_sel1_text);

static const struct snd_kcontrol_new linesw1_mux =
	SOC_DAPM_ENUM("Line In 1 Source", linsw1_sel1_enum);

static const struct snd_soc_dapm_widget evea_widgets[] = {
	SND_SOC_DAPM_ADC("ADC", NULL, SND_SOC_NOPM, 0, 0),
	SND_SOC_DAPM_MUX("Line In 1 Mux", SND_SOC_NOPM, 0, 0, &linesw1_mux),
	SND_SOC_DAPM_INPUT("LIN1_LP"),
	SND_SOC_DAPM_INPUT("LIN1_RP"),
	SND_SOC_DAPM_INPUT("LIN2_LP"),
	SND_SOC_DAPM_INPUT("LIN2_RP"),
	SND_SOC_DAPM_INPUT("LIN3_LP"),
	SND_SOC_DAPM_INPUT("LIN3_RP"),

	SND_SOC_DAPM_DAC("DAC HP", NULL, SND_SOC_NOPM, 0, 0),
	SND_SOC_DAPM_DAC("DAC LO1", NULL, SND_SOC_NOPM, 0, 0),
	SND_SOC_DAPM_DAC("DAC LO2", NULL, SND_SOC_NOPM, 0, 0),
	SND_SOC_DAPM_OUTPUT("HP1_L"),
	SND_SOC_DAPM_OUTPUT("HP1_R"),
	SND_SOC_DAPM_OUTPUT("LO2_L"),
	SND_SOC_DAPM_OUTPUT("LO2_R"),
};

static const struct snd_soc_dapm_route evea_routes[] = {
	{ "Line In 1", NULL, "ADC" },
	{ "ADC", NULL, "Line In 1 Mux" },
	{ "Line In 1 Mux", NULL, "LIN1_LP" },
	{ "Line In 1 Mux", NULL, "LIN1_RP" },
	{ "Line In 1 Mux", NULL, "LIN2_LP" },
	{ "Line In 1 Mux", NULL, "LIN2_RP" },
	{ "Line In 1 Mux", NULL, "LIN3_LP" },
	{ "Line In 1 Mux", NULL, "LIN3_RP" },

	{ "DAC HP", NULL, "Headphone 1" },
	{ "DAC LO1", NULL, "Line Out 1" },
	{ "DAC LO2", NULL, "Line Out 2" },
	{ "HP1_L", NULL, "DAC HP" },
	{ "HP1_R", NULL, "DAC HP" },
	{ "LO2_L", NULL, "DAC LO2" },
	{ "LO2_R", NULL, "DAC LO2" },
};
----------

I can see the value of ALINSW1 register at 'Line In 1 Mux',0 using
  amixer get 'Line In 1 Mux',0

But I can't change the value.
  amixer set 'Line In 1 Mux',0 LIN2
  Simple mixer control 'Line In 1 Mux',0
    Capabilities: enum
    Items: 'LIN1' 'LIN2' 'LIN3'
    Item0: 'LIN1'

Would you tell me what is wrong...


Regards,
--
Katsuhiro Suzuki
