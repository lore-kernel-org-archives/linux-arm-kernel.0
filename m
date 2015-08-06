From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 06 Aug 2015 19:33:32 +0200
Subject: [PATCH v2 1/2] ARM: dts: rockchip: reserve unusable memory region on
 rk3288
Message-ID: <1763907.pckMEaRNPs@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The all current Rockchip SoCs supporting 4GB of ram have problems accessing
the memory region 0xfe000000~0xff000000. This also seems to includes the
rk3368 arm64 soc.

All current code handling dma memory oddities I could find, seem to involve
soc-specific code (zone-dma or so) while this issue is shared between arm32
and arm64 socs from Rockchip, which would need to have this described in
the soc devicetree on both socs.

Limiting the dma-zone alone also does not solve the issue and as the
dma-masks need to be a power-of-two in the kernel, the next lower dma-mask
brings memory usable for dma down to 2GB.

So as a stop-gap block off the affected region to prevent its use by
devices with 4GB of memory, like some recent Chromebooks.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v1:
- expand reasons for the reserved memory

 arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 47a15aa..118fe74 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -169,6 +169,26 @@
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/*
+		 * The rk3288 cannot use the memory area above 0xfe000000
+		 * for dma operations for some reason. While there is
+		 * probably a better solution available somewhere, we
+		 * haven't found it yet and while devices with 2GB of ram
+		 * are not affected, this issue prevents 4GB from booting.
+		 * So to make these devices at least bootable, block
+		 * this area for the time being until the real solution
+		 * is found.
+		 */
+		dma-unusable at fe000000 {
+			reg = <0xfe000000 0x1000000>;
+		};
+	};
+
 	xin24m: oscillator {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
2.1.4
