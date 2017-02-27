From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 27 Feb 2017 06:30:08 +0100
Subject: [PATCH v2 2/3] soc: rockchip: add driver handling grf setup
In-Reply-To: <CAOesGMj_RdxVDzirT97KLkXRsyVcFh3Z8jZLNjn0ehAv0Qhmhg@mail.gmail.com>
References: <20161115223900.30728-1-heiko@sntech.de> <7144543.znLMLUJXpB@phil>
 <CAOesGMj_RdxVDzirT97KLkXRsyVcFh3Z8jZLNjn0ehAv0Qhmhg@mail.gmail.com>
Message-ID: <2206970.JAebETMOV6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

sorry that took way longer than I expected, I was slightly swamped the last 
days with general work and the travel to Portland.

Am Sonntag, 29. Januar 2017, 16:41:46 CET schrieb Olof Johansson:
> On Sun, Jan 29, 2017 at 3:36 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> > Am Sonntag, 29. Januar 2017, 14:40:53 CET schrieb Olof Johansson:
> >> On Tue, Nov 15, 2016 at 2:38 PM, Heiko Stuebner <heiko@sntech.de> wrote:

[...]

> >> Would it be possible to describe this directly in the DT instead? If
> >> nothing else, something like
> >> 
> >> function-regs = < array of regs >
> >> function-values = < array of values >
> >> function-names = < array of names >
> >> 
> >> Not ideal either, especially if abused into a random poke table, but
> >> it won't require per-SoC changes to the kernel. If we keep the binding
> >> under close eyes we can hopefully avoid abuse.
> >> 
> >> Given that Rockchip is still working on new SoCs, this list will just
> >> grow and doing it in-kernel will stop scaling at some point.
> > 
> > As explained in the commit message, this is meant as a last resort for
> > settings that no driver can be responsible for in a sensible way and that
> > are Linux-specific and thus cannot be set in firmware for everybody. Most
> > GRF- specific settings are already done by the specific drivers needing
> > them.
> > 
> > I.e. you see the mmc/jtag thing, which is getting disabled because the
> > Linux mmc subsystem gets a hickup if the pinmux is changed by the soc to
> > early after card eject. Other OSes might like that behaviour.
> > 
> > As the dts is meant to be for everyone I don't see how that could be
> > sanely
> > defined for things.
> 
> But every OS that wants to use JTAG instead of MMC, or enable JTAG
> around MMC, will need to know about this setting, right? So we're not
> necessarily leaking linux implementation details into the DT here.
> Whether each OS applies the setting is up to them.

The issue with this specific setting is that the soc wants to be more 
intelligent than the kernel :-)
It makes the soc switch pin-muxes automatically between mmc and jtag depending 
on the card-detect status - circumventing pinctrl completely and killing the 
our mmc subsystem in the process.

You can of course still select jtag pinmuxes using the regular linux pinctrl 
subsystem. But as I said, other systems might like that functionality for 
whatever reason.


Describing the value (and others) in the dt creates the issue, that the driver 
code still needs to have a list of "we as Linux want to set the jtag-property 
but not other-property-y" and so on and would therefore rely on the function 
being stable over multiple socs, as otherwise we may end up with function-
names "mmc-jtag-rk3288", ... as the GRF and its contents are notorious 
unpredictable :-) .


> > Another option would be to burden the rockchip mmc-driver with that
> > specific setting, but then the mmc-driver (and possible other drivers if
> > needed) would need per-soc additions, resulting in the same scaling
> > problem.
> > Having one per-soc list at least keeps in one place :-) .
> 
> That's exactly what I'm looking to avoid -- i.e. I don't want the GRF
> driver to need patching for every SoC either, if we can avoid it.
> 
> Once the list gets too long, you'll want to add #ifdef SOCNAME and
> only build in the tables for some of the SoCs. And then we've all lost
> 
> :-)

Right now we don't have any SOCNAME stuff. It's in the back of my mind because 
we're currently also compiling for example all clock drivers for all 
ARCH_ROCKCHIP socs, so it might make sense to split that up a bit, so people 
will be able to limit kernel size if they like to.

But one thing I stumbled upon is that while some arm32 socs do have per-soc 
kconfig entries, there does not seem to be anything like this on arm64 yet.

Is there a plan stated somewhere already on how this should be handled?
I.e. introducing SOC_RK3399 (or similar) or having separate CLK_RK3399, 
GRF_RK3399 (or similar) symbols that all need to be disabled separately if 
desired.

As stated in the original commit message, the list of settings in there is not 
supposed to get "long", but that may or may not be wishful thinking on my part 
;-) .

> Or, if you're firmly deciding to keep updating kernel code for all
> SoCs, could also just add one platform quirk file in
> drivers/soc/rockchip with the postcore_initcall that matches toplevel
> compatible per SoC, finds the device node, maps the address range,
> sets the value.
> 
> That'll give you a place for other platform quirks, if they ever come
> up. In one place, even if the other quirks might be in other register
> ranges.

I would very much prefer going this route, as I really don't trust the GRF to 
keep conforming to any devicetree binding (or anything at all) and this way, 
stuff is completely reversable / redoable if the need arises (hopefully not) 
and we don't have to live with an inadequate bindings forever :-) .


> > If you really dislike the current approach, we can of course postpone it
> > for now though.
> 
> It's a bit bikesheddy, but it just seems like adding a driver that
> will always need updates is a bit of a heavy solution.

It's not the only one though, needing per soc updates.

Closed neighbour is probably the io-domain handling in [0], whose binding I 
really like, as it hides the the GRF-shenanigans nicely and only exposes the 
actual supplies.

So yes, I'd like to keep it codified, but we can split that up on a per-soc 
basis as you suggested.


Heiko


[0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/
drivers/power/avs/rockchip-io-domain.c
