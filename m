From: alex.elder@linaro.org (Alex Elder)
Date: Tue, 03 Dec 2013 21:56:58 -0600
Subject: [PATCH 1/3] clk: bcm281xx: define kona clock binding
In-Reply-To: <529EA78E.7060904@linaro.org>
References: <529EA78E.7060904@linaro.org>
Message-ID: <529EA80A.60801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device tree binding for Broadcom Kona architecture
clock control units and clocks.  Kona device nodes are represented
with compatible strings having "bcm11351" in their name.

Kona clocks are managed by "clock control units" (CCUs).  Each CCU
has a device tree node, and within that node are defined the names
of the clocks provided by the CCU.

The BCM281xx family of SoCs use Kona CCUs and clocks.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
---
 .../devicetree/bindings/clock/bcm-kona-clock.txt   |   95
++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/clock/bcm-kona-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/bcm-kona-clock.txt
b/Documentation/devicetree/bindings/clock/bcm-kona-clock.txt
new file mode 100644
index 0000000..0cafd6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/bcm-kona-clock.txt
@@ -0,0 +1,95 @@
+Broadcom Kona Family Clocks
+
+This binding is associated with Broadcom SoCs having "Kona" style
+clock control units (CCUs).  A CCU is a clock provider that manages
+a set of clock signals.  Each CCU is represented by a node in the
+device tree.
+
+This binding uses the common clock binding:
+    Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Many source clocks are described using the "fixed-clock" binding:
+    Documentation/devicetree/bindings/clock/fixed-clock.txt
+
+Required properties:
+- compatible
+	Shall have a value "brcm,bcm11351-<which>-ccu", where
+	<which> identifies the particular CCU (see below).
+- reg
+	Shall define the base and range of the address space
+	containing clock control registers
+- #clock-cells
+	Shall have the value <1>
+- clock-output-names
+	Shall be an ordered list of strings defining the names of
+	the clocks provided by the CCU.
+
+Clock consumers refer to a particular clock supplied by a CCU using
+a phandle and specifier pair, using the phandle for the CCU device
+tree node and the clock's symbolic specifier.  The clock specifier
+is a CCU-unique 0-based index value.
+
+
+BCM281XX family SoCs use Kona CCUs.  The following table defines
+the set of CCUs and clock specifiers for BCM281XX clocks.  The
+compatible string for the CCU uses the name in the "CCU" column
+below as it's <which> value.
+
+    CCU     Clock           Type    Index   Specifier
+    ---     -----           ----    -----   ---------
+    root    frac_1m         peri      0     BCM281XX_ROOT_CCU_FRAC_1M
+
+    aon     hub_timer       peri      0     BCM281XX_AON_CCU_HUB_TIMER
+    aon     pmu_bsc         peri      1     BCM281XX_AON_CCU_PMU_BSC
+    aon     pmu_bsc_var     peri      2     BCM281XX_AON_CCU_PMU_BSC_VAR
+
+    hub     tmon_1m         peri      0     BCM281XX_HUB_CCU_TMON_1M
+
+    master  sdio1           peri      0     BCM281XX_MASTER_CCU_SDIO1
+    master  sdio2           peri      1     BCM281XX_MASTER_CCU_SDIO2
+    master  sdio3           peri      2     BCM281XX_MASTER_CCU_SDIO3
+    master  sdio4           peri      3     BCM281XX_MASTER_CCU_SDIO4
+    master  dmac            peri      4     BCM281XX_MASTER_CCU_DMAC
+    master  usb_ic          peri      5     BCM281XX_MASTER_CCU_USB_IC
+    master  hsic2_48m       peri      6     BCM281XX_MASTER_CCU_HSIC_48M
+    master  hsic2_12m       peri      7     BCM281XX_MASTER_CCU_HSIC_12M
+
+    slave   uartb           peri      0     BCM281XX_SLAVE_CCU_UARTB
+    slave   uartb2          peri      1     BCM281XX_SLAVE_CCU_UARTB2
+    slave   uartb3          peri      2     BCM281XX_SLAVE_CCU_UARTB3
+    slave   uartb4          peri      3     BCM281XX_SLAVE_CCU_UARTB4
+    slave   ssp0            peri      4     BCM281XX_SLAVE_CCU_SSP0
+    slave   ssp2            peri      5     BCM281XX_SLAVE_CCU_SSP2
+    slave   bsc1            peri      6     BCM281XX_SLAVE_CCU_BSC1
+    slave   bsc2            peri      7     BCM281XX_SLAVE_CCU_BSC2
+    slave   bsc3            peri      8     BCM281XX_SLAVE_CCU_BSC3
+    slave   pwm             peri      9     BCM281XX_SLAVE_CCU_PWM
+
+
+Device tree example:
+
+	clocks {
+		slave_ccu: slave_ccu {
+			compatible = "brcm,bcm11351-slave-ccu";
+			reg = <0x3e011000 0x0f00>;
+			#clock-cells = <1>;
+			clock-output-names = "uartb",
+					     "uartb2",
+					     "uartb3",
+					     "uartb4";
+		};
+		ref_crystal_clk: ref_crystal {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <26000000>;
+		};
+	};
+	uart at 3e002000 {
+		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
+		status = "disabled";
+		reg = <0x3e002000 0x1000>;
+		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_UARTB3>;
+		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+	};
-- 1.7.9.5
