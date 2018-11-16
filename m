From: jolly.shah@xilinx.com (Jolly Shah)
Date: Fri, 16 Nov 2018 15:56:50 -0800
Subject: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
Message-ID: <1542412619-387-1-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Base firmware node and clock child node binding are part of mainline kernel. This patchset adds documentation to describe rest of the firmware child node bindings. 
Complete firmware DT node example is shown below for ease of understanding:

firmware {
	zynqmp_firmware: zynqmp-firmware {
		compatible = "xlnx,zynqmp-firmware";
		method = "smc";
		#power-domain-cells = <1>;
		#reset-cells = <1>;

		zynqmp_clk: clock-controller {
			#clock-cells = <1>;
			compatible = "xlnx,zynqmp-clk";
			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
		};

		zynqmp_power: zynqmp-power {
			compatible = "xlnx,zynqmp-power";
			interrupts = <0 35 4>;
		};

		nvmem_firmware {
			compatible = "xlnx,zynqmp-nvmem-fw";
			#address-cells = <1>;
			#size-cells = <1>;

			/* Data cells */
			soc_revision: soc_revision {
				reg = <0x0 0x4>;
			};
		};

		afi0: afi0 {
			compatible = "xlnx,afi-fpga";
			config-afi = <0 2>, <1 1>, <2 1>;
		};

		qspi: spi at ff0f0000 {
			compatible = "xlnx,zynqmp-qspi-1.0";
			clock-names = "ref_clk", "pclk";
			clocks = <&misc_clk &misc_clk>;
			interrupts = <0 15 4>;
			interrupt-parent = <&gic>;
			num-cs = <1>;
			reg = <0x0 0xff0f0000 0x1000>,<0x0 0xc0000000 0x8000000>;
		};

		serdes: zynqmp_phy at fd400000 {
			compatible = "xlnx,zynqmp-psgtr";
			status = "okay";
			reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>,
				<0x0 0xff5e0000 0x0 0x1000>;
			reg-names = "serdes", "siou", "lpd";

			lane0: lane at 0 {
				#phy-cells = <4>;
			};
			lane1: lane at 1 {
				#phy-cells = <4>;
			};
			lane2: lane at 2 {
				#phy-cells = <4>;
			};
			lane3: lane at 3 {
				#phy-cells = <4>;
			};
		};

		pinctrl_uart1_default: uart1-default {
			mux {
				groups = "uart0_4_grp";
				function = "uart0";
			};

			conf {
				groups = "uart0_4_grp";
				slew-rate = <SLEW_RATE_SLOW>;
				io-standard = <IO_STANDARD_LVCMOS18>;
			};

			conf-rx {
				pins = "MIO18";
				bias-high-impedance;
			};

			conf-tx {
				pins = "MIO19";
				bias-disable;
				schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
			};
		};
		zynqmp-r5-remoteproc at 0 {
			compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
			reg = <0x0 0xFFE00000 0x0 0x10000>,
				<0x0 0xFFE20000 0x0 0x10000>,
				<0x0 0xff340000 0x0 0x100>;
			reg-names = "tcm_a", "tcm_b", "ipi";
			dma-ranges;
			core_conf = "split0";
			memory-region = <&rproc_0_fw_reserved>,
					<&rproc_0_dma_reserved>;
			tcm-pnode-id = <0xf>, <0x10>;
			rpu-pnode-id = <0x7>;
			interrupt-parent = <&gic>;
			interrupts = <0 29 4>;
		};
	};
};

Jolly Shah (2):
  dt-bindings: phy: Add dt bindings for ZynqMP PHY
  dt-bindings: fpga: Add binding doc for the afi config driver

Nava kishore Manne (2):
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver

Rajan Vaja (4):
  dt-bindings: power: Add ZynqMP power domain bindings
  dt-bindings: soc: Add ZynqMP PM bindings
  dt-bindings: pinctrl: Add ZynqMP pin controller bindings
  dt-bindings: spi: zynqmp: Move SPI node under zynqmp firmware

Wendy Liang (1):
  dt-bindings: remoteproc: Add Xilinx R5 rproc binding

 .../devicetree/bindings/fpga/xlnx,afi-fpga.txt     |  67 +++++
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt           |  44 ++++
 .../devicetree/bindings/phy/phy-zynqmp.txt         | 126 ++++++++++
 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.txt       | 272 +++++++++++++++++++++
 .../bindings/power/reset/xlnx,zynqmp-power.txt     |  25 ++
 .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 +++
 .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       |  81 ++++++
 .../bindings/reset/xlnx,zynqmp-reset.txt           | 148 +++++++++++
 .../devicetree/bindings/spi/spi-zynqmp-qspi.txt    |  22 +-
 include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 +++
 10 files changed, 850 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,afi-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

-- 
2.7.4
