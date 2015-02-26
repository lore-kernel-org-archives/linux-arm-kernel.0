From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 26 Feb 2015 01:30:58 +0100
Subject: [PATCH 2/4] ARM: mvebu: add audio I2S controller to Armada 38x
 Device Tree
In-Reply-To: <CAPv3WKf8b+fuB-4qVwKC57iKaNHTLZAf9VFpfDbow1Sb3YAsNw@mail.gmail.com>
References: <1424901482-3809-1-git-send-email-mw@semihalf.com>
 <1424901482-3809-3-git-send-email-mw@semihalf.com>
 <54EE4AD6.6090101@gmail.com>
 <CAPv3WKf8b+fuB-4qVwKC57iKaNHTLZAf9VFpfDbow1Sb3YAsNw@mail.gmail.com>
Message-ID: <54EE6942.9080800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.02.2015 01:11, Marcin Wojtas wrote:
> 2015-02-25 23:21 GMT+01:00 Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com>:
>> On 25.02.2015 22:58, Marcin Wojtas wrote:
[...]
>> sorry but NACK. The PLL and SoC ctrl are not even close to the audio
>> controller registers.
>>
>>> +                               interrupts = <GIC_SPI 75
>>> IRQ_TYPE_LEVEL_HIGH>;
>>> +                               clocks = <&gateclk 0>;
>>> +                               clock-names = "internal";
>>
>>
>> How about providing access to audio PLL by a clock driver and amend the
>> binding to allow for a second more precise PLL clock, e.g.
>>
>>          clocks = <&gateclk CLK_AUDIO>, <&pll PLL_AUDIO>;
>>          clock-names = "internal", "pll";
>>
>
> Good idea. Would you suggest some name for the new driver? How about
> clk-audio.c under drivers/clk/mvebu?

Depends on how much you know about the surrounding registers.

If there is more clock related stuff than the audio pll, I'd
suggest to have a single driver for everything that isn't core clk
or clk gates which are already dealt with in the existing driver.

Given that this PLL layout is most likely 38x specific, I'd just put it
into drivers/clk/mvebu/armada-38x.c.

>> we already check for an "extclk" on Dove for the same reason but the
>> name might be misleading here.
>>
>> Also, i2c/spdif muxing option could be handled by 38x's pinctrl driver,
>> we have the same for Dove's internal i2c mux.
>>
>> If you want to use i2s you just add the option to the default pinctrl
>> hog:
>>
>>          pinctrl-0 = <&i2s_pins &audio_mux_i2s>;
>>          pinctrl-names = "default";
>>
>
> Ok, I'll try to extend pinctrl-armada-38x then.

IMHO, adding a "syscon" compatible to the system-controller node should
do the trick. You can reference the regmap from 38x's pinctrl driver and
have a specific callback for the i2s/spdif muxing. The reg property
range of the system-controller should be extended but that definitely
depends on what the you or the Free Electron guys know about the
register set.

Sebastian
