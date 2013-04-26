From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 26 Apr 2013 18:27:46 +0200
Subject: [PATCH 5/6] ARM: shmobile: r8a7740: add DT node for one DMAC instance
In-Reply-To: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
References: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1366993667-23294-6-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds  Device Tree support for the first (#0) DMA controller
instance on r8a7740. We want to add further DMA controller DT nodes in
a DMA multiplexer node, which isn't implemented yet. Further DMAC
instances will be added after the DMA multiplexer support is done.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7740.dtsi         |   20 ++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c |    2 ++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index e9a90d8..054bc1a 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -112,6 +112,26 @@
 			      0 149 0x4>;
 	};
 
+	dma0: shdma at fe008020 {
+		compatible = "renesas,shdma";
+		reg = <0xfe008020 0x270
+			0xfe009000 0xc>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 34 4
+				0 28 4
+				0 29 4
+				0 30 4
+				0 31 4
+				0 32 4
+				0 33 4>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5";
+		#dma-cells = <1>;
+		dma-channels = <6>;
+		dma-requests = <256>;
+	};
+
 	i2c0: i2c at fff20000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 6b3ed42..7781d3b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -997,6 +997,8 @@ void __init r8a7740_add_early_devices(void)
 #ifdef CONFIG_USE_OF
 
 static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("renesas,shdma", 0xfe008020, "sh-dma-engine.0",
+		       &r8a7740_dma_platform_data),
 	{ }
 };
 
-- 
1.7.2.5
