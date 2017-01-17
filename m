From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Jan 2017 13:49:17 +0100
Subject: [PATCH 1/4] ARM: dts: r8a7743: Link ARM GIC to clock and clock domain
In-Reply-To: <1484657360-13101-1-git-send-email-geert+renesas@glider.be>
References: <1484657360-13101-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1484657360-13101-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Link the ARM GIC to the INTC-SYS module clock, and add it to the SYSC
"always-on" PM Domain, so it can be power managed using that clock.

Note that currently the GIC-400 driver doesn't support module clocks nor
Runtime PM, so this must be handled as a critical clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7743.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 0956125597fdf835..40d2cdede7022ff6 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -60,6 +60,9 @@
 			      <0 0xf1006000 0 0x2000>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
 						 IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
 		};
 
 		irqc: interrupt-controller at e61c0000 {
-- 
1.9.1
