From: stefan@agner.ch (Stefan Agner)
Date: Mon, 17 Oct 2016 18:51:27 -0700
Subject: [PATCH] ARM: dts: vf610: fix IRQ flag of global timer
Message-ID: <20161018015127.16981-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The global timer IRQ (PPI[0], PPI 11 in device tree terms) is a
rising edge interrupt. The ARM Cortex-A5 MPCore TRM in Chapter
10.1.2. Interrupt types and sources says:
"Interrupt is rising-edge sensitive."

The bits seem to be read-only, hence this missconfiguration had
no negative effect. However, with commit 992345a58e0c
("irqchip/gic: WARN if setting the interrupt type for a PPI fails")
warnings such as this get printed:
GIC: PPI11 is secure or misconfigured

With this change the new configuration matches the default
configuration and no warning is printed anymore.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf500.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index a3824e6..d7fdb2a 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -70,7 +70,7 @@
 			global_timer: timer at 40002200 {
 				compatible = "arm,cortex-a9-global-timer";
 				reg = <0x40002200 0x20>;
-				interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 				interrupt-parent = <&intc>;
 				clocks = <&clks VF610_CLK_PLATFORM_BUS>;
 			};
-- 
2.10.0
