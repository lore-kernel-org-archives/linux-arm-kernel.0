From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 9 Sep 2013 19:32:00 +0900
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a7791 SoC support
In-Reply-To: <CACRpkdY44c_qzQ6XVjCs86axta-0VBqL8ygH5j+q3z294YXjLA@mail.gmail.com>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034557.12546.97503.sendpatchset@w520>
 <CACRpkdb7QkqCmTMua1yJNJxSAWff=0f6a2SWkf6K9SqbW0BOVg@mail.gmail.com>
 <CANqRtoQzLKk3EKcm=EiZCg73fgDBZ1xjPi_6fH_PsGdkr6w5sA@mail.gmail.com>
 <CACRpkdZGLR3=UZ7f-9r02Gea2hTomp+6+bz0BDQOvk9zRHTxxw@mail.gmail.com>
 <CANqRtoQ0dnG6HwjJSrK8+Qt8wvJhqsJHxgj-LGvnJvS0KT81nw@mail.gmail.com>
 <CACRpkdY44c_qzQ6XVjCs86axta-0VBqL8ygH5j+q3z294YXjLA@mail.gmail.com>
Message-ID: <CANqRtoT9TsDadKX1XgmANGcBhXp8sOgcY=6b7+0nPheKPpHduw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Sep 9, 2013 at 6:15 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Sep 9, 2013 at 10:05 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> At
>> this time though, apart from common clocks, extended DT support and
>> multiplatform I'm not so sure what desired cleanup-wise.
>
> It'd be nice to switch shmobile to use AUTO_ZRELADDR, as it is
> the other criteria (apart from common clock) standing in the way
> for multiplatform. (Maybe this just works if you turn it on?)

This works already for the majority of the boards. My gut feeling is
that it should be the default for multiplatform.

There is one special case when AUTO_ZRELADDR is not working today -
both Laurent and I spent a bit of time trying to figure it out - but
it is currently not moving anywhere due to focus elsewhere. It is
however only triggering on one board - KZM9G - and that board is not
yet supported by neither common clocks nor multiplatform yet anyway,
so it's a problem pretty far away in the future.

> For multiplatform you also have to depopulate <mach/*>
> completely, either move stuff down into the mach-folder
> or to <linux/platform_data/*> if absolutely necessary.
> This will be quite some work, especially if the <mach/*>
> path is used in a lot of drivers...

Fortunately we don't use mach/ in our drivers, so that shouldn't be
any issue. At least that used to be the case. See it as a nice side
effect of doing both SH and ARM. =)

> Then we have a quite broad consensus to depopulate arch/arm/*
> of drivers, so for shmobile:
>
> clock* -> drivers/clk

Sure, here we have quite a bit to do, no doubt about that!

> cpuidle.c -> drivers/cpuidle (or was this just fixed?)

I don't know the latest state here. For me it would make sense that
arch/arm actually contained some shared sleep mode support, but if
that should be in drivers/ instead then that's really no biggie for
me. We have some cpuidle code that wants to be moved.

> intc* -> drivers/irqchips

We have some legacy SoCs using INTC tables under mach-shmobile/, but
it is likely that those SoCs will be phased out before we have working
generic INTC DT binding support. Everything modern is using GIC plus
drivers under drivers/irqchips already.

> sh-gpio.c -> drivers/pinctrl/gpio
>
> The last one I know you will soon finish.

I believe Laurent has this under control. Actually, from the top of my
head I don't even know which IP sh-gpio.c is tied to. I know we have a
couple of drivers in drivers/gpio and also stuff in drivers/pinctrl/,
but apart from that..

> Then deleteing all board file stuff that is not using DT.

As you noticed, we sort of have a flow of code coming in that is
written for currently-existing frameworks. Then we have the upstream
rework and DT support going on in parallel. To aid this we have
something called DT reference board support, which is basically board
support code where we add DT bit by bit. Those DT reference boards can
also be used together with common clocks and multiplatform kernels.
KZM9D and EMEV2 are multiplatform ready, but lack CCF at this point.

So the idea is that we move individual SoCs and boards over to
multiplatform and then remove the old board code bit by bit. In
parallel with this we may phase out old boards and old SoCs.

> After all that it's top-notch I think :-)

Thanks for your suggestions!!

/ magnus
