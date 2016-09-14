From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 14 Sep 2016 12:02:40 -0700
Subject: [GIT PULL] Amlogic driver updates for v4.9, 2nd round
Message-ID: <7hoa3ql2y7.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Below is the 2nd round of driver updates for Amlogic SoCs.  All patches
have acks from appropriate maintainers.

There is a dependency on the immutable clk-meson-gxbb branch of the
clock tree, which is merged into this branch.  The reason is that clock
maintainers wanted me to start taking the simple patcches that just
expose clock IDs for use by DT files.

Due to the dependency, I recommend adding this to next/late so it will
go upstream after the clock dependencies.

I'll also have a round of dt64 changes coming shortly that depend on
this branch (due to the clock IDs.)

Kevin


The following changes since commit ad855eae6caf0d1dd17bce5bcd8e07759adc9903:

  nvmem: amlogic: Add Amlogic Meson EFUSE driver (2016-09-01 14:24:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-drivers-2

for you to fetch changes up to dfdd7d4af6ebee027be7bf2636b2314937948da6:

  clk: gxbb: expose i2c clocks (2016-09-14 11:24:04 -0700)

----------------------------------------------------------------
Amlogic driver updates for v4.9, 2nd round
- media: update IR support for newer SoCs
- firmware: add secure monitor driver
- net: new stmmac glue driver
- usb: udd DWC2 support for meson-gxbb
- clocks: expose more clock IDs for use by DT
- DT binding updates

----------------------------------------------------------------
Alexander M?ller (6):
      clk: meson: Rename meson8b-clkc.c to reflect gxbb naming convention
      meson: clk: Move register definitions to meson8b.h
      meson: clk: Rename register names according to Amlogic datasheet
      clk: meson: Copy meson8b CLKID defines to private header file
      gxbb: clk: Adjust MESON_GATE macro to be shared with meson8b
      meson: clk: Add support for clock gates

Jerome Brunet (3):
      usb: dwc2: add support for Meson8b and GXBB SoCs
      clk: gxbb: expose spifc clock
      clk: gxbb: expose i2c clocks

Joachim Eastwood (1):
      stmmac: introduce get_stmmac_bsp_priv() helper

Kevin Hilman (2):
      clk: gxbb: add MMC gate clocks, and expose for DT
      Merge branch 'clk-meson-gxbb' of git://git.kernel.org/.../clk/linux into v4.8/drivers

Martin Blumenstingl (6):
      net: dt-bindings: Document the new Meson8b and GXBB DWMAC bindings
      net: stmmac: add a glue driver for the Amlogic Meson 8b / GXBB DWMAC
      net: stmmac: update the module description of the dwmac-meson driver
      Documentation: dt-bindings: Add documentation for the Meson USB2 PHYs
      clk: gxbb: expose MPLL2 clock for use by DT
      clk: gxbb: expose USB clocks

Michael Turquette (1):
      Merge remote-tracking branch 'clk/clk-meson-gxbb-ao' into clk-meson-gxbb

Neil Armstrong (3):
      dt-bindings: clock: reset: Add GXBB AO Clock and Reset Bindings
      clk: meson: Add GXBB AO Clock and Reset controller driver
      clk: meson-gxbb: Export PWM related clocks for DT

Wei Yongjun (1):
      clk: meson: Fix invalid use of sizeof in gxbb_aoclkc_probe()

 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt |  45 ++++++++++++
 Documentation/devicetree/bindings/net/meson-dwmac.txt           |  45 +++++++++---
 Documentation/devicetree/bindings/phy/meson-usb2-phy.txt        |  27 ++++++++
 Documentation/devicetree/bindings/usb/dwc2.txt                  |   2 +
 drivers/clk/meson/Makefile                                      |   4 +-
 drivers/clk/meson/clkc.h                                        |   2 +-
 drivers/clk/meson/gxbb-aoclk.c                                  | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.c                                        | 171 +++++++++++++++++++++++----------------------
 drivers/clk/meson/gxbb.h                                        |  31 +++++----
 drivers/clk/meson/{meson8b-clkc.c => meson8b.c}                 | 293 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/clk/meson/meson8b.h                                     | 151 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig                     |   6 +-
 drivers/net/ethernet/stmicro/stmmac/Makefile                    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c               |   4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c             | 324 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h           |   8 +++
 drivers/usb/dwc2/platform.c                                     |  34 +++++++++
 include/dt-bindings/clock/gxbb-aoclkc.h                         |  66 ++++++++++++++++++
 include/dt-bindings/clock/gxbb-clkc.h                           |  16 +++++
 include/dt-bindings/clock/meson8b-clkc.h                        |   2 -
 include/dt-bindings/reset/gxbb-aoclkc.h                         |  66 ++++++++++++++++++
 21 files changed, 1346 insertions(+), 144 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
 create mode 100644 drivers/clk/meson/gxbb-aoclk.c
 rename drivers/clk/meson/{meson8b-clkc.c => meson8b.c} (51%)
 create mode 100644 drivers/clk/meson/meson8b.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
 create mode 100644 include/dt-bindings/clock/gxbb-aoclkc.h
 create mode 100644 include/dt-bindings/reset/gxbb-aoclkc.h
