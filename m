From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Jan 2013 14:42:34 -0700
Subject: [GIT PULL 3/8] ARM: tegra: USB driver cleanup
In-Reply-To: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
References: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1359582159-28816-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra USB driver has a number of issues:

1) The PHY driver isn't a true platform device, and doesn't implement
   the standard USB PHY API.

2) struct device instance numbers were used to make decisions in the
   driver, rather than being parameterized by DT or platform data.

This pull request solves issue (2), and lays the groundwork for solving
issue (1). The work on issue (1) involved introducing new DT nodes for
the USB PHYs, which in turn interacted with the Tegra common clock
framework changes, due to the move of clock lookups into device tree.
Hence, these USB driver changes are taken through the Tegra tree with
acks from USB maintainers.

This pull request is based on the previous pull request, with tag
tegra-for-3.9-soc-ccf.

----------------------------------------------------------------

The following changes since commit ef3ffe5a0458606c488def757bb7f6dd013c2db5:

  clk: tegra30: remove unused TEGRA_CLK_DUPLICATE()s

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.9-soc-usb

for you to fetch changes up to ab137d04db5a4b32250ce5ef1b288ce6cf06adf6:

  usb: host: tegra: make use of PHY pointer of HCD

----------------------------------------------------------------

Stephen Warren (2):
      ARM: tegra: add clocks properties to USB PHY nodes
      usb: host: tegra: don't touch EMC clock

Venu Byravarasu (11):
      ARM: tegra: remove USB address related macros from iomap.h
      usb: phy: use kzalloc to allocate struct tegra_usb_phy
      ARM: tegra: Add new DT property to USB node.
      usb: host: tegra: Resetting PORT0 based on information received via DT.
      usb: phy: remove unused APIs from Tegra PHY.
      ARM: tegra: add DT nodes for Tegra USB PHY
      USB: PHY: tegra: get rid of instance number to differentiate legacy controller
      USB: PHY: tegra: Get rid of instance number to differentiate PHY type
      usb: add APIs to access host registers from Tegra PHY
      ARM: tegra: Add reset GPIO information to PHY DT node
      usb: host: tegra: make use of PHY pointer of HCD

 .../bindings/usb/nvidia,tegra20-ehci.txt        |    3 +
 .../bindings/usb/nvidia,tegra20-usb-phy.txt     |   17 +++
 arch/arm/boot/dts/tegra20-harmony.dts           |    4 +
 arch/arm/boot/dts/tegra20-paz00.dts             |    4 +
 arch/arm/boot/dts/tegra20-seaboard.dts          |    4 +
 arch/arm/boot/dts/tegra20-trimslice.dts         |    4 +
 arch/arm/boot/dts/tegra20-ventana.dts           |    4 +
 arch/arm/boot/dts/tegra20.dtsi                  |   29 ++++
 arch/arm/mach-tegra/board-dt-tegra20.c          |    6 +-
 arch/arm/mach-tegra/iomap.h                     |    9 --
 drivers/usb/host/ehci-tegra.c                   |   97 ++++++++-----
 drivers/usb/phy/tegra_usb_phy.c                 |  132 ++++++------------
 include/linux/usb/tegra_usb_phy.h               |   16 ++-
 13 files changed, 191 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra20-usb-phy.txt
