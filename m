From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Oct 2012 11:59:30 +0200
Subject: [PATCH 03/10] tty: pxa: configure pin
In-Reply-To: <20121023093711.GS4477@opensource.wolfsonmicro.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-3-git-send-email-haojian.zhuang@gmail.com>
 <508080CB.5010904@wwwdotorg.org>
 <CACRpkdb5Jiw71jBLDXpf2VTJQx7_gABqs03_20CeCLbVT=JkaA@mail.gmail.com>
 <5085AC06.8070508@wwwdotorg.org>
 <CACRpkdY-XyagxGU_ya_FZirzbqStTirOC5nuBBwwFY3f4bBTYA@mail.gmail.com>
 <20121023093711.GS4477@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdb+DkZbTDZamGMN+9t07kPktuA_3QtHQJFv+Vu859r7KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 11:37 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 23, 2012 at 11:26:40AM +0200, Linus Walleij wrote:
>> I thought about that, but it does not allow us to control the
>> resource activation/deactivation order.
>
>> In some drivers the suspend() path could be:
>
>> - pins to sleep
>> - clk_disable
>> - disable external regulator
>> - release power domain
>
>> In others:
>
>> - clk_disable()
>> - disable external regulator
>> - pins to sleep()
>> - release power domain
>
>> Ulf Hansson ran into this a while back.
>
>> Just like with the notifier approach, this approach assumes that either
>> the ordering above doesn't matter, or that it is the same for all drivers.
>
> Can we handle this with power domains - if different devices require
> different orderings they can be placed in power domains which implement
> the appropriate orderings for them?

clocks, regulators, pins and all in power domains?

Then we should rename them "device resource domains" or
something...

I have a strong sense of system-wide all-or-nothing approaches
to this problem.

- Either we use "power" domains to handle every resource the
 device has.
- Or the device driver manages it's own resources.

I find it pretty hard to build consensus around either idea.

The problem is that the latter approach (devices drivers themselves
take clocks, domain power, etc) is already quite widespread
in the kernel so to get the entire world consistent to the former
approach would be pretty painful I think. Especially in the case
where a device driver is used on more than one SoC.

Yours,
Linus Walleij
