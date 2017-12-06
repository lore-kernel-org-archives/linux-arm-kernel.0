From: heiko@sntech.de (Heiko Stuebner)
Date: Wed,  6 Dec 2017 01:14:46 +0100
Subject: [PATCH] arm64: dts: rockchip: limit rk3328-rock64 gmac speed to
 100MBit for now
Message-ID: <20171206001446.26810-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It looks like either the current kernel or the hardware has reliability
issues when the gmac is actually running at 1GBit. In my test-case
it is not able to boot on a nfsroot at this speed, as the system
will always lose the connection to the nfs-server during boot, before
reaching any login prompt and not recover from this.

So until this is solved, limit the speed to 100MBit as with this the
nfsroot survives stress tests like an apt-get upgrade without problems.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index d4f80786e7c2..3890468678ce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -132,6 +132,8 @@
 	assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
 	assigned-clock-parents = <&gmac_clkin>, <&gmac_clkin>;
 	clock_in_out = "input";
+	/* shows instability at 1GBit right now */
+	max-speed = <100>;
 	phy-supply = <&vcc_io>;
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
-- 
2.14.2
