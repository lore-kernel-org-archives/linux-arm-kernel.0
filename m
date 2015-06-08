From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jun 2015 10:28:53 +0100
Subject: [PATCH v5 2/3] ARM: rockchip: ensure CPU to enter WFI/WFE state
In-Reply-To: <1433747496-7642-3-git-send-email-wxt@rock-chips.com>
References: <1433747496-7642-1-git-send-email-wxt@rock-chips.com>
 <1433747496-7642-3-git-send-email-wxt@rock-chips.com>
Message-ID: <20150608092852.GW7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 03:11:35PM +0800, Caesar Wang wrote:
> diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
> index bd40852..5bc2a89 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -321,6 +321,9 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
>  #ifdef CONFIG_HOTPLUG_CPU
>  static int rockchip_cpu_kill(unsigned int cpu)
>  {
> +	/* ensure CPU can enter the WFI/WFE state */

I would like to see a better comment here, describing what the problem
is.  Maybe something like this:

	/*
	 * We need a delay here to ensure that the dying CPU can finish
	 * executing v7_coherency_exit() and reach the WFI/WFE state
	 * prior to having the power domain disabled.
	 */

Thanks.

> +	mdelay(1);
> +
>  	pmu_set_power_domain(0 + cpu, false);
>  	return 1;
>  }
> -- 
> 1.9.1
> 

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
