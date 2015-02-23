From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 23 Feb 2015 19:35:21 +0100
Subject: [PATCH] ARM: mvebu: Disable CPU Idle on Armada 38x
In-Reply-To: <1423245844-28701-1-git-send-email-gregory.clement@free-electrons.com>
References: <1423245844-28701-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <54EB72E9.7010402@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On 06/02/2015 19:04, Gregory CLEMENT wrote:
> On Armada 38x SoCs, under heavy I/O load, the system hangs when CPU
> Idle is enabled. Waiting for a solution to this issue, this patch
> disables the CPU Idle support for this SoC.
> 
> As CPU Hot plug support also uses some of the CPU Idle functions it is
> also affected by the same issue. This patch disables it also for the
> Armada 38x SoCs.
> 

If nobody is against it, I plan to apply this patch as a fix for 4.0 in
a couple of days.

Gregory


> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.17 +
> ---
>  arch/arm/mach-mvebu/pmsu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index d8ab605a44fa..05c8625bbc40 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -476,12 +476,22 @@ static int __init mvebu_v7_cpu_pm_init(void)
>  		return 0;
>  	of_node_put(np);
>  
> +	/*
> +	 * Currently the CPU Idle support for Armada 38x is broken, as
> +	 * the CPU Hotplug uses some of the CPU Idle functions it is
> +	 * broken too, so let's disable it
> +	 */
> +	if (of_machine_is_compatible("marvell,armada380")) {
> +		cpu_hotplug_disable();
> +		pr_warn("CPU Hotplug support is currently broken on Armada 38x: disabling");
> +	}
> +
>  	if (of_machine_is_compatible("marvell,armadaxp"))
>  		ret = armada_xp_cpuidle_init();
>  	else if (of_machine_is_compatible("marvell,armada370"))
>  		ret = armada_370_cpuidle_init();
> -	else if (of_machine_is_compatible("marvell,armada380"))
> -		ret = armada_38x_cpuidle_init();
> +	else if (of_machine_is_compatible("marvell,armada380")
> +		 pr_warn("CPU Idle is currently broken on Armada 38x: disabling");
>  	else
>  		return 0;
>  
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
