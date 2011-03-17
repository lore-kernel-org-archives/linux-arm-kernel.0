From: khilman@ti.com (Kevin Hilman)
Date: Thu, 17 Mar 2011 10:20:32 -0700
Subject: [PATCH V3 10/19] OMAP3+: SR: enable/disable SR only on need
In-Reply-To: <1299338962-5602-11-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:13 +0530")
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-11-git-send-email-nm@ti.com>
Message-ID: <87aagt8xzz.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> Since we already know the state of the autocomp enablement, we can
> see if the requested state is different from the current state and
> enable/disable SR only on the need basis.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, queuing for 2.6.40.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index f9057ad..2b6fdc7 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -806,10 +806,13 @@ static int omap_sr_autocomp_store(void *data, u64 val)
>  		return -EINVAL;
>  	}
>  
> -	if (!val)
> -		sr_stop_vddautocomp(sr_info);
> -	else
> -		sr_start_vddautocomp(sr_info);
> +	/* control enable/disable only if there is a delta in value */
> +	if (sr_info->autocomp_active != val) {
> +		if (!val)
> +			sr_stop_vddautocomp(sr_info);
> +		else
> +			sr_start_vddautocomp(sr_info);
> +	}
>  
>  	return 0;
>  }
