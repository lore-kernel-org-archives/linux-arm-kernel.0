From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 07 Sep 2014 17:52:59 +0200
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <540C202E.2060009@collabora.co.uk>
References: <20140905115704.GO13515@arm.com>	<20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk>
Message-ID: <540C7F5B.6070307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> Have you seen the very long "[PATCH 4/4] simplefb: add clock handling
>>> code" thread [0]?. I wonder if the problem is that the display clocks were
>>> not known to the kernel before 3.15 but now are getting disabled and thus
>>> the simplefb driver not working?
>>>
>>> So probably is worth to try passing clk_ignore_unused as a parameter to
>>> the kernel command line.
>>>
>>> [0]: https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg06623.html
>>
> 
> So my assumptions was correct and the issue is that the kernel disables the
> resources (clocks and regulators) needed to have display working and because
> the simplefb expects the display hardware to have been already initialized by
> the bootloader/firmware, it simply fails.
> 
> You didn't face this issue before 3.15 because the default bootargs set by
> nv_uboot-snow already includes the "clk_ignore_unused" parameter and the
> kernel didn't know about the regulators but the later changed with commit:
> 
> b16be76 ("ARM: dts: add tps65090 power regulator for exynos5250-snow")
> 
> This was included in 3.16, so the mentioned commit is what "broke" your
> workflow since now the kernel is aware of the tps65090 fet1 and fet6
> regulators (used as supply for the the backlight and panel respectively) and
> disables them because nothing uses them from a kernel POV.

So I believe we've got a process issue here. If you don't have normal
support for display hardware, but you want to keep the display
operational thanks to bootloader already initializing it, you should not
add anything to the kernel which breaks it, until full support comes in.

This means that respective regulators should be either always-on or not
listed at all (I'd favor the former) and respective clocks either
somehow enabled at boot-up or completely ignored, including all their
parents capable of being gated.

Now with regulators this is pretty straightforward, but with clocks I
believe it's an open issue. AFAIR we've discussed this on MLs some time
ago (at least I remember Doug commenting on that topic) and kind of
concluded that SoC clock drivers could include lists of clocks to be
enabled at boot-up (as a HACK to enable things like simplefb until
proper support for respective features are added).

I believe this would be the proper solution for $subject.

Best regards,
Tomasz
