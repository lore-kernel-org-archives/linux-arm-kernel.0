From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 03 Apr 2013 14:10:27 -0700
Subject: [PATCH v2 15/18] ARM: OMAP4+: CPUidle: Consolidate idle driver
 for OMAP5 support
In-Reply-To: <1364205910-32392-16-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:07 +0530")
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-16-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87ip43s4l8.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The OMAP5 idle driver can re-use most of OMAP4 CPUidle driver
> implementation. Also the next derivative SOCs are going to re-use
> the MPUSS so, same driver with minor updates can be re-used.
>
> Prepare the code so that its easier to add CPUidle support for
> OMAP5 devices.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |   31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index b8a22f0..ac6d526 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -1,7 +1,7 @@
>  /*
> - * OMAP4 CPU idle Routines
> + * OMAP4PLUS CPU idle Routines

nit: s/PLUS/+/ 

in a few other places in this patch also.


>   *
> - * Copyright (C) 2011 Texas Instruments, Inc.
> + * Copyright (C) 2011-2013 Texas Instruments, Inc.
>   * Santosh Shilimkar <santosh.shilimkar@ti.com>
>   * Rajendra Nayak <rnayak@ti.com>
>   *
> @@ -24,13 +24,13 @@
>  #include "clockdomain.h"
>  
>  /* Machine specific information */
> -struct omap4_idle_statedata {
> +struct idle_statedata {
>  	u32 cpu_state;
>  	u32 mpu_logic_state;
>  	u32 mpu_state;
>  };
>  
> -static struct omap4_idle_statedata omap4_idle_data[] = {
> +static struct idle_statedata omap4_idle_data[] = {
>  	{
>  		.cpu_state = PWRDM_POWER_ON,
>  		.mpu_state = PWRDM_POWER_ON,
> @@ -53,11 +53,12 @@ static struct clockdomain *cpu_clkdm[NR_CPUS];
>  
>  static atomic_t abort_barrier;
>  static bool cpu_done[NR_CPUS];
> +static struct idle_statedata *state_ptr = &omap4_idle_data[0];

The assignment at init time (from the next patch) should be done here
for 44xx, and the next patch can just add OMAP5 support.

Kevin
