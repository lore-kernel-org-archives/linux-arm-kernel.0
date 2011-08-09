From: olof@lixom.net (Olof Johansson)
Date: Tue, 9 Aug 2011 10:35:28 -0700
Subject: Tegra pinmux Device Tree support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049F17229E@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF049F17229E@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMgONkY2i+1H+zZ2MJSDnPmFT8AnSjDQxJGaQZvVCExm2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2011 at 2:42 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Grant, Linus, & all,
>
> I was thinking of adding some Device Tree support to Tegra's existing
> pinmux driver. This would remove the dependence of mach-tegra/board-dt.c
> on board-{harmony,seaboard}-pinmux.c, and make the DT board stand on its
> own.
>
> My thoughts were:
>
> a) Every Tegra board currently has a board-$name-pinmux.c which contains
> a table like:
>
> static struct tegra_pingroup_config harmony_pinmux[] = {
> ? ? ? ?{TEGRA_PINGROUP_ATA, ? TEGRA_MUX_IDE, ? ? ? ? ? TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_NORMAL},
>
> I'd just move that table into the Device Tree, keeping logically the same
> structure, but just changing the syntax as appropriate for DT.
>
> (I'm slightly worried that DT wants me to encode all that using an
> unformatted table consistent of integers without any pre-processor macros
> or named constants though...)
>
> b) I'd probably need to modify the pinmux driver to be a platform device
> in order to simplify integration with DT parsing etc.
>
> c) I think the DT binding would not be affected by Linus W's work on a
> pinctrl API; I see this table as platform data that sets up the initial
> state of the SoC at boot-time, whereas the pinmux driver is more about
> drivers dynamically altering the pinmux at run-time. Is this a reasonable
> assertion? The alternative would be that once the new pinctrl API is
> available, it would have an associated DT binding that represented this
> data in a completely cross-SoC manner. Hence, any work on Tegra's pinmux
> right now would be throwaway. I'm interested in people's thoughts here.
>
> Finally, I was thinking that a similar thing could be done for the Tegra
> GPIO driver, to replace gpio_table[] also in board-*-pinmux.c.
>
> If this isn't useful right now, is there anything else that would help
> out on Tegra?


This sounds similar to what I had in mind to look at when I got back
from vacation (not enough rainy days here to deal with it during :).

Some devices/drivers might need to make references to a pinmux (what
comes to mind is the i2c driver that has two virtual busses on two
separate multiplexed outputs on some boards). So having a tegra-pinmux
node with a sub-node for every pin group might get verbose but
definitely most flexible.

Each sub-node could encode the mux type with separate properties, for
example for the ata case above:

.../pinmux/ata:
    nvidia,pingroup-number = <>
    nvidia,tristate-normal
    nvidia,mux-mode = <>   (this should probably be an integer, seems
appropriate since the TRM uses integers as well)
    nvidia,pull-up-down-normal

(It could be argued that the 'normal' properties could just be omitted
and assumed)

'reg' could be used to specify the pingroup-number, I suppose -- but
omitting that means that you can have two entries for the same
pingroup, and mark one as inactive, so it can also be referenced with
a phandle.

This way the i2c virtual busses could just refer to the pingroup by
phandle for the mux flipping, with one of them being enabled by
default and the others inactive.


Thoughts?

-Olof
