From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Nov 2012 10:38:09 +0000
Subject: [PATCH v2 2/5] ARM: kernel: add device tree init map function
In-Reply-To: <1352471654-20207-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1352471654-20207-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1352471654-20207-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20121112103713.GA7982@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 02:34:11PM +0000, Lorenzo Pieralisi wrote:
> When booting through a device tree, the kernel cpu logical id map can be
> initialized using device tree data passed by FW or through an embedded blob.
> 
> This patch adds a function that parses device tree "cpu" nodes and
> retrieves the corresponding CPUs hardware identifiers (MPIDR).
> It sets the possible cpus and the cpu logical map values according to
> the number of CPUs defined in the device tree and respective properties.
> 
> The device tree HW identifiers are considered valid if all CPU nodes contain
> a "reg" property and the DT defines a CPU node that matches the MPIDR[23:0]
> of the boot CPU.
> 
> The primary CPU is assigned cpu logical number 0 to keep the current convention
> valid.
> 
> Current bindings documentation is included in the patch:
> 
> Documentation/devicetree/bindings/arm/cpus.txt
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 84 ++++++++++++++++++++++++++
>  arch/arm/include/asm/prom.h                    |  2 +
>  arch/arm/kernel/devtree.c                      | 76 +++++++++++++++++++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> new file mode 100644
> index 0000000..83cd98a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -0,0 +1,84 @@
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
> +- reg : property matching the CPU MPIDR[23:0] register bits
> +- compatible: must be set to "arm, <cpu-model>"
> +              where <cpu-model> is the full processor name as used in the
> +              processor Technical Reference Manual, eg:
> +              - for a Cortex A9 processor
> +                compatible = <arm, cortex-a9>;
> +              - for a Cortex A15 processor
> +                compatible = <arm, cortex-a15>;
> +
> +List of possible "compatible" string ids:
> +
> +<arm, arm1020>
> +<arm, arm1020e>
> +<arm, arm1022>
> +<arm, arm1026>
> +<arm, arm720>
> +<arm, arm740>
> +<arm, arm7tdmi>
> +<arm, arm920>
> +<arm, arm922>
> +<arm, arm925>
> +<arm, arm926>
> +<arm, arm940>
> +<arm, arm946>
> +<arm, arm9tdmi>
> +<arm, fa526>
> +<arm, feroceon>
> +<arm, mohawk>
> +<arm, sa110>
> +<arm, sa1100>
> +<arm, xsc3>
> +<arm, xscale>
> +<arm, cortex-a5>
> +<arm, cortex-a7>
> +<arm, cortex-a8>
> +<arm, cortex-a9>
> +<arm, cortex-a15>
> +<arm, arm1136>
> +<arm, arm11-mpcore>
> +

Is there any reason for the spaces in the compatible string? No other binding
seems to do this.

Is <STRING> a valid dts format? Should these not be "STRING" instead?

For consistency, it would be nice to have the compatible strings tab-indented
as in Documentation/devicetree/bindings/arm/pmu.txt.

Thanks,
Mark
