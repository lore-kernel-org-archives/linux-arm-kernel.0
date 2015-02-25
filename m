From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Feb 2015 17:10:49 +0100
Subject: [PATCH 2/4] i2c: sunxi: Add Reduced Serial Bus (RSB) DT bindings
 documentation
In-Reply-To: <CAGb2v675oV60cont4JPX0Cy-5oaqXSz+74kC4JFeJYja6SSV+A@mail.gmail.com>
References: <1424773744-15106-1-git-send-email-wens@csie.org>
 <16025407.hQRFhlbHKD@wuerfel>
 <CAGb2v675oV60cont4JPX0Cy-5oaqXSz+74kC4JFeJYja6SSV+A@mail.gmail.com>
Message-ID: <2832810.NHVTmhf5rK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 22:32:57 Chen-Yu Tsai wrote:
> On Tue, Feb 24, 2015 at 10:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 24 February 2015 22:01:26 Chen-Yu Tsai wrote:
> >> On Tue, Feb 24, 2015 at 6:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Tuesday 24 February 2015 18:29:02 Chen-Yu Tsai wrote:
> >> >>
> >> >> +       rsb at 01f03400 {
> >> >> +               compatible = "allwinner,sun8i-a23-rsb";
> >> >> +               reg = <0x01f03400 0x400>;
> >> >> +               interrupts = <0 39 4>;
> >> >> +               clocks = <&apb0_gates 3>;
> >> >> +               clock-frequency = <3000000>;
> >> >> +               resets = <&apb0_rst 3>;
> >> >> +
> >> >> +               axp223: pmic at 2d {
> >> >> +                       compatible = "x-powers,axp223", "x-powers,axp221";
> >> >> +                       reg = <0x2d>;
> >> >> +                       allwinner,rsb-hw-addr = <0x3e3>;
> >> >> +
> >> >> +                       /* ... */
> >> >> +               };
> >> >> +       };
> >>
> >> > I don't really understand the need for having two addresses (runtime
> >> > and hardware). Could the runtime address be configured at runtime?
> >>
> >> You can, though the driver doesn't support this. I don't think the
> >> I2C subsystem allows arbitrary device insertion during normal
> >> operation, but maybe i2c-dev? I've tried using different addresses
> >> for devices so they do get changed during the probe phase, just
> >> to be sure that the code works, and it's not just sitting at
> >> the address the bootloader used.
> >>
> >> In any case, the distinction is more like burnt-in or hardwired
> >> addresses vs software configurable addresses.
> >
> > The simplest binding would the probably be to only put the
> > hardware address into the 'reg' property and always assign the
> > logical addresses dynamically.
> >
> > Would that add a lot of complexity or does it have any other
> > downsides?
> 
> The hardware address is 12 bits wide. Any address higher than
> 0x3ff will be rejected by the I2C core. The AC100 is at 0xe89.
> 
> Assigning addresses dynamically means the driver has to keep
> a lookup table to map the hardware address to the logical
> address to issue the command to.
> 
> There's also the issue of dynamically assigned address colliding
> with unlisted devices, though I think this would only happen in
> the development / bring up phase of the device.
> 
> I think the first issue pretty much rules out putting the
> hardware address into 'reg'.
> 
> Putting the logical address in the 'reg' property allows the
> user to poke unlisted devices using i2c-tools, though this
> is not so useful to the average user.

Ok, fair enough. Your approach seems reasonable then, but it
might be helpful to add your explanation to the changelog of the
patch that introduces the binding.

	Arnd
