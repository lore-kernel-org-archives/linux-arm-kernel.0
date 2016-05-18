From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 18 May 2016 22:41:50 +0800
Subject: [PATCH] arm64: dts: rockchip: fixes the gic400 2nd region size for
 rk3368
Message-ID: <1463582510-29156-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 2nd additional region is the GIC virtual cpu interface register
base and size.

As the gic400 of rk3368 says, the cpu interface register map as below

:

-0x0000 GICC_CTRL
.
.
.
-0x00fc GICC_IIDR
-0x1000 GICC_IDR

Obviously, the region size should be greater than 0x1000.
So we should make sure to include the GICC_IDR since the kernel will access
it in some cases.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org

---

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 8b4a7c9..080203e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -670,7 +670,7 @@
 		#address-cells = <0>;
 
 		reg = <0x0 0xffb71000 0x0 0x1000>,
-		      <0x0 0xffb72000 0x0 0x1000>,
+		      <0x0 0xffb72000 0x0 0x2000>,
 		      <0x0 0xffb74000 0x0 0x2000>,
 		      <0x0 0xffb76000 0x0 0x2000>;
 		interrupts = <GIC_PPI 9
-- 
2.7.4
