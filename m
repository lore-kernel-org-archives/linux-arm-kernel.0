From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  7 Jul 2018 21:42:46 +0200
Subject: [PATCH v2 1/2] ARM: dts: pxa: add pincontrol helpers
Message-ID: <20180707194247.31143-1-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 3 helpers so that pincontrol definitions for pxa25x and pxa27x are
easier, and can be easily converted from old mfp mach-pxa code to
devicetree.

An example of such conversion would be :
static unsigned long mioa701_pin_config[] = {
	GPIO32_MMC_CLK,
	GPIO92_MMC_DAT_0,
	GPIO109_MMC_DAT_1,
	GPIO110_MMC_DAT_2,
	GPIO111_MMC_DAT_3,
	GPIO112_MMC_CMD,
	MIO_CFG_IN(GPIO78_SDIO_RO, AF0),
	MIO_CFG_IN(GPIO15_SDIO_INSERT, AF0),
	MIO_CFG_OUT(GPIO91_SDIO_EN, AF0, DRIVE_LOW),
};
into:
	pinctrl_mmc_default: mmc-default {
		PMMUX(sd-insert, 15, gpio_in);
		PMMUX(mmclk, 32, MMCLK);
		PMMUX(sd-ro, 78, gpio_in);
		PMMUX_LPM_LOW(sd-enable, 91, gpio_out);
		PMMUX(mmdat0, 92, MMDAT<0>);
		PMMUX(mmdat1, 109, MMDAT<1>);
		PMMUX(mmdat2, 110, MMDAT<2>);
		PMMUX(mmdat3, 111, MMDAT<3>);
		PMMUX(mmcmd, 112, MMCMD);
	};

The third column of PMMUX*() helpers can be found in pincontrol muxing
functions, either in pinctrl-pxa27x.c (or pinctrl-pxa25x.c), or by
inspecting the pincontrol once booted in debugfs.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index e4ebcde17837..f609dbb86abf 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -9,6 +9,25 @@
 #include "skeleton.dtsi"
 #include "dt-bindings/clock/pxa-clock.h"
 
+#define PMGROUP(pin) #pin
+#define PMMUX(func, pin, af)			\
+	mux- ## func {				\
+		groups = PMGROUP(P ## pin);	\
+		function = #af;			\
+	}
+#define PMMUX_LPM_LOW(func, pin, af)		\
+	mux- ## func {				\
+		groups = PMGROUP(P ## pin);	\
+		function = #af;			\
+		low-power-disable;		\
+	}
+#define PMMUX_LPM_HIGH(func, pin, af)		\
+	mux- ## func {				\
+		groups = PMGROUP(P ## pin);	\
+		function = #af;			\
+		low-power-enable;		\
+	}
+
 / {
 	model = "Marvell PXA2xx family SoC";
 	compatible = "marvell,pxa2xx";
-- 
2.11.0
