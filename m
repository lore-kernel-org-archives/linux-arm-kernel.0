From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 22 Aug 2017 12:03:56 +0800
Subject: [PATCH v2 0/4] Workaround broken RTL8211E on some Pine64+ boards
Message-ID: <20170822040400.12166-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Pine64+ boards come with bad RTL8211E PHYs, which cannot work reliably
unless do some hack. According to Pine64 people, Realtek describes the hack
as totally disabling RX delay, and it's not documented at all.

This patchset introduces the workaround on Pine64+.

The first patch adds RGMII variants' support to the dwmac-sun8i driver.

The second patch renames some macros in RTL PHY driver, and the third
patch introduces the hack as the "RGMII-TXID" mode of the PHY.

The fourth patch enables the hack in the device tree.

Icenowy Zheng (4):
  net: stmmac: dwmac-sun8i: support RGMII modes with PHY internal delay
  net: phy: realtek: change macro name for page select register
  net: phy: realtek: add disable RX internal delay mode
  arm64: allwinner: a64: disable the RTL8211E internal RX delay on
    Pine64+

 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  3 ++
 drivers/net/phy/realtek.c                          | 43 +++++++++++++++++++---
 3 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.13.5
