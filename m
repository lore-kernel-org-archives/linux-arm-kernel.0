From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 22 Jul 2013 22:01:04 -0300
Subject: [PATCH RFC 0/8] sunxi clk: PLL4/5/6 and module 0 support
Message-ID: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset provides more clock support for the sunxi platform. Its 
main aim is to implement support for PLL4, 5 and 6, as well as 
MOD0-style clocks, used for various components such as MMC and IR.

The first patch fixes a small regression found while testing on 
3.11-rc1. It does not affect the system in any way though, so there is 
no real need to submit it as an rc fix.

The second patch reworks the way factor clocks are registered. By doing 
so behind a composite clock, we gain the ability to divide, mux or gate 
these clocks. This comes in handy to implement PLL5, PLL6 and MOD0

The third patch adds gating support to PLL1, and by doing so, it also 
becomes bit-compatible with PLL4. The fourth patch adds a node on DT to 
get PLL4 supported this way.

The fifth and sixth patches implement support for PLL5 and 6 on the 
driver and adding the DT node, respectively.

Patches 7 and 8 implement support for module 0 style clocks and add all
the corresponding DT nodes for sun4i.

I have marked this series as RFC as I still need to write the bindings 
for sun5i mod0 clocks and might change a thing or two on the other patches,
but I wanted to get this code out there for review early this cycle.

As always, any comments will be highly appreciated.

Thanks,

Emilio

Emilio L?pez (8):
  clk: sunxi: fix initialization of basic clocks
  clk: sunxi: register factors clocks behind composite
  clk: sunxi: add gating support to PLL1
  ARM: sunxi: add PLL4 support
  clk: sunxi: add PLL5 and PLL6 support
  ARM: sunxi: add PLL5 and PLL6 support
  clk: sunxi: mod0 support
  ARM: sun4i: mod0 clocks

 Documentation/devicetree/bindings/clock/sunxi.txt |   5 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                  | 131 +++++++++-
 arch/arm/boot/dts/sun5i-a10s.dtsi                 |  26 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                  |  26 +-
 drivers/clk/sunxi/clk-factors.c                   |  63 +----
 drivers/clk/sunxi/clk-factors.h                   |  16 +-
 drivers/clk/sunxi/clk-sunxi.c                     | 285 +++++++++++++++++++++-
 7 files changed, 466 insertions(+), 86 deletions(-)

-- 
1.8.3.3
