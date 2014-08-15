From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Aug 2014 13:13:34 +0100
Subject: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
 (Bhupesh Sharma's message of "Fri, 15 Aug 2014 10:49:13 +0100")
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <87sikyq7bl.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15 2014 at 10:49:13 am BST, Bhupesh Sharma <bhupesh.sharma@freescale.com> wrote:
> This patch adds the device tree support for FSL LS2085A SoC
> based on ARMv8 architecture.
>
> Following levels of DTSI/DTS files have been created for the
> LS2085A SoC family:
>
> - fsl-ls2085a.dtsi:
> DTS-Include file for FSL LS2085A SoC.
>
> - fsl-ls2085a-simu.dts:
> DTS file for FSL LS2085a software simulator model.
>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Arnab Basu <arnab.basu@freescale.com>
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
>  arch/arm64/boot/dts/fsl-ls2085a-simu.dts |   29 ++++++
>  arch/arm64/boot/dts/fsl-ls2085a.dtsi     |  145 ++++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/fsl-ls2085a-simu.dts
>  create mode 100644 arch/arm64/boot/dts/fsl-ls2085a.dtsi

[...]

> diff --git a/arch/arm64/boot/dts/fsl-ls2085a.dtsi
> b/arch/arm64/boot/dts/fsl-ls2085a.dtsi
> new file mode 100644
> index 0000000..aca48ac
> --- /dev/null
> +++ b/arch/arm64/boot/dts/fsl-ls2085a.dtsi

[...]

> +
> +	gic: interrupt-controller at 6000000 {
> +		compatible = "arm,gic-v3";
> +		reg = <0x0 0x06000000 0 0x10000>, /* GIC Dist */
> + <0x0 0x06100000 0 0x100000>; /* GICR (RD_base + SGI_base) */
> +		#interrupt-cells = <3>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		interrupt-controller;
> +		interrupts = <1 9 0xf04>;

The GICv3 binding doesn't encode anything in the top bits of the 3rd
word. this should read 4 instead of 0xf04.

> +
> +		its: gic-its at 6020000 {
> +			compatible = "arm,gic-v3-its";
> +			msi-controller;
> +			reg = <0x0 0x6020000 0 0x20000>;
> +		};

Adding the ITS at this point is probably a bit premature, as I haven't
posted the patches yet, and it needs a public review.

> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> + 		interrupts = <1 13 0x01>, /* Physical Secure PPI, edge triggered */
> + 			     <1 14 0x01>, /* Physical Non-Secure PPI, edge triggered */
> +			     <1 0 0x01>,  /* Virtual PPI, edge triggered */

Are you sure about this interrupt number? Given that you have a bunch of
Cortex-A57, I'd expect this to be 11 instead of 0.

> +			     <1 10 0x01>; /* Hypervisor PPI, edge triggered */
> +	};
> +
> +	serial0: serial at 21c4500 {
> +		device_type = "serial";
> +		compatible = "fsl,ns16550", "ns16550a";
> +		reg = <0x0 0x21c4500 0x0 0x100>;
> +		clock-frequency = <0>;
> +		interrupts = <0 32 0x1>; /* edge triggered */

Nitpick: some level of consistency in the way you describe the trigger
would be good (0x01 vs 0x1 vs 1...).

> +	};
> +
> +	serial1: serial at 21c4600 {
> +		device_type = "serial";
> +		compatible = "fsl,ns16550", "ns16550a";
> +		reg = <0x0 0x21c4600 0x0 0x100>;
> +		clock-frequency = <0>;
> +		interrupts = <0 32 0x1>; /* edge triggered */
> +	};
> +
> +	fsl_mc: fsl-mc at 80c000000 {
> +		compatible = "fsl,qoriq-mc";
> +		reg = <0x00000008 0x0c000000 0 0x40	/* MC portal base */
> +		       0x00000000 0x08340000 0 0x40000 >; /* MC control reg */
> +		};
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0 0x80000000>;
> +		      /* DRAM space 1 - 2 GB DRAM */
> +	};
> +};

-- 
Jazz is not dead. It just smells funny.
