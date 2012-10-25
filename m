From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 25 Oct 2012 09:47:38 -0600
Subject: [PATCH] [RFC] pinctrl: mvebu: reset pins to an UNKNOWN state
 on startup
In-Reply-To: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <50895F1A.9020101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 01:18 PM, Thomas Petazzoni wrote:
> Note: this patch is a *RFC*, it is not intended for merging, only to
> get a discussion started. The code is horrible, makes terrible
> assumptions and so on.
> 
> On many platforms, most of the pinmux initialization is done in the
> bootloader, and therefore persists when we boot the Linux kernel. This
> prevents us from making sure that the pinmux configuration in the
> board device trees is correct.

Well, it's easy enough to determine that the kernel's configuration is
correct as far as it goes, since it's applied, and if everything still
works, the pinmux configuration is presumably correct. The issue is more
that the kernel's configuration may be missing some entries, and hence
relying on the bootloader having already set up some pins/groups.

> One idea to make sure our device trees are correct in terms of
> pinmuxing is to set the state of each pin to an unavailable function
> during the initialization of the pinctrl driver. This way, only pins
> that are explicitly configured through proper device tree attributes
> will actually be functional.

On Tegra at least, and I imagine many SoCs, there is not an
"unavailable" function for each pin/group. Hence, this would be
impossible to implement. For pins/groups where there is a mux function
that is reserved or actually does do nothing, the value of that mux
function is potentially different per pin/group. At least I suppose we
could force tristate on for all pingroups, so no output signals would work.

> Remaining questions to solve:
> 
>  * Is this useful?

I can certainly see the use of this, as an explicitly enabled option
used for testing at least. On Tegra, we've certainly had issues where
the kernel accidentally relies on the bootloader having set things up,
so when switching to a different lighter-weight bootloader, things stop
working. That was more w.r.t. clocks, but it could easily happen for
pinmux too.

>  * How to figure out what function number is a good function number to
>    set all pins to at startup? It could be passed by the SoC-specific
>    pinctrl drivers.

Yes, this would have to be either implemented by individual drivers, or
use data passed in by the individual drivers.

>  * Maybe some pins should be excluded for this, especially if the
>    console serial port pins are muxed. On Armada XP, it's not the
>    case: UART0 RX/UART0 TX pins are not part of MPPs, so we can clear
>    all pins. But on other mvebu platforms, it may be the case.

I don't think excluding the serial port pins would be useful.
Presumably, if you enable this option, you're doing so explicitly to
test the pinmux setup after you've tested that the kernel otherwise
works correctly. As such, if the serial port stops working when you flip
on this option, it's a pretty good clue that the serial port pinmux
setup isn't correct. Presumably, you might also enable earlyprintk over
the UART when debugging with this new option.

>  * If this sounds like an interesting thing, should we keep it only at
>    the mvebu driver level, or make it something more generically
>    available in the pinctrl subsystem?

Making this generic is probably complex for reasons I outlined above.
I'd tend towards a common kernel Kconfig or cmdline option to trigger
this, but have each driver use that option as it sees fit in its own
custom code. I imagine that will reduce the overall amount of code it
takes to implement this. If using a cmdline option, the pinmux core
should parse it, and set up some variable or function for the drivers to
query.
