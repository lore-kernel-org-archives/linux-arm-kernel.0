From: pavel@denx.de (Pavel Machek)
Date: Sun, 17 Mar 2013 19:18:14 +0100
Subject: [PATCHv1 1/2] ARM: socfpga: Enable hotplug and soft reset
In-Reply-To: <1363211722-27237-2-git-send-email-dinguyen@altera.com>
References: <1363211722-27237-1-git-send-email-dinguyen@altera.com>
 <1363211722-27237-2-git-send-email-dinguyen@altera.com>
Message-ID: <20130317181814.GC4394@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Put CPU1 into reset when it is hotplugged.
> Enable a cold or warm reset to the HW from userspace.
> 
> Also fix a few sparse errors:
> 
> warning: symbol 'sys_manager_base_addr' was not declared. Should it be static?
> warning: symbol 'rst_manager_base_addr' was not declared. Should it be static?
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

It seems pretty good.

> --- a/arch/arm/mach-socfpga/core.h
> +++ b/arch/arm/mach-socfpga/core.h
> +/*MPU Module Reset Register */
> +#define RSTMGR_MPUMODRST_CPU0	0x1	/*CPU0 Reset*/
> +#define RSTMGR_MPUMODRST_CPU1	0x2	/*CPU1 Reset*/
> +#define RSTMGR_MPUMODRST_WDS		0x4	/*Watchdog Reset*/
> +#define RSTMGR_MPUMODRST_SCUPER	0x8	/*SCU and periphs reset*/
> +#define RSTMGR_MPUMODRST_L2		0x10	/*L2 Cache reset*/
> +

I'd include space after /* and before */.

> @@ -100,6 +97,12 @@ static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
>   */
>  static void socfpga_cpu_die(unsigned int cpu)
>  {
> +	/* Flush the L1 data cache. */
> +	flush_cache_all();
> +
> +	/* This will put CPU1 into reset.*/
> +	__raw_writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr + 0x10);

Is there reason to do __raw_* operations? I believe we want the memory
barriers etc, so we should use plain writel(). Same for actual reset
code.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
