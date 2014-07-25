From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Fri, 25 Jul 2014 08:14:40 +0200
Subject: [PATCH] ARM: at91: at91sam9x5: sets NPCS0 (PA14) back to GPIO
In-Reply-To: <20140724175848.44f5da10@bbrezillon>
References: <1405074175-22444-1-git-send-email-voice.shen@atmel.com>	<53D10C50.50305@aksignal.cz>	<20140724162645.4e19c26c@bbrezillon>	<53D12103.3020103@aksignal.cz>
 <20140724175848.44f5da10@bbrezillon>
Message-ID: <53D1F5D0.1080006@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Dne 24.7.2014 v 17:58 Boris BREZILLON napsal(a):
> On Thu, 24 Jul 2014 17:06:43 +0200
> Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:
>
>> Hi,
>>
>> Dne 24.7.2014 v 16:26 Boris BREZILLON napsal(a):
>>> Hello Ji??,
>>>
>>> First of all, please try to use git format-patch when submitting a
>>> patch to any kernel mailing list.
>> Sorry for that.
>>>
>>> On Thu, 24 Jul 2014 15:38:24 +0200
>>> Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:
>>>
>>>> After ROMBOOT tries boot from flash on SPI0 NPCS0, this NPCS0 (PA14) remains set to PERIPH_A.
>>>> Because of that, this pin is unusable to something else.
>>>> This patch sets it back to GPIO.
>>>
>>> The policy is to leave pins in an unknown state till some peripheral
>>> need them.
>>>
>>> What are you trying to use this pin for ?
>> For chip select, but #3. And when SPI communicate with cs0 (PA22), it goes down too (PA14), so 2 devices on bus were
>> selected.
>
> Are you using a 9x5ek board or a custom one, in the latter case could
> you paste your spi0 node definition ?
I'm using custom board. My spi node:
			spi0: spi at f0000000 {
				status = "okay";
				cs-gpios = <&pioA 23 0
					    &pioA 22 0
					    &pioC 29 0
					    &pioA 14 0>;

				fm25 at 0 {
					compatible = "cypress,fm25";
					spi-max-frequency = <40000000>;
					reg = <0>;
					pagesize = <256>;
					size = <131072>;
					address-width = <24>;
				};
				/* ADC */
				spidev at 1 {
					compatible = "spidev";
					reg = <1>;
					spi-max-frequency = <1000000>;
				};
				/* IO expander for busaddr */
				spidev at 2 {
					compatible = "spidev";
					reg = <2>;
					label = "busaddr";
					spi-max-frequency = <10000000>;
				};
				/* audio codec */
				codec: codec at 3 {
					compatible = "ti,tlv320aic3x";
					spi-max-frequency = <1000000>;
					reg = <3>;
				};
			};

This does not work without patch, because of 2 chips selected at one time because of PA14 is periph_a. Probably ROMBOOT 
changes that.
>
>>> If you just want to use it as a chip select for an spi device, take a
>>> look at [1].
>> At [1] it's OK until as cs0 is for example PA22 and cs1 is PA14.
>
> If you want PA14 to control cs1 and PA22 to control cs0 (both
> configured as GPIOs), you'll have the following definition:
>
> cs-gpios = <&pioA 22 0>, <&pioA 14 0>, <0>, <0>;
See my node.
>
>>>
>>> Here the gpio is requested by the spi core when defining the cs-gpios
>>> property. The gpio controller then request the listed pins to the pin
>>> controller (pinctrl driver).
>> GPIO is not set in driver as GPIO, at least I didn't find it.
>
> Take a look at [1], which is set as the gpio_request_enable callback,
> called by pinctrl core when a gpio is requested.
But is this called from spi driver when requesting gpios as cs?
>
>
> [1]http://lxr.free-electrons.com/source/drivers/pinctrl/pinctrl-at91.c#L665
>
>
