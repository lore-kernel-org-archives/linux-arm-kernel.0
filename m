From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 27 Sep 2017 20:11:32 +0200
Subject: [GIT PULL v2] Rockchip dts64 Fixes for 4.14
In-Reply-To: <6990785.aOlALvEuSf@phil>
References: <6990785.aOlALvEuSf@phil>
Message-ID: <2709130.jIo7eQHvkl@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below three fixes for 64bit Rockchip devicetrees.

As the tag explains the main change is the revert of the rk3368 opp
addition, as this cannot safely run on current rk3368 boards and thus
shouldn't make a kernel release.


Please pull, thanks
Heiko

changes in v2:
- remove left over half-sentence at the end of the tag message
- add rk3399 mipi dsi grf-clock reference (part of the binding already
  and of course needed on rk3399)


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.14-rockchip-dts64fixes-1

for you to fetch changes up to 0bc15d85d97d44e8979ff91d0c1fbafe6fd4172c:

  arm64: dts: rockchip: add the grf clk for dw-mipi-dsi on rk3399 (2017-09-26 15:59:17 +0200)

----------------------------------------------------------------
Adding the operating points on rk3368 like they were did not end up well
for the boards as all of them are missing their cpu supplies, the OPPs
actually need to follow the <target min max> format as the regulator is
shared between both clusters and the one rk3368 board I have, somehow also
doesn't like the higher opps at all - all of which I only realized after
I brought my rk3368 board online again, after its bootloader broke.
So we revert that OPP addition for now.

And also two fixes for the mipi dsi controller on rk3399, which was
referencing a clock to high up in the clock-tree so that an intermediate
gate could be disabled inadvertently and also needs a clock for its area
in the general register files of the rk3399 soc.

----------------------------------------------------------------
Heiko Stuebner (1):
      Revert "arm64: dts: rockchip: Add basic cpu frequencies for RK3368"

Nickey Yang (2):
      arm64: dts: rockchip: Correct MIPI DPHY PLL clock on rk3399
      arm64: dts: rockchip: add the grf clk for dw-mipi-dsi on rk3399

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 72 +-------------------------------
 arch/arm64/boot/dts/rockchip/rk3399.dtsi |  6 +--
 2 files changed, 5 insertions(+), 73 deletions(-)
