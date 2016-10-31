From: olof@lixom.net (Olof Johansson)
Date: Mon, 31 Oct 2016 15:39:05 -0700
Subject: [GIT PULL] i.MX fixes for 4.9
In-Reply-To: <20161024140622.GM30578@tiger>
References: <20161024140622.GM30578@tiger>
Message-ID: <CAOesGMhSHqs_WfxkdUn7yrT_9g1CO1cqXGzQ2Y1Y-+-tY1KNmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio,

I've got multi_v7 booting now, but imx_v6_v7 is still broken on both
hummingboard and wandboard.

Hummingboard doesn't even output anything on serial during boot, bug
with DEBUG_LL I got some more info

(No output boot at
http://arm-soc.lixom.net/bootlogs/mainline/v4.9-rc3/hummingboard-arm-imx_v6_v7_defconfig.html,
not very useful).

This one seems to be due to CONFIG_PCI_IMX6, which is off on
multi_v7_defconfig. Hard hang(?), last output is:

[    0.490643] OF: PCI: host bridge /soc/pcie at 0x01000000 ranges:
[    0.496540] OF: PCI:   No bus range found for /soc/pcie at 0x01000000,
using [bus 00-ff]
[    0.504512] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.510559] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000



Wandboard, has a peculiar MMC error. First I thought it was just the
card going bad, but now I'm not so sure since multi_v7 boots just fine
on the same hardware:

http://arm-soc.lixom.net/bootlogs/mainline/v4.9-rc3/wandboard-arm-imx_v6_v7_defconfig.html

Not sure what's going on here, since bisecting between two configs is
a pain. When I disabled CONFIG_PCI, the error seems to be less likely
to happen (some boots succeed, sometimes it happens later during
boot).


-Olof

On Mon, Oct 24, 2016 at 7:06 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
>
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.9
>
> for you to fetch changes up to 4edd601c5a9c5094daa714e65063e623826f3bcc:
>
>   ARM: imx: mach-imx6q: Fix the PHY ID mask for AR8031 (2016-10-24 21:26:01 +0800)
>
> ----------------------------------------------------------------
> The i.MX fixes for 4.9:
>  - A couple of patches from Fabio to fix the GPC power domain regression
>    which is caused by PM Domain core change 0159ec670763dd
>    ("PM / Domains: Verify the PM domain is present when adding a
>    provider"), and a related kernel crash seen with multi_v7_defconfig
>    build.
>  - Correct the PHY ID mask for AR8031 to match phy driver code.
>  - Apply new added timer erratum A008585 for LS1043A and LS2080A SoC.
>  - Correct vf610 global timer IRQ flag to avoid warning from gic driver
>    after commit 992345a58e0c ("irqchip/gic: WARN if setting the
>    interrupt type for a PPI fails").
>
> ----------------------------------------------------------------
> Fabio Estevam (3):
>       ARM: imx: gpc: Initialize all power domains
>       ARM: imx: gpc: Fix the imx_gpc_genpd_init() error path
>       ARM: imx: mach-imx6q: Fix the PHY ID mask for AR8031
>
> Scott Wood (1):
>       arm64: dts: Add timer erratum property for LS2080A and LS1043A
>
> Stefan Agner (1):
>       ARM: dts: vf610: fix IRQ flag of global timer
>
>  arch/arm/boot/dts/vf500.dtsi                   |  2 +-
>  arch/arm/mach-imx/gpc.c                        | 15 ++++++++++++---
>  arch/arm/mach-imx/mach-imx6q.c                 |  2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  1 +
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |  1 +
>  5 files changed, 16 insertions(+), 5 deletions(-)
