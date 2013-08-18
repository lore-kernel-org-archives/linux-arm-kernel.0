From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 19 Aug 2013 01:11:37 +0200
Subject: [RFC v1 4/5] ARM: mvebu: add Armada 1500 and Sony NSZ-GS7 device
 tree files
In-Reply-To: <201308172128.35245.arnd@arndb.de>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376682098-10580-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308172128.35245.arnd@arndb.de>
Message-ID: <521154A9.3000505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2013 09:28 PM, Arnd Bergmann wrote:
> On Friday 16 August 2013, Sebastian Hesselbarth wrote:
>> +               cpu at 0 {
>> +                       compatible = "marvell,sheeva-v7";
>> +                       device_type = "cpu";
>> +                       next-level-cache = <&l2>;
>> +                       reg = <0>;
>> +               };
> ...
>> +               l2: l2-cache-controller at 1ac0000 {
>> +                       compatible = "marvell,aurora-outer-cache";
>> +                       reg = <0x1ac0000 0x1000>;
>> +                       cache-level = <2>;
>> +               };
>> +
>> +               gic: interrupt-controller at 1ad0000 {
>> +                       compatible = "arm,cortex-a9-gic";
>> +                       reg = <0x1ad1000 0x1000
>> +                              0x1ad0100 0x0100>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <3>;
>> +               };
>> +
>> +               local-timer at 1ad0600 {
>> +                       compatible = "arm,cortex-a9-twd-timer";
>> +                       reg = <0x1ad0600 0x20>;
>> +                       interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&cpu0clk>;
>> +               };
>
> This seems like a strange combination. I would have expected either PJ4+Aurora+apbtimer
> or A9+pl310+localtimer, based on what I found in the chromecast kernel source.
> Do you have more information here about what is used on the two variants?

I have no clue, what combination it really is. Unfortunately,
Marvell didn't release any open datasheets, of course.

I can only look at GPL'd Asus Cube kernel, I used for getting an idea
of what was required for initial support and reg offsets, irqs and
friends. They bring up twd as localtimer. Also, grep'ing the Cube
kernel sources in mach-mv88de3100 gives hits for CONFIG_PJ4 (note the
missing B), l2x0, smp_twd, apb_timer.

No hits for pl310, A9.

Sebastian
