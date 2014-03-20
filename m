From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Mar 2014 11:42:38 +0000
Subject: Common clock: function clock and bus clock
In-Reply-To: <CADApbeh0zjd=qMguiqQGrn=0v+-SVqgnyL=Gk8D9MiQvHU2XGA@mail.gmail.com>
References: <CADApbej768d0z_SwSOAK8WcrxZOMMs3mFNzJ76Bewmi_-UU-PA@mail.gmail.com>
 <CAN1soZzFfSp2Hj=JBxj+N9iLrjkm3poOa7piJDJT5BY-ycsWHQ@mail.gmail.com>
 <CADApbegGTm=REJbukdyEY9ZVK9hXax+Hodp7MFx3SUb=CV1TbA@mail.gmail.com>
 <5320336B.3020107@ti.com>
 <CADApbeh0zjd=qMguiqQGrn=0v+-SVqgnyL=Gk8D9MiQvHU2XGA@mail.gmail.com>
Message-ID: <20140320114238.GQ7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:15:20AM +0800, Chao Xie wrote:
> For a device, it has bus clock and function clock. usally bus clock is
> a gate type clock.
> 
> some devices share same bus clock, but have different function clock.
> If we want to use the device, we have to enable the bus clock and
> function clock both.
> 
> The problem is for some SOCes, there is no sharing of bus clock while
> for others, it has, and this limitation can happen at all clocks in
> clock domain.
> 
> So i do not want to make device driver be aware of it. I just let it
> know there is only one clock, and keep the dependency in clock
> framework.

This is something I really hate.  Of course the device driver needs to
be aware of it.

A dumb device driver which enables all its clocks at probe time and
turns them all off at remove time doesn't need to know about it, but
if you're doing something more clever - like what the clk API was
designed for such as power saving, where you would turn off the
function clock while it wasn't used but still access the device, then
the device driver /does/ need to have control of the two separately.

The big mistake here is everyone latching on to platform devices,
which provide almost zero assistance with any of this.  If you look
at something like the AMBA primecell stuff, then that:

- deals with runtime PM for the device driver before it's probed
- handles the device bus clock, ensuring that it is running for the
  probe, and disabling it after the remove
- provides the driver with a simple API to allow the bus clock to be
  disabled and re-enabled should the driver wish to go that far.

That's the right way to deal with this.

Note that the driver model maintainer, Greg KH, has stated a number of
times that he wishes people would stop using platform devices... so,
the solution here seems quite simple.

- Stop using platform devices
- Create a bus infrastructure which helps with this problem

And don't try and hide this kind of stuff inside the clk layer.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
