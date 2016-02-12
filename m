From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 12 Feb 2016 19:51:13 +0100
Subject: [linux-sunxi] [RFC PATCH 0/4] clk: sunxi: fix DT compatibility
 issues
In-Reply-To: <1455300000-18723-1-git-send-email-andre.przywara@arm.com>
References: <1455300000-18723-1-git-send-email-andre.przywara@arm.com>
Message-ID: <56BE29A1.3060107@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

So far I've stayed out of this discussion, but now I feel I have to
weigh in:

There is no need for this series, device-tree compatibility for
sunxi devices is a non issue. No devices ship with dtb files as
part of the bootloader / firmware (the vendor kernels do not
use dtb at all).

So we always are using a dtb from the kernel tree, and both Fedora
and Debian (AFAIK), the 2 distros which ship with more or less official
sunxi support package things so that each kernel version uses the dtb
files compiled from the dts shipped with that exact kernel version,
(through the ftddir directive in extlinux.conf, which is per menu
entry / kernel version) even if multiple kernel versions are installed.

So there is no reason, no reason at all to worry too much about dtb
compatibility for sunxi devices.

As for compatibility with u-boot, u-boot ships with its own embedded
dtb copy, which is based on dts files from the kernel (the u-boot copies
get synced regularly), and even if this dtb were to somehow be replaced
by a new "incompatible" dtb from a newer kernel there would still not
be a problem as u-boot does not (currently) use the clk definitions
from the dtb. Note I'm the u-boot sunxi custodian and I'm fine with
the proposed changes.

TL;DR: NACK for this series.

Regards,

Hans



On 12-02-16 18:59, Andre Przywara wrote:
> Commit f7d372ba54ea ("clk: sunxi: Refactor A31 PLL6 so that it can be
> reused") (in -next) made the A31 PLL6 clock driver more generic, so
> that it can drive the PLL8 clock in newer SoCs too.
> However the patch broke compatibility with older DTs, which this
> series tries to fix.
> The approach chosen here is to bring back the old driver under its
> old name, while letting the new driver using a different name to be
> able to tell them apart.
> The old driver should be somewhat deprecated and not used in new DTs
> anymore.
> The slight disadvantage is that there are now two drivers and two
> compatible names for the same hardware (the PLL6 clock), I am not
> sure if this is frowned upon or can be tolerated since the new driver
> is more generic (drives PLL8 as well) and makes the old one obsolete.
> We just need to keep it for compatibility.
>
> The naming for both the functions and compatible names is probably
> wrong, I am relying on more sunxi - experienced people here to
> suggest better identifiers.
>
> This is only one possible approach to fix this issues, so I am open
> to any kind of discussion.
>
> The series is made on top of Maxime's sunxi/for-next branch, so it
> somehow reverts the change in question. I am happy to rebase it on
> any branch people tell me.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>
> Andre Przywara (4):
>    clk: sunxi: rename new sun6i_a31_pll6 clock to sun6i_a31_pll clock
>    clk: sunxi: re-add old sun6i_a31_pll6 clock
>    clk: sunxi: revert .dtsi changes for DTs with a sun6i_a31_pll6 clock
>    DT: Allwinner H3: fix PLL8 clock
>
>   Documentation/devicetree/bindings/clock/sunxi.txt |  2 +-
>   arch/arm/boot/dts/sun6i-a31.dtsi                  | 36 ++++++++---------
>   arch/arm/boot/dts/sun8i-a23-a33.dtsi              | 25 ++++--------
>   arch/arm/boot/dts/sun8i-a23.dtsi                  |  2 +-
>   arch/arm/boot/dts/sun8i-a33.dtsi                  |  4 +-
>   arch/arm/boot/dts/sun8i-h3.dtsi                   | 31 +++++---------
>   drivers/clk/sunxi/clk-sunxi.c                     | 49 ++++++++++++++++++++---
>   7 files changed, 84 insertions(+), 65 deletions(-)
>
