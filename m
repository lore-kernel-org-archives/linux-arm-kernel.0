From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 4 Feb 2013 21:37:17 +0000
Subject: [GIT PULL] ARM: mvebu fixes for v3.8-rc6 (round 2)
Message-ID: <1360013837.bfC5F0.15090@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit de27686b77f1c5c5dddf06d48fd322c52f098d51:

  arm: mvebu: i2c come back in defconfig

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_fixes_for_v3.8-rc6-round2

for you to fetch changes up to b3fa2a0a2e3ac23415efec7ae848efd918b6b444:

  rtc: rtc-mv: Add support for clk to avoid lockups

----------------------------------------------------------------
mvebu fixes for v3.8-rc6 (round 2)
    
    This series of four patches started with Simon Baatz reporting lost MAC
    addresses when compiling mv643xx_eth as a module.  Accompanying that, he was
    getting hard lockups on boot when most other drivers were compiled as modules.
    
    All of this boiled down to gated clocks.  mv643xx_eth looses it's mac address
    after it's clock gets gated.  The patch included in this series prevents the
    ge0 and ge1 clocks from being gated when doing legacy platform init of the
    driver.
    
    There is another patch to accompany the DT conversion of the driver which will
    allow reading the mac address from the devicetree.  This patch is not included
    here because the bindings are being added for v3.9.
    
    The hard lockups at boot were the result of many SoC IPs using the runit gate
    clock.  Several drivers (gpio, rtc) were not claiming the clock, and of_serial
    wouldn't claim the clock if clock-frequency was specified in the DT.
    
    clock-frequency was only necessary before we added proper clock support, it is
    now removed from all kirkwood dts files.
    
    Last, proper clock support is added to gpio-mvebu and rtc-mv.
    
    With these four fixes all drivers that can be compiled as modules can be
    without breaking bootup.
----------------------------------------------------------------
Andrew Lunn (2):
      gpio: mvebu: Add clk support to prevent lockup
      rtc: rtc-mv: Add support for clk to avoid lockups

Jason Cooper (1):
      ARM: kirkwood: of_serial: fix clock gating by removing clock-frequency

Sebastian Hesselbarth (1):
      ARM: kirkwood: fix to retain gbe MAC addresses for DT kernels

 arch/arm/boot/dts/kirkwood-dns320.dts         |  2 --
 arch/arm/boot/dts/kirkwood-dns325.dts         |  1 -
 arch/arm/boot/dts/kirkwood-dockstar.dts       |  1 -
 arch/arm/boot/dts/kirkwood-dreamplug.dts      |  1 -
 arch/arm/boot/dts/kirkwood-goflexnet.dts      |  1 -
 arch/arm/boot/dts/kirkwood-ib62x0.dts         |  1 -
 arch/arm/boot/dts/kirkwood-iconnect.dts       |  1 -
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |  1 -
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts    |  1 -
 arch/arm/boot/dts/kirkwood-lschlv2.dts        |  1 -
 arch/arm/boot/dts/kirkwood-lsxhl.dts          |  1 -
 arch/arm/boot/dts/kirkwood-mplcec4.dts        |  1 -
 arch/arm/boot/dts/kirkwood-nsa310.dts         |  1 -
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts  |  2 --
 arch/arm/boot/dts/kirkwood-topkick.dts        |  1 -
 arch/arm/boot/dts/kirkwood.dtsi               |  5 ++--
 arch/arm/mach-kirkwood/board-dt.c             | 24 ++++++++++++-------
 drivers/gpio/gpio-mvebu.c                     |  7 ++++++
 drivers/rtc/rtc-mv.c                          | 28 ++++++++++++++++++----
 19 files changed, 49 insertions(+), 32 deletions(-)
