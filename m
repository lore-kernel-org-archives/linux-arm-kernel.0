From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Nov 2018 12:29:33 +0000
Subject: [RFC PATCH 0/6] Armada 38x comphy driver to support 2.5Gbps networking
Message-ID: <20181112122933.GD30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for dynamically switching between 1Gbps
and 2.5Gbps networking for the Marvell Armada 38x SoCs, tested on
Armada 388 on the Clearfog platform.

This is necessary to be able to connect (eg) a Clearfog platform
with a Macchiatobin platform via the SFP sockets, as Clearfog
currently only supports 1Gbps networking via the SFP socket and
Macchiatobin defaults to 2.5Gbps when using Fiberchannel SFPs.

In order to allow dynamic switching, we need to implement a common
phy driver to switch the ethernet serdes lane speed - 2.5Gbps is
just 1Gbps up-clocked by 2.5x.  We implement a simple comphy
driver to achieve this, which only supports networking.

With this, we are able to support both Fiberchannel SFPs operating
at 2.5Gbps or 1Gbps, and 1G ethernet SFPs plugged into the Clearfog
platform, dynamically selecting according to the SFPs abilities.

I'm aware of the proposed changes to the PHY layer, changing
phy_set_mode() to take the ethernet phy interface type, hence why
this is RFC - there's also the question about how this will be
merged.  This series is currently based on 4.20-rc1, but will
likely need to be rebased when the PHY layer changes hit.

 .../bindings/net/marvell-armada-370-neta.txt       |   2 +-
 .../bindings/phy/phy-armada38x-comphy.txt          |  40 ++++
 arch/arm/boot/dts/armada-388-clearfog.dtsi         |   2 +
 arch/arm/boot/dts/armada-38x.dtsi                  |  37 ++++
 drivers/net/ethernet/marvell/mvneta.c              |  58 ++++-
 drivers/phy/marvell/Kconfig                        |  10 +
 drivers/phy/marvell/Makefile                       |   1 +
 drivers/phy/marvell/phy-armada38x-comphy.c         | 236 +++++++++++++++++++++
 8 files changed, 378 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-armada38x-comphy.txt
 create mode 100644 drivers/phy/marvell/phy-armada38x-comphy.c


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
