From: john.stultz@linaro.org (John Stultz)
Date: Thu, 28 Mar 2013 10:57:33 -0700
Subject: [PATCH V7 1/2] ARM: bcm281xx: Add timer driver (driver portion)
In-Reply-To: <CAGFynZ-8hQLLYuny6V6=9c+dqtAHs51BcH_wPb=k7WdY9FXS3Q@mail.gmail.com>
References: <1363210048-3334-1-git-send-email-csd@broadcom.com>
 <51410BF4.4040400@linaro.org> <alpine.LFD.2.02.1303140951580.22263@ionos>
 <201303141603.02401.arnd@arndb.de>
 <CAGFynZ-8hQLLYuny6V6=9c+dqtAHs51BcH_wPb=k7WdY9FXS3Q@mail.gmail.com>
Message-ID: <5154848D.7010400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2013 09:03 AM, Christian Daudt wrote:
> On Thu, Mar 14, 2013 at 9:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thursday 14 March 2013, Thomas Gleixner wrote:
>>>> But if its arch specific for hardware I don't have, I'd really prefer the arch
>>>> maintainer be the upstream path.
>>>>
>>>> Thomas: Am I being too obstinate here?  If not, should we drop "F:
>>>> drivers/clocksource" from the MAINTAINERS entry?
>> The idea of moving drivers out of arch/* into drivers/* is definitely to
>> have someone who understands the subsystem act as the gatekeeper. There
>> should be very little architecture specific knowledge in those drivers,
>> and I think it's more important to ensure that they are following a
>> sensible understanding of how timekeeping is done than that they
>> are following specific architecture maintainer's preferences.

Sorry for the slow reply here.

Arnd: So I think I better understand the crux of the debate:

I'm unfamiliar with the hardware specifics, so I'm pushing the 
gatekeeping to the SoC maintainers, where as the SoC maintainer (dealing 
with tons of different SoC's), you're also unfamiliar with the hardware 
specifics, and would like to push the gatekeeping of the subsystem 
specific functionality to those maintainers.

Given that for each SoC there's tons of subsystem specific functionality 
that you're having to deal with, I can sympathize with your need to 
offload some of the gatekeeping.


>>> Maybe we should move the ARM specific ones into
>>> drivers/clocksource/arm/ ?
>> About half the IP blocks we use on ARM are also used on at least
>> one ARM64/AVR32/MIPS/PowerPC/x86/SH/Hexagon/c6x/etc part. Grouping them
>> by which CPU architecture first starts using them or happens to be
>> more popular at the time does not seem too helpful here.
>>
>> Maybe it's better to have a subdirectory for those clock sources
>> that are used on any SoC, or have subdirectories based on the
>> company that created that part, as we do for ethernet drivers.
>> I wouldn't bother with that until there are a couple of dozen
>> different clock source drivers.

So having had a few days to think about this, I think what usually rubs 
me the wrong way when I get driver/clocksource submissions, is that for 
99% of it, they *aren't clocksource drivers*.  Most of the code is 
*clockevent* driver logic, and then maybe 1-5 lines of actual 
clocksource code.

Now, I know the reason for this is often the clocksource and clockevent 
drivers are backed by the same hardware, and since there's no clockevent 
directory, might as well have it all in a single file somewhere. But 
mixing the different subsystem drivers together causes some of the 
maintenance confusion here.

So instead of creating drivers/clocksource/arch/ directories, what I'd 
propose is we create a drivers/clockevent directory to handle the actual 
clockevent code. I think this would better delineate the lines of 
responsibility on the gatekeeper side (that being Thomas or maybe 
someone else who has an interest in the subtleties of how various 
hardware timers are be broken-by-design ;), and I'd be much happier 
taking clocksource code where I felt I had a reasonable chance of 
noticing bugs.

Thomas: Not that you need more to maintain, but does this seem 
semi-reasonable? Do we need to find someone else to help here?

That said, at the end of the day, if I take a bad drivers/clocksource 
patch, what breaks won't be the timekeeping core, it will be an SoC 
board.  So I'll have to really rely on the original clocksource driver 
authors to help vet incoming patches. This is where I think having the 
SoC tree as a central point for SoC patches has and advantage, as its 
less likely breakage will sneak upstream via a subsystem tree. But 
understanding the need for review help, I think I'm ok with taking on 
more clocksource specific review.


> So it seems the (weak...) consensus is that it should go through the
> clocksource tree. John, can you please apply the patch ?

Christian: So thanks again for the ping here. So I think I'd prefer 
Thomas to be the one to apply these sorts (ie: clockevent) of patches in 
the future, but this time around I'll do it because its been unfair to 
make you the monkey-in-the-middle as we've tossed the responsibility 
around (and my stuff goes through Thomas anyway).

thanks
-john
