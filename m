From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 12 Sep 2014 09:59:10 +0000
Subject: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <20140911111202.GA4958@pengutronix.de>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
 <62651744.c71MLsL3Q5@wuerfel>
 <cd69af536cd248b8add94a468fa97095@BL2PR03MB467.namprd03.prod.outlook.com>
 <2944183.HzFlEzpKtu@wuerfel> <20140911111202.GA4958@pengutronix.de>
Message-ID: <de5dbb877d09447498c8c3cabce67f7e@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
>Sent: Thursday, September 11, 2014 7:12 PM
>To: Arnd Bergmann
>Cc: Lu Jingchang-B35083; linux-arm-kernel at lists.infradead.org; Guo Shawn-
>R65073; devicetree at vger.kernel.org; Zhao Chenhui-B35336; Fu Chao-B44548;
>Leekha Shaveta-B20052; Gupta Suresh-B42813; Sharma Bhupesh-B45370; Xiubo
>Li-B47053; Gupta Ruchika-R66431; Badola Nikhil-B46172
>Subject: Re: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
>LS1021A
>
>On Thu, Sep 11, 2014 at 12:36:50PM +0200, Arnd Bergmann wrote:
>> On Thursday 11 September 2014 08:21:58 Jingchang Lu wrote:
>> > >One more thing: these should all go into the board specific files.
>> > >
>> > >The installed memory is almost always a property of the board, not
>> > >the SoC, and a lot of boards only connect a subset of the serial
>> > >ports, or they may have them in a different order.
>> > >
>> > >In particular, you only provide aliases for the six out of the ten
>> > >available uarts, which seems arbitrary.
>> > >
>> >
>> > The memory size info will be fixed up in u-boot before booting the
>> > kernel image, so I add the memory node in the SoC level device tree
>and keep only one copy.
>>
>> Right. I wonder if it would make sense to just leave a placeholder in
>> there that does not look like a plausible memory size.
>
>The placeholder is already in skeleton.dtsi, no need to add it at SoC
>level.
Thanks, I will remove the node in the SoC dtsi and use just that in
the skeleton64.dtsi instead.

>
>> I believe the common case today
>> is that we actually want to have the correct memory size in the
>> board-level dts file because the boot loader does not change that
>> value. If your boot loader does it, we probably don't want any default
>> that may confuse users at all, in particular in the per-soc file.
>>
>> > The lpuart derives the line number from the node's alias id, 8250
>> > serial driver doesn't rely on it, so only aliases for the lpuart are
>added, not arbitrary.
>>
>> This is really bad though, for two reasons:
>>
>> a) you are relying on current behavior of two kernel drivers that we
>> may want to change in the future. Unfortunately the two drivers don't
>> do this consistently today, but that's something we should fix in the
>> kernel, not work around in the hardware description.
>>
>> b) for the lpuart case, you put a fixed device order in the
>> soc-specific file, without any guarantee that the board uses just the
>> first x devices rather than another random subset. The alias values
>> are really meant to to correspond to how the machine calls things, not
>how the SoC sees it.
>
>All i.MX SoCs have the aliases defined how the SoC sees the devices and
>i.MX is not alone here.
>
>I know that some people rather like to see the aliases correspond to the
>numbers printed on the case or PCB, thus dropping the aliases from the SoC
>dtsi and putting them into the board dts instead.
>
>I think both the UART number from the datasheet and the number printed on
>the case are valuable informations, we should come up with a way to
>express both informations instead of argueing about the meaning of the
>'serialx' alias. This shouldn't even be too hard, we could create multiple
>aliases for the same device and let udev create links for all of them.
>
>Sascha

Then I will keep the only alias for the lpuart to make them working well currently.
Thanks.

Best Regards,
Jingchang
