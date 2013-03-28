From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 19:27:34 +0000
Subject: [PATCH V7 1/2] ARM: bcm281xx: Add timer driver (driver portion)
In-Reply-To: <5154848D.7010400@linaro.org>
References: <1363210048-3334-1-git-send-email-csd@broadcom.com>
 <CAGFynZ-8hQLLYuny6V6=9c+dqtAHs51BcH_wPb=k7WdY9FXS3Q@mail.gmail.com>
 <5154848D.7010400@linaro.org>
Message-ID: <201303281927.34327.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013, John Stultz wrote:
> On 03/28/2013 09:03 AM, Christian Daudt wrote:

> >>> Maybe we should move the ARM specific ones into
> >>> drivers/clocksource/arm/ ?
> >> About half the IP blocks we use on ARM are also used on at least
> >> one ARM64/AVR32/MIPS/PowerPC/x86/SH/Hexagon/c6x/etc part. Grouping them
> >> by which CPU architecture first starts using them or happens to be
> >> more popular at the time does not seem too helpful here.
> >>
> >> Maybe it's better to have a subdirectory for those clock sources
> >> that are used on any SoC, or have subdirectories based on the
> >> company that created that part, as we do for ethernet drivers.
> >> I wouldn't bother with that until there are a couple of dozen
> >> different clock source drivers.
> 
> So having had a few days to think about this, I think what usually rubs 
> me the wrong way when I get driver/clocksource submissions, is that for 
> 99% of it, they *aren't clocksource drivers*.  Most of the code is 
> *clockevent* driver logic, and then maybe 1-5 lines of actual 
> clocksource code.
> 
> Now, I know the reason for this is often the clocksource and clockevent 
> drivers are backed by the same hardware, and since there's no clockevent 
> directory, might as well have it all in a single file somewhere. But 
> mixing the different subsystem drivers together causes some of the 
> maintenance confusion here.
> 
> So instead of creating drivers/clocksource/arch/ directories, what I'd 
> propose is we create a drivers/clockevent directory to handle the actual 
> clockevent code. I think this would better delineate the lines of 
> responsibility on the gatekeeper side (that being Thomas or maybe 
> someone else who has an interest in the subtleties of how various 
> hardware timers are be broken-by-design ;), and I'd be much happier 
> taking clocksource code where I felt I had a reasonable chance of 
> noticing bugs.

Yes, this sounds like a good idea.

> Thomas: Not that you need more to maintain, but does this seem 
> semi-reasonable? Do we need to find someone else to help here?
> 
> That said, at the end of the day, if I take a bad drivers/clocksource 
> patch, what breaks won't be the timekeeping core, it will be an SoC 
> board.  So I'll have to really rely on the original clocksource driver 
> authors to help vet incoming patches. This is where I think having the 
> SoC tree as a central point for SoC patches has and advantage, as its 
> less likely breakage will sneak upstream via a subsystem tree. But 
> understanding the need for review help, I think I'm ok with taking on 
> more clocksource specific review.

I think the important point for you to realize is that you don't need to
worry about breaking a specific SoC. The patches will come from someone
who is using that hardware in the end. What we need from clock{source,event}
subsystem maintainers is perspective of how things fit into the subsystem
and to provide review like:
- this driver is not using CLOCKSOURCE_OF_DECLARE when it should
- that driver only handles clockevent, don't put it into drivers/clocksource
- I don't like your coding style, it doesn't fit in with the other
  drivers in this subsystem.
- what you do can be implemented much simpler using the generic infrastructure
  introduced by that earlier driver.

	Arnd
