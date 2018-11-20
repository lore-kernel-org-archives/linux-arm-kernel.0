From: mpe@ellerman.id.au (Michael Ellerman)
Date: Tue, 20 Nov 2018 22:21:37 +1100
Subject: [PATCH 04/10] powerpc: perf/core: generalise event exclusion
 checking with perf macro
In-Reply-To: <1542363853-13849-5-git-send-email-andrew.murray@arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-5-git-send-email-andrew.murray@arm.com>
Message-ID: <87va4s0zb2.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Murray <andrew.murray@arm.com> writes:

> Replace checking of perf event exclusion flags with perf macro.
>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/powerpc/perf/hv-24x7.c |  7 +------
>  arch/powerpc/perf/hv-gpci.c |  7 +------
>  arch/powerpc/perf/imc-pmu.c | 14 ++------------
>  3 files changed, 4 insertions(+), 24 deletions(-)

These conversions look fine, thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 72238ee..60db22d 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1307,12 +1307,7 @@ static int h_24x7_event_init(struct perf_event *event)
>  	}
>  
>  	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	/* no branch sampling */
> diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
> index 43fabb3..2d2b5c0 100644
> --- a/arch/powerpc/perf/hv-gpci.c
> +++ b/arch/powerpc/perf/hv-gpci.c
> @@ -233,12 +233,7 @@ static int h_gpci_event_init(struct perf_event *event)
>  	}
>  
>  	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	/* no branch sampling */
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 1fafc32b..1ae1d3f 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -474,12 +474,7 @@ static int nest_imc_event_init(struct perf_event *event)
>  		return -EINVAL;
>  
>  	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	if (event->cpu < 0)
> @@ -749,12 +744,7 @@ static int core_imc_event_init(struct perf_event *event)
>  		return -EINVAL;
>  
>  	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	if (event->cpu < 0)
> -- 
> 2.7.4
