From: alex.elder@linaro.org (Alex Elder)
Date: Wed, 04 Dec 2013 09:33:16 -0600
Subject: [PATCH v2 1/3] clk: bcm281xx: define kona clock binding
In-Reply-To: <529F4B0F.2020801@linaro.org>
References: <529F4B0F.2020801@linaro.org>
Message-ID: <529F4B3C.4020608@linaro.org>
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
v2: - list all CCU compatible strings explicitly
    - reworded a few things, and deleted some text
    - CCUs and clocks are now defined at the root level
    - added reference to header file that defines specifiers

 .../devicetree/bindings/clock/bcm-kona-clock.txt   |   93
++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/clock/bcm-kona-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/bcm-kona-clock.txt
b/Documentation/devicetree/bindings/clock/bcm-kona-clock.txt
new file mode 100644
index 0000000..56d1f49
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/bcm-kona-clock.txt
@@ -0,0 +1,93 @@
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
+Required properties:
+- compatible
+	Shall have one of the following values:
+	- "brcm,bcm11351-root-ccu"
+	- "brcm,bcm11351-aon-ccu"
+	- "brcm,bcm11351-hub-ccu"
+	- "brcm,bcm11351-master-ccu"
+	- "brcm,bcm11351-slave-ccu"
+- reg
+	Shall define the base and range of the address space
+	containing clock control registers
+- #clock-cells
+	Shall have value <1>.  The permitted clock-specifier values
+	are defined below.
+- clock-output-names
+	Shall be an ordered list of strings defining the names of
+	the clocks provided by the CCU.
+
+
+BCM281XX family SoCs use Kona CCUs.  The following table defines
+the set of CCUs and clock specifiers for BCM281XX clocks.  When
+a clock consumer references a clocks, its symbolic specifier
+(rather than its numeric index value) should be used.  These
+specifiers are defined in "include/dt-bindings/clock/bcm281xx.h".
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
+	slave_ccu: slave_ccu {
+		compatible = "brcm,bcm11351-slave-ccu";
+		reg = <0x3e011000 0x0f00>;
+		#clock-cells = <1>;
+		clock-output-names = "uartb",
+				     "uartb2",
+				     "uartb3",
+				     "uartb4";
+	};
+
+	ref_crystal_clk: ref_crystal {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+	};
+
+	uart at 3e002000 {
+		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
+		status = "disabled";
+		reg = <0x3e002000 0x1000>;
+		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_UARTB3>;
+		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+	};
-- 
1.7.9.5
