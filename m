From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 24 Jan 2013 10:24:21 +0000
Subject: [alsa-devel] [PATCH V2 2/2] ASoC: Davinci: machine: Add device
 tree binding
In-Reply-To: <20130124101301.GG4955@opensource.wolfsonmicro.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
 <20130104122612.GM4627@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB50DCF@DBDE01.ent.ti.com>
 <20130123154804.GB4565@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB52FD9@DBDE01.ent.ti.com>
 <20130124100252.GE4955@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB530BB@DBDE01.ent.ti.com>
 <20130124101301.GG4955@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB5312F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 15:43:03, Mark Brown wrote:
> On Thu, Jan 24, 2013 at 10:06:42AM +0000, Hebbar, Gururaja wrote:
> 
> > What I meant was that by using this macro (SND_SOC_DAPM_POST_PMU &
> > SND_SOC_DAPM_PRE_PMD) I can just save and restore existing voltage values inside
> > the event. They will not be user configurable (available to user through some widget).
> 
> Well, you *could* add separate register control for that 

That?s what I am doing using a different register control


	+static const char *mic_bias_level_txt[] = { "off", "2V", "2.5V", "AVDD" };
	+
	+static const struct soc_enum mic_bias_level =
	+SOC_ENUM_SINGLE(MICBIAS_CTRL, 6, 4, mic_bias_level_txt);
	+
	 static const struct snd_kcontrol_new aic3x_snd_controls[] = {
		/* Output */
		SOC_DOUBLE_R_TLV("PCM Playback Volume",
	@@ -391,6 +396,9 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
		SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),
	 
		SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
	+
	+	/* Mic Bias Level */
	+	SOC_ENUM("Mic Bias Level", mic_bias_level),



> but it's not
> really something that should obviously be exposed to users; usually
> that'd be something that is fixed by the platform via platform data.

Will look into this angle.

> 

Going by the way of using extra register control, will my method (code change
attached in prev mail) be sufficient?


Regards, 
Gururaja
