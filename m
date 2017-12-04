From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 4 Dec 2017 09:52:34 +0100
Subject: [PATCH v5.1 1/2] ARM64: dts: meson-gx: use stable UART bindings
 with correct gate clock
In-Reply-To: <61a59a32-a812-cc88-79f9-02c13f1901d7@suse.de>
References: <1498056132-18508-1-git-send-email-narmstrong@baylibre.com>
 <1498056132-18508-2-git-send-email-narmstrong@baylibre.com>
 <4e0d1db1-6382-a4b7-d112-3e45e0c1af2d@suse.de>
 <61a59a32-a812-cc88-79f9-02c13f1901d7@suse.de>
Message-ID: <5c689c0f-1861-d65f-0aa4-5d751ad90611@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2017 01:16, Andreas F?rber wrote:
> Am 03.12.2017 um 15:15 schrieb Andreas F?rber:
>> Hi,
>>
>> Am 21.06.2017 um 16:42 schrieb Neil Armstrong:
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>>> index 17d3efd..ea53cc2 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>>> @@ -682,6 +682,31 @@
>>>  	clocks = <&clkc CLKID_SPI>;
>>>  };
>>>  
>>> +&uart_A {
>>> +	clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
>>> +	clock-names = "xtal", "pclk", "baud";
>>> +};
>>> +
>>> +&uart_AO {
>>> +	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
>>> +	clock-names = "xtal", "pclk", "baud";
>>> +};
>>> +
>>> +&uart_AO_B {
>>> +	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
>>> +	clock-names = "xtal", "pclk", "baud";
>>> +};
>>> +
>>> +&uart_B {
>>> +	clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
>>> +	clock-names = "xtal", "core", "baud";
>>
>> Looking at the meson_uart driver, it only looks for a "pclk" clock,
>> never for "core", and the only unnamed clock used should be the first.
>>
>> There is no bindings documentation for "core", so I assume this was an
>> oversight and should be "pclk" everywhere?
>>
>>> +};
>>> +
>>> +&uart_C {
>>> +	clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
>>> +	clock-names = "xtal", "core", "baud";
>>> +};
>>
>> The issue I'm facing is that uart_C on NanoPi K2 is not working in
>> 4.14.1. To my surprise it appears to be probing okay though.
> 
> In 4.14 the serial driver checks for the legacy compatible and if
> present (even alongside the new compatible) always takes the legacy code
> path, using only the first clock, thus not tripping over "core" and not
> enabling the "pclk" if supplied.

I only used UART_A, this explains a lot.

> 
> This was changed for v4.15-rc1, so we should start seeing errors for
> missing "pclk" clocks.
> 
>> Sadly just overwriting the clock-names property via overlay does not fix
>> my issue. Any ideas?

You need to rebind the devices.

> 
> For reference here's my latest overlay, overriding compatible, too:
> https://github.com/afaerber/dt-overlays/blob/master/meson-gxbb-nanopi-k2%2Barpi600%2Bnucleo-lrwan1.dts
> 
> Regards,
> Andreas
> 

Wow I must have been very tired when pushing this....

Thanks for spotting this.

I'll send a fix asap.

Neil
