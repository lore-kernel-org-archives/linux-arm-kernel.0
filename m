From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 15 Nov 2016 15:29:11 +0100
Subject: [PATCH net 0/3] Fix OdroidC2 Gigabit Tx link issue
Message-ID: <1479220154-25851-1-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes an issue with the OdroidC2 board (DWMAC + RTL8211F).
Initially reported as a low Tx throughput issue at gigabit speed, the
platform enters LPI too often. This eventually break the link (both Tx
and Rx), and require to bring the interface down and up again to get the
Rx path working again.

The root cause of this issue is not fully understood yet but disabling EEE
advertisement on the PHY prevent this feature to be negotiated.
With this change, the link is stable and reliable, with the expected
throughput performance.

The patchset adds options in the realtek phy driver to disable EEE
advertisement, through device tree, for the phy version supporting EEE.
Then EEE is disabled in the OdroidC2 device tree for Gigabit speed.
100M is not affected by this issue.

Jerome Brunet (3):
  net: phy: realtek: add eee advertisement disable options
  dt-bindings: net: add DT bindings for realtek phys
  ARM64: dts: meson: odroidc2: disable 1000t-eee advertisement

 .../devicetree/bindings/net/realtek-phy.txt        | 20 +++++++
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 15 +++++
 drivers/net/phy/realtek.c                          | 65 +++++++++++++++++++++-
 3 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-phy.txt

-- 
2.7.4
