From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 27 Jun 2011 13:53:28 +0900
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <BANLkTimsGp+FsKSxqzigmFCZxhQ+Av0DzA@mail.gmail.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<201106171707.23989.arnd@arndb.de> <4DFB8E20.60802@gmail.com>
	<4DFF03FA.8030906@arm.com>
	<20110620083216.GB26089@n2100.arm.linux.org.uk>
	<BANLkTimsGp+FsKSxqzigmFCZxhQ+Av0DzA@mail.gmail.com>
Message-ID: <BANLkTi=yqsa9Arwqex2SRmuLLZeJ3EUDNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2011 at 4:00 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jun 20, 2011 at 2:32 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Jun 20, 2011 at 09:25:30AM +0100, Marc Zyngier wrote:
>>> On 17/06/11 18:25, Rob Herring wrote:
>>> > If this is the direction to go, then there are a lot of other timers
>>> > that can be moved besides just local timers. But Russell didn't really
>>> > like the shmobile patches for early platform devices which this relies
>>> > on. So we should get agreement on the small bit of infrastructure needed
>>> > first, then start moving individual timers.
>>>
>>> I'm open to suggestions. Should the early platform infrastructure be
>>> flagged as unsuitable, I'd be happy to switch to something else, as long
>>> as it is minimal, and does not create another ARM-specific API (been
>>> there, done that...).
>>
>> I am most certainly not a fan of the early platform device stuff as I've
>> said in the past.
>>
>> It looks to me like:
>>
>> 1. it's overcomplex and fragile.
>> 2. it abuses the early command line system.
>> 3. it abuses platform devices etc.
>> 4. it requires more initialization calls.
>>
>> Lastly, and probably more importantly for the direction we're going, I
>> can't see how it would hook into DT other than using the DT provided
>> command line, which also appears to be an abuse there too.
>
> I'm going to second that opinion. ?I just looked through the early
> platform stuff, and I'm not thrilled with the model.
>
> Setting up timers does not need to plug into the device model. ?Unless
> I'm completely reading the ARM code wrong, these timers are pretty
> fundamental to the operating system, and thus aren't really like other
> devices. ?I don't see any problem with individual timer init functions
> populated in machine_desc assuming that multiple boards with the same
> SoC will not require different timer initialization.

Perhaps that's the case for some ARM platforms, but at least the
sh7372 ARM platform is using general purpose timers as system timers.
We have to since there are not other timers dedicated as system
timers. Same for the SH architecture. I suspect that's the case for
most other SoCs too actually, with the exception of platforms making
use of ARM IP such as the TWD found in for instance Cortex-A9.

On most SoCs there are a wide range of SoC-specific timer channels to
choose from. We want to reuse the same driver for multiple SoCs so
separating the device configuration parameters (such as I/O base and
IRQ) from the actual driver is desired.

The reason why we want to select timer channel is that some timer
channels are tied to GPIO pins, and those GPIO pins may be used to
driver board-specific hardware. So timer channel #2 may be great as
clock source for board X but on board Y channel #2 is used to drive
the PWM for the LCD backlight.

I fail to see what is wrong with separating device configuration from
the actual driver.

Thanks,

/ magnus
