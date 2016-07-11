From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Jul 2016 09:22:38 -0500
Subject: [PATCH V2 03/10] Documentation: dt-bindings: firmware: tegra:
 add bindings of the BPMP
In-Reply-To: <20160705090431.5852-4-josephl@nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-4-josephl@nvidia.com>
Message-ID: <20160711142238.GA30600@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 05:04:24PM +0800, Joseph Lo wrote:
> The BPMP is a specific processor in Tegra chip, which is designed for
> booting process handling and offloading the power management, clock
> management, and reset control tasks from the CPU. The binding document
> defines the resources that would be used by the BPMP firmware driver,
> which can create the interprocessor communication (IPC) between the CPU
> and BPMP.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> Changes in V2:
> - update the message that the BPMP is clock and reset control provider
> - add tegra186-clock.h and tegra186-reset.h header files
> - revise the description of the required properties
> ---
>  .../bindings/firmware/nvidia,tegra186-bpmp.txt     |  77 ++
>  include/dt-bindings/clock/tegra186-clock.h         | 940 +++++++++++++++++++++
>  include/dt-bindings/reset/tegra186-reset.h         | 217 +++++
>  3 files changed, 1234 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>  create mode 100644 include/dt-bindings/clock/tegra186-clock.h
>  create mode 100644 include/dt-bindings/reset/tegra186-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
> new file mode 100644
> index 000000000000..4d0b6eba56c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
> @@ -0,0 +1,77 @@
> +NVIDIA Tegra Boot and Power Management Processor (BPMP)
> +
> +The BPMP is a specific processor in Tegra chip, which is designed for
> +booting process handling and offloading the power management, clock
> +management, and reset control tasks from the CPU. The binding document
> +defines the resources that would be used by the BPMP firmware driver,
> +which can create the interprocessor communication (IPC) between the CPU
> +and BPMP.
> +
> +Required properties:
> +- name : Should be bpmp
> +- compatible
> +    Array of strings
> +    One of:
> +    - "nvidia,tegra186-bpmp"
> +- mboxes : The phandle of mailbox controller and the mailbox specifier.
> +- shmem : List of the phandle of the TX and RX shared memory area that
> +	  the IPC between CPU and BPMP is based on.

I think you can use memory-region here.

> +- #clock-cells : Should be 1.
> +- #reset-cells : Should be 1.
> +
> +This node is a mailbox consumer. See the following files for details of
> +the mailbox subsystem, and the specifiers implemented by the relevant
> +provider(s):
> +
> +- Documentation/devicetree/bindings/mailbox/mailbox.txt
> +- Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> +
> +This node is a clock and reset provider. See the following files for
> +general documentation of those features, and the specifiers implemented
> +by this node:
> +
> +- Documentation/devicetree/bindings/clock/clock-bindings.txt
> +- include/dt-bindings/clock/tegra186-clock.h
> +- Documentation/devicetree/bindings/reset/reset.txt
> +- include/dt-bindings/reset/tegra186-reset.h
> +
> +The shared memory bindings for BPMP
> +-----------------------------------
> +
> +The shared memory area for the IPC TX and RX between CPU and BPMP are
> +predefined and work on top of sysram, which is an SRAM inside the chip.
> +
> +See "Documentation/devicetree/bindings/sram/sram.txt" for the bindings.
> +
> +Example:
> +
> +hsp_top0: hsp at 03c00000 {
> +	...
> +	#mbox-cells = <1>;
> +};
> +
> +sysram at 30000000 {
> +	compatible = "nvidia,tegra186-sysram", "mmio-ram";
> +	reg = <0x0 0x30000000 0x0 0x50000>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	ranges = <0 0x0 0x0 0x30000000 0x0 0x50000>;
> +
> +	cpu_bpmp_tx: bpmp_shmem at 4e000 {
> +		compatible = "nvidia,tegra186-bpmp-shmem";
> +		reg = <0x0 0x4e000 0x0 0x1000>;
> +	};
> +
> +	cpu_bpmp_rx: bpmp_shmem at 4f000 {
> +		compatible = "nvidia,tegra186-bpmp-shmem";
> +		reg = <0x0 0x4f000 0x0 0x1000>;
> +	};
> +};
> +
> +bpmp {
> +	compatible = "nvidia,tegra186-bpmp";
> +	mboxes = <&hsp_top0 HSP_MBOX_ID(DB, HSP_DB_MASTER_BPMP)>;
> +	shmem = <&cpu_bpmp_tx &cpu_bpmp_rx>;
> +	#clock-cells = <1>;
> +	#reset-cells = <1>;
> +};
> diff --git a/include/dt-bindings/clock/tegra186-clock.h b/include/dt-bindings/clock/tegra186-clock.h
> new file mode 100644
> index 000000000000..f73d32098f99
> --- /dev/null
> +++ b/include/dt-bindings/clock/tegra186-clock.h
> @@ -0,0 +1,940 @@
> +/** @file */
> +
> +#ifndef _MACH_T186_CLK_T186_H
> +#define _MACH_T186_CLK_T186_H
> +
> +/**
> + * @defgroup clock_ids Clock Identifiers

Aren't these doxygen markup? Does that work with docbook? If not, 
remove.
