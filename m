From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 5 Jan 2016 10:21:47 +0800
Subject: [linux-sunxi] reason for Allwinner SoC specific pinctrl drivers?
In-Reply-To: <568A514D.7070102@arm.com>
References: <568A514D.7070102@arm.com>
Message-ID: <CAGb2v65WttmGunT1ipekdZN_orjbWa43p9w2tcq_SCi-fzQMnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 4, 2016 at 7:02 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> Hi,
>
> while looking at the Allwinner A64 SoC support, I was wondering why we
> would actually need a pinctrl driver (file) for each and every Allwinner
> SoC that we support.
> Looking at both the A20 and the A64 doc I don't see any differences in
> the port controller implementation apart from the actual
> muxval <-> subsystem assignment, which is just data, right?
> Comparing the code files in drivers/pinctrl/sunxi seems to support this,
> as those drivers only consist of the table and some boilerplate code.
>
> Now I was wondering whether we could get away with one generic Allwinner
> pinctrl driver and put the SoC specific pin assignments in DT instead.
> It looks like adding an "allwinner,muxval" property in addition to the
> existing "allwinner,function" in the SoC's .dtsi would give us all the
> information we need. This could look like:
>
>         uart0_pins_a: uart0 at 0 {
>                 allwinner,pins =   "PB22", "PB23";
> +               allwinner,muxval = <0x02    0x02>;
>                 allwinner,function = "uart0";
>                 allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>         };

Using a mux value over a string does not gain us much, other than
smaller driver code, since all the strings are gone, and smaller DT,
again no strings. However, if you want some sensible debug output
from the driver, you're going to keep the strings anyway.

The mux values would need to be macros defined in some header file,
instead of raw values which are hard to understand.

That's only half of it. The driver should know what pins are available
and which mux values can be used for them. So you'd still need a table
of some sort. That means it's unlikely you can have a generic driver.
Leaking the internals into the DT is not a good way either.

The current approach of a generic driver library and SoC specific
tables maybe isn't the best approach, but it is easy enough to add new
SoC support.


Regards
ChenYu

> Would it make sense that I sit down and prototype such a driver?
>
> We should keep compatibility with older DTs by keeping the existing
> drivers in (or maybe emulating the current behaviour by providing just
> those tables as a fallback) , but newer SoCs (like the A64?) would not
> need a SoC specific driver, but just go with that generic driver and
> appropriate DT properties.
>
> I appreciate any comments on this, especially if I missed something
> which would render this approach impossible or tedious.
>
> Cheers,
> Andre.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
