From: liwei213@huawei.com (Li Wei)
Date: Fri, 13 Oct 2017 15:49:33 +0800
Subject: [PATCH v4 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs
In-Reply-To: <20171013074936.97284-1-liwei213@huawei.com>
References: <20171013074936.97284-1-liwei213@huawei.com>
Message-ID: <20171013074936.97284-3-liwei213@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add ufs node document for Hisilicon.

Signed-off-by: Li Wei <liwei213@huawei.com>
---
 Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt

diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
new file mode 100644
index 000000000000..ee114a65143d
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
@@ -0,0 +1,47 @@
+* Hisilicon Universal Flash Storage (UFS) Host Controller
+
+UFS nodes are defined to describe on-chip UFS hardware macro.
+Each UFS Host Controller should have its own node.
+
+Required properties:
+- compatible        : compatible list, contains one of the following -
+			"hisilicon,hi3660-ufs" for hisi ufs host controller
+			 present on Hi3660 chipset.
+- reg               : should contain UFS register address space & UFS SYS CTRL register address,
+- interrupt-parent  : interrupt device
+- interrupts        : interrupt number
+- clocks	        : List of phandle and clock specifier pairs
+- clock-names       : List of clock input name strings sorted in the same
+		      order as the clocks property. "clk_ref", "clk_phy" is optional
+- resets            : reset node register, one reset the clk and the other reset the controller
+- reset-names       : describe reset node register
+
+Optional properties for board device:
+- reset-gpio			: specifies to reset devices
+
+Example:
+
+	ufs: ufs at ff3b0000 {
+		compatible = "hisilicon,hi3660-ufs", "jedec,ufs-1.1";
+		/* 0: HCI standard */
+		/* 1: UFS SYS CTRL */
+		reg = <0x0 0xff3b0000 0x0 0x1000>,
+			<0x0 0xff3b1000 0x0 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
+			<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
+		clock-names = "clk_ref", "clk_phy";
+		freq-table-hz = <0 0>, <0 0>;
+		/* offset: 0x84; bit: 12 */
+		/* offset: 0x84; bit: 7  */
+		resets = <&crg_rst 0x84 12>,
+			<&crg_rst 0x84 7>;
+		reset-names = "rst", "assert";
+	};
+
+	&ufs {
+		reset-gpio = <&gpio18 1 0>;
+		status = "okay";
+	};
+
-- 
2.11.0
