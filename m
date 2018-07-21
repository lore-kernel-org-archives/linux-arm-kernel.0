From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 21 Jul 2018 19:37:21 +0200
Subject: [PATCH 3/3] ARM: dts: meson8b: add the ARM TWD timer
In-Reply-To: <20180721173721.31361-1-martin.blumenstingl@googlemail.com>
References: <20180721173721.31361-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180721173721.31361-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Meson8B SoC is using four ARM Cortex-A5 cores which come with a
"TWD" (Timer-Watchdog) based timer. This adds support for the ARM TWD
Timer on this SoC.

Suggested-by: Carlo Caione <carlo@endlessm.com>
[ rebased patch from Carlo, use IRQ_TYPE_EDGE_RISING instead of
  IRQ_TYPE_LEVEL_LOW to prevent "GIC: PPI13 is secure or misconfigured"
  message during boot, use pre-processor macros to specify the IRQ,
  dropped TWD watchdog node since there's no driver for it anymore ]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 08f7f6be7254..d0443ae03c72 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -117,6 +117,13 @@
 		compatible = "arm,cortex-a5-scu";
 		reg = <0xc4300000 0x100>;
 	};
+
+	timer at c4300600 {
+		compatible = "arm,cortex-a5-twd-timer";
+		reg = <0xc4300600 0x20>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+		clocks = <&clkc CLKID_CPU_DIV16>;
+	};
 }; /* end of / */
 
 &aobus {
-- 
2.18.0
