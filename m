From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 2 Mar 2013 00:06:14 +0100
Subject: [GIT PULL] Device Tree fixes for v3.9
Message-ID: <CACRpkdai0PRbK-R_KfNqkkVuSNn97v9Za8Doq71Zb-xCHW+J1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Here is a pull request for the Device Tree fixes for Ux500 in the v3.9 series.

Basically this should have come in earlier, but I failed at processing
it in time
for the merge window. t should have been this cycle's Ux500 DT topic branch.

As discussed I've started to funnel all Ux500 DT stuff through my ux500 tree
in order to do some coordination and I became overloaded. So this patch set
got stuck in the air. It was not trivial to push since this branch had a few
conflicts with other branches. (There might have been a good way to solve
that but I didn't come up with it in time.)

Basically how to handle it is your pick, in the old times I would have pushed
it ASAP, maybe during -rc1, as it restores the Ux500 DT to a working state
for the basic functionality (notably ethernet and MMC on the Snowball).

Please pull it in, for fixes or -next at your decision. As you can see the
base is at Torvald's HEAD since all dependencies that conflicted with
this branch is now there. If you want me to resend based on v3.9-rc1
or so, just tell.

Yours,
Linus Walleij


The following changes since commit b0af9cd9aab60ceb17d3ebabb9fdf4ff0a99cf50:

  Merge tag 'lzo-update-signature-20130226' of
git://github.com/markus-oberhumer/linux (2013-02-28 20:45:52 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dt-fixes

for you to fetch changes up to 924e82dacab9a0b2ea661c57c98112569267f0db:

  ARM: ux500: allow Snowball access to the AB8500 GPIO pins
(2013-03-01 23:30:20 +0100)

----------------------------------------------------------------
Ux500 Device Tree fixes
All are necessary to make a proper DT boot on the v3.9
series:
- IRQ edges.
- Register defines.
- FSMC clock.
- Ethernet clk fixup (one patch to drivers/net ACKed by
  David Miller)
- Proper IOS and regulator voltages for MMCI.
- AB8500 GPIOs restored after they were fixed in the v3.9
  merge window from the pinctrl tree.
- There is also a minor cleanup in the platform code, but it
  is strongly connected to the other patches.

----------------------------------------------------------------
Lee Jones (16):
      ARM: ux500: Change IRQ from low-to-high edge triggered to high-to-low
      ARM: ux500: Include the PRCMU's Secure Registers in DB8500's DT
      ARM: ux500: Provide a means to obtain the SMSC9115 clock when DT
is enabled
      clk: ux500: Ensure the FMSC clock is obtainable
      clk: ux500: Provide an alias for the SMSC911x Ethernet chip
      net/smsc911x: Provide common clock functionality
      mmc: mmci: Move ios_handler functionality into the driver
      ARM: ux500: Set correct MMCI regulator voltages in the ux5x0 Device Tree
      ARM: ux500: Specify the ux5x0 MMCI regulator's on/off GPIO as high-enable
      ARM: ux500: Specify which IOS regulator to use for MMCI
      ARM: ux500: Use the correct name when supplying a GPIO enable pin
      ARM: ux500: Setup correct settling time for the MMCI regulator
      ARM: ux500: Use the GPIO regulator framework for SDI0's 'en' and 'vsel'
      ARM: ux500: Remove traces of the ios_handler from platform code
      ARM: ux500: enable AB8500 GPIO for HREF
      ARM: ux500: allow Snowball access to the AB8500 GPIO pins

 arch/arm/boot/dts/dbx5x0.dtsi                 |  7 ++--
 arch/arm/boot/dts/href.dtsi                   |  1 +
 arch/arm/boot/dts/hrefprev60.dts              | 10 +++++-
 arch/arm/boot/dts/snowball.dts                |  4 +++
 arch/arm/boot/dts/stuib.dtsi                  |  2 +-
 arch/arm/mach-ux500/board-mop500-regulators.c | 14 ++++++++
 arch/arm/mach-ux500/board-mop500-regulators.h |  1 +
 arch/arm/mach-ux500/board-mop500-sdi.c        | 52 ---------------------------
 arch/arm/mach-ux500/board-mop500.c            | 45 +++++++++++++++++++++++
 arch/arm/mach-ux500/cpu-db8500.c              |  1 +
 drivers/clk/ux500/u8500_clk.c                 |  3 +-
 drivers/mmc/host/mmci.c                       |  9 +++++
 drivers/net/ethernet/smsc/smsc911x.c          | 29 ++++++++++++++-
 13 files changed, 120 insertions(+), 58 deletions(-)
