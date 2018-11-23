From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 23 Nov 2018 20:53:10 +0100
Subject: [PATCH 5/6] ARM: dts: meson8b: add the ARM TWD timer
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181123195311.4578-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Meson8B SoC is using four ARM Cortex-A5 cores which come with a
"TWD" (Timer-Watchdog) based timer. This adds support for the ARM TWD
Timer on this SoC.

Suggested-by: Carlo Caione <carlo@endlessm.com>
[ rebased patch from Carlo, use IRQ_TYPE_EDGE_RISING instead of
  IRQ_TYPE_LEVEL_LOW to prevent "GIC: PPI13 is secure or misconfigured"
  message during boot, use pre-processor macros to specify the IRQ,
  added the correct clock, dropped TWD watchdog node since there's no
  driver for it anymore ]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 6b097ab8637f..a3a5649e32fa 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -349,6 +349,13 @@
 		compatible = "arm,cortex-a5-scu";
 		reg = <0x0 0x100>;
 	};
+
+	timer at 600 {
+		compatible = "arm,cortex-a5-twd-timer";
+		reg = <0x600 0x20>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+		clocks = <&clkc CLKID_PERIPH>;
+	};
 };
 
 &pwm_ab {
-- 
2.19.2
