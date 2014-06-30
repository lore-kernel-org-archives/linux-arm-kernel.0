From: elder@linaro.org (Alex Elder)
Date: Mon, 30 Jun 2014 17:09:45 -0500
Subject: [PATCH] devicetree: bindings: document Broadcom CPU enable method
Message-ID: <1404166185-4168-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom mobile SoCs use a ROM-implemented holding pen for
controlled boot of secondary cores.  A special register is
used to communicate to the ROM that a secondary core should
start executing kernel code.  This enable method is currently
used for members of the bcm281xx and bcm21664 SoC families.

The use of an enable method also allows the SMP operation vector to
be assigned as a result of device tree content for these SoCs.

Signed-off-by: Alex Elder <elder@linaro.org>
---
Notes:
  - This patch was previously posted as part of this series:
	https://lkml.org/lkml/2014/6/16/580
  - The binding definition is now found in a separate file rather
    than embedding it in:
	Documentation/devicetree/bindings/arm/cpus.txt

 .../bindings/arm/bcm/brcm,bcm11351-cpu-method      | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method
new file mode 100644
index 0000000..8240c02
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method
@@ -0,0 +1,36 @@
+Broadcom Kona Family CPU Enable Method
+--------------------------------------
+This binding defines the enable method used for starting secondary
+CPUs in the following Broadcom SoCs:
+  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155, BCM21664
+
+The enable method is specified by defining the following required
+properties in the "cpus" device tree node:
+  - enable-method = "brcm,bcm11351-cpu-method";
+  - secondary-boot-reg = <...>;
+
+The secondary-boot-reg property is a u32 value that specifies the
+physical address of the register used to request the ROM holding pen
+code release a secondary CPU.  The value written to the register is
+formed by encoding the target CPU id into the low bits of the
+physical start address it should jump to.
+
+Example:
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "brcm,bcm11351-cpu-method";
+		secondary-boot-reg = <0x3500417c>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
-- 
1.9.1
