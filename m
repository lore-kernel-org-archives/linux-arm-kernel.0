From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Nov 2012 13:54:18 +0000
Subject: [PATCH v4 4/7] ARM: kernel: add device tree init map function
In-Reply-To: <1353329106-24084-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1353329106-24084-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1353329106-24084-5-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20121119135418.GB2816@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 12:45:03PM +0000, Lorenzo Pieralisi wrote:
> When booting through a device tree, the kernel cpu logical id map can be
> initialized using device tree data passed by FW or through an embedded blob.
> 
> This patch adds a function that parses device tree "cpu" nodes and
> retrieves the corresponding CPUs hardware identifiers (MPIDR).
> It sets the possible cpus and the cpu logical map values according to
> the number of CPUs defined in the device tree and respective properties.
> 
> The device tree HW identifiers are considered valid if all CPU nodes contain
> a "reg" property, there are no duplicate "reg" entries and the DT defines a
> CPU node whose "reg" property matches the MPIDR[23:0] of the boot CPU.
> 
> The primary CPU is assigned cpu logical number 0 to keep the current convention
> valid.
> 
> Current bindings documentation is included in the patch:
> 
> Documentation/devicetree/bindings/arm/cpus.txt
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt |  77 +++++++++++++++++++
>  arch/arm/include/asm/prom.h                    |   2 +
>  arch/arm/kernel/devtree.c                      | 100 +++++++++++++++++++++++++
>  3 files changed, 179 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> new file mode 100644
> index 0000000..46c3589
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -0,0 +1,77 @@
> +* ARM CPUs binding description
> +
> +The device tree allows to describe the layout of CPUs in a system through
> +the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> +defining properties for every cpu.
> +
> +Bindings for CPU nodes follow the ePAPR standard, available from:
> +
> +http://devicetree.org
> +
> +For the ARM architecture every CPU node must contain the following properties:
> +
> +- device_type:	must be "cpu"
> +- reg:		property matching the CPU MPIDR[23:0] register bits
> +		reg[31:24] bits must be set to 0
> +- compatible:	should be one of:
> +		"arm,arm1020"
> +		"arm,arm1020e"
> +		"arm,arm1022"
> +		"arm,arm1026"
> +		"arm,arm720"
> +		"arm,arm740"
> +		"arm,arm7tdmi"
> +		"arm,arm920"
> +		"arm,arm922"
> +		"arm,arm925"
> +		"arm,arm926"
> +		"arm,arm940"
> +		"arm,arm946"
> +		"arm,arm9tdmi"
> +		"arm,cortex-a5"
> +		"arm,cortex-a7"
> +		"arm,cortex-a8"
> +		"arm,cortex-a9"
> +		"arm,cortex-a15"
> +		"arm,arm1136"
> +		"arm,arm1156"
> +		"arm,arm1176"
> +		"arm,arm11mpcore"
> +		"faraday,fa526"
> +		"intel,sa110"
> +		"intel,sa1100"
> +		"marvell,feroceon"
> +		"marvell,mohawk"
> +		"marvell,xsc3"
> +		"marvell,xscale"
> +
> +Example:
> +
> +	cpus {
> +		#size-cells = <0>;
> +		#address-cells = <1>;
> +
> +		CPU0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm, cortex-a15";
> +			reg = <0x0>;
> +		};
> +
> +		CPU1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm, cortex-a15";
> +			reg = <0x1>;
> +		};
> +
> +		CPU2: cpu at 100 {
> +			device_type = "cpu";
> +			compatible = "arm, cortex-a7";
> +			reg = <0x100>;
> +		};
> +
> +		CPU3: cpu at 101 {
> +			device_type = "cpu";
> +			compatible = "arm, cortex-a7";
> +			reg = <0x101>;
> +		};
> +	};

Those spaces in the compatible strings shouldn't be there.

Otherwise, looks good to me.

Thanks,
Mark
