From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 31 Oct 2011 20:58:55 +0100
Subject: [PATCH 3/3] arm/dt: tegra: add dts file for paz00
In-Reply-To: <cover.1320088857.git.marvin24@gmx.de>
References: <cover.1320088857.git.marvin24@gmx.de>
Message-ID: <855f09f77c03a9f081818a03effdbd3bf7a30c91.1320088857.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a dts file for paz00. As a side effect, this also enables
the embedded controller which controls the keyboard, touchpad, power,
leds, and some other functions.

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/boot/dts/tegra-paz00.dts |   78 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/Makefile      |    1 +
 arch/arm/mach-tegra/Makefile.boot |    1 +
 arch/arm/mach-tegra/board-dt.c    |    3 +
 4 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra-paz00.dts

diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
new file mode 100644
index 0000000..7eebd16
--- /dev/null
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -0,0 +1,78 @@
+/dts-v1/;
+
+/memreserve/ 0x1c000000 0x04000000;
+/include/ "tegra20.dtsi"
+
+/ {
+	model = "Toshiba AC100 / Dynabook AZ";
+	compatible = "compal,paz00", "nvidia,tegra20";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 root=/dev/mmcblk0p1";
+	};
+
+	memory at 0 {
+		reg = <0x00000000 0x20000000>;
+	};
+
+	i2c at 7000c000 {
+		clock-frequency = <400000>;
+	};
+
+	i2c at 7000c400 {
+		clock-frequency = <400000>;
+	};
+
+	i2c at 7000c500 {
+		status = "disable";
+	};
+
+	nvec at 7000c500 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nvidia,nvec";
+		reg = <0x7000C500 0x100>;
+		interrupts = <124>;
+		clock-frequency = <80000>;
+		request-gpios = <&gpio 170 0>;
+		slave-addr = <138>;
+	};
+
+	i2c at 7000d000 {
+		clock-frequency = <400000>;
+	};
+
+	serial at 70006000 {
+		clock-frequency = <216000000>;
+	};
+
+	serial at 70006040 {
+		status = "disable";
+	};
+
+	serial at 70006200 {
+		status = "disable";
+	};
+
+	serial at 70006300 {
+		clock-frequency = <216000000>;
+	};
+
+	sdhci at c8000000 {
+		cd-gpios = <&gpio 173 0>; /* gpio PV5 */
+		wp-gpios = <&gpio 57 0>;  /* gpio PH1 */
+		power-gpios = <&gpio 155 0>; /* gpio PT3 */
+	};
+
+	sdhci at c8000200 {
+		status = "disable";
+	};
+
+	sdhci at c8000400 {
+		status = "disable";
+	};
+
+	sdhci at c8000600 {
+		support-8bit;
+	};
+};
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 91a07e1..b04ebfe6 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -31,6 +31,7 @@ obj-${CONFIG_MACH_SEABOARD}             += board-seaboard-pinmux.o
 
 obj-${CONFIG_MACH_TEGRA_DT}             += board-dt.o
 obj-${CONFIG_MACH_TEGRA_DT}             += board-harmony-pinmux.o
+obj-${CONFIG_MACH_TEGRA_DT}             += board-paz00-pinmux.o
 obj-${CONFIG_MACH_TEGRA_DT}             += board-seaboard-pinmux.o
 
 obj-${CONFIG_MACH_TRIMSLICE}            += board-trimslice.o
diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
index bd12c9f..152f9fb 100644
--- a/arch/arm/mach-tegra/Makefile.boot
+++ b/arch/arm/mach-tegra/Makefile.boot
@@ -3,5 +3,6 @@ params_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00000100
 initrd_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00800000
 
 dtb-$(CONFIG_MACH_HARMONY) += tegra-harmony.dtb
+dtb-$(CONFIG_MACH_PAZ00) += tegra-paz00.dtb
 dtb-$(CONFIG_MACH_SEABOARD) += tegra-seaboard.dtb
 dtb-$(CONFIG_MACH_VENTANA) += tegra-ventana.dtb
diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index d368f8d..379660e 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -46,6 +46,7 @@
 #include "devices.h"
 
 void harmony_pinmux_init(void);
+void paz00_pinmux_init(void);
 void seaboard_pinmux_init(void);
 void ventana_pinmux_init(void);
 
@@ -85,6 +86,7 @@ static struct {
 	void (*init)(void);
 } pinmux_configs[] = {
 	{ "nvidia,harmony", harmony_pinmux_init },
+	{ "compal,paz00", paz00_pinmux_init },
 	{ "nvidia,seaboard", seaboard_pinmux_init },
 	{ "nvidia,ventana", ventana_pinmux_init },
 };
@@ -120,6 +122,7 @@ static void __init tegra_dt_init(void)
 
 static const char * tegra_dt_board_compat[] = {
 	"nvidia,harmony",
+	"compal,paz00",
 	"nvidia,seaboard",
 	"nvidia,ventana",
 	NULL
-- 
1.7.5.4
