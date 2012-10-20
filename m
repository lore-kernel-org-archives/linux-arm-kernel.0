From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Oct 2012 17:07:32 +0200
Subject: [RFC 00/11] Convert Kirkwood to pinctrl
Message-ID: <1350745663-5277-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset converts all kirkwood DT boards to pinctrl.
It is an RFC for a number of reasons:

Do we want to enable the use of mvebu GPIO driver
outside of mach-mvebu?

Do we want to enable the use of mvebu pinctrl driver
outside of mach-mvebu?

The old MPP code would probe the hardware to determine what kirkwood
variant it was running on. The new pinctrl driver does not do this, it
uses a DT compatibility string. We are only part way through checking
what CPU each board has, and probably some of the DT compatibility strings
are wrong.

board-kw_kirkwood is an oddball. The SoC on this board is a Marvell
Ethernet switch with an embedded kirkwood. The pinctrl-kirkwood.c
sub-driver does not yet support this kirkwood variant, so the board
file has not been converted yet. It is possible that the second patch
in this series breaks this board.

Andrew Lunn (11):
  ARM: Kirkwood: Allow use of pinctrl
  ARM: Kirkwood: Allow use of MVEBU GPIO driver.
  ARM: Kirkwood: Convert TS219 to pinctrl.
  ARM: Kirkwood: Convert iConnect to pinctrl.
  ARM: Kirkwood: Convert dnskw to pinctrl
  ARM: Kirkwood: Convert dockstar to pinctrl.
  ARM: Kirkwood: Convert dreamplug to pinctrl.
  ARM: Kirkwood: Convert GoFlex Net to pinctrl.
  ARM: Kirkwood: Convert ib62x0 to pinctrl.
  ARM: Kirkwood: Convert lsxl boards to pinctrl.
  ARM: Kirkwood: Convert IX2-200 to pinctrl.

 arch/arm/Kconfig                              |    3 +
 arch/arm/boot/dts/kirkwood-dnskw.dtsi         |  136 +++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-dockstar.dts       |   21 ++++
 arch/arm/boot/dts/kirkwood-dreamplug.dts      |   26 +++++
 arch/arm/boot/dts/kirkwood-goflexnet.dts      |   57 +++++++++++
 arch/arm/boot/dts/kirkwood-ib62x0.dts         |   41 ++++++++
 arch/arm/boot/dts/kirkwood-iconnect.dts       |   52 ++++++++++
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |   90 ++++++++++++++++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi          |   67 ++++++++++++
 arch/arm/boot/dts/kirkwood-ts219-6281.dts     |   56 ++++++++++
 arch/arm/boot/dts/kirkwood-ts219-6282.dts     |   56 ++++++++++
 arch/arm/boot/dts/kirkwood.dtsi               |   11 +-
 arch/arm/mach-kirkwood/board-dnskw.c          |   37 -------
 arch/arm/mach-kirkwood/board-dockstar.c       |   10 --
 arch/arm/mach-kirkwood/board-dreamplug.c      |   14 ---
 arch/arm/mach-kirkwood/board-goflexnet.c      |   18 ----
 arch/arm/mach-kirkwood/board-ib62x0.c         |   21 ----
 arch/arm/mach-kirkwood/board-iconnect.c       |   17 ----
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   24 -----
 arch/arm/mach-kirkwood/board-lsxl.c           |   19 ----
 arch/arm/mach-kirkwood/board-ts219.c          |   25 -----
 arch/arm/plat-orion/irq.c                     |    5 +-
 drivers/gpio/Kconfig                          |    2 +-
 drivers/pinctrl/Kconfig                       |    2 +-
 24 files changed, 617 insertions(+), 193 deletions(-)

-- 
1.7.10.4
