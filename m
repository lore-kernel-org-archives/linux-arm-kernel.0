From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Aug 2013 17:39:05 +0100
Subject: [RESEND PATCH 4/4] ARM: msm: Add support for 8974 SMP
In-Reply-To: <1375409725-22004-5-git-send-email-rvaswani@codeaurora.org>
References: <1375409725-22004-1-git-send-email-rvaswani@codeaurora.org>
 <1375409725-22004-5-git-send-email-rvaswani@codeaurora.org>
Message-ID: <20130812163905.GE27165@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 03:15:25AM +0100, Rohit Vaswani wrote:
> Add the cpus bindings and the Kraitv2 release sequence
> to make SMP work for 2 cores on MSM8974.
> 
> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt |  1 +
>  arch/arm/boot/dts/msm8974.dts                  | 23 ++++++++
>  arch/arm/mach-msm/board-dt-8974.c              |  3 +
>  arch/arm/mach-msm/platsmp.c                    | 79 ++++++++++++++++++++++++++
>  4 files changed, 106 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 1132eac..7c3c677 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -52,6 +52,7 @@ For the ARM architecture every CPU node must contain the following properties:
>  		 This should be one of:
>  		 "qcom,scss"
>  		 "qcom,kpssv1"
> +		 "qcom,kpssv2"

I guess I should've looked at the whole series before responding, that
answers my prior question about what variation we expect.

>  
>  Example:
>  
> diff --git a/arch/arm/boot/dts/msm8974.dts b/arch/arm/boot/dts/msm8974.dts
> index c31c097..ef35a9b 100644
> --- a/arch/arm/boot/dts/msm8974.dts
> +++ b/arch/arm/boot/dts/msm8974.dts
> @@ -7,6 +7,22 @@
>  	compatible = "qcom,msm8974";
>  	interrupt-parent = <&intc>;
>  
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "qcom,krait";
> +		device_type = "cpu";
> +		enable-method = "qcom,kpssv2";
> +
> +		cpu at 0 {
> +			reg = <0>;
> +		};
> +
> +		cpu at 1 {
> +			reg = <1>;
> +		};
> +	};
> +
>  	intc: interrupt-controller at f9000000 {
>  		compatible = "qcom,msm-qgic2";
>  		interrupt-controller;
> @@ -23,4 +39,11 @@
>  			     <1 1 0xf08>;
>  		clock-frequency = <19200000>;
>  	};
> +
> +	kpss at f9012000 {
> +		compatible = "qcom,kpss";
> +		reg = <0xf9012000 0x1000>,
> +		      <0xf9088000 0x1000>,
> +		      <0xf9098000 0x1000>;
> +	};

In the previous examples, the number of CPUs was equal to the number of
kpss reg values. Why does it differ here. Either:

* We always have the extra regsiter here, and it should be described
  even if we don't use it.

* It's a different hardware block, and needs a more specific
  compatible string.

Eitehr way this strengthens my feeling that we need to define the linkage
from a CPU to the portion of the kpss which affects it.

>  };
> diff --git a/arch/arm/mach-msm/board-dt-8974.c b/arch/arm/mach-msm/board-dt-8974.c
> index d7f84f2..06119f9 100644
> --- a/arch/arm/mach-msm/board-dt-8974.c
> +++ b/arch/arm/mach-msm/board-dt-8974.c
> @@ -13,11 +13,14 @@
>  #include <linux/of_platform.h>
>  #include <asm/mach/arch.h>
>  
> +#include "common.h"
> +
>  static const char * const msm8974_dt_match[] __initconst = {
>  	"qcom,msm8974",
>  	NULL
>  };
>  
>  DT_MACHINE_START(MSM8974_DT, "Qualcomm MSM (Flattened Device Tree)")
> +	.smp = smp_ops(msm_smp_ops),
>  	.dt_compat = msm8974_dt_match,
>  MACHINE_END
> diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
> index 82eb079..0fdae69 100644
> --- a/arch/arm/mach-msm/platsmp.c
> +++ b/arch/arm/mach-msm/platsmp.c
> @@ -124,6 +124,80 @@ static int msm8960_release_secondary(unsigned int cpu)
>  	return 0;
>  }
>  
> +static int msm8974_release_secondary(unsigned int cpu)
> +{
> +	void __iomem *reg;
> +	void __iomem *l2_saw_base;
> +	struct device_node *dn = NULL;
> +	unsigned apc_pwr_gate_ctl = 0x14;
> +	unsigned reg_val;
> +
> +	if (cpu == 0 || cpu >= num_possible_cpus())
> +		return -EINVAL;
> +
> +	dn = of_find_compatible_node(dn, NULL, "qcom,kpss");
> +	if (!dn) {
> +		pr_err("%s : Missing kpss node from device tree\n", __func__);
> +		return -ENXIO;
> +	}
> +
> +	reg = of_iomap(dn, cpu+1);

This looks very fishy given the prior patch being one off from this.
why is reg[0] now different?

> +	if (!reg)
> +		return -ENOMEM;
> +
> +	pr_debug("Starting secondary CPU %d\n", cpu);
> +
> +	/* Turn on the BHS, turn off LDO Bypass and power down LDO */
> +	reg_val =  0x403f0001;

Magic number?

> +	writel_relaxed(reg_val, reg + apc_pwr_gate_ctl);
> +
> +	/* complete the above write before the delay */
> +	mb();

Use writel?

> +	/* wait for the bhs to settle */
> +	udelay(1);
> +
> +	/* Turn on BHS segments */
> +	reg_val |= 0x3f << 1;
> +	writel_relaxed(reg_val, reg + apc_pwr_gate_ctl);
> +
> +	/* complete the above write before the delay */
> +	mb();

Use writel again?

> +	 /* wait for the bhs to settle */
> +	udelay(1);
> +
> +	/* Finally turn on the bypass so that BHS supplies power */
> +	reg_val |= 0x3f << 8;
> +	writel_relaxed(reg_val, reg + apc_pwr_gate_ctl);
> +
> +	/* enable max phases */
> +	l2_saw_base = of_iomap(dn, 0);
> +	if (!l2_saw_base) {
> +		return -ENOMEM;
> +	}

What? 

You've just lost your only reference to the mapping in reg.

Why do you not do this at the start, before poking everything else? Even
better, do it at probe time and fail once rather than for each CPU you
have no chance of bringing up.

[...]
>  static void boot_cold_cpu(unsigned int cpu)
> @@ -151,6 +225,11 @@ static void boot_cold_cpu(unsigned int cpu)
>  			msm8960_release_secondary(cpu);
>  			per_cpu(cold_boot_done, cpu) = true;
>  		}
> +	} else if (!strcmp(enable_method, "qcom,kpssv2")) {
> +		if (per_cpu(cold_boot_done, cpu) == false) {
> +			msm8974_release_secondary(cpu);
> +			per_cpu(cold_boot_done, cpu) = true;
> +		}
>  	} else {
>  		pr_err("%s: Invalid enable-method property: %s\n",
>  				__func__, enable_method);

The enable-method parsing really should be moved out to common code. We
could make it scan the enable-method if a machine has no smp ops (which
is more general than the PSCI fallback that's been suggested before).

Thanks,
Mark.
