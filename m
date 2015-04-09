From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Apr 2015 16:36:29 +0100
Subject: [PATCH V2] drivers: CCI: fix used_mask init in validate_group()
In-Reply-To: <1428591425-17330-1-git-send-email-msalter@redhat.com>
References: <20150409144029.GE9648@leverpostej>
 <1428591425-17330-1-git-send-email-msalter@redhat.com>
Message-ID: <20150409153629.GI9648@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 03:57:05PM +0100, Mark Salter wrote:
> Currently in validate_group(), there is a static initializer
> for fake_pmu.used_mask which is based on CPU_BITS_NONE but
> the used_mask array size is based on CCI_PMU_MAX_HW_EVENTS.
> CCI_PMU_MAX_HW_EVENTS is not based on NR_CPUS, so CPU_BITS_NONE
> is not correct and will cause a build failure if NR_CPUS
> is set high enough to make CPU_BITS_NONE larger than used_mask.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Arnd, Olof, are you happy to take this via arm-soc?

My (broken) patch went via Will's tree because of a perf dependency, but
other CCI patches have gone via you guys.

Thanks,
Mark.

> ---
>  drivers/bus/arm-cci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 84fd660..759e41c 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -684,7 +684,7 @@ validate_group(struct perf_event *event)
>  		 * Initialise the fake PMU. We only need to populate the
>  		 * used_mask for the purposes of validation.
>  		 */
> -		.used_mask = CPU_BITS_NONE,
> +		.used_mask = { 0 },
>  	};
>  
>  	if (!validate_event(&fake_pmu, leader))
> -- 
> 1.8.3.1
> 
