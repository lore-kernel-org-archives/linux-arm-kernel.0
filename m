From: rob.lee@linaro.org (Rob Lee)
Date: Fri, 13 Jan 2012 11:25:47 -0600
Subject: [PATCH 5/7] at91 : fix dirty hack for the selfrefresh function
In-Reply-To: <201201131548.50753.arnd.bergmann@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
 <4F0FF98D.9050308@linaro.org>
 <20120113102216.GQ1068@n2100.arm.linux.org.uk>
 <201201131548.50753.arnd.bergmann@linaro.org>
Message-ID: <CAMXH7KEtc6PJNEUH6a-wxtC9zJk3RL8n4mi6Kfw3_AS3C0UYew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 9:48 AM, Arnd Bergmann <arnd.bergmann@linaro.org> wrote:
> On Friday 13 January 2012, Russell King - ARM Linux wrote:
>> The idea of exporting arm_pm_standby() is one I thought about, but I'm
>> not sure if it makes sense for all SoCs to call their standby function
>> from the CPU idle code.
>
> It doesn't have to be all SoCs, but it would be nice if we could
> do it for a few of them.
>
>> I'm coming to the conclusion that moving the AT91 CPU idle driver out
>> of arch/arm/mach-at91 is the wrong thing to do - it seems that the CPU
>> idle driver is intimately linked to core AT91 code, and moving it out
>> just makes those linkages a lot more complicated to handle. ?And for
>> what benefit - just to have this located under the drivers/ subtree
>> because it's now seen to be a driver ?
>>
>> I think this is one of the times where the 'solution' is worse than the
>> problem.
>
> One of the benefits of moving all cpuidle drivers into that directory
> was so that we could spot commonalities between them and share code across
> the implementation.
>
> Maybe the answer is that we should do the second step before the first
> one instead, in particular since the at91 implementation is so simple.
> Could we have a common cpuidle driver that just calls cpu_do_idle or a
> new global pm_standby function when that is available for two disinct
> levels? Then again, there really isn't that much code left, so maybe
> it doesn't make much sense after all to consolidate it this one.
>

This patch provides a common cpuidle interface with an optional
default state that just calls cpu_do_idle.  Take a look at the
drivers/cpuidle/common.c file.  I hope to release the next version
within day or two, so if you have any additional suggestions that
could help with this situation, please let me know.

http://www.spinics.net/lists/arm-kernel/msg151843.html

> One more idea: We can put the driver into drivers/cpuidle/at91_cpuidle.c
> but put the functions that get called into the arch/arm/mach-at91/pm.c
> and initialize it with the standby function provided as driver_data:
>
> struct cpuidle_device at91_cpuidle_device = {
> ? ? ? ?.count = 2,
> ? ? ? ?.states_usage = {
> ? ? ? ?[0] = { .driver_data = &cpu_do_idle },
> ? ? ? ?[1] = { .driver_data = &at91_standby },
> ? ? ? ?},
> };
>
> Not really how it's meant to be used, but separates the cpu-specific parts
> from the main driver.
>
> ? ? ? ?Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html

It seems that clock driver functionality for some platforms are
implemented in arch/arm/mach-xxx and then exported through calls to
clk_get.  The platform_driver system also allows exporting of platform
data to non platform located files.  Perhaps each platform could have
one specific platform driver structure instance whose sole purpose is
to export platform specific functions by a call to
platform_get_drvdata.  Or, a lighter weight system similar to clk_get
could be created for this purpose.  Of course both of these are
heavier than just adding extern statements to a drivers/cpuidle/blah.c
file but I just wanted to throw those options out there in case it is
the "extern" method of exporting that is an issue and not the actual
exporting platform specific located functionality to non-platform
areas.
