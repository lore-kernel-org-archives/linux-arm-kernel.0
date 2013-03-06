From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Mar 2013 10:50:42 +0000
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <1781901.cQ9rKScpd8@flatron>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <201303051919.02638.arnd@arndb.de> <1781901.cQ9rKScpd8@flatron>
Message-ID: <201303061050.42451.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013, Tomasz Figa wrote:
> On Tuesday 05 of March 2013 19:19:02 Arnd Bergmann wrote:

> > If none of these are needed for DT-based systems, we should probably
> > build that code conditionally based on the CONFIG_EXYNOS_ATAGS symbol
> > I introduced.
> 
> Yes, none of them are needed for DT-based systems.

Ah, good. I'll try to make more code conditional then.
 
> > How are you planning to solve this? Do you want to have a combined
> > driver that registers both a clocksource and a pwm?
> 
> Let's start with a quick introduction to the s3c-pwm hardware. Each 
> channel has its own timer value, compare and reload value registers, so 
> they don't need any extra locking. However there are additional shared 
> configuration registers, containing things such as start and reload bits 
> for all channels, prescaler and main divisor values, etc. Those registers 
> needs synchronization.
> 
> Now there are several possible approaches:
> 
> 1) A brute force one - two separate drivers, based on the fact that the
>    clocksource driver will be used only on uniprocessor systems, so
>    a simple _irqsave when accessing a shared register in both will 
>    guarantee correct synchronization.
> 
> 2) Two separate drivers with some synchronized shared code accessing 
>    registers (_start, _stop, _set_reload, _set_prescaler, _set_divisor, 
>    etc.; all using a shared spinlock).
> 
> 3) Single driver registering PWM channels, clocksource and clock event 
>    device. This does not seem like a bad idea, since the whole code for 
>    configuration of the PWM block would reside in one location and there 
>    would be no redundancy. However there is a question where such driver 
>    should be placed - drivers/clocksource, drivers/pwm, or maybe somewhere 
>    else?
> 
> Personally I wanted to go with first option, which would require least 
> amount of changes to existing code, at a cost of some code duplication 
> (but some PWM code is duplicated already).

I would prefer option 3. That is also easier to implement with a straightforward
DT binding that defines a single node with the clock registers. The location
doesn't have an obvious answer, but I would probably put them into
drivers/clocksource if the PWM maintainer agrees.

Option 2 would probably come down to having a trivial MFD driver exposing
a regmap. You can probably reuse drivers/mfd/syscon.c for this and make
the node compatible with "syscon" to designate the clock registers as
a system-wide resource, making the other device nodes register-less.

	Arnd
