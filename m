From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Sat, 24 Mar 2018 22:08:56 +0100
Subject: [PATCH 3/3] arm64: dts: armada-3720-espressobin: wire up LED2
In-Reply-To: <20180321105005.18426-3-u.kleine-koenig@pengutronix.de> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 21 Mar 2018 11:50:05
 +0100")
References: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
 <20180321105005.18426-3-u.kleine-koenig@pengutronix.de>
Message-ID: <87vadluqon.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On mer., mars 21 2018, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> The led is connected to MPP1_2.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Note the LED doesn't work for me on two different boards. But the
> voltage levels on one side of the LED changes from 1.76V to 0V when
> enabling the LED. So there is probably something fishy, don't know if it
> is hardware or software related.

Initially I thought that maybe you should use the "led" function for
it. But this function is only available for pin 11 to 14 not for pin 2.

Another tricky thing is that the pin controller for Armada 37xx really
work on groups: you can't only change the function of a single pin. But
the pin 2 is linked to pin 3 and they have as alternate function "i2c"
which is not used for the espressobin.

Moreover you seemed to managed to controller the pin.

So I have no more ideas for this issue.

At least according to the datasheet, there is no way to control the
behavior of the pin (pull-up, pull-don, open-drain, ...). It is only the
pin 11 to 14 which can be put in Open-Drain if they use the function
"led".

Gregory



>
> Best regards
> Uwe
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index a88f053d2f28..0802d595e0a2 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -77,6 +77,15 @@
>  			  3300000 0x0>;
>  		enable-active-high;
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led2 {
> +			gpios = <&gpionb 2 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
>  };
>  
>  /* J9 */
> -- 
> 2.16.2
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
