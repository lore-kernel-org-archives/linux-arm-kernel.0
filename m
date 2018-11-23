From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 23 Nov 2018 20:53:11 +0100
Subject: [PATCH 6/6] ARM: dts: meson8b: add the Cortex-A5 global timer
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181123195311.4578-7-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Meson8b SoC is using four Cortex-A5 cores. These come with an ARM
global timer.
This adds the Cortex-A5 global timer but keeps it disabled for now. The
timer is clocked by the "PERIPH" clock whose rate can change during
runtime (when changing the frequency of the CPU clock). Unfortunately
the arm_global_timer driver does not handle changes to the clock rate
yet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index a3a5649e32fa..a38d187d3d6e 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -350,6 +350,19 @@
 		reg = <0x0 0x100>;
 	};
 
+	timer at 200 {
+		compatible = "arm,cortex-a5-global-timer";
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
 		compatible = "arm,cortex-a5-twd-timer";
 		reg = <0x600 0x20>;
-- 
2.19.2
