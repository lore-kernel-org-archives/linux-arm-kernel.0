From: jeffy.chen@rock-chips.com (jeffy)
Date: Mon, 18 Sep 2017 09:46:03 +0800
Subject: [PATCH] Asoc: rockchip: Init dapm routes dynamically
In-Reply-To: <20170916005407.GH173745@google.com>
References: <20170905041401.23866-1-jeffy.chen@rock-chips.com>
 <20170916005407.GH173745@google.com>
Message-ID: <59BF255B.2040203@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Thanks for your test and review.

On 09/16/2017 08:54 AM, Matthias Kaehlcke wrote:
>> -static const struct snd_soc_dapm_route rockchip_dapm_routes[] = {
>> >-	/* Input Lines */
>> >-	{"MIC", NULL, "Headset Mic"},
>> >-	{"DMIC1L", NULL, "Int Mic"},
>> >-	{"DMIC1R", NULL, "Int Mic"},
>> >-
>> >-	/* Output Lines */
>> >-	{"Headphones", NULL, "HPL"},
>> >-	{"Headphones", NULL, "HPR"},
>> >-	{"Speakers", NULL, "Speaker"},
>> >+	SND_SOC_DAPM_LINE("HDMI", NULL),
> The HDMI items are newly added, I think a separate patch would be
> preferable.
ok, will do

>
>> >  };
>> >
>> >  static const struct snd_kcontrol_new rockchip_controls[] = {
>> >@@ -66,6 +55,7 @@ static const struct snd_kcontrol_new rockchip_controls[] = {
>> >  	SOC_DAPM_PIN_SWITCH("Speakers"),
>> >  	SOC_DAPM_PIN_SWITCH("Headset Mic"),
>> >  	SOC_DAPM_PIN_SWITCH("Int Mic"),
>> >+	SOC_DAPM_PIN_SWITCH("HDMI"),
>> >  };
>> >
>> >  static int rockchip_sound_max98357a_hw_params(struct snd_pcm_substream *substream,
>> >@@ -314,8 +304,6 @@ static struct snd_soc_card rockchip_sound_card = {
>> >  	.owner = THIS_MODULE,
>> >  	.dapm_widgets = rockchip_dapm_widgets,
>> >  	.num_dapm_widgets = ARRAY_SIZE(rockchip_dapm_widgets),
>> >-	.dapm_routes = rockchip_dapm_routes,
>> >-	.num_dapm_routes = ARRAY_SIZE(rockchip_dapm_routes),
>> >  	.controls = rockchip_controls,
>> >  	.num_controls = ARRAY_SIZE(rockchip_controls),
>> >  };
>> >@@ -391,6 +379,65 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
>> >  	},
>> >  };
>> >
>> >+static const struct snd_soc_dapm_route rockchip_sound_cdndp_routes[] = {
>> >+	/* Output */
>> >+	{"HDMI", NULL, "TX"},
>> >+};
>> >+
>> >+static const struct snd_soc_dapm_route rockchip_sound_da7219_routes[] = {
>> >+	/* Output */
>> >+	{"Headphones", NULL, "HPL"},
>> >+	{"Headphones", NULL, "HPR"},
>> >+
>> >+	/* Input */
>> >+	{"MIC", NULL, "Headset Mic"},
>> >+};
>> >+
>> >+static const struct snd_soc_dapm_route rockchip_sound_dmic_routes[] = {
>> >+	/* Input */
>> >+	{"Dmic", NULL, "Int Mic"},
> Should be "DMic" as in dmic_dapm_widgets of the dmic codec driver.
>
> This route is also new and would probably be better added in a
> separate patch.

ok, will do
>
