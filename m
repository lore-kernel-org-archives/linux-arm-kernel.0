From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 23 Jan 2013 12:39:35 +0000
Subject: [alsa-devel] [PATCH V2 2/2] ASoC: Davinci: machine: Add device
 tree binding
In-Reply-To: <20130104122612.GM4627@opensource.wolfsonmicro.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
 <20130104122612.GM4627@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB50DCF@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 17:56:12, Mark Brown wrote:
> On Fri, Jan 04, 2013 at 03:24:37PM +0530, Hebbar Gururaja wrote:
> 
> > +		"MIC3L",                "Mic Bias 2V",
> > +		"MIC3R",                "Mic Bias 2V",
> > +		"Mic Bias 2V",          "Mic Jack",
> 
> The CODEC driver biases should be changed over to be supplies, this
> makes the above much more natural - the routing there is a hack for
> older versions of ASoc.  Otherwise this looks fine.


ON TLV320AIC3x Codec, MIC Bias power on/off share the same register bits
with Bias voltage output.

Page 0 / Register 25: MICBIAS Control Register

BIT	READ/WRITE	RESET VALUE	DESCRIPTION
D7?D6	R/W 			00 	MICBIAS Level Control
					00: MICBIAS output is powered down
					01: MICBIAS output is powered to 2.0V
					10: MICBIAS output is powered to 2.5V
					11: MICBIAS output is connected to AVDD


Because of this, I find it difficult to use SND_SOC_DAPM_SUPPLY macro.

I found a similar implementation (MIC BIAS enable + Bias voltage selection)
in 2 other platform (WM8900 & SGTL5000).

WM8900 --> Different registers for MIC BIAS enable & Bias voltage selection.
However both are implemented using different macros

static const char *mic_bias_level_txt[] = { "0.9*AVDD", "0.65*AVDD" };

static const struct soc_enum mic_bias_level =
SOC_ENUM_SINGLE(WM8900_REG_INCTL, 8, 2, mic_bias_level_txt);

...
static const struct snd_kcontrol_new wm8900_snd_controls[] = {
SOC_ENUM("Mic Bias Level", mic_bias_level),
...

SND_SOC_DAPM_SUPPLY("Mic Bias", WM8900_REG_POWER1, 4, 0, NULL, 0),



SGTL5000 --> Single register for MIC BIAS enable & output impedance of MIC
Bias. The driver uses SND_SOC_DAPM_POST_PMU & SND_SOC_DAPM_PRE_PMD macro to
handle the MIC Bias enable & disable event.


static int mic_bias_event(struct snd_soc_dapm_widget *w,
        struct snd_kcontrol *kcontrol, int event)
{
        switch (event) {
        case SND_SOC_DAPM_POST_PMU:
	...

static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
	...
        SND_SOC_DAPM_SUPPLY("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0,
                            mic_bias_event,
                            SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),


Since TLV320AIC3x Codec uses single register bit-set to indicate BIA state
& Voltage level, I am not able to able to change existing code to
SND_SOC_DAPM_SUPPLY macro.


Could you please show some pointers on how to handle/implement
SND_SOC_DAPM_SUPPLY in above scenario?


Thanks & Regards, 
Gururaja
