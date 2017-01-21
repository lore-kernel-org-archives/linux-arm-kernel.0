From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 Jan 2017 01:10:38 +0100
Subject: [GIT PULL 1/3] Rockchip driver updates for 4.11 part1
Message-ID: <6458001.3c0YmcoF8y@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below some rockchip-specific soc-driver updates for 4.11.
It is based on 4.10-rc2 due to the bug in 4.10-rc1 that caused the whole
arm64 to not build.

The grf-thingy has been on the lists in some iterations and as the tag
message says is really only ever meant for stuff that really fits nowhere
else but can also not be set in firmware in a sane way.

So if there are no complaints, please pull.


Thanks
Heiko


The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.11-armsoc-drivers1

for you to fetch changes up to 19f0f3021e7532a1056886e3ddf524f9847e4f15:

  ARM: rockchip: drop rk3288 jtag/mmc switch handling (2017-01-06 10:29:16 +0100)

----------------------------------------------------------------
Some extensions to the power-domain driver to support domains in
hiword registers (write-mask in upper 16bit) and domain-definitions
for the rk3328 soc.

Secondly a "driver" that attaches to the already existing grf nodes
and is able to set static defaults for settings that cannot really
be attached to any specific subsystem.
Most GRF settings can already be set from drivers using them, but there
are some behavioural settings like the mmc/jtag switch that cannot.

As the commit message states this is really meant as a last line
of defence for things that neither belong to a subsystem nor to the

Having this here allows arm64 socs to have this as well and also
moves another bit of code out of the arm32 mach-rockchip.

----------------------------------------------------------------
Elaine Zhang (4):
      soc: rockchip: power-domain: Support domain control in hiword-registers
      dt-bindings: power: add RK3328 SoCs header for idle-request
      dt-bindings: add binding for rk3328 power domains
      soc: rockchip: power-domain: add power domain support for rk3328

Heiko Stuebner (4):
      Merge branch 'v4.11-shared/pdids' into v4.11-armsoc/drivers
      dt-bindings: add used but undocumented rockchip grf compatible values
      soc: rockchip: add driver handling grf setup
      ARM: rockchip: drop rk3288 jtag/mmc switch handling

 .../devicetree/bindings/soc/rockchip/grf.txt       |   4 +
 .../bindings/soc/rockchip/power_domain.txt         |   3 +
 arch/arm/mach-rockchip/rockchip.c                  |  12 --
 drivers/soc/rockchip/Kconfig                       |  10 ++
 drivers/soc/rockchip/Makefile                      |   1 +
 drivers/soc/rockchip/grf.c                         | 134 +++++++++++++++++++++
 drivers/soc/rockchip/pm_domains.c                  |  63 +++++++++-
 include/dt-bindings/power/rk3328-power.h           |  18 +++
 8 files changed, 227 insertions(+), 18 deletions(-)
 create mode 100644 drivers/soc/rockchip/grf.c
 create mode 100644 include/dt-bindings/power/rk3328-power.h
