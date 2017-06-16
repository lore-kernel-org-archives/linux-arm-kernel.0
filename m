From: butao@hisilicon.com (Bu Tao)
Date: Fri, 16 Jun 2017 14:51:16 +0800
Subject: [PATCH v2 2/5] dt-bindings: scsi: ufs: add document for hi3660-ufs
In-Reply-To: <20170616065119.10704-1-butao@hisilicon.com>
References: <20170616065119.10704-1-butao@hisilicon.com>
Message-ID: <20170616065119.10704-3-butao@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add ufs node document for hi3660

Signed-off-by: Bu Tao <butao@hisilicon.com>
---
 .../devicetree/bindings/ufs/hi3660-ufs.txt         | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/hi3660-ufs.txt

diff --git a/Documentation/devicetree/bindings/ufs/hi3660-ufs.txt b/Documentation/devicetree/bindings/ufs/hi3660-ufs.txt
new file mode 100644
index 000000000000..461afc8ef017
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/hi3660-ufs.txt
@@ -0,0 +1,58 @@
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
+- ufs-hi3660-use-rate-B		: specifies UFS rate-B
+- ufs-hi3660-broken-fastauto	: specifies no fastauto
+- ufs-hi3660-use-HS-GEAR3	: specifies UFS HS-GEAR3
+- ufs-hi3660-use-HS-GEAR2	: specifies UFS HS-GEAR2
+- ufs-hi3660-use-HS-GEAR1	: specifies UFS HS-GEAR1
+- ufs-hi3660-broken-clk-gate-bypass	: specifies no clk-gate
+- ufs-hi3660-use-one-line	: specifies UFS use one line work
+- reset-gpio			: specifies to reset devices
+
+Example:
+
+		ufs: ufs at ff3b0000 {
+			compatible = "jedec,ufs-1.1", "hisilicon,hi3660-ufs";
+			/* 0: HCI standard */
+			/* 1: UFS SYS CTRL */
+			reg = <0x0 0xff3b0000 0x0 0x1000>,
+				<0x0 0xff3b1000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
+				<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
+			clock-names = "clk_ref", "clk_phy";
+			freq-table-hz = <0 0>, <0 0>;
+			/* offset: 0x84; bit: 12 */
+			/* offset: 0x84; bit: 7  */
+			resets = <&crg_rst 0x84 12>,
+				<&crg_rst 0x84 7>;
+			reset-names = "rst", "assert";
+		}
+
+		&ufs {
+		        ufs-hi3660-use-rate-B;
+		        ufs-hi3660-broken-fastauto;
+		        ufs-hi3660-use-HS-GEAR3;
+			ufs-hi3660-broken-clk-gate-bypass;
+			reset-gpio = <&gpio18 1 0>;
+			status = "okay";
+		}
+
-- 
2.11.GIT
