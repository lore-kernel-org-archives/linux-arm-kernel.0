From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 15:48:41 +0200
Subject: [PATCH v2 0/5] ARM: rockchip: move io-domains under GRF
Message-ID: <1459432126-6395-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GRF contains both individual settings-bits as well as somewhat more
fully blocks like different phy-controls and also the io-voltage selection.
Similar to the power-domains living under the pmu, things like said
io-voltage selection should live under the grf instead of separate
nodes higher up.

This is even more important now that socs like the rk3368 and probably
more future socs seem to contain more than one GRF-area (a second one
under the PMU power-domain) with each containing a part of the voltage
selection. So having that in the correct place also prevents confusion.


Ideally patch1 would go into 4.7 through the power or avs tree and the
devicetree-related things should wait until after the next merge window
due to the updated binding, which I can then simply apply to my dts
branches.

changes in v2:
- adapt patch1 to underlying changes in the iodomain driver

Heiko Stuebner (5):
  PM / AVS: rockchip-io: make io-domains a child of the GRF
  ARM: dts: rockchip: make rk3288-grf a simple-mfd
  ARM: dts: rockchip: move rk3288 io-domain nodes to the grf
  arm64: dts: rockchip: make rk3368 grf syscons simple-mfds as well
  arm64: dts: rockchip: add rk3368 iodomains

 .../bindings/power/rockchip-io-domain.txt          |  4 ++-
 arch/arm/boot/dts/rk3288-firefly.dtsi              | 33 +++++++++++----------
 arch/arm/boot/dts/rk3288-popmetal.dts              | 34 ++++++++++++----------
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            | 34 ++++++++++++----------
 arch/arm/boot/dts/rk3288-veyron.dtsi               | 28 +++++++++---------
 arch/arm/boot/dts/rk3288.dtsi                      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        | 22 ++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  4 +--
 drivers/power/avs/rockchip-io-domain.c             | 10 ++++++-
 9 files changed, 105 insertions(+), 66 deletions(-)

-- 
2.6.4
