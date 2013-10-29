From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Oct 2013 15:09:53 -0700
Subject: [PATCH v2 5/6] ASoC: sirf-inner: add mach driver for SiRFSoC
 internal codec
In-Reply-To: <1383002159-29273-1-git-send-email-Baohua.Song@csr.com>
References: <1383002159-29273-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20131029220953.GA11424@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 07:15:59AM +0800, Barry Song wrote:

> +	if (sinner_card->extcon_info.state_changed) {
> +		sinner_card->extcon_info.state_changed = 0;
> +		if (!sinner_card->extcon_info.last_state)
> +			gpio_direction_output(sinner_card->gpio_spk_pa, 0);
> +		else
> +			gpio_direction_output(sinner_card->gpio_spk_pa, 1);

What's this extcon stuff all about?

> +	sinner_card->sirf_inner_device = platform_device_alloc("soc-audio", -1);
> +	if (!sinner_card->sirf_inner_device)
> +		return -ENOMEM;

You shouldn't be using soc-audio - use devm_snd_soc_register_card() for
new drivers.

> +	sirf_inner_dai_links[0].cpu_of_node =
> +		of_parse_phandle(pdev->dev.of_node, "sirf,inner-platform", 0);

You need to add binding documents for new bindings.

> +	if (gpio_is_valid(sinner_card->gpio_spk_pa))
> +		gpio_request(sinner_card->gpio_spk_pa, "SPA_PA_SD");
> +	if (gpio_is_valid(sinner_card->gpio_hp_pa))
> +		gpio_request(sinner_card->gpio_hp_pa, "HP_PA_SD");

devm_gpio_request_one().

> +	sinner_card->extcon_info.pdev.name = "extcon-gpio";
> +	sinner_card->extcon_info.pdev.id = pdev->id;
> +	sinner_card->extcon_info.pdev.dev.platform_data =
> +		&sinner_card->extcon_info.extcon_data;

Use the ASoC jack support so this behaves like other cards.  Hooking the
ALSA core jack support into extcon would be a good idea but it should be
done there.

> +#ifdef CONFIG_PM_SLEEP
> +static int sirf_inner_resume(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct sirf_inner_card *sinner_card = snd_soc_card_get_drvdata(card);
> +	struct extcon_dev *edev;
> +	int state;
> +
> +	edev = extcon_get_extcon_dev(sinner_card->extcon_info.extcon_data.name);
> +	state = gpio_get_value(sinner_card->extcon_info.extcon_data.gpio);
> +	if (state != sinner_card->extcon_info.last_state) {
> +		sinner_card->extcon_info.state_changed = 1;
> +		sinner_card->extcon_info.last_state = state;
> +		extcon_set_state(edev, state);

Even if you're using extcon this looks like something that extcon-gpio
ought to be handling...

> +static int sirf_inner_suspend(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct sirf_inner_card *sinner_card = snd_soc_card_get_drvdata(card);
> +	sinner_card->extcon_info.last_state = gpio_get_value(sinner_card->extcon_info.extcon_data.gpio);
> +	if (gpio_is_valid(sinner_card->gpio_spk_pa))
> +		gpio_direction_output(sinner_card->gpio_spk_pa, 0);

DAPM will do this for you.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/fd8d86dd/attachment.sig>
