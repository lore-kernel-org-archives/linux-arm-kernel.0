From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Feb 2017 17:39:19 +0100
Subject: [PATCH 5/8] ARM: sun8i: a33: Add shared display memory pool
In-Reply-To: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
Message-ID: <cbbbc887fcebed08f60c5424c8cbd65a3467ce96.1486655917.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory buffers might need to be allocated and shared from both the
scanout and the GPU.

Create a memory region reserved for their own usage so that each can
allocate from it, and get the informations on the region that is going to
be used (size and offset).

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 5a9ba43ccb07..043b1b017276 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -97,6 +97,7 @@
 	de: display-engine {
 		compatible = "allwinner,sun8i-a33-display-engine";
 		allwinner,pipelines = <&fe0>;
+		memory-region = <&display_pool>;
 		status = "disabled";
 	};
 
@@ -104,6 +105,18 @@
 		reg = <0x40000000 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		display_pool: cma {
+			compatible = "shared-dma-pool";
+			size = <0x1000000>;
+			reusable;
+		};
+	};
+
 	soc at 01c00000 {
 		tcon0: lcd-controller at 01c0c000 {
 			compatible = "allwinner,sun8i-a33-tcon";
@@ -267,6 +280,10 @@
 	compatible = "allwinner,sun8i-a33-ccu";
 };
 
+&mali {
+	memory-region = <&display_pool>;
+};
+
 &pio {
 	compatible = "allwinner,sun8i-a33-pinctrl";
 	interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-- 
git-series 0.8.11
