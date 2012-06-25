From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 25 Jun 2012 13:15:38 -0500
Subject: [PATCH V2] ARM: OMAP4470: Fix OMAP4470 boot failure
In-Reply-To: <1340645903-28550-1-git-send-email-jon-hunter@ti.com>
References: <1340645903-28550-1-git-send-email-jon-hunter@ti.com>
Message-ID: <4FE8AACA.5030207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding linux-arm ML.

Jon

On 06/25/2012 12:38 PM, Jon Hunter wrote:
> OMAP4470 currently fails to boot, printing various messages such as ...
> 
> omap_hwmod: mpu: cannot clk_get main_clk dpll_mpu_m2_ck
> omap_hwmod: mpu: cannot _init_clocks
> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/omap_hwmod.c:2062 _init+0x2a0/0x2e4()
> omap_hwmod: mpu: couldn't init clocks
> Modules linked in:
> [<c001c7fc>] (unwind_backtrace+0x0/0xf4) from [<c0043c64>] (warn_slowpath_common+0x4c/0x64)
> [<c0043c64>] (warn_slowpath_common+0x4c/0x64) from [<c0043d10>] (warn_slowpath_fmt+0x30/0x40)
> [<c0043d10>] (warn_slowpath_fmt+0x30/0x40) from [<c0674208>] (_init+0x2a0/0x2e4)
> [<c0674208>] (_init+0x2a0/0x2e4) from [<c067428c>] (omap_hwmod_setup_one+0x40/0x60)
> [<c067428c>] (omap_hwmod_setup_one+0x40/0x60) from [<c0674280>] (omap_hwmod_setup_one+0x34/0x60)
> [<c0674280>] (omap_hwmod_setup_one+0x34/0x60) from [<c06726f4>] (omap_dm_timer_init_one+0x30/0x250)
> [<c06726f4>] (omap_dm_timer_init_one+0x30/0x250) from [<c0672930>] (omap2_gp_clockevent_init+0x1c/0x108)
> [<c0672930>] (omap2_gp_clockevent_init+0x1c/0x108) from [<c0672c60>] (omap4_timer_init+0x10/0x5c)
> [<c0672c60>] (omap4_timer_init+0x10/0x5c) from [<c066c418>] (time_init+0x20/0x30)
> [<c066c418>] (time_init+0x20/0x30) from [<c0668814>] (start_kernel+0x1b0/0x304)
> [<c0668814>] (start_kernel+0x1b0/0x304) from [<80008044>] (0x80008044)
> ---[ end trace 1b75b31a2719ed1c ]---
> 
> The problem is that currently none of the clocks are being registered for
> OMAP4470 devices and so on boot-up no clocks can be found and the kernel panics.
> 
> This fix allows the kernel to boot without failure using a simple RAMDISK file
> system on OMAP4470 blaze board.
> 
> V2:
> - Per feedback from Paul and Benoit the 4470 clock data is incomplete for new
>   modules such as the 2D graphics block that has been added to the 4470.
>   Therefore add a warning to indicate that the clock data is incomplete.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index b825049..de53b70 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3407,9 +3407,12 @@ int __init omap4xxx_clk_init(void)
>  	if (cpu_is_omap443x()) {
>  		cpu_mask = RATE_IN_4430;
>  		cpu_clkflg = CK_443X;
> -	} else if (cpu_is_omap446x()) {
> +	} else if (cpu_is_omap446x() || cpu_is_omap447x()) {
>  		cpu_mask = RATE_IN_4460 | RATE_IN_4430;
>  		cpu_clkflg = CK_446X | CK_443X;
> +
> +		if (cpu_is_omap447x())
> +			pr_warn("WARNING: OMAP4470 clock data incomplete!\n");
>  	} else {
>  		return 0;
>  	}
> 
