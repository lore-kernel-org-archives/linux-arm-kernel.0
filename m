From: robh@kernel.org (Rob Herring)
Date: Sun, 21 Feb 2016 20:53:57 -0600
Subject: [PATCH 2/3] clk: mvebu: add AP806 core clock driver
In-Reply-To: <1455521698-7905-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455521698-7905-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455521698-7905-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160222025357.GE15973@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 08:34:57AM +0100, Thomas Petazzoni wrote:
> This commit adds a new driver to handle the core clocks found in the
> AP806 HW block, which is the core block of all Armada 7K and 8K
> Marvell 64-bits processors. This core clock driver reads the
> Sample-At-Reset register to determine the frequencies of several core
> clocks: DDR, Ring and CPU clocks.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../clock/mvebu-armada-ap806-core-clock.txt        |  33 ++++++
>  drivers/clk/mvebu/Kconfig                          |   3 +
>  drivers/clk/mvebu/Makefile                         |   2 +-
>  drivers/clk/mvebu/ap806-core.c                     | 112 +++++++++++++++++++++
>  4 files changed, 149 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-armada-ap806-core-clock.txt
>  create mode 100644 drivers/clk/mvebu/ap806-core.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/mvebu-armada-ap806-core-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-armada-ap806-core-clock.txt
> new file mode 100644
> index 0000000..b2131bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mvebu-armada-ap806-core-clock.txt
> @@ -0,0 +1,33 @@
> +* Clock bindings for Marvell MVEBU AP806 Core clocks
> +
> +The Marvell MVEBU Armada 7K/8K SoCs contain a block called AP806,
> +hosting the CPU and other core components of the CPU. This Device Tree
> +binding allows to describe the core clocks of the AP806, whose
> +frequencies are determined by reading the Sample-At-Reset (SAR)
> +register.

What else is in the AP806?

> +
> +Clock consumers must specify the desired clock by having the clock ID
> +in its "clocks" phandle cell.
> +
> +The following is a list of provided IDs and clock names for the core
> +Armada AP806 clocks:
> +
> + 0 = DDR
> + 1 = Ring
> + 2 = CPU
> +
> +Required properties:
> +- compatible: must be be one of the following:
> +	"marvell,armada-ap806-core-clock"

I'd expect this to be a sub-node of a syscon block or just a single 
clock provider for the full block. Hard to tell reviewing this without 
context of what the full clock tree looks like. 

> +- reg: must be the register address of the Sample-At-Reset (SAR) register
> +- #clock-cells: from common clock binding; shall be set to 1
> +- clock-output-names: name of the output clocks
> +
> +Example:
> +
> +	coreclk: clk at 0x6F8204 {

Drop 0x and lowercase hex.

> +		compatible = "marvell,armada-ap806-core-clock";
> +		reg = <0x6F8204 0x04>;

lowercase hex.

> +		#clock-cells = <1>;
> +		clock-output-names = "ddr", "ring", "cpu";
> +	};
