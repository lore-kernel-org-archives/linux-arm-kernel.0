From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 28 Jul 2014 00:49:38 -0300
Subject: [RFC 0/8] Audio clocks for sun[457]i, SoC revision detection
Message-ID: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for PLL2 on A10 rev B and higher, A10S, A13 
and A20. It also includes support for the codec clock as well as
module 1 clocks, used in the audio blocks. There's also two patches
fixing sparse warnings on the driver.

I'm sending this as RFC as this does not support the A10 rev A PLL2
clock. It seems from the Allwinner code that rev A has a different
register layout, and is programmed with different values. Unfortunately
there's no mention of this on the User Manual, so I'm left to guess
for the most part.

The clock code is not the only part in where rev A is special cased;
there's some register writes just for it on the analog audio driver
as well, so we probably need a way to support this in a generic way.

So, how should we proceed with this? Here are some ideas:
  * Make different device trees with different compatibles. Pros:
    not much extra code. Cons: we don't know the SoC revision on
    devices and/or they may change during the product lifecycle.
  * Use different compatibles and change them on U-Boot. Pros: it
    keeps Linux simple. Cons: dependency on a newer bootloader.
  * Use different compatibles and change them on early boot.
    Pros: compatibility with existing bootloaders. Cons: Need
    code in Linux to fixup the DT
  * Have a function "int sunxi_soc_revision(void)" that drivers
    can use to check which SoC revision they're running on.
    Pros: no DT fixup. Cons: ugly and less portable if the driver
    ever needs to run on a non-sunxi platform.
  * <your idea here>

I'd like to hear everyone's thoughts on this. From what I've seen
around on LAKML, it seems the last option is the one in widest use, but
I'd appreciate a confirmation. If this is the way forward,
where should the code live in? The SoC detection is done by
reading a register on the timer block on sun4i, and SID on sun5i.

As usual, all comments on the code are welcome as well.

Thanks!

Emilio

Emilio L?pez (8):
  clk: sunxi: PLL2 support for sun4i, sun5i and sun7i
  clk: sunxi: codec clock support
  clk: sunxi: mod1 clock support
  clk: sunxi: add __iomem markings to MMIO pointers
  clk: sunxi: staticize structures and arrays
  ARM: sunxi: Add PLL2 support
  ARM: sunxi: Add codec clock support
  ARM: sun7i: Add mod1 clock nodes

 arch/arm/boot/dts/sun4i-a10.dtsi         |  16 ++
 arch/arm/boot/dts/sun5i-a10s.dtsi        |  16 ++
 arch/arm/boot/dts/sun5i-a13.dtsi         |  16 ++
 arch/arm/boot/dts/sun7i-a20.dtsi         |  55 +++++++
 drivers/clk/sunxi/Makefile               |   3 +
 drivers/clk/sunxi/clk-a10-codec.c        |  41 +++++
 drivers/clk/sunxi/clk-a10-mod1.c         |  69 +++++++++
 drivers/clk/sunxi/clk-a10-pll2.c         | 249 +++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-a20-gmac.c         |   2 +-
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c |   2 +-
 drivers/clk/sunxi/clk-sun6i-apb0.c       |   2 +-
 drivers/clk/sunxi/clk-sun6i-ar100.c      |   4 +-
 drivers/clk/sunxi/clk-sun8i-apb0.c       |   2 +-
 drivers/clk/sunxi/clk-sunxi.c            |  10 +-
 14 files changed, 476 insertions(+), 11 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-a10-codec.c
 create mode 100644 drivers/clk/sunxi/clk-a10-mod1.c
 create mode 100644 drivers/clk/sunxi/clk-a10-pll2.c

-- 
2.0.3
