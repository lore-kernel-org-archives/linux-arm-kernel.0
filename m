From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Feb 2015 15:17:51 +0100
Subject: [PATCH 2/4] i2c: sunxi: Add Reduced Serial Bus (RSB) DT bindings
 documentation
In-Reply-To: <CAGb2v66ru6Yurt1CFn-zocAuqen8GWSm8y9dHRf=-OOcc-DR7g@mail.gmail.com>
References: <1424773744-15106-1-git-send-email-wens@csie.org>
 <9851276.8ZCd3XfZle@wuerfel>
 <CAGb2v66ru6Yurt1CFn-zocAuqen8GWSm8y9dHRf=-OOcc-DR7g@mail.gmail.com>
Message-ID: <16025407.hQRFhlbHKD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 22:01:26 Chen-Yu Tsai wrote:
> On Tue, Feb 24, 2015 at 6:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 24 February 2015 18:29:02 Chen-Yu Tsai wrote:
> >>
> >> +       rsb at 01f03400 {
> >> +               compatible = "allwinner,sun8i-a23-rsb";
> >> +               reg = <0x01f03400 0x400>;
> >> +               interrupts = <0 39 4>;
> >> +               clocks = <&apb0_gates 3>;
> >> +               clock-frequency = <3000000>;
> >> +               resets = <&apb0_rst 3>;
> >> +
> >> +               axp223: pmic at 2d {
> >> +                       compatible = "x-powers,axp223", "x-powers,axp221";
> >> +                       reg = <0x2d>;
> >> +                       allwinner,rsb-hw-addr = <0x3e3>;
> >> +
> >> +                       /* ... */
> >> +               };
> >> +       };
> 
> > I don't really understand the need for having two addresses (runtime
> > and hardware). Could the runtime address be configured at runtime?
> 
> You can, though the driver doesn't support this. I don't think the
> I2C subsystem allows arbitrary device insertion during normal
> operation, but maybe i2c-dev? I've tried using different addresses
> for devices so they do get changed during the probe phase, just
> to be sure that the code works, and it's not just sitting at
> the address the bootloader used.
> 
> In any case, the distinction is more like burnt-in or hardwired
> addresses vs software configurable addresses.

The simplest binding would the probably be to only put the
hardware address into the 'reg' property and always assign the
logical addresses dynamically.

Would that add a lot of complexity or does it have any other
downsides?

	arnd
