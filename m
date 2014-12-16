From: stefan@agner.ch (Stefan Agner)
Date: Tue, 16 Dec 2014 23:19:08 +0100
Subject: [PATCH 11/12] ARM: dts: add support for Vybrid running on
 Cortex-M4
In-Reply-To: <2994970.DCfUQgtmcD@wuerfel>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-12-git-send-email-stefan@agner.ch>
 <2994970.DCfUQgtmcD@wuerfel>
Message-ID: <b090cb361e81d2f1be5d21d1a07e9340@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-12-03 12:03, Arnd Bergmann wrote:
> On Wednesday 03 December 2014 01:12:10 Stefan Agner wrote:
>> diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
>> new file mode 100644
>> index 0000000..051ee0f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/vf610m4-colibri.dts
>> @@ -0,0 +1,52 @@
>> +/*
>> + * Device tree for Colibri VF61 Cortex-M4 support
>> + *
>> + * Copyright 2014 Stefan Agner
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +
>> +/dts-v1/;
>> +#include "vf610m4.dtsi"
>> +
>> +/ {
>> +       model = "VF610 Cortex-M4";
>> +       compatible = "fsl,vf610m4";
>> +
>> +       chosen {
>> +               bootargs = "console=ttyLP2,115200 ihash_entries=64 dhash_entries=64 earlyprintk clk_ignore_unused init=/linuxrc rw";
>> +       };
>> +
> 
> Starting with v3.19, you should be able to use the earlycon framework on
> arm32, so it would be better to replace earlyprintk with earlycon here
> and add a stdout-path property in chosen that points to the console
> uart.

Hi Arnd,

Just started looking in that a bit deeper and some question arose:
Afaik, earlycon need to be supported by the uart driver. The fsl_lpuart,
which is used for Vybrid's uart, does not support earlycon yet. However,
earlyprink already works (see ./arch/arm/include/debug/vf.S). I
understand that earlycon has the advantage of being able to be used on
multiplatform. But earlyprintk is working really early (e.g. before
locating the FDT), and it proved helpful for me when I started working
on that Cortex-M4 stuff. Should earlycon replace earlyprintk completely?

Maybe, on Vybrid, since it would be a good platform for automated !MMU
testing, it would be nice to have earlycon which can be enabled in any
case and would provide output even something blows up quite early... But
I guess I would add earlycon support as part of a new patchset and just
drop earlyprintk here for now.

> 64 hash table entries sounds extremely small, doesn't that impact
> performance? If you have 50MB of actual RAM available, I don't think
> you need that.

Agreed. I copied that from EFM32 which is under much more memory
pressure...

--
Stefan
