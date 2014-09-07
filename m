From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 07 Sep 2014 18:19:03 +0200
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <540C83DE.10505@collabora.co.uk>
References: <20140905115704.GO13515@arm.com>	<20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <540C83DE.10505@collabora.co.uk>
Message-ID: <540C8577.2070907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.09.2014 18:12, Javier Martinez Canillas wrote:
> Hello Tomasz,
> 
> On 09/07/2014 05:52 PM, Tomasz Figa wrote:
>>
>> So I believe we've got a process issue here. If you don't have normal
>> support for display hardware, but you want to keep the display
>> operational thanks to bootloader already initializing it, you should not
>> add anything to the kernel which breaks it, until full support comes in.
>>
>> This means that respective regulators should be either always-on or not
>> listed at all (I'd favor the former)
> 
> So that means that do you think that the workaround patch I shared on the
> previous email could be considered as a correct solution? In that case I can
> post it as a proper patch.

Right.

> 
>> somehow enabled at boot-up or completely ignored, including all their
>> parents capable of being gated.
>>
> 
> AFAIU from the thread I mentioned before, Nvidia folks proposed the same to
> fix the simplefb issue on sunxi, to avoid the clocks in question being turned
> off at boot by modifying the sunxi clock driver.

OK.

> 
>> Now with regulators this is pretty straightforward, but with clocks I
>> believe it's an open issue. AFAIR we've discussed this on MLs some time
>> ago (at least I remember Doug commenting on that topic) and kind of
>> concluded that SoC clock drivers could include lists of clocks to be
>> enabled at boot-up (as a HACK to enable things like simplefb until
>> proper support for respective features are added).
>>
>> I believe this would be the proper solution for $subject.
>>
> 
> Clocks is not an issue at least on this machine since the bootloader already
> passes the clk_ignore_unused parameter to the kernel command line so in that
> sense there isn't a regression comparing with older kernels. If possible I
> would prefer to leave this way instead of adding quirks to the clock driver,
> specially since there are proposed patches to have the display working using
> the Exynos DRM driver on this machine.

Well, clk_ignore_unused seems a bit too coarse grained to me. Also
forcing the user to add it in his bootloader (or any other way) is not
really the best practice IMHO.

At least for next 3.17-rc I'd suggest fixing this up in respective clock
driver and dropping the hack only after Exynos DRM patches are merged
and confirmed working.

Best regards,
Tomasz
