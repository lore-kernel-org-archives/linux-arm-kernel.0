From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Apr 2015 11:55:09 +0100
Subject: [PATCH 1/2] clocksource: arm_arch_timer: add
 arch_timer_okay_for_vdso
In-Reply-To: <1429911801-6069-1-git-send-email-nathan_lynch@mentor.com>
References: <1429911801-6069-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20150427105509.GC1544@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 24, 2015 at 10:43:20PM +0100, Nathan Lynch wrote:
> The 32-bit ARM VDSO needs to know whether a generic timer is present
> and whether it is suitable for use by user space.  The VDSO
> initialization code currently duplicates some of the logic from the
> driver to make this determination, but unfortunately it is incomplete;
> it will incorrectly enable the VDSO if HYP mode is available or if no
> interrupt is provided for the virtual timer (see arch_timer_init).  In
> these cases the driver will switch to memory-backed access while the
> VDSO will attempt to access the counter using cp15 reads.
> 
> Add an arch_timer_okay_for_vdso API which can reliably inform the VDSO
> init code whether the arch timer is present and usable.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
>  drivers/clocksource/arm_arch_timer.c | 12 ++++++++++++
>  include/clocksource/arm_arch_timer.h |  6 ++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 0aa135ddbf80..b75215523d2f 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -462,6 +462,18 @@ struct timecounter *arch_timer_get_timecounter(void)
>  	return &timecounter;
>  }
>  
> +/* The ARM VDSO init code needs to know:
> + * - whether a cp15-based arch timer is present; and if so
> + * - whether the physical or virtual counter is being used.
> + */
> +bool arch_timer_okay_for_vdso(void)
> +{
> +	if (!(arch_timers_present & ARCH_CP15_TIMER))
> +		return false;
> +
> +	return arch_timer_use_virtual;
> +}

If we're adding this, then it wouldn't hurt to use the same check in
arch/arm64 when we update_vsyscall(...). Could we also encapsulate the
`current clocksource' knowledge in there too, to remove the hardcoded
"arch_sys_counter" check from the arch code?

Will
