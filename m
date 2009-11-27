From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Nov 2009 11:34:49 +0000
Subject: [PATCH 2/3] ALSA: ARM: add Raumfeld audio support
In-Reply-To: <1259258341-31114-3-git-send-email-daniel@caiaq.de>
References: <1259258341-31114-1-git-send-email-daniel@caiaq.de>
	<1259258341-31114-2-git-send-email-daniel@caiaq.de>
	<1259258341-31114-3-git-send-email-daniel@caiaq.de>
Message-ID: <20091127113449.GB29821@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2009 at 06:59:00PM +0100, Daniel Mack wrote:

> +static struct regulator_consumer_supply audio_va_consumer_supply =
> +	REGULATOR_SUPPLY("va", "soc-audio.0");

I hadn't spotted this in your cs4270 patches but the device used should
be the I2C device, not the soc-audio device.  I'd also expect to see
this regulator setup done in arch/arm - the stuff I'd expect to see in
here is the resource claiming stuff.  Having it here is also fine, it's
just a little surprising.

> +static int raumfeld_ak4104_init(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}

Remove empty functions like this (I think this is the only one that's
left).

> +static int __init raumfeld_audio_init(void)
> +{
> +	int ret;
> +
> +	if (!machine_is_raumfeld_speaker() &&
> +	    !machine_is_raumfeld_connector())
> +		return 0;
> +
> +	max9486_client = i2c_new_device(i2c_get_adapter(0),
> +					&max9486_hwmon_info);
> +
> +	if (!max9486_client)
> +		return -ENOMEM;

I'd still really prefer to see this as a regular I2C device driver with
the code in arch/arm (even if the driver itself ends up embedded in this
file, which is what GTA01 did for a similar situation) but I guess I'm
OK.  max9486_hwmon_info could be renamed, though.

> +       platform_add_devices(regulator_devices, ARRAY_SIZE(regulator_devices));

Nothing ever reverses this (one of the reasons to shove this bit into
arch/arm :) ).
