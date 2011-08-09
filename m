From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 9 Aug 2011 11:33:05 -0700
Subject: Tegra pinmux Device Tree support
In-Reply-To: <CAOesGMgONkY2i+1H+zZ2MJSDnPmFT8AnSjDQxJGaQZvVCExm2A@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF049F17229E@HQMAIL01.nvidia.com>
	<CAOesGMgONkY2i+1H+zZ2MJSDnPmFT8AnSjDQxJGaQZvVCExm2A@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04A0687334@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Tuesday, August 09, 2011 11:35 AM:
> On Mon, Aug 8, 2011 at 2:42 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > Grant, Linus, & all,
> >
> > I was thinking of adding some Device Tree support to Tegra's existing
> > pinmux driver. This would remove the dependence of mach-tegra/board-dt.c
> > on board-{harmony,seaboard}-pinmux.c, and make the DT board stand on its
> > own.
> >
> > My thoughts were:
> >
> > a) Every Tegra board currently has a board-$name-pinmux.c which contains
> > a table like:
> >
> > static struct tegra_pingroup_config harmony_pinmux[] = {
> > ? ? ? ?{TEGRA_PINGROUP_ATA, ? TEGRA_MUX_IDE, ? ? ? ? ? TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_NORMAL},
> >
> > I'd just move that table into the Device Tree, keeping logically the same
> > structure, but just changing the syntax as appropriate for DT.
> >
> > (I'm slightly worried that DT wants me to encode all that using an
> > unformatted table consistent of integers without any pre-processor macros
> > or named constants though...)
...
> > c) I think the DT binding would not be affected by Linus W's work on a
> > pinctrl API; I see this table as platform data that sets up the initial
> > state of the SoC at boot-time, whereas the pinmux driver is more about
> > drivers dynamically altering the pinmux at run-time. Is this a reasonable
> > assertion? The alternative would be that once the new pinctrl API is
> > available, it would have an associated DT binding that represented this
> > data in a completely cross-SoC manner. Hence, any work on Tegra's pinmux
> > right now would be throwaway. I'm interested in people's thoughts here.
> >
> > Finally, I was thinking that a similar thing could be done for the Tegra
> > GPIO driver, to replace gpio_table[] also in board-*-pinmux.c.
> >
> > If this isn't useful right now, is there anything else that would help
> > out on Tegra?
...
> Some devices/drivers might need to make references to a pinmux (what
> comes to mind is the i2c driver that has two virtual busses on two
> separate multiplexed outputs on some boards). So having a tegra-pinmux
> node with a sub-node for every pin group might get verbose but
> definitely most flexible.

My previous thinking was that:

* We'd invent a new I2C bus mux driver for this purpose, rather than
  building the muxing functionality solely into the Tegra I2C driver
  like it is now.

* The new mux driver would use Linus W's pinctrl API to perform the
  muxing, and hence be generic across SoCs.

* The mux driver would need to be configured based on the pinctrl
  API's (well, the SoC's pinctrl driver's) names for pin groups and
  functions, rather than with something from Device Tree. This would
  allow the mux driver to work on systems that used the pinctrl API,
  but not Device Tree.

However, hooking Device Tree phandles and the pinctrl API together
sounds like it'd be a good idea; allowing the above points to still be
valid, and encompassing your idea. I'm not totally sure how that'd end
up working though; the original pinctrl idea was that the drivers
themselves would drive the names/numbers of the exposed pin groups,
whereas we're talking about driving that all from Device Tree data. That
would require each pingroup to contain e.g. a register address and bit
for each group. And Tegra's pinctrl driver would have all the drive
strength groups too, which are different groups in different registers,
and since all that data is encoded in the SoC HW rather than board-
specific, it seems like there's little benefit putting it into Device
Tree.

> Each sub-node could encode the mux type with separate properties, for
> example for the ata case above:
> 
> .../pinmux/ata:
>     nvidia,pingroup-number = <>
>     nvidia,tristate-normal
>     nvidia,mux-mode = <>   (this should probably be an integer, seems
> appropriate since the TRM uses integers as well)
>     nvidia,pull-up-down-normal

That's pretty verbose. However, it certainly addresses the problems with
a huge table of apparently meaningless numbers. It's probably workable.

> (It could be argued that the 'normal' properties could just be omitted
> and assumed)
> 
> 'reg' could be used to specify the pingroup-number, I suppose -- but
> omitting that means that you can have two entries for the same
> pingroup, and mark one as inactive, so it can also be referenced with
> a phandle.
> 
> This way the i2c virtual busses could just refer to the pingroup by
> phandle for the mux flipping, with one of them being enabled by
> default and the others inactive.
> 
> 
> Thoughts?
> 
> -Olof

-- 
nvpublic
