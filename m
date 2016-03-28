From: robh@kernel.org (Rob Herring)
Date: Mon, 28 Mar 2016 14:47:56 -0500
Subject: [PATCH v4 4/5] dt-bindings: arm: add DT binding for Marvell
 CP110 system controller
In-Reply-To: <1459070777-18049-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459070777-18049-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160328194756.GA28967@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 27, 2016 at 11:26:16AM +0200, Thomas Petazzoni wrote:
> This commit adds the DT binding documentation for the Marvell CP110
> system controller, which is part of the CP110 HW block, itself used in
> the Marvell Armada 7K and 8K SoCs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../arm/marvell/cp110-system-controller0.txt       | 88 ++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
> new file mode 100644
> index 0000000..e8883da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
> @@ -0,0 +1,88 @@
> +Marvell Armada CP110 System Controller 0
> +========================================
> +
> +The CP110 is one of the two core HW blocks of the Marvell Armada 7K/8K
> +SoCs. It contains two sets of system control registers, System
> +Controller 0 and System Controller 1. This Device Tree binding allows
> +to describe the first system controller, which provides registers to
> +configure various aspects of the SoC.
> +
> +The Device Tree node representing this System Controller 0 provides a
> +number of clocks:
> +
> + - a set of core clocks
> + - a set of gatable clocks
> +
> +Those clocks can be referenced by other Device Tree nodes using two
> +cells:
> + - The first cell must be 0 or 1. 0 for the core clocks and 1 for the
> +   gatable clocks.
> + - The second cell identifies the particular core clock or gatable
> +   clocks.
> +
> +The following clocks are available:
> + - Core clocks
> +   - 0 0	APLL
> +   - 0 1	PPv2 core
> +   - 0 2	EIP
> +   - 0 3	Core
> +   - 0 4	NAND core
> + - Gatable clocks
> +   - 1 0	Audio
> +   - 1 1	Comm Unit
> +   - 1 2	NAND
> +   - 1 3	PPv2
> +   - 1 4	SDIO
> +   - 1 5	MG Domain
> +   - 1 6	MG Core
> +   - 1 7	XOR1
> +   - 1 8	XOR0
> +   - 1 9	GOP DP
> +   - 1 11	PCIe x1 0
> +   - 1 12	PCIe x1 1
> +   - 1 13	PCIe x4
> +   - 1 14	PCIe / XOR
> +   - 1 15	SATA
> +   - 1 16	SATA USB
> +   - 1 18	GOP Macro
> +   - 1 22	USB3H0
> +   - 1 23	USB3H1
> +   - 1 24	USB3 Device
> +   - 1 25	EIP150
> +   - 1 26	EIP197
> +
> +Required properties:
> +
> + - compatible: must be:
> +     "marvell,cp110-system-controller0", "syscon";

This block is really the same across SoCs? 

> + - reg: register area of the CP110 system controller 0
> + - #clock-cells: must be set to 2
> + - core-clock-output-names must be set to:
> +    "cpm-apll", "cpm-ppv2-core", "cpm-eip", "cpm-core", "cpm-nand-core"
> + - gatable-clock-indices must be set to:
> +	<0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>, <8>,
> +	<9>, <11>, <12>, <13>, <14>, <15>, <16>, <18>,
> +	<22>, <23>, <24>, <25>, <26>

You aren't skipping very many spots. I'd just fill the unused names in 
with "none" or something.

> + - gatable-clock-output-names must be set to:
> +	"cpm-audio", "cpm-communit", "cpm-nand", "cpm-ppv2", "cpm-sdio",
> +	"cpm-mg-domain", "cpm-mg-core", "cpm-xor1", "cpm-xor0", "cpm-gop-dp", "cpm-pcie_x10",
> +	"cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor", "cpm-sata", "cpm-sata-usb",
> +	"cpm-gop-macro", "cpm-usb3h0", "cpm-usb3h1", "cpm-usb3dev", "cpm-eip150",
> +	"cpm-eip197"
> +
> +Example:
> +
> +	cpm_syscon0: system-controller at 440000 {
> +		compatible = "marvell,cp110-system-controller0", "syscon";
> +		reg = <0x440000 0x1000>;
> +		#clock-cells = <2>;
> +		core-clock-output-names = "cpm-apll", "cpm-ppv2-core", "cpm-eip", "cpm-core", "cpm-nand-core";
> +		gate-clock-indices = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>, <8>,
> +			<9>, <11>, <12>, <13>, <14>, <15>, <16>, <18>,
> +			<22>, <23>, <24>, <25>, <26>;
> +		gate-clock-output-names = "cpm-audio", "cpm-communit", "cpm-nand", "cpm-ppv2", "cpm-sdio",
> +			"cpm-mg-domain", "cpm-mg-core", "cpm-xor1", "cpm-xor0", "cpm-gop-dp", "cpm-pcie_x10",
> +			"cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor", "cpm-sata", "cpm-sata-usb",
> +			"cpm-gop-macro", "cpm-usb3h0", "cpm-usb3h1", "cpm-usb3dev", "cpm-eip150",
> +			"cpm-eip197";
> +	};
> -- 
> 2.6.4
> 
