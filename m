From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 16 Mar 2015 15:20:32 +0100
Subject: [PATCH v2 2/5] PCI: st: Add Device Tree bindings for sti pcie
In-Reply-To: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1426515635-9466-3-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sti pcie is built around a Synopsis Designware PCIe IP.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 Documentation/devicetree/bindings/pci/st-pcie.txt | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/st-pcie.txt b/Documentation/devicetree/bindings/pci/st-pcie.txt
new file mode 100644
index 0000000..94aae2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/st-pcie.txt
@@ -0,0 +1,54 @@
+STMicroelectronics STi PCIe controller
+
+This PCIe host controller is based on the Synopsis Designware PCIe IP
+and thus inherits all the common properties defined in designware-pcie.txt.
+
+Required properties:
+ - compatible: "st,stih407-pcie"
+ - reg: base address and length of the pcie controller, mem-window address
+   and length available to the controller.
+ - interrupts: A list of interrupt outputs of the controller. Must contain an
+   entry for each entry in the interrupt-names property.
+ - interrupt-names: Should be "msi". STi interrupt that is asserted when an
+   MSI is received.
+ - st,syscfg : should be a phandle of the syscfg node. Also contains syscfg
+   offset for IP configuration.
+ - resets, reset-names: the power-down and soft-reset lines of PCIe IP.
+   Associated names must be "powerdown" and "softreset".
+ - phys, phy-names: the phandle for the PHY device.
+   Associated name must be "pcie"
+
+Optional properties:
+ - reset-gpio: a GPIO spec to define which pin is connected to the bus reset.
+
+Example:
+
+pcie0: pcie at 9b00000 {
+	compatible = "st,stih407-pcie", "snps,dw-pcie";
+	device_type = "pci";
+	reg = <0x09b00000 0x4000>,	/* dbi cntrl registers */
+	      <0x2fff0000 0x00010000>,	/* configuration space */
+	      <0x40000000 0x80000000>;	/* lmi mem window */
+	reg-names = "dbi", "config", "mem-window";
+	st,syscfg = <&syscfg_core 0xd8 0xe0>;
+	#address-cells = <3>;
+	#size-cells = <2>;
+	ranges = <0x00000800 0 0x2fff0000 0x2fff0000 0 0x00010000   /* configuration space */
+		  0x82000000 0 0x20000000 0x20000000 0 0x0FFF0000>; /* non-prefetchable memory */
+	num-lanes = <1>;
+	interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "msi";
+	#interrupt-cells = <1>;
+	interrupt-map-mask = <0 0 0 7>;
+	interrupt-map = <0 0 0 1 &intc GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>, /* INT A */
+			<0 0 0 2 &intc GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>, /* INT B */
+			<0 0 0 3 &intc GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>, /* INT C */
+			<0 0 0 4 &intc GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>; /* INT D */
+
+	resets = <&powerdown STIH407_PCIE0_POWERDOWN>,
+		 <&softreset STIH407_PCIE0_SOFTRESET>;
+	reset-names = "powerdown",
+		      "softreset";
+	phys = <&phy_port0 PHY_TYPE_PCIE>;
+	phy-names = "pcie";
+};
-- 
1.9.1
