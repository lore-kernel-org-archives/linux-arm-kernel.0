From: aik@ozlabs.ru (Alexey Kardashevskiy)
Date: Wed, 14 Dec 2016 10:49:57 +1100
Subject: [linux-sunxi] Re: [PATCH v3 -next 2/2] ARM: dts: sunxi: add
 support for Orange Pi Zero board
In-Reply-To: <20161207100132.1Qp0ZxGD@smtp3o.mail.yandex.net>
References: <20161207100132.1Qp0ZxGD@smtp3o.mail.yandex.net>
Message-ID: <dc3d5e9e-ac9c-5ad1-7daf-39ed6ff7d84e@ozlabs.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/16 18:01, Icenowy Zheng wrote:
> 
> 2016?12?7? 05:52? Alexey Kardashevskiy <aik@ozlabs.ru>???
>>
>> On 06/12/16 18:43, Icenowy Zheng wrote: 
>>>
>>> 2016?12?6? 09:51? Alexey Kardashevskiy <aik@ozlabs.ru>??? 
>>>>
>>>> On 03/12/16 02:05, Icenowy Zheng wrote: 
>>>>> Orange Pi Zero is a board that came with the new Allwinner H2+ SoC and a 
>>>>> SDIO Wi-Fi chip by Allwinner (XR819). 
>>>>>
>>>>> Add a device tree file for it. 
>>>>>
>>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz> 
>>>>> --- 
>>>>> Changes since v2: 
>>>>> - Merged SDIO Wi-Fi patch into it. 
>>>>> - SDIO Wi-Fi: add a ethernet1 alias to it, as it has no internal NVRAM. 
>>>>> - SDIO Wi-Fi: changed pinctrl binding to generic pinconf 
>>>>> - removed all gpio pinctrl nodes 
>>>>> - changed h2plus to h2-plus 
>>>>> Changes since v1: 
>>>>> - Convert to generic pinconf bindings. 
>>>>> - SDIO Wi-Fi: add patch. 
>>>>>
>>>>> Some notes: 
>>>>> - The uart1 and uart2 is available on the unsoldered gpio header. 
>>>>> - The onboard USB connector has its Vbus directly connected to DCIN-5V (the 
>>>>>     power jack) 
>>>>>
>>>>>    arch/arm/boot/dts/Makefile                        |   1 + 
>>>>>    arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 159 ++++++++++++++++++++++ 
>>>>>    2 files changed, 160 insertions(+) 
>>>>>    create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts 
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile 
>>>>> index 6447abc..59f6e86 100644 
>>>>> --- a/arch/arm/boot/dts/Makefile 
>>>>> +++ b/arch/arm/boot/dts/Makefile 
>>>>> @@ -844,6 +844,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \ 
>>>>>    sun8i-a33-sinlinx-sina33.dtb \ 
>>>>>    sun8i-a83t-allwinner-h8homlet-v2.dtb \ 
>>>>>    sun8i-a83t-cubietruck-plus.dtb \ 
>>>>> + sun8i-h2-plus-orangepi-zero.dtb \ 
>>>>>    sun8i-h3-bananapi-m2-plus.dtb \ 
>>>>>    sun8i-h3-nanopi-neo.dtb \ 
>>>>>    sun8i-h3-orangepi-2.dtb \ 
>>>>> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts 
>>>>> new file mode 100644 
>>>>> index 0000000..d18807f 
>>>>> --- /dev/null 
>>>>> +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts 
>>>>> @@ -0,0 +1,159 @@ 
>>>>> +/* 
>>>>> + * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz> 
>>>>> + * 
>>>>> + * Based on sun8i-h3-orangepi-one.dts, which is: 
>>>>> + *   Copyright (C) 2016 Hans de Goede <hdegoede@redhat.com> 
>>>>> + * 
>>>>> + * This file is dual-licensed: you can use it either under the terms 
>>>>> + * of the GPL or the X11 license, at your option. Note that this dual 
>>>>> + * licensing only applies to this file, and not this project as a 
>>>>> + * whole. 
>>>>> + * 
>>>>> + *  a) This file is free software; you can redistribute it and/or 
>>>>> + *     modify it under the terms of the GNU General Public License as 
>>>>> + *     published by the Free Software Foundation; either version 2 of the 
>>>>> + *     License, or (at your option) any later version. 
>>>>> + * 
>>>>> + *     This file is distributed in the hope that it will be useful, 
>>>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of 
>>>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
>>>>> + *     GNU General Public License for more details. 
>>>>> + * 
>>>>> + * Or, alternatively, 
>>>>> + * 
>>>>> + *  b) Permission is hereby granted, free of charge, to any person 
>>>>> + *     obtaining a copy of this software and associated documentation 
>>>>> + *     files (the "Software"), to deal in the Software without 
>>>>> + *     restriction, including without limitation the rights to use, 
>>>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or 
>>>>> + *     sell copies of the Software, and to permit persons to whom the 
>>>>> + *     Software is furnished to do so, subject to the following 
>>>>> + *     conditions: 
>>>>> + * 
>>>>> + *     The above copyright notice and this permission notice shall be 
>>>>> + *     included in all copies or substantial portions of the Software. 
>>>>> + * 
>>>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
>>>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
>>>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
>>>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
>>>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
>>>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
>>>>> + *     OTHER DEALINGS IN THE SOFTWARE. 
>>>>> + */ 
>>>>> + 
>>>>> +/dts-v1/; 
>>>>> +#include "sun8i-h3.dtsi" 
>>>>> +#include "sunxi-common-regulators.dtsi" 
>>>>> + 
>>>>> +#include <dt-bindings/gpio/gpio.h> 
>>>>> +#include <dt-bindings/input/input.h> 
>>>>> +#include <dt-bindings/pinctrl/sun4i-a10.h> 
>>>>> + 
>>>>> +/ { 
>>>>> + model = "Xunlong Orange Pi Zero"; 
>>>>> + compatible = "xunlong,orangepi-zero", "allwinner,sun8i-h2-plus"; 
>>>>> + 
>>>>> + aliases { 
>>>>> + serial0 = &uart0; 
>>>>> + /* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */ 
>>>>
>>>>
>>>> It is not defined there as for: 
>>>>
>>>> cef87e9 (tag: next-20161205) 20 hours ago Stephen Rothwell Add linux-next 
>>>> specific files for 20161205 
>>>
>>> The driver of H3's obfuscated DesignWare MAC is not yet mainlined, so there won't be one ethernet0 now. 
>>>
>>> But it's reserved for the onboard Ethernet. 
>>
>>
>> Could you please elaborate how you tested this patch (ideally some tree 
>> somewhere on github)? This patch added RX819, it assumes EMAC support is 
>> there, neither is there nor there is a way to test this... Thanks. 
> 
> It do not assume EMAC is there. 
> It only assume EMAC will be there someday :-)
> 
> For tree... wait for my push :-)

Has it happened yet? :)



-- 
Alexey
