From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 22 Sep 2013 14:14:14 +0200
Subject: [PATCH 00/26] ARM: provide common arch init for DT clocks
In-Reply-To: <20130920191613.GA25191@ohporter.com>
References: <20130920191613.GA25191@ohporter.com>
Message-ID: <523EDF16.10102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2013 09:16 PM, Matt Porter wrote:
> On Wed, Sep 18, 2013 at 07:53:33PM +0200, Sebastian Hesselbarth wrote:
>> This is a patch set based on an RFC [1][2] sent earlier to provide a common
>> arch/arm init for DT clock providers. Currently, the call to of_clk_init(NULL)
>> to initialize DT clock providers is spread among several mach-dirs. Since most
>> machs require DT clocks initialized before timers, no initcall can be used.
[...]
> Could you pick up the following patch for mach-bcm/ into this series?
>
> Thanks,
> Matt
>
>  From f65d048b3453447bb3e693cb21701c4d0c6375ed Mon Sep 17 00:00:00 2001
> From: Matt Porter <matt.porter@linaro.org>
> Date: Fri, 20 Sep 2013 13:41:06 -0400
> Subject: [PATCH] ARM: bcm: Remove custom .time_init hook
>
> With arch/arm calling of_clk_init(NULL) and clocksource_of_init()
> this is no longer needed. The former is useful because we can make
> use of dummy fixed clocks for drivers until the bcm281xx common
> clock driver is ready.
>
> Signed-off-by: Matt Porter <matt.porter@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Christian Daudt <csd@broadcom.com>

As a v2 is required due to calling of_clk_init() breaks non-DT builds,
I will include this _if_ Christian actually gives his Acked-By.

Sebastian

> ---
>   arch/arm/mach-bcm/board_bcm281xx.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
> index 8d9f931..26b2390 100644
> --- a/arch/arm/mach-bcm/board_bcm281xx.c
> +++ b/arch/arm/mach-bcm/board_bcm281xx.c
> @@ -68,7 +68,6 @@ static void __init board_init(void)
>   static const char * const bcm11351_dt_compat[] = { "brcm,bcm11351", NULL, };
>
>   DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
> -	.init_time = clocksource_of_init,
>   	.init_machine = board_init,
>   	.restart = bcm_kona_restart,
>   	.dt_compat = bcm11351_dt_compat,
>
