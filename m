From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 23 Feb 2015 20:12:15 +0100
Subject: [PATCH] ARM: mvebu: Disable CPU Idle on Armada 38x
In-Reply-To: <1423245844-28701-1-git-send-email-gregory.clement@free-electrons.com>
References: <1423245844-28701-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150223201215.039fa38b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Fri,  6 Feb 2015 19:04:04 +0100, Gregory CLEMENT wrote:
> On Armada 38x SoCs, under heavy I/O load, the system hangs when CPU
> Idle is enabled. Waiting for a solution to this issue, this patch
> disables the CPU Idle support for this SoC.
> 
> As CPU Hot plug support also uses some of the CPU Idle functions it is
> also affected by the same issue. This patch disables it also for the
> Armada 38x SoCs.
> 
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

There's one thing that annoys me with this part disabling CPU hotplug:
it will prevent suspend to RAM, even though suspend to RAM is most
likely safe with regard to the PCIe/PL310 deadlock problem. CPU hotplug
support is needed for suspend to RAM, as secondary CPUs are all turned
off towards the end of the suspend process, before really entering the
suspend to RAM state.

And since this happens after calling the ->suspend() hook on all
devices, we are normally in a quiet state in terms of PCIe traffic,
which should normally avoid the PL310 issue.

So, we would have basically to discriminate between CPU hotplug done at
"run time" and CPU hotplug done as part of the suspend to RAM and
resume sequence. Maybe this cpu_hotplug_disable() still allows the form
of CPU hotplug needed by suspend to RAM, but since would have to be
verified.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
