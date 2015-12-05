From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 5 Dec 2015 10:43:37 +0100 (CET)
Subject: [PATCH RFC 2/4] ARM: bcm2835: rename sdhci pin group
In-Reply-To: <565E6892.4070600@wwwdotorg.org>
References: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
 <1447949176-21926-3-git-send-email-stefan.wahren@i2se.com>
 <565E6892.4070600@wwwdotorg.org>
Message-ID: <705524977.33360.5a38c754-5911-4377-aa1a-501587b3a337.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Stephen Warren <swarren@wwwdotorg.org> hat am 2. Dezember 2015 um 04:42
> geschrieben:
>
>
> On 11/19/2015 09:06 AM, Stefan Wahren wrote:
> > The node name of the sdhci pin group doesn't explain it's
> > real function. So rename it.
>
> The real function of this node is not to configure SDHCI pins, but to
> set pins to alt3, as the current name states. Admittedly it's possible
> that currently the only pins that need to be set to ALT3 are SDHCI
> related, but that's incidental.

Yes, i understand the original intension to assign every pin to the available
mux functions ( gpio_in, gpio_out, alt* ).

But 3f37169fb3 ("ARM: bcm2835: dt: Add Raspberry Pi Model B rev2") introduce a
better self-describing pin group naming for I2S. So my idea was to adapt it
according to sdhci first and go on.

So here is a possible vision for bcm2835-rpi.dtsi

&gpio {
	pinctrl-names = "default";

	act_gpio: gpio {
		brcm,pins = <6>;
		brcm,function = <BCM2835_FSEL_GPIO_OUT>;
	};

	i2c0_alt0: i2c {
		brcm,pins = <0 1>;
		brcm,function = <BCM2835_FSEL_ALT0>;
	};

	i2c1_alt0: i2c {
		brcm,pins = <2 3>;
		brcm,function = <BCM2835_FSEL_ALT0>;
	};
	
	gpclk_alt0: gpclk {
		brcm,pins = <4 5>;
		brcm,function = <BCM2835_FSEL_ALT0>;
	};
	
	spi0_alt0: spi {
		brcm,pins = <7 8 9 10 11>;
		brcm,function = <BCM2835_FSEL_ALT0>;
	};
	
	uart0_alt0: spi {
		brcm,pins = <14 15>;
		brcm,function = <BCM2835_FSEL_ALT0>;
	};
	
	pwm0_alt0: pwm {
		brcm,pins = <40>;
		brcm,function = <BCM2835_FSEL_ALT0>;
	};
	
	pwm1_alt0: pwm {
		brcm,pins = <45>;
		brcm,function = <BCM2835_FSEL_ALT0>;
	};

	sdhci_alt3: sdhci_alt3 {
		brcm,pins = <48 49 50 51 52 53>;
		brcm,function = <BCM2835_FSEL_ALT3>;
	};
};

Best regards
Stefan
