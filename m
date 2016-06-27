From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 27 Jun 2016 17:02:41 +0800
Subject: [PATCH 03/10] Documentation: dt-bindings: firmware: tegra: add
 bindings of the BPMP
In-Reply-To: <20160627090248.23621-1-josephl@nvidia.com>
References: <20160627090248.23621-1-josephl@nvidia.com>
Message-ID: <20160627090248.23621-4-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BPMP is a specific processor in Tegra chip, which is designed for
booting process handling and offloading the power management tasks
from the CPU. The binding document defines the resources that would be
used by the BPMP firmware driver, which can create the interprocessor
communication (IPC) between the CPU and BPMP.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 .../bindings/firmware/nvidia,tegra186-bpmp.txt     | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt

diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
new file mode 100644
index 000000000000..34a252d87e17
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
@@ -0,0 +1,61 @@
+NVIDIA Tegra Boot and Power Management Processor (BPMP)
+
+The BPMP is a specific processor in Tegra chip, which is designed for
+booting process handling and offloading the power management tasks from
+the CPU. The binding document defines the resources that would be used by
+the BPMP firmware driver, which can create the interprocessor
+communication (IPC) between the CPU and BPMP.
+
+Required properties:
+- name : Should be bpmp
+- compatible : Should be "nvidia,tegra<chip>-bpmp"
+- mboxes : The phandle of mailbox controller and the channel ID
+           See "Documentation/devicetree/bindings/mailbox/
+	   nvidia,tegra186-hsp.txt" and "Documentation/devicetree/
+	   bindings/mailbox/mailbox.txt" for more details about the generic
+	   mailbox controller and mailbox client driver bindings.
+- shmem : List of the phandle of the TX and RX shared memory area that
+	  the IPC between CPU and BPMP is based on.
+- #clock-cells : Should be 1.
+- #reset-cells : Should be 1.
+
+The shared memory bindings for BPMP
+-----------------------------------
+
+The shared memory area for the IPC TX and RX between CPU and BPMP are
+predefined and work on top of sysram, which is a sram inside the chip.
+
+See "Documentation/devicetree/bindings/sram/sram.txt" for the bindings.
+
+Example:
+
+hsp_top: hsp at 03c00000 {
+	...
+	#mbox-cells = <1>;
+};
+
+bpmp at d0000000 {
+	compatible = "nvidia,tegra186-bpmp";
+	mboxes = <&hsp_mbox HSP_DB_MASTER_BPMP>;
+	shmem = <&cpu_bpmp_tx &cpu_bpmp_rx>;
+	#clock-cells = <1>;
+	#reset-cells = <1>;
+};
+
+sysram at 30000000 {
+	compatible = "nvidia,tegra186-sysram", "mmio-ram";
+	reg = <0x0 0x30000000 0x0 0x50000>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges = <0 0x0 0x0 0x30000000 0x0 0x50000>;
+
+	cpu_bpmp_tx: bpmp_shmem at 4e000 {
+		compatible = "nvidia,tegra186-bpmp-shmem";
+		reg = <0x0 0x4e000 0x0 0x1000>;
+	};
+
+	cpu_bpmp_rx: bpmp_shmem at 4f000 {
+		compatible = "nvidia,tegra186-bpmp-shmem";
+		reg = <0x0 0x4f000 0x0 0x1000>;
+	};
+};
-- 
2.9.0
