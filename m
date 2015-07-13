From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 Jul 2015 12:34:51 +0200
Subject: [PATCH] thermal: Add Mediatek thermal support
Message-ID: <1436783694-30717-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds support for the thermal sensors included in the
MT8173 SoC. Currently only basic temperature reading is supported
without any interrupt support.

The cpufreq driver for MT8173 is currently under review, so there's no
real cooling device available in mainline. Until this is available the
thermal driver can be tested with the following dts snippet. It creates
a fake gpio fan and a fake trip point which is so low that it can easily
be reached with a "cat /dev/zero > /dev/null" on the command line.

Please review and let me know what's missing to be included in mainline.

Sascha

	fan: gpio_fan {
		compatible = "gpio-fan";
		gpios = <&pio 24 0>;
		gpio-fan,speed-map = <0    0
				      4500 1>;
		#cooling-cells = <2>;
	};

	thermal-zones {
		cpu_thermal: cpu_thermal {
			polling-delay-passive = <1000>; /* milliseconds */
			polling-delay = <1000>; /* milliseconds */

			thermal-sensors = <&thermal 0>;

			trips {
				cpu_passive: cpu_passive {
					temperature = <47000>; /* millicelsius */
					hysteresis = <2000>; /* millicelsius */
					type = "passive";
				};

				cpu_crit {
					temperature = <90000>; /* millicelsius */
					hysteresis = <2000>; /* millicelsius */
					type = "critical";
				};
			};

			cooling-maps {
				map0 {
					trip = <&cpu_passive>;
					cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
				};
			};
		};
	};

----------------------------------------------------------------
Sascha Hauer (3):
      dt-bindings: thermal: Add binding document for Mediatek thermal controller
      thermal: Add Mediatek thermal controller support
      ARM64: dts: mt8173: Add thermal/auxadc device nodes

 .../bindings/thermal/mediatek-thermal.txt          |  38 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  18 +
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/mtk_thermal.c                      | 602 +++++++++++++++++++++
 5 files changed, 667 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
 create mode 100644 drivers/thermal/mtk_thermal.c
