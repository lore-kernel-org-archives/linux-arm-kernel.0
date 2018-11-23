From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 23 Nov 2018 20:53:09 +0100
Subject: [PATCH 4/6] ARM: dts: meson8: add the Cortex-A9 global timer
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181123195311.4578-5-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Meson8 and Meson8m2 SoCs are using four Cortex-A9 cores. These come
with an ARM global timer.
This adds the Cortex-A9 global timer but keeps it disabled for now. The
timer is clocked by the "PERIPH" clock whose rate can change during
runtime (when changing the frequency of the CPU clock). Unfortunately
the arm_global_timer driver does not handle changes to the clock rate
yet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 2b0b3edbd896..2575a5835567 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -363,6 +363,19 @@
 		reg = <0x0 0x100>;
 	};
 
+	timer at 200 {
+		compatible = "arm,cortex-a9-global-timer";
+		reg = <0x200 0x20>;
+		interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+		clocks = <&clkc CLKID_PERIPH>;
+
+		/*
+		 * the arm_global_timer driver currently does not handle clock
+		 * rate changes. Keep it disabled for now.
+		 */
+		status = "disabled";
+	};
+
 	timer at 600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x600 0x20>;
-- 
2.19.2
