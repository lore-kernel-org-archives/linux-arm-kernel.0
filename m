From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 21 Jul 2018 19:37:20 +0200
Subject: [PATCH 2/3] ARM: dts: meson8: add the ARM TWD timer
In-Reply-To: <20180721173721.31361-1-martin.blumenstingl@googlemail.com>
References: <20180721173721.31361-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180721173721.31361-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Meson8 and Meson8m2 SoC are using four ARM Cortex-A9 cores which
come with a "TWD" (Timer-Watchdog) based timer. This adds support for
the ARM TWD Timer on these two SoCs.

Suggested-by: Carlo Caione <carlo@endlessm.com>
[ rebased patch from Carlo, use IRQ_TYPE_EDGE_RISING instead of
  IRQ_TYPE_LEVEL_LOW to prevent "GIC: PPI13 is secure or misconfigured"
  message during boot, use pre-processor macros to specify the IRQ,
  dropped TWD watchdog node since there's no driver for it anymore ]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index d77dcf890cfc..4e3406edb61b 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -134,6 +134,13 @@
 		compatible = "arm,cortex-a9-scu";
 		reg = <0xc4300000 0x100>;
 	};
+
+	timer at c4300600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0xc4300600 0x20>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+		clocks = <&clkc CLKID_CPU_DIV16>;
+	};
 }; /* end of / */
 
 &aobus {
-- 
2.18.0
