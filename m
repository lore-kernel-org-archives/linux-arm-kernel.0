From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 20 Dec 2017 10:19:51 +0100
Subject: [PATCH V2 9/9] ARM: dts: stm32: add initial support of
 stm32mp157c eval board
In-Reply-To: <CACRpkdZaEjdGB2k6HdPt1_E0jRXEimEUxT9NmMwMw7OiyeqGLA@mail.gmail.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
 <1513610272-7824-10-git-send-email-ludovic.Barre@st.com>
 <CACRpkdZaEjdGB2k6HdPt1_E0jRXEimEUxT9NmMwMw7OiyeqGLA@mail.gmail.com>
Message-ID: <27a339f7-33a7-eb73-27fe-9927838729d6@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On 12/20/2017 08:44 AM, Linus Walleij wrote:
> On Mon, Dec 18, 2017 at 4:17 PM, Ludovic Barre <ludovic.Barre@st.com> wrote:
> 
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> Add support of stm32mp157c evaluation board (part number: STM32MP157C-EV1)
>> split in 2 elements:
>> -Daughter board (part number: STM32MP157C-ED1)
>>   which includes CPU, memory and power supply
>> -Mother board (part number: STM32MP157C-EM1)
>>   which includes external peripherals (like display, camera,...)
>>   and extension connectors.
>>
>> The daughter board can run alone, this is why the device tree files
>> are split in two layers, for the complete evaluation board (ev1)
>> and for the daughter board alone (ed1).
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> (...)
>> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> 
> Evaluation boards are important because they set a pattern that customers
> will use.
> 
> Please consider to include nodes for all GPIO blocks used in this
> evaluation board, and add:
> 
> gpio-line-names = "foo", "bar" ...;
> 
> See for example
> arch/arm/boot/dts/bcm2835-rpi-a.dts
> arch/arm/boot/dts/ste-snowball.dts
> 
> It's good to have because probably you guys have proper schematics and
> know rail names of the stuff connected to those GPIO lines and so on,
> so you can give the lines proper names.

It looks like useful for pins used as gpio line. Are you saying that we 
also have to describe pins used as Alternate Function ? Currently for 
stm32 MCU we add (for each pins in a group) a comment in 
stm32xxx-pinctrl.dtsi file to describe the pinmux (to help developers). 
On driver side for each stm32 pinctrl driver (ex: 
drivers/pinctrl/stm32/pinctrl-stm32f429.c) we add for each possible 
muxing a name:


	STM32_PIN(
		PINCTRL_PIN(0, "PA0"),
		STM32_FUNCTION(0, "GPIOA0"),
		STM32_FUNCTION(2, "TIM2_CH1 TIM2_ETR"),
		STM32_FUNCTION(3, "TIM5_CH1"),
		STM32_FUNCTION(4, "TIM8_ETR"),
		STM32_FUNCTION(8, "USART2_CTS"),
		STM32_FUNCTION(9, "UART4_TX"),
		STM32_FUNCTION(12, "ETH_MII_CRS"),
		STM32_FUNCTION(16, "EVENTOUT"),
		STM32_FUNCTION(17, "ANALOG")
	),

To be honest, currently there is a an issue to printout the name :) but 
I have a patch to send for that.


regards
Alex


> 
> It will be helpful for people using the reference design, especially with the
> new character device, and also sets a pattern for people doing devices
> based on the reference design and we really want to do that.
> 
> Yours,
> Linus Walleij
> 
