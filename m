From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 Nov 2009 11:41:07 +0000
Subject: [PATCH 12/17] ARM: pxa/raumfeld: add audio related functions
In-Reply-To: <1259145751-3331-13-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-13-git-send-email-daniel@caiaq.de>
Message-ID: <20091125114106.GA3175@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 11:42:26AM +0100, Daniel Mack wrote:

> +	if (en) {
> +		gpio_set_value(mfp_to_gpio(GPIO_AUDIO_VA_ENABLE), 1);

This looks like you want to add regulator support to the CODEC.

> +		gpio_set_value(mfp_to_gpio(GPIO_MCLK_RESET), 1);
> +
> +		/* wait some time to let VA and the clocks become stable */
> +		schedule_timeout(HZ/10);
> +
> +		gpio_set_value(mfp_to_gpio(GPIO_SPDIF_RESET), 1);
> +		gpio_set_value(mfp_to_gpio(GPIO_CODEC_RESET), 1);

The relevant drivers really need to know about this...  if you are going
to stick with this approach I'd push all this stuff into the audio
driver, splitting it into this separate file isn't really buying
anything since it's all machine specific and nothing except the audio
driver needs to know what's going on.
