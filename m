From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  6 May 2013 17:33:33 +0200
Subject: [PATCH 0/7] mv643xx_eth: device tree bindings
In-Reply-To: <1365071235-11611-1-git-send-email-florian@openwrt.org>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
Message-ID: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set picks up work by Florian Fainelli bringing full DT
support to mv643xx_eth and Marvell SoCs using it.

The current patch set drops Florian's device tree conversions for
Kirkwood, Dove, and Orion5x in favour of split patches for board
files and board descriptor files.

Device tree conversion for Dove and Kirkwood is added. Dove has
been fully tested, while Kirkwood is compile-tested only.

Florian Fainelli (2):
  net: mv643xx_eth: add Device Tree bindings
  net: mv643xx_eth: update Device Tree bindings documentation

Sebastian Hesselbarth (5):
  ARM: dove: remove legacy mv643xx_eth setup
  ARM: dove: add gigabit ethernet and mvmdio device tree nodes
  ARM: kirkwood: remove legacy mv643xx_eth board setup
  ARM: kirkwood: add gigabit ethernet and mvmdio device tree nodes
  ARM: kirkwood: remove legacy clk alias for mv643xx_eth

 Documentation/devicetree/bindings/marvell.txt      |   22 ++++-
 arch/arm/boot/dts/dove-cubox.dts                   |    8 ++
 arch/arm/boot/dts/dove.dtsi                        |   35 +++++++
 arch/arm/boot/dts/kirkwood-cloudbox.dts            |   15 +++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   15 +++
 arch/arm/boot/dts/kirkwood-dockstar.dts            |   15 +++
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   26 +++++
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |   15 +++
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |   26 +++++
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   15 +++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   15 +++
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |   22 ++++
 arch/arm/boot/dts/kirkwood-is2.dts                 |    2 +
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |   15 +++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |   26 +++++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |   25 +++++
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |   15 +++
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |   15 +++
 arch/arm/boot/dts/kirkwood-ns2.dts                 |    2 +
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |    2 +
 arch/arm/boot/dts/kirkwood-ns2max.dts              |    2 +
 arch/arm/boot/dts/kirkwood-ns2mini.dts             |    2 +
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |   15 +++
 arch/arm/boot/dts/kirkwood-topkick.dts             |   15 +++
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |    4 +-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |    4 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |   15 +++
 arch/arm/boot/dts/kirkwood.dtsi                    |   52 ++++++++++
 arch/arm/mach-dove/board-dt.c                      |    5 -
 arch/arm/mach-kirkwood/board-dnskw.c               |    7 --
 arch/arm/mach-kirkwood/board-dockstar.c            |    9 --
 arch/arm/mach-kirkwood/board-dreamplug.c           |   14 ---
 arch/arm/mach-kirkwood/board-dt.c                  |   16 ---
 arch/arm/mach-kirkwood/board-goflexnet.c           |    9 --
 arch/arm/mach-kirkwood/board-guruplug.c            |   14 ---
 arch/arm/mach-kirkwood/board-ib62x0.c              |    9 --
 arch/arm/mach-kirkwood/board-iconnect.c            |    6 -
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c      |   16 ---
 arch/arm/mach-kirkwood/board-km_kirkwood.c         |    7 --
 arch/arm/mach-kirkwood/board-lsxl.c                |   12 --
 arch/arm/mach-kirkwood/board-mplcec4.c             |   11 --
 arch/arm/mach-kirkwood/board-ns2.c                 |   13 ---
 arch/arm/mach-kirkwood/board-openblocks_a6.c       |    9 --
 arch/arm/mach-kirkwood/board-readynas.c            |    6 -
 arch/arm/mach-kirkwood/board-ts219.c               |   13 ---
 arch/arm/mach-kirkwood/board-usi_topkick.c         |    9 --
 drivers/net/ethernet/marvell/mv643xx_eth.c         |  108 +++++++++++++++++++-
 include/linux/mv643xx_eth.h                        |    3 +
 48 files changed, 544 insertions(+), 192 deletions(-)
---
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: David Miller <davem@davemloft.net>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Cc: Jamie Lentin <jm@lentin.co.uk>
Cc: Michael Walle <michael@walle.cc>
Cc: Eric Hutter <hutter.eric@gmail.com>
Cc: Joshua Coombs <josh.coombs@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Simon Baatz <gmbnomis@gmail.com>
Cc: Alan M Butler <alanbutty12@gmail.com>
Cc: Nigel Roberts <nigel@nobiscuit.com>
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>
Cc: Stefan Peter <s.peter@mpl.ch>
Cc: Arnaud Ebalard <arno@natisbad.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: netdev at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
1.7.2.5
