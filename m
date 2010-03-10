From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 10 Mar 2010 17:01:19 +0000
Subject: [PATCH 4/4] Zipit Z2 WM8750 aSoC driver
In-Reply-To: <201003101742.24566.marek.vasut@gmail.com>
References: <201003101742.24566.marek.vasut@gmail.com>
Message-ID: <20100310170119.GI6850@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 05:42:24PM +0100, Marek Vasut wrote:
> Hi,
> This patch adds support for sound through the WM8750 codec on Zipit Z2.
> Also, this patch incorporates support for detecting headset jack
> insertion through the jack detection API.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

The ASoC stuff needs to get merged via ASoC.

Please do remember to CC maintainers and relevant lists on patches.
Please also try to follow the recommendations in
Documentation/SubmittingPatches - there's a fair number of people who
manage to submit using gmail without these problems.

> + *  Revision history
> + *    21st Dec 2008   Zipit Z2 version.
> + *    30th Nov 2005   Initial version.

Remove this.

> +/* Headset jack detection DAPM pins */
> +static struct snd_soc_jack_pin hs_jack_pins[] = {
> +	{
> +		.pin	= "Mic Jack",
> +		.mask	= SND_JACK_MICROPHONE,
> +	},
> +	{
> +		.pin	= "Headphone Jack",
> +		.mask	= SND_JACK_HEADPHONE,
> +	},
> +};
> +
> +/* Headset jack detection gpios */
> +static struct snd_soc_jack_gpio hs_jack_gpios[] = {
> +	{
> +		.gpio		= GPIO37_ZIPITZ2_HEADSET_DETECT,
> +		.name		= "hsdet-gpio",
> +		.report		= SND_JACK_HEADSET,
> +		.debounce_time	= 200,
> +	},
> +};

The code here doesn't seem entrely compatible with the explicit ext
control stuff you've got above - there's two different ways to manage
the jack status that don't seem to be cooperating.  Both "Headphone
Jack" and "Microphone Jack" are managed by both.

> +static const struct snd_kcontrol_new wm8750_z2_controls[] = {
> +	SOC_ENUM_EXT("Jack Function", z2_enum[0], z2_get_jack,
> +		z2_set_jack),
> +	SOC_ENUM_EXT("Speaker Function", z2_enum[1], z2_get_spk,
> +		z2_set_spk),

Please don't use an array to store the enums.

> +static struct wm8750_setup_data z2_wm8750_setup = {
> +	.i2c_bus	= 0,
> +	.i2c_address	= 0x1b,
> +};

Nack, use the driver model (looks like WM8750 needs converting over
still, wonder what went AWOL there).
