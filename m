From: stefan@olimex.com (Stefan Mavrodiev)
Date: Fri, 19 Jan 2018 15:27:28 +0200
Subject: [PATCH 1/1] ARM: dts: sunxi: Add Olimex A20-SOM204-EVB board
In-Reply-To: <CAGb2v66U9ziFhU5n6haTA3LGNX7BavmfXiiCmvebtqaMxcN0-w@mail.gmail.com>
References: <1515747666-6597-1-git-send-email-stefan@olimex.com>
 <20180115095031.pzsgrp3tdmemotrs@flea.lan>
 <1b9667a4-75de-4ece-069d-7ec33b7e2f8d@olimex.com>
 <20180118100745.y62adzvfnrzqkagd@flea.lan>
 <CAGb2v66U9ziFhU5n6haTA3LGNX7BavmfXiiCmvebtqaMxcN0-w@mail.gmail.com>
Message-ID: <548d57b7-4db1-a9ee-369e-9067f981162d@olimex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2018 04:28 PM, Chen-Yu Tsai wrote:
> On Thu, Jan 18, 2018 at 6:07 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Hi!
>>
>> On Mon, Jan 15, 2018 at 12:07:34PM +0200, Stefan Mavrodiev wrote:
>>>>> +/dts-v1/;
>>>>> +#include "sun7i-a20.dtsi"
>>>>> +#include "sunxi-common-regulators.dtsi"
>>>>> +
>>>>> +
>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>>>> +#include <dt-bindings/pwm/pwm.h>
>>>>> +
>>>>> +/ {
>>>>> + model = "Olimex A20-SOM204-EVB";
>>>>> + compatible = "olimex,a20-olimex-som204-evb", "allwinner,sun7i-a20";
>>>>> +
>>>>> + aliases {
>>>>> +         serial0 = &uart0;
>>>>> +         serial1 = &uart4;
>>>>> +         serial2 = &uart7;
>>>>> +         spi0 = &spi1;
>>>>> +         spi1 = &spi2;
>>>>> +         ethernet1 = &rtl8723bs;
>>>> ethernet1? if there's a single network interface, it should be
>>>> ethernet0.
>>> I think this will conflict the gmac alias defined in sun7i-a20.dtsi:
>>>
>>> aliases {
>>>      ethernet0 = &gmac;
>>> };
>> We have that? That's bad, but you're right :)
>>
>>>>> +         stat {
>>>>> +                 label = "a20-som204:green:stat";
>>>>> +                 gpios = <&pio 8 0 GPIO_ACTIVE_HIGH>;
>>>>> +                 default-state = "on";
>>>>> +         };
>>>>> +
>>>>> +         led1 {
>>>>> +                 label = "a20-som204-evb:green:led1";
>>>>> +                 gpios = <&pio 8 10 GPIO_ACTIVE_HIGH>;
>>>>> +                 default-state = "on";
>>>>> +         };
>>>>> +
>>>>> +         led2 {
>>>>> +                 label = "a20-som204-evb:yellow:led2";
>>>>> +                 gpios = <&pio 8 11 GPIO_ACTIVE_HIGH>;
>>>>> +                 default-state = "on";
>>>>> +         };
>>>> You don't have the same prefix between stat and led1/led2. I'm fine
>>>> with both, but you should be consistent :)
>>> STAT led is on the SOM204 module, while led1/2 on the EVB. Thats why
>>> they have different prefix.
>> Still, the user and the system will see it as a single board, and the
>> documentation states that it should be the board name. I'm not quite
>> sure what a good rule would be here. Have you looked at how other
>> boards dealt with it? Chen-Yu, any opinion on this?
> Follow the bindings, I guess? I don't think we (sunxi) have dealt
> with modules that have LEDs or anything that needs to be named after
> the board.
>
> On a related topic, I don't know if you (Stefan / Olimex) want to split
> this into a .dtsi file for the SoM, and a .dts file for the EVB. It might
> help your customers?
I'm not sure this will be good ideal. We will have one EVB with all
possible peripheries. On the other hand, we are planning 3-4 different
SOM204 modules (A20, A64, RK....). I think this will make the dtsi 
incompatible.

Maybe if there is one dtsi for the base SOM204 module (one for each 
arch) and
multiple dts for boards with additional features. But this will generate 
10-20
dts files. I think this will be better handled using overlays in the uboot.

About the leds, I'm ok to be named after full board name (a20-som204-evb).
> I've tried it previously, and it helps in some ways
> when you're matching the files to the schematics. But it is confusing
> when you want the big picture. On the other hand, this is not going to
> help with supporting different modules on the same baseboard, as the
> routing, peripherals and labels likely won't match up. Just my two cents.
>
> ChenYu
Regards,
Stefan Mavrodiev
