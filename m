From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 21:43:59 +0200
Subject: [PATCH 1/2 v2] spi: s3c64xx: use "cs-gpios" from spi node instead
 of "cs-gpio"
In-Reply-To: <CAD=FV=XtdgKEg7fTHe+tsFM1Y_YwqNNk_DBW7ZX83YERGJsHBg@mail.gmail.com>
References: <1402394881-31564-1-git-send-email-ch.naveen@samsung.com>	<1402394881-31564-2-git-send-email-ch.naveen@samsung.com>	<5396E051.8050803@samsung.com>	<CAHfPSqAq9L5Zu7z3-y6Y2pG8AhE4Y1j8DE35LDfMW_DYc_x-gw@mail.gmail.com>
 <CAD=FV=XtdgKEg7fTHe+tsFM1Y_YwqNNk_DBW7ZX83YERGJsHBg@mail.gmail.com>
Message-ID: <53975FFF.7010209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.06.2014 20:09, Doug Anderson wrote:
> Naveen / Sylwester,
> 
> On Tue, Jun 10, 2014 at 4:00 AM, Naveen Krishna Ch
> <naveenkrishna.ch@gmail.com> wrote:
>>> Can we support both "cs-gpio" and "cs-gpios" for backward compatibility ?
>>> After your change all DTBs using the original pattern will not work with
>>> new kernels any more. At least I would expect such backward compatibility
>>> maintained for few kernel releases.
>>
>> The reason behind removing the "cs-gpio" or not providing backward
>> compatibility was
>>
>> 1. Since spi-core started using "cs-gpios" string from spi device node
>> several months ago.
>>   The spi-s3c64xx.c driver is partially broken for more than 6 months.
>>
>> 2. Supporting "cs-gpio" would add extra bit of code.
>>
>> I've corrected the dts files that were using "cs-gpio" under
>> "controller-data"(child node)
>> to use "cs-gpio" from spi device node (parent node).
>>
>> I will make another version if you insist.
> 
> Yup, as near as I can tell this has been broken since (3146bee spi:
> s3c64xx: Added provision for dedicated cs pin).  That landed June 25th
> of 2013 into the SPI tree.
> 
> ...so clearly nobody was really testing Samsung's SPI driver on ToT
> Linux.  1 year of unnoticed brokenness seems like enough time that we
> could do away with the old code.  If someone comes out of the woodwork
> and claims a dire need to support the old binding then it can be added
> then.
> 
> In-tree users of this appear to be:
> 
> arch/arm/boot/dts/exynos4210-smdkv310.dts:
>  cs-gpio = <&gpc1 2 0>;
> arch/arm/boot/dts/exynos4412-trats2.dts:
>  cs-gpio = <&gpb 5 0>;
> arch/arm/boot/dts/exynos5250-smdk5250.dts:
>  cs-gpio = <&gpa2 5 0>;
> 
> ...and I guess nobody has bothered using the SPI flash on those boards
> for the last year?

On Trats2, it's actually a camera sensor, not SPI flash...

Still, that's really a shame that:

a) such patch went in (i.e. its brokenness was not spotted in review),
b) the regression was not spotted.

Anyway, IMHO this justifies removing the old binding then.

Best regards,
Tomasz
