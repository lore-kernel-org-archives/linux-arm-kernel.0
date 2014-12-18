From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Dec 2014 08:52:05 +0100
Subject: DT on s3c24xx
In-Reply-To: <CA+E=qVf4nT5x-fRFBu=Wv_VKUnEMAEP4GgJG8em8NyUFkwtbPg@mail.gmail.com>
References: <CA+E=qVf4nT5x-fRFBu=Wv_VKUnEMAEP4GgJG8em8NyUFkwtbPg@mail.gmail.com>
Message-ID: <20141218075205.GB10857@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[Cc += linusw, linux-gpio]

On Wed, Dec 17, 2014 at 10:04:24PM +0300, Vasily Khoruzhick wrote:
> I'd like to port several s3c24xx to DT, and I'm stuck with s3c24xx LCD
> controller and power drivers for H1940 and RX1950.
> 
> Please see [1]. I want to move this function into another LCD power
> driver, but I'm not sure what to do with s3c_gpio_cfgpin(). I need to
> change pin function in runtime, and as far as I understand it should
> be handled via pinctrl driver somehow. But how?
You can pass >1 pinctrl setups to a node:

	somedevice {
		pinctrl-names = "default", "foo", "bar";
		pinctrl-0 = <&pinctrl_somedevice_default>;
		pinctrl-1 = <&pinctrl_somedevice_foo>;
		pinctrl-2 = <&pinctrl_somedevice_bar>;
		cfg-gpios = <&gpio4 12 3>, <&gpio2 7 5>;
	};

Then I think you can fiddle with pinctrl_select_state(). For the gpios
you can then use the standard gpiod_{request,direction_{in,out}put}
combo.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
