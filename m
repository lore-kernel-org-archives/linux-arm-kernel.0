From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Aug 2015 16:48:48 +0100
Subject: [PATCH 9/9] drm: bridge/dw_hdmi-i2s-audio: add audio driver
In-Reply-To: <E1ZO6hr-0003No-RB@rmk-PC.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hr-0003No-RB@rmk-PC.arm.linux.org.uk>
Message-ID: <20150810154848.GV7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 05:10:47PM +0100, Russell King wrote:
> From: Yakir Yang <ykk@rock-chips.com>
> 
> Add ALSA based HDMI I2S audio driver for dw_hdmi. Sound card
> driver could connect to this codec through the codec dai name
> "dw-hdmi-i2s-audio".
> 
> [Fixed IRQ name, MODULE_DESCRIPTION, MODULE_ALIAS in
>  dw-hdmi-i2s-audio.c, and platform device name in dw-hdmi.c --rmk]
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I'm dropping this patch after all as it no longer builds against modern
kernels due to the reference to the removed snd_soc_jack_new().  Its
replacement is at card level, and I don't think it's a simple case of
replacing it here.

> +static int snd_dw_hdmi_audio_probe(struct snd_soc_codec *codec)
> +{
> +	struct snd_dw_hdmi *dw = snd_soc_codec_get_drvdata(codec);
> +	int ret;
> +
> +	ret = snd_soc_jack_new(codec, "dw Jack", SND_JACK_LINEOUT,
> +			       &dw->jack);
...
> +static const struct snd_soc_codec_driver dw_hdmi_audio = {
> +	.probe = snd_dw_hdmi_audio_probe,
> +	.dapm_widgets = snd_dw_hdmi_audio_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(snd_dw_hdmi_audio_widgets),
> +	.dapm_routes = snd_dw_hdmi_audio_routes,
> +	.num_dapm_routes = ARRAY_SIZE(snd_dw_hdmi_audio_routes),
> +};
> +
> +static int dw_hdmi_audio_probe(struct platform_device *pdev)
> +{
> +	struct dw_hdmi_audio_data *data = pdev->dev.platform_data;
> +	struct snd_dw_hdmi *dw;
> +	int ret;
> +
> +	dw = devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
> +	if (!dw)
> +		return -ENOMEM;
> +
> +	dw->data = *data;
> +	dw->dev = &pdev->dev;
> +	dw->is_jack_ready = false;
> +	platform_set_drvdata(pdev, dw);
> +
> +	ret = request_irq(dw->data.irq, snd_dw_hdmi_irq, IRQF_SHARED,
> +			  DRIVER_NAME, dw);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request irq failed (%d)\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	ret = snd_soc_register_codec(&pdev->dev, &dw_hdmi_audio,
> +				     &dw_hdmi_audio_dai, 1);

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
