From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 08 Aug 2013 09:50:11 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130805085114.GE15885@kroah.com> (Greg KH's message of "Mon, 5
 Aug 2013 16:51:14 +0800")
References: <20130801192730.GC9174@kroah.com>
 <20130802090355.GF7656@atomide.com> <20130802093222.GA8982@kroah.com>
 <20130802123445.GG7656@atomide.com> <20130802141449.GA7533@kroah.com>
 <20130805065535.GP7656@atomide.com> <20130805071106.GA14215@kroah.com>
 <20130805073730.GU7656@atomide.com> <20130805080254.GA15376@kroah.com>
 <20130805082138.GV7656@atomide.com> <20130805085114.GE15885@kroah.com>
Message-ID: <87txj0rut8.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg KH <greg@kroah.com> writes:

> On Mon, Aug 05, 2013 at 01:21:38AM -0700, Tony Lindgren wrote:

[...]

>> 
>> How the power and clock domains are done and how the clocks are gated
>> or idled. So basically how the devices are reset and idled at the bus
>> level.
>
> I think of a "bus" as the way that a device talks to the hardware (i.e.
> PCI, USB, i2c, spi, etc.)  You are saying a "bus" is something
> different, something that is used to control the "raw" devices that just
> do iowrites.
>
> Why not just create a bus for your devices, have them register platform
> devices (so you can take advantage of the existing drivers) and have
> your own "platform bus" of a specific type?  The code to do that would
> only need to be created once "per bus", and that way you can handle all
> of the needed reset/idle stuff properly for things "attached" to it.

Each time we've looked at doing this (when pre-cursors to runtime PM
were being explored, for example), what you end up with is essentially
with a copy of drivers/base/platform.c with a few lines of additional
code.  So each time this has happened, the outcome has been that the
platform_bus has just extended slightly with the new features to avoid
the massive duplication.

This has followed the "extend instead of duplicate" philosophy we
generally follow, but the question now is whether we've finally extended
the platform_bus to it's breaking point.  (I don't think we don't have
to guess what your answer is.) :)

At least for the PM stuff (including reset/idle), I don't think we need
a new bus type.  We now have PM domains which IMO should be used for
this stuff.  PM domains allow arbitrary groupings of (independent of
underlying bus type) that have common PM operations (read struct
dev_pm_ops.)  For these things, it's probabably PM domains (along with
runtime PM/dev_pm_ops) that should be extended for some of the PM
features Tony is referring to.  Then the driver core (not the bus) might
need to grow some new operations to handle new items in dev_pm_ops.

While I think that could address the device/bus specific PM related
operations without the need for a new bus type, it doesn't really solve
the bigger forward-looking features Will is raising.

> Perhaps we need to get in front of a whiteboard at the ARM mini summit
> and hash this all out...

Agreed, this will be a great topic for the ARM mini summit.

Kevin
