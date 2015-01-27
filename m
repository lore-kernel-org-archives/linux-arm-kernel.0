From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 28 Jan 2015 00:24:40 +0100
Subject: pinctrl-imx: calculation of pinid bogus for i.MX25
Message-ID: <20150127232440.GK29856@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

for an i.MX25 based machine I used the same pin for two different
devices (which obviously is an error). The pinctrl driver detected this
just fine, but the error message it issued is bogus. It said:

	imx25-pinctrl 43fac000.iomuxc: pin MX25_PAD_CSI_D9 already requested by 43fac000.iomuxc; cannot claim for gpio-leds
	imx25-pinctrl 43fac000.iomuxc: could not request pin 80 (MX25_PAD_CSI_D9) from group gpioleds  on device 43fac000.iomuxc

but actually it was pin MX25_PAD_CSI_MCLK that I used twice.

The problem is 

 - drivers/pinctrl/freescale/pinctrl-imx25.c has:

	enum ... {
		...
		MX25_PAD_CSI_D9 = 80,
		MX25_PAD_CSI_MCLK = 81,
		...
	};

 - arch/arm/boot/dts/imx25-pinfunc.h has:

 	#define MX25_PAD_CSI_MCLK__GPIO_1_8             0x140 0x338 0x000 0x15 0x000

 - and to determine the pin of a given pinconfig tuple the first value
   is divided by 4. 0x140 / 4 == 80.

All entries in the enum above are affected. Is the right fix to
decrement all the values by one (and drop MX25_PAD_RESERVE1)?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
