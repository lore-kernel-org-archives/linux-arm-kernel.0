From: robherring2@gmail.com (Rob Herring)
Date: Tue, 22 May 2012 09:04:55 -0500
Subject: [PATCH v2 2/2] clk: add highbank clock support
In-Reply-To: <4FBB6053.9030908@codethink.co.uk>
References: <1337220137-31666-1-git-send-email-robherring2@gmail.com>
 <1337220137-31666-3-git-send-email-robherring2@gmail.com>
 <4FBB6053.9030908@codethink.co.uk>
Message-ID: <4FBB9D07.4080604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2012 04:45 AM, Ben Dooks wrote:
> On 17/05/12 03:02, Rob Herring wrote:
>> From: Rob Herring<rob.herring@calxeda.com>
>>
>> This adds real clock support to Calxeda Highbank SOC using the common
>> clock infrastructure.
>>
>> Signed-off-by: Rob Herring<rob.herring@calxeda.com>
> 
>> diff --git a/arch/arm/boot/dts/highbank.dts
>> b/arch/arm/boot/dts/highbank.dts
>> index 83e7229..2e1cfa0 100644
>> --- a/arch/arm/boot/dts/highbank.dts
>> +++ b/arch/arm/boot/dts/highbank.dts
>> @@ -1,5 +1,5 @@
>>   /*
>> - * Copyright 2011 Calxeda, Inc.
>> + * Copyright 2011-2012 Calxeda, Inc.
>>    *
>>    * This program is free software; you can redistribute it and/or
>> modify it
>>    * under the terms and conditions of the GNU General Public License,
>> @@ -24,6 +24,7 @@
>>       compatible = "calxeda,highbank";
>>       #address-cells =<1>;
>>       #size-cells =<1>;
>> +    clock-ranges;
>>
>>       cpus {
>>           #address-cells =<1>;
>> @@ -33,24 +34,32 @@
>>               compatible = "arm,cortex-a9";
>>               reg =<0>;
>>               next-level-cache =<&L2>;
>> +            clocks =<&a9pll>;
>> +            clock-names = "cpu";
>>           };
>>
>>           cpu at 1 {
>>               compatible = "arm,cortex-a9";
>>               reg =<1>;
>>               next-level-cache =<&L2>;
>> +            clocks =<&a9pll>;
>> +            clock-names = "cpu";
>>           };
>>
>>           cpu at 2 {
>>               compatible = "arm,cortex-a9";
>>               reg =<2>;
>>               next-level-cache =<&L2>;
>> +            clocks =<&a9pll>;
>> +            clock-names = "cpu";
>>           };
>>
>>           cpu at 3 {
>>               compatible = "arm,cortex-a9";
>>               reg =<3>;
>>               next-level-cache =<&L2>;
>> +            clocks =<&a9pll>;
>> +            clock-names = "cpu";
>>           };
>>       };
>>
>> @@ -75,12 +84,14 @@
>>               compatible = "arm,cortex-a9-twd-timer";
>>               reg =<0xfff10600 0x20>;
>>               interrupts =<1 13 0xf01>;
>> +            clocks =<&a9periphclk>;
>>           };
>>
>>           watchdog at fff10620 {
>>               compatible = "arm,cortex-a9-twd-wdt";
>>               reg =<0xfff10620 0x20>;
>>               interrupts =<1 14 0xf01>;
>> +            clocks =<&a9periphclk>;
>>           };
>>
>>           intc: interrupt-controller at fff11000 {
>> @@ -116,12 +127,15 @@
>>               compatible = "calxeda,hb-sdhci";
>>               reg =<0xffe0e000 0x1000>;
>>               interrupts =<0 90 4>;
>> +            clocks =<&eclk>;
>>           };
>>
>>           ipc at fff20000 {
>>               compatible = "arm,pl320", "arm,primecell";
>>               reg =<0xfff20000 0x1000>;
>>               interrupts =<0 7 4>;
>> +            clocks =<&pclk>;
>> +            clock-names = "apb_pclk";
>>           };
>>
>>           gpioe: gpio at fff30000 {
>> @@ -130,6 +144,8 @@
>>               gpio-controller;
>>               reg =<0xfff30000 0x1000>;
>>               interrupts =<0 14 4>;
>> +            clocks =<&pclk>;
>> +            clock-names = "apb_pclk";
>>           };
>>
>>           gpiof: gpio at fff31000 {
>> @@ -138,6 +154,8 @@
>>               gpio-controller;
>>               reg =<0xfff31000 0x1000>;
>>               interrupts =<0 15 4>;
>> +            clocks =<&pclk>;
>> +            clock-names = "apb_pclk";
>>           };
>>
>>           gpiog: gpio at fff32000 {
>> @@ -146,6 +164,8 @@
>>               gpio-controller;
>>               reg =<0xfff32000 0x1000>;
>>               interrupts =<0 16 4>;
>> +            clocks =<&pclk>;
>> +            clock-names = "apb_pclk";
>>           };
>>
>>           gpioh: gpio at fff33000 {
>> @@ -154,24 +174,32 @@
>>               gpio-controller;
>>               reg =<0xfff33000 0x1000>;
>>               interrupts =<0 17 4>;
>> +            clocks =<&pclk>;
>> +            clock-names = "apb_pclk";
>>           };
>>
>>           timer {
>>               compatible = "arm,sp804", "arm,primecell";
>>               reg =<0xfff34000 0x1000>;
>>               interrupts =<0 18 4>;
>> +            clocks =<&pclk>;
>> +            clock-names = "apb_pclk";
>>           };
>>
>>           rtc at fff35000 {
>>               compatible = "arm,pl031", "arm,primecell";
>>               reg =<0xfff35000 0x1000>;
>>               interrupts =<0 19 4>;
>> +            clocks =<&pclk>;
>> +            clock-names = "apb_pclk";
>>           };
>>
>>           serial at fff36000 {
>>               compatible = "arm,pl011", "arm,primecell";
>>               reg =<0xfff36000 0x1000>;
>>               interrupts =<0 20 4>;
>> +            clocks =<&pclk>;
>> +            clock-names = "apb_pclk";
>>           };
>>
>>           smic at fff3a000 {
>> @@ -186,12 +214,73 @@
>>           sregs at fff3c000 {
>>               compatible = "calxeda,hb-sregs";
>>               reg =<0xfff3c000 0x1000>;
>> +
>> +            clocks {
>> +                #address-cells =<1>;
>> +                #size-cells =<0>;
>> +
>> +                osc: oscillator {
>> +                    #clock-cells =<0>;
>> +                    compatible = "fixed-clock";
>> +                    clock-frequency =<33333000>;
>> +                };
>> +
>> +                ddrpll: ddrpll {
>> +                    #clock-cells =<0>;
>> +                    compatible = "calxeda,hb-pll-clock";
>> +                    clocks =<&osc>;
>> +                    reg =<0x108>;
>> +                };
>> +
>> +                a9pll: a9pll {
>> +                    #clock-cells =<0>;
>> +                    compatible = "calxeda,hb-pll-clock";
>> +                    clocks =<&osc>;
>> +                    reg =<0x100>;
>> +                };
>> +
>> +                a9periphclk: a9periphclk {
>> +                    #clock-cells =<0>;
>> +                    compatible = "calxeda,hb-a9periph-clock";
>> +                    clocks =<&a9pll>;
>> +                    reg =<0x104>;
>> +                };
>> +
>> +                a9bclk: a9bclk {
>> +                    #clock-cells =<0>;
>> +                    compatible = "calxeda,hb-a9bus-clock";
>> +                    clocks =<&a9pll>;
>> +                    reg =<0x104>;
>> +                };
>> +
>> +                emmcpll: emmcpll {
>> +                    #clock-cells =<0>;
>> +                    compatible = "calxeda,hb-pll-clock";
>> +                    clocks =<&osc>;
>> +                    reg =<0x10C>;
>> +                };
>> +
>> +                eclk: eclk {
>> +                    #clock-cells =<0>;
>> +                    compatible = "calxeda,hb-emmc-clock";
>> +                    clocks =<&emmcpll>;
>> +                    reg =<0x114>;
>> +                };
>> +
>> +                pclk: pclk {
>> +                    #clock-cells =<0>;
>> +                    compatible = "fixed-clock";
>> +                    clock-frequency =<150000000>;
>> +                };
>> +            };
>>           };
>>
>>           dma at fff3d000 {
>>               compatible = "arm,pl330", "arm,primecell";
>>               reg =<0xfff3d000 0x1000>;
>>               interrupts =<0 92 4>;
>> +            clocks =<&pclk>;
>> +            clock-names = "apb_pclk";
>>           };
>>
>>           ethernet at fff50000 {
>> diff --git a/arch/arm/mach-highbank/Makefile
>> b/arch/arm/mach-highbank/Makefile
>> index f8437dd..6ca6afa 100644
> 
> I don't think the right solution is to push this stuff into the
> device-tree like this. It is only going to end up with this
> information being replicated through every machine with clock
> support.

Most SOCs are splitting board specific and SOC specific parts of the DTS
files so there should be little duplication.

For SOCs with hundreds of internal clocks, it probably does not make
sense to put every single clock into the DT. In that case you would only
define the oscillator inputs, a clock controller with lots of outputs,
and the clock connections to each device.

Rob
