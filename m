From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Apr 2011 17:14:07 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <201104191655.13133.arnd@arndb.de>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<201104191616.01647.arnd@arndb.de>
	<20110419145009.GH9462@sirena.org.uk>
	<201104191655.13133.arnd@arndb.de>
Message-ID: <BANLkTi=kGxL9N-RNqxmeqs4zeYo0zzfmhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/19 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 19 April 2011, Mark Brown wrote:
>> On Tue, Apr 19, 2011 at 04:16:01PM +0200, Arnd Bergmann wrote:
>>
>> > That sounds like a good idea. Same for the regulator drivers that are
>> > currently in arch/arm instead of drivers/regulator.
>>
>> We don't have any regulator drivers in arch/arm I think (unless the ST
>> one got merged, but that's actually a dual regulator/system management
>> driver rather than a proper regulator - when I reviewed it I didn't flag
>> the location due to the second interface on the side).
>
> I was thinking of arch/arm/mach-ux500/regulator-db8500.c in linux-next.
>
> I can only see regulator contents in there, what do you mean by
> system management?

I will surely put that into drivers/regulator, Mark already requested that
as part of his review.

The problem is that it is dependent on the PRCMU driver which
provides the communication mechanism to actually control these
regulators.

The PRCMU is the Power Reset and Control Management Unit,
it is a register pages where you send commands to a firmware
running on its own CPU on the other side, partly using mailboxes.
The firmware handles things like voltage and power domains
(modeled as regulators), frequency changes (using CPUfreq),
idle states (CPUidle and sleep, idling), as well as resetting
particular memory blocks AND an I2C channel to the AB8500
chip (driven from drivers/ab8500-core.c indeed) and some
GPIO configuration.

We are indeed trying to spread the stuff in there out across
the proper subsystems.

Thinking of it, is it OK to put chip CPUfreq drivers into
drivers/cpufreq/* instead of into the arch/arm/* platform
code as everyone does right now? We could probably
fix that and bring down the diffstat considerably.

Yours,
Linus Walleij
