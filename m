From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Jan 2016 14:10:06 +0100
Subject: reason for Allwinner SoC specific pinctrl drivers?
In-Reply-To: <568A514D.7070102@arm.com>
References: <568A514D.7070102@arm.com>
Message-ID: <20160105131006.GI11722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Mon, Jan 04, 2016 at 11:02:37AM +0000, Andre Przywara wrote:
> Hi,
> 
> while looking at the Allwinner A64 SoC support, I was wondering why we
> would actually need a pinctrl driver (file) for each and every Allwinner
> SoC that we support.

This was actually requested during the initial driver submission
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/136809.html

And I actually came to like it, even though the initial port is indeed
quite painful, for several reasons:

1) In those times, we didn't have a datasheet available for all these
SoCs, so no easy way to find out the value to set in the register to
mux a particular function in. These days are mostly over, but we're
still in that situation for a few SoCs (mostly the R* and H* SoCs
though).

2) It's quite easy to read and debug, at least from the DT PoV. The
pain mostly comes from writing that table in the first place, but the
alternative other SoCs have picked to have something readable in the
DT is a SoC specific header file with the defines of all the functions
availables for all the pins, which is just as painful to write and
review, and is essentialy the same thing.

3) It's easy to maintain. If one of the entry in the table came to be
wrong, we simply have to update the table, it's completely contained
in the kernel itself and doesn't require fixing (and updating) the DT.

4) It allows to catch misconfiguration in the cases where you set a
function on a pin that doesn't support it as well, which is also quite
convenient, and wouldn't be possible at all in the case of a header,
or simply open-coding the value.

> Looking at both the A20 and the A64 doc I don't see any differences
> in the port controller implementation apart from the actual muxval
> <-> subsystem assignment, which is just data, right?

There's also the interrupts over GPIOs that change slightly, the A20
having a single bank and the A64 having several of them.

The interrupt mechanism is quite interesting, since it's also a muxing
option of a given pin, and only a few pins implement that option. On
the A20 and earlier, we had 32 interrupts scattered around the
available pins, on A31 and later, we still have the same mechanism,
this time with multiple banks of 32 interrupts.

We have to have a table somewhere as well to give the mapping a pin
and the interrupt that might be connected to it.

> Comparing the code files in drivers/pinctrl/sunxi seems to support this,
> as those drivers only consist of the table and some boilerplate code.
> 
> Now I was wondering whether we could get away with one generic Allwinner
> pinctrl driver and put the SoC specific pin assignments in DT instead.
> It looks like adding an "allwinner,muxval" property in addition to the
> existing "allwinner,function" in the SoC's .dtsi would give us all the
> information we need. This could look like:
> 
> 	uart0_pins_a: uart0 at 0 {
> 		allwinner,pins =   "PB22", "PB23";
> +		allwinner,muxval = <0x02    0x02>;
> 		allwinner,function = "uart0";
> 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> 	};
> 
> Would it make sense that I sit down and prototype such a driver?
> 
> We should keep compatibility with older DTs by keeping the existing
> drivers in (or maybe emulating the current behaviour by providing just
> those tables as a fallback) , but newer SoCs (like the A64?) would not
> need a SoC specific driver, but just go with that generic driver and
> appropriate DT properties.

I guess in the such a case you wouldn't need the function string at
all then?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160105/27733273/attachment.sig>
