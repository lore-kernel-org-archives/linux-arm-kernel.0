From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Dec 2016 16:08:13 +0100
Subject: [linux-sunxi] sunxi-ng clocks: leaving certain clocks alone?
In-Reply-To: <4e6ddb18-0686-1639-544c-c02371331d3c@arm.com>
References: <d70f2809-102c-a3de-c77c-43af27bbcbbc@arm.com>
 <CAGb2v67kCAr6Ty5=Gg8vOGNC6xhuRM66Wa=H+C3AD=_d_H+N8w@mail.gmail.com>
 <4e6ddb18-0686-1639-544c-c02371331d3c@arm.com>
Message-ID: <20161213150813.uq6megq24nmaircc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 12, 2016 at 12:16:07PM +0000, Andre Przywara wrote:
> Hi Chen-Yu,
> 
> thanks for the answer!
> 
> On 12/12/16 04:41, Chen-Yu Tsai wrote:
> > On Mon, Dec 12, 2016 at 7:54 AM, Andr? Przywara <andre.przywara@arm.com> wrote:
> >> Hi,
> >>
> >> I was observing that the new sunxi-ng clock code apparently explicitly
> >> turns off _all_ clocks that are not used or needed. I find this rather
> >> unfortunate, as I wanted to use the THS temperature sensor from ARM
> >> Trusted Firmware to implement emergency shutdown or DVFS throttling.
> >> That works until the clock framework finds the clock (as enumerated in
> >> ccu-sun50i-a64.c) and obviously explicitly clears bit 31 in the THS mod
> >> clock register and bit 8 in the respective clock gate register.
> >> Turning them manually back on via /dev/mem or removing the THS clock
> >> from the sunxi-ng driver fixes this for me.
> >>
> >> This was not happening with the old Allwinner clocks, since the kernel
> >> wouldn't even know about it if there was no driver and the clock wasn't
> >> mentioned in the DT.
> >>
> >> Now with sunxi-ng even though the THS clock is not actually referenced
> >> or used in the DT, the kernel turns it off. I would expect that upon
> >> entering the kernel all unneeded clocks are turned off anyway, so there
> >> is no need to mess with clocks that have no user, but are enumerated in
> >> the ccu driver.
> > 
> > I can't say that's absolutely true (wink).
> > 
> >>
> >> I wonder if this kills simplefb as well, for instance, since I believe
> >> that U-Boot needs to turn on certain clocks and relies on them staying up.
> > 
> > The simplefb bindings takes clocks and regulators expressly for the
> > purpose of keeping them enabled.
> 
> Right, I should have checked this before ...
> 
> >>
> >> So my questions:
> >> 1) Is this expected behaviour?
> > 
> > Yes.
> > 
> >> 2) If yes, should it really be?
> >> 3) If yes, shouldn't there be way to explicitly tell Linux to leave that
> >> clock alone, preferably via DT? Although the sunxi-ng clocks take
> >> control over the whole CCU unit, I wonder if it should really mess with
> >> clocks there are not referenced in the DT.
> > 
> > As it owns the whole CCU unit, why not? And how would it know if some
> > clock is referenced or not, unless going through the whole device tree?
> 
> I was hoping that it just provides clocks to any users (drivers) and
> wouldn't bother with tinkering with every clock unless explicitly being
> asked for (by a driver being pointed to a specific clock through DT).
> So it would need to iterate through anything - neither the whole DT nor
> it's own list of clocks.
> 
> > Furthermore, nothing prevents another device driver from referencing
> > said clock and turning it off when it's not in use. Think THS driver
> > with runtime PM.
> 
> I am totally OK with that: Any potential Linux THS driver can take over,
> if the DT references this device and the clock.
> My point is that atm there is no such driver and so the clocks framework
> shouldn't turn that clock off.

You could turn that exact argument the other way though. If there's no
user in the system, why should we waste power and leave it enabled?

> > Are you also mapping the THS to secure only? Otherwise nothing would
> > prevent Linux from also claiming it.
> 
> Unfortunately the THS is always unsecure. And even if it could be
> switched, after a recent IRC discussion I came to believe that those
> secure peripherals features only works when the secure boot feature is
> used, which requires to blow an efuse and thus is not easily doable on
> most boards and also irreversible.
> Also I am not sure whether this security feature actually extends to the
> mod clocks and the bus reset and clock gates bits.
> 
> But I was relying on that Linux doesn't touch hardware that's not
> referenced in the DT, so if firmware uses the THS, any Linux THS node
> would need to go - or the other way around: if there is a Linux THS
> node, firmware backs off.

It's not just about node though, but also based on the kernel
configuration. If the kernel didn't have a THS driver compiled (or not
loaded), then if you want to implement such a behaviour, you should
also keep the THS driver in the firmware.

> >> Maybe there is some way to reference those clocks via some dummy driver
> >> or DT node to avoid this behaviour? Is there any prior art in this respect?
> > 
> > If you want a clock to not be disabled by anyone, adding CLK_IS_CRITICAL
> > to its flags is the proper option. This is done in the clk driver though.
> 
> Yes, I was thinking about that, but it indeed sounds like a hack to
> follow this.

You also have the option to add a clock-critical property.

Keep in mind that just preventing it from shutting down at boot gives
no warranty that the clock will remain enabled. Other clocks in the
same sub-tree might do a reparenting or a disable that would lead to
that clock being modified or disabled too as a side effect.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/b593fc31/attachment.sig>
