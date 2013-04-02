From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 02 Apr 2013 13:33:25 -0600
Subject: [PATCH V3 1/3] ARM: tegra: get PMC clock source from DT
In-Reply-To: <1364901583-24867-2-git-send-email-josephl@nvidia.com>
References: <1364901583-24867-1-git-send-email-josephl@nvidia.com>
 <1364901583-24867-2-git-send-email-josephl@nvidia.com>
Message-ID: <515B3285.5080400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2013 05:19 AM, Joseph Lo wrote:
> Adding the bindings of the clock source of PMC in DT. And getting
> the clock from DT.

>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 23 ++++++++++++++++++++++
>  arch/arm/mach-tegra/common.c                       |  2 +-
>  arch/arm/mach-tegra/pmc.c                          |  4 ++++

I'd like to re-order and split up this series slightly differently.

Patch (1) should include the binding updates (nvidia,tegra20-pmc.txt)
from this patch 1/3 and the DT changes (*.dts) from patch 2/3.

Patch (2) should contain be the current patch 3/3 plus the *.c changes
from this patch 1/3.

That ensures that:

a) The DT binding changes happen before (or rather at the same time) as
the first other change that relies on them.

b) The DT changes happen before the code changes, which is required to
avoid the code-changes causing WARN_ON(IS_ERR(tegra_pclk)) from firing
before all the patches are applied.

c) The new code to retrieve tegra_pclk isn't added without anything that
uses the new variable; it's added only when something makes use of it.

> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt

> +- clocks : the source clock of PMC
> +- clock-names : the name of source clock of PMC

"the" is wrong here, since there is more than one clock. Also, the
binding document needs to define the set of clocks that those properties
must provide. I suggest the following wording, which I cribbed from the
Tegra audio bindings:

- clocks : Must contain an entry for each entry in clock-names.
- clock-names : Must include the following entries:
  "pclk" (The Tegra clock of that name),
  "clk32k_in" (The 32KHz clock input to Tegra).

That text should also be added to the "Required properties" section, not
the "Optional proeprties" section.

> +/ SoC dts including file
>  pmc at 7000f400 {
>  	compatible = "nvidia,tegra20-pmc";
>  	reg = <0x7000e400 0x400>;
>  	nvidia,invert-interrupt;
> +	clocks = <&tegra_car 110>, <&clk32k_in>;
> +	clock-names = "pclk", "clk32k_in";

In this example, I'd prefer the clocks properties to be before the
custom nvidia,invert-interrupt property, so that all standard and
required properties are first, then custom properties. so, compatible,
reg, clock*, nvidia,invert-interrupt.

> diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c

>  void __init tegra_dt_init_irq(void)
>  {
>  	tegra_clocks_init();
> +	tegra_pmc_init();
>  	tegra_init_irq();
>  	irqchip_init();
>  }

I'll let this slide for now. Please be aware that I'd prefer all
non-IRQ-related initialization to happen somewhere inside the machine's
.init_machine() callback, not its .init_irq() callback. However, we can
clean this up later; most likely a lot of the calls in
tegra_init_early() should move too.
