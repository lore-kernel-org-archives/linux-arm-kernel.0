From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 31 Oct 2017 15:31:41 +0530
Subject: [PATCH V4 00/12] drivers: Boot Constraints core
In-Reply-To: <CAL_JsqKi+9yEXRq=XcCG=S8wXmLk9BFCnXWEE9mcf+495j+1sw@mail.gmail.com>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <CAL_JsqKi+9yEXRq=XcCG=S8wXmLk9BFCnXWEE9mcf+495j+1sw@mail.gmail.com>
Message-ID: <20171031100141.GQ4240@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 30-10-17, 17:07, Rob Herring wrote:
> Would probing the display earlier solve this as that's also something
> people care about (or work-around by initializing the display in the
> bootloader).

Not always.

And probing the display earlier may result in breaking some other
devices. For example, the display driver may want to enable and then
disable its clock at some point of time in probe(). The enable will
get propagated to parent clocks of display clock as well and all will
have a refcount of 1. Now if display controller disables its clock,
the whole hierarchy of clocks may go down as no one else have taken a
reference of those clocks and other peripherals, used during booting
the kernel, that depend on the clk hierarchy may not work properly
after that until the time their driver comes up.

One more typical problem I saw during my testing on hikey was that
many debug messages were missing during kernel boot (though everything
was available with dmesg later on), that I never noticed earlier on.

After digging a bit I found that it is because of the way AMBA bus
works. It enables and disables the interface clock before calling
probe() (to read some registers) and the interface and functional
clocks were same for hikey UART. And that disabled the clock before
calling probe() which was enabled by the bootloader. And the message
started coming again only after sometime when tty device all setup
properly.

Over that the display driver can be compiled as a module (which we
will disallow with your suggestion). Plus all the resources for the
display driver may not be available early on and so the driver will be
probed later again. And by that time some of the resources may get
disabled/reconfigured.

> I guess if the display depends on resources A, B, and C,
> other drivers could still each only depend on one of those and probe
> successfully before the display does.

That would be tricky as well. Same example about refcounting of
clocks. What if the parent clock of display controller's clock gets
disabled, because another child of that parent clock has done a clk
enable/disable? And with amba probing, there are more chances of that
naturally.

My basic idea is that some code should come in and set these
constraints before any of the users of these resources come up (i.e.
display, serial, mmc drivers, etc). That is the only sane way with
which we would be able to have some guarantees here.

> However, the display driver
> would still probe,

As I said, it may be too late.

> so you could do something then to enable the
> constraints.
> That would have the advantage that the driver knows what
> resources it needs even if probe is deferred and you don't need
> special DT bindings nor platform code.

I am not sure if I fully understood some of your comments. Lets see if
I have :)

Are you saying that we set the same boot constraints (i.e. by calling
the same API as proposed in this patchset) from these generic drivers?
I agree that the driver would know all the details and would be in a
good position to judge all the resources it needs, but again, this may
be too late. And what if we have two drivers which want to come up
first and set these constraints? Like MMC and LCD sharing same
regulator or clk line ?

> Getting certain drivers/devices to probe first may just require
> ensuring they get inserted at the beginning of the driver and device
> lists which would be a pretty trivial change I think. That's ignoring
> differing initcall levels though.

Sure and that's what we have been doing so far. Hacking different
parts of kernel to force some kind of ordering :)

> > Another case can be a debug serial port enabled from the bootloader.
> 
> Continuing the above thought, we could just match device nodes against
> stdout-path as we create devices and then set a priority flag or
> something that the driver core would handle.
> 
> Yes, it's triggered by a specific use case, but I'm not that convinced
> that having things setup by the bootloader and needing a transparent
> hand off is a general case. You've given 2 examples. I can't think of
> many more. One is CAN bus which has realtime servicing requirements,
> but I don't think this series solves that (OOT solutions I've seen
> insert callbacks at random places during kernel init).

I am not sure what the problem is and I can't say if that can benefit
from this work. Someone also mentioned (privately) that handing off a
preboot DSP to kernel can also be a usecase for this framework. I am
not sure of the details though :)

> The other case
> is just things that have no driver at all, but resources need to
> remain enabled. That should just be some platform code to enable those
> things IMO.

Yeah, I am not really targeting those right now. They can have
always-ON kind of hints in DT and that should be all. I am
specifically targeting stuff where a driver takes over eventually.

> > Of course we can have more complex cases where the same resource is
> > getting used by two devices while the kernel boots and the order in
> > which devices get probed wouldn't matter as the other device will surely
> > break then.
> >
> > There are also cases where the resources may not be shared, but the
> > kernel will disable them forcefully as no users may have appeared until
> > a certain point in kernel boot. This makes sure that the resources stay
> > enabled. A wide variety of constraints can be satisfied using the new
> > framework.
> 
> This is only if the driver (or dependent driver) is a module though.
> Is that something we really need to handle?

Maybe, I am not sure.

Why shouldn't we allow the LCD driver to be present as a module? I am
just asking :)

> > Viresh Kumar (11):
> >   of: platform: Add of_find_amba_device_by_node()
> >   of: platform: Make of_platform_bus_create() global
> >   drivers: Add boot constraints core
> >   boot_constraint: Add support for supply constraints
> >   boot_constraint: Add support for clk constraints
> >   boot_constraint: Add support for PM constraints
> >   boot_constraint: Add debugfs support
> >   boot_constraint: Manage deferrable constraints
> >   boot_constraint: Add earlycon helper
> >   boot_constraint: Add support for Hisilicon platforms
> >   boot_constraint: Add support for IMX platform
> >
> >  arch/arm/mach-imx/Kconfig                 |   1 +
> >  arch/arm64/Kconfig.platforms              |   2 +
> >  drivers/Kconfig                           |   2 +
> >  drivers/Makefile                          |   1 +
> >  drivers/base/dd.c                         |  32 +++-
> >  drivers/boot_constraints/Kconfig          |   9 +
> >  drivers/boot_constraints/Makefile         |   7 +
> 
> Maintainer for this?

Sure, that's me. I am just holding off from touching MAINTAINERS file
until this stuff is accepted (at least informally).

> >  drivers/boot_constraints/clk.c            |  73 ++++++++
> >  drivers/boot_constraints/core.c           | 271 ++++++++++++++++++++++++++++++
> >  drivers/boot_constraints/core.h           |  48 ++++++
> >  drivers/boot_constraints/deferrable_dev.c | 235 ++++++++++++++++++++++++++
> >  drivers/boot_constraints/hikey.c          | 145 ++++++++++++++++
> >  drivers/boot_constraints/imx.c            | 113 +++++++++++++
> >  drivers/boot_constraints/pm.c             |  31 ++++
> >  drivers/boot_constraints/qcom.c           | 123 ++++++++++++++
> >  drivers/boot_constraints/serial.c         |  28 +++
> 
> earlycon really. earlycon doesn't have to be a serial device.

Ah, ok.

> >  drivers/boot_constraints/supply.c         | 107 ++++++++++++
> 
> Kind of a mixture of boards and subsystem handlers. Perhaps subsystem
> handlers should go into the subsystems. Then you can get a lot more
> opinions on this. :)

You don't want this to get merged, do you ? :)

Thanks for your feedback Rob. Really appreciate it.

-- 
viresh
