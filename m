From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Thu, 31 Jul 2014 18:28:03 -0300
Subject: [PATCH 0/9] Audio clocks for sun[457]i, SoC revision detection
Message-ID: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

As part of my ongoing GSoC project effort, I did some work on the clock
code we're going to need for the audio blocks. This series adds support for
PLL2 on A10, A10S, A13 and A20. It also includes support for the codec
clock as well as module 1 clocks, used in the audio blocks.

To achieve this, we also need to implement SoC revision detection,
as the PLL2 clock is different on A10 revision A. As discussed on the
RFC series, we achieve this by detecting the revision during runtime and
adjusting the compatibles before the devices get probed. As a side effect,
we can also add support for the SoC bus to expose these details to
userspace.

The first two patches introduce the SoC identification support and the
quirk support. The third patch is a fix to a sparse warning that I hit
while building the code. Patches four to six implement the support for PLL2,
codec and module 1 clocks on our clock driver. The last three patches
add the corresponding clock nodes to the device tree.

As usual, all comments and reviews are welcome.

Thanks!

Emilio

Emilio L?pez (9):
  ARM: sunxi: introduce SoC identification support
  ARM: sunxi: quirk support
  ARM: sunxi: make sun6i SMP ops static
  clk: sunxi: PLL2 support for sun4i, sun5i and sun7i
  clk: sunxi: codec clock support
  clk: sunxi: mod1 clock support
  ARM: sunxi: dt: Add PLL2 support
  ARM: sunxi: dt: Add codec clock support
  ARM: sun7i: dt: Add mod1 clock nodes

 Documentation/devicetree/bindings/clock/sunxi.txt |   4 +
 arch/arm/boot/dts/sun4i-a10.dtsi                  |  16 ++
 arch/arm/boot/dts/sun5i-a10s.dtsi                 |  16 ++
 arch/arm/boot/dts/sun5i-a13.dtsi                  |  16 ++
 arch/arm/boot/dts/sun7i-a20.dtsi                  |  56 +++++
 arch/arm/mach-sunxi/Kconfig                       |   1 +
 arch/arm/mach-sunxi/Makefile                      |   2 +-
 arch/arm/mach-sunxi/platsmp.c                     |   2 +-
 arch/arm/mach-sunxi/quirks.c                      |  82 ++++++++
 arch/arm/mach-sunxi/sunxi-soc-id.c                | 226 ++++++++++++++++++++
 arch/arm/mach-sunxi/sunxi-soc-id.h                |   6 +
 drivers/clk/sunxi/Makefile                        |   3 +
 drivers/clk/sunxi/clk-a10-codec.c                 |  41 ++++
 drivers/clk/sunxi/clk-a10-mod1.c                  |  69 ++++++
 drivers/clk/sunxi/clk-a10-pll2.c                  | 243 ++++++++++++++++++++++
 15 files changed, 781 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/quirks.c
 create mode 100644 arch/arm/mach-sunxi/sunxi-soc-id.c
 create mode 100644 arch/arm/mach-sunxi/sunxi-soc-id.h
 create mode 100644 drivers/clk/sunxi/clk-a10-codec.c
 create mode 100644 drivers/clk/sunxi/clk-a10-mod1.c
 create mode 100644 drivers/clk/sunxi/clk-a10-pll2.c

-- 
2.0.3
