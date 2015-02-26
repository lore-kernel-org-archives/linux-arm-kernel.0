From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 26 Feb 2015 01:11:44 +0100
Subject: [PATCH 2/4] ARM: mvebu: add audio I2S controller to Armada 38x
 Device Tree
In-Reply-To: <54EE4AD6.6090101@gmail.com>
References: <1424901482-3809-1-git-send-email-mw@semihalf.com>
 <1424901482-3809-3-git-send-email-mw@semihalf.com>
 <54EE4AD6.6090101@gmail.com>
Message-ID: <CAPv3WKf8b+fuB-4qVwKC57iKaNHTLZAf9VFpfDbow1Sb3YAsNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

Thanks for your input.

2015-02-25 23:21 GMT+01:00 Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com>:
> On 25.02.2015 22:58, Marcin Wojtas wrote:
>>
>> This commit adds the description of the I2S controller to the Marvell
>> Armada 38x SoC's Device Tree, as well as its pin configuration.
>>
>> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>> ---
>>   arch/arm/boot/dts/armada-38x.dtsi | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/armada-38x.dtsi
>> b/arch/arm/boot/dts/armada-38x.dtsi
>> index 1dff30a..fa21cb5 100644
>> --- a/arch/arm/boot/dts/armada-38x.dtsi
>> +++ b/arch/arm/boot/dts/armada-38x.dtsi
>
> [...]
>>
>> @@ -555,6 +561,17 @@
>>                                 status = "disabled";
>>                         };
>>
>> +                       audio_controller: audio-controller at e8000 {
>> +                               #sound-dai-cells = <1>;
>> +                               compatible = "marvell,armada-380-audio";
>> +                               reg = <0xe8000 0x4000>, <0x18410 0xc>,
>> <0x18204 0x4>;
>> +                               reg-names = "i2s_regs", "pll_regs",
>> "soc_ctrl";
>
>
> Marcin,
>
> sorry but NACK. The PLL and SoC ctrl are not even close to the audio
> controller registers.
>
>> +                               interrupts = <GIC_SPI 75
>> IRQ_TYPE_LEVEL_HIGH>;
>> +                               clocks = <&gateclk 0>;
>> +                               clock-names = "internal";
>
>
> How about providing access to audio PLL by a clock driver and amend the
> binding to allow for a second more precise PLL clock, e.g.
>
>         clocks = <&gateclk CLK_AUDIO>, <&pll PLL_AUDIO>;
>         clock-names = "internal", "pll";
>

Good idea. Would you suggest some name for the new driver? How about
clk-audio.c under drivers/clk/mvebu?

> we already check for an "extclk" on Dove for the same reason but the
> name might be misleading here.
>
> Also, i2c/spdif muxing option could be handled by 38x's pinctrl driver,
> we have the same for Dove's internal i2c mux.
>
> If you want to use i2s you just add the option to the default pinctrl
> hog:
>
>         pinctrl-0 = <&i2s_pins &audio_mux_i2s>;
>         pinctrl-names = "default";
>

Ok, I'll try to extend pinctrl-armada-38x then.

Marcin
