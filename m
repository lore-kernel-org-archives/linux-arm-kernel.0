From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 12 Oct 2015 18:19:54 +0200
Subject: [PATCH v5 1/4] ARM: mvebu: add broken-idle option
In-Reply-To: <1444140824-24132-2-git-send-email-simon.guinot@sequanux.org>
 (Simon Guinot's message of "Tue, 6 Oct 2015 16:13:41 +0200")
References: <1444140824-24132-1-git-send-email-simon.guinot@sequanux.org>
 <1444140824-24132-2-git-send-email-simon.guinot@sequanux.org>
Message-ID: <87y4f8kqj9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,
 
 On mar., oct. 06 2015, Simon Guinot <simon.guinot@sequanux.org> wrote:

> From: Vincent Donnefort <vdonnefort@gmail.com>
>
> The broken-idle option can be activated from the coherency-fabric DT
> node. This property allows to disable the idle capability, when the
> hardware doesn't support it, like the Seagate Personal Cloud boards.
>
> Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>

Applied on mvebu/config

Thanks,

Gregory
> ---
>  .../devicetree/bindings/arm/coherency-fabric.txt   |  5 ++++
>  arch/arm/mach-mvebu/pmsu.c                         | 29 +++++++++++++++++++---
>  2 files changed, 31 insertions(+), 3 deletions(-)
>
> Changes for v5:
> - Make the broken-idle property boolean.
> - Don't use the broken-idle flag for Armada 38x.
>
> diff --git a/Documentation/devicetree/bindings/arm/coherency-fabric.txt b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
> index 8dd46617c889..9b5c3f620e65 100644
> --- a/Documentation/devicetree/bindings/arm/coherency-fabric.txt
> +++ b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
> @@ -27,6 +27,11 @@ Required properties:
>   * For "marvell,armada-380-coherency-fabric", only one pair is needed
>     for the per-CPU fabric registers.
>  
> +Optional properties:
> +
> +- broken-idle: boolean to set when the Idle mode is not supported by the
> +  hardware.
> +
>  Examples:
>  
>  coherency-fabric at d0020200 {
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index e8fdb9ceedf0..cba3fa985734 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -379,6 +379,16 @@ static struct notifier_block mvebu_v7_cpu_pm_notifier = {
>  
>  static struct platform_device mvebu_v7_cpuidle_device;
>  
> +static int broken_idle(struct device_node *np)
> +{
> +	if (of_property_read_bool(np, "broken-idle")) {
> +		pr_warn("CPU idle is currently broken: disabling\n");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
>  static __init int armada_370_cpuidle_init(void)
>  {
>  	struct device_node *np;
> @@ -387,7 +397,9 @@ static __init int armada_370_cpuidle_init(void)
>  	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
>  	if (!np)
>  		return -ENODEV;
> -	of_node_put(np);
> +
> +	if (!broken_idle(np))
> +		goto end;
>  
>  	/*
>  	 * On Armada 370, there is "a slow exit process from the deep
> @@ -406,6 +418,8 @@ static __init int armada_370_cpuidle_init(void)
>  	mvebu_v7_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
>  	mvebu_v7_cpuidle_device.name = "cpuidle-armada-370";
>  
> +end:
> +	of_node_put(np);
>  	return 0;
>  }
>  
> @@ -422,6 +436,10 @@ static __init int armada_38x_cpuidle_init(void)
>  				     "marvell,armada-380-coherency-fabric");
>  	if (!np)
>  		return -ENODEV;
> +
> +	if (!broken_idle(np))
> +		goto end;
> +
>  	of_node_put(np);
>  
>  	np = of_find_compatible_node(NULL, NULL,
> @@ -430,7 +448,6 @@ static __init int armada_38x_cpuidle_init(void)
>  		return -ENODEV;
>  	mpsoc_base = of_iomap(np, 0);
>  	BUG_ON(!mpsoc_base);
> -	of_node_put(np);
>  
>  	/* Set up reset mask when powering down the cpus */
>  	reg = readl(mpsoc_base + MPCORE_RESET_CTL);
> @@ -450,6 +467,8 @@ static __init int armada_38x_cpuidle_init(void)
>  	mvebu_v7_cpuidle_device.dev.platform_data = armada_38x_cpu_suspend;
>  	mvebu_v7_cpuidle_device.name = "cpuidle-armada-38x";
>  
> +end:
> +	of_node_put(np);
>  	return 0;
>  }
>  
> @@ -460,12 +479,16 @@ static __init int armada_xp_cpuidle_init(void)
>  	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
>  	if (!np)
>  		return -ENODEV;
> -	of_node_put(np);
> +
> +	if (!broken_idle(np))
> +		goto end;
>  
>  	mvebu_cpu_resume = armada_370_xp_cpu_resume;
>  	mvebu_v7_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
>  	mvebu_v7_cpuidle_device.name = "cpuidle-armada-xp";
>  
> +end:
> +	of_node_put(np);
>  	return 0;
>  }
>  
> -- 
> 2.1.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
