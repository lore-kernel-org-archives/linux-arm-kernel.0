From: afd@ti.com (Andrew F. Davis)
Date: Mon, 26 Feb 2018 09:43:27 -0600
Subject: regression v4.16 on Nokia N900:/dev/input/event6 aka AV Jack
 support disappeared
In-Reply-To: <20180224214617.GA22619@amd>
References: <20180224214617.GA22619@amd>
Message-ID: <052b4de7-5734-925b-7e0d-edf7abeefcfc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2018 03:46 PM, Pavel Machek wrote:
> Hi!
> 
> In v4.16, AV jack support disappeared.
> 
> This one is suspect:
> 
> commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057
> Author: Andrew F. Davis <afd@ti.com>
> Date:   Wed Nov 29 11:13:59 2017 -0600
> 
>     ARM: dts: omap3-n900: Fix the audio CODEC's reset pin
> 
>     The correct DT property for specifying a GPIO used for reset
>         is "reset-gpios", fix this here.
> 
>     Fixes: 14e3e295b2b9 ("ARM: dts: omap3-n900: Add TLV320AIC3X
>     support")
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> How was it tested? It reverts polarity of reset pin, but
> sound/soc/codecs/tlv320aic3x.c treats those as aliases:
> 


The polarity was wrong before, the AIC3x devices are active low reset
and there is no logic inverters between the SoC and the reset line.
GPIO_ACTIVE_LOW is therefor the correct polarity.

This does not change the driver behavior as currently it uses the old
gpio_set_value() which does not respect the polarity as set in DT.

When this driver is converted to use gpiod_ style calls having the
polarity correct will be important, and right now the old style gpio
calls will cause this driver to fail to work if a board comes along that
does have some logic inversion on the reset line as GPIO_ACTIVE is ignored.

As Pavel points out I think your trouble is elsewhere.

Andrew


>  ret = of_get_named_gpio(np, "reset-gpios", 0);
>  if (ret >= 0) {
>     aic3x->gpio_reset = ret;
>  } else {
>  ret = of_get_named_gpio(np, "gpio-reset", 0);
>  if (ret > 0) {
>     dev_warn(&i2c->dev, "Using deprecated property \"gpio-r\eset\", please update your DT");
>     aic3x->gpio_reset = ret;
> 
> 
> 									Pavel
> 
