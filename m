From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 06 Feb 2018 09:05:47 +0900
Subject: [PATCH] [v2] drm/exynos: g2d: use monotonic timestamps
In-Reply-To: <20180117170131.2677586-1-arnd@arndb.de>
References: <CGME20180117170211epcas5p12a9b274b2b0d0b0522c909be3644eebb@epcas5p1.samsung.com>
 <20180117170131.2677586-1-arnd@arndb.de>
Message-ID: <5A78F15B.30707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2018? 01? 18? 02:01? Arnd Bergmann ?(?) ? ?:
> The exynos DRM driver uses real-time 'struct timeval' values
> for exporting its timestamps to user space. This has multiple
> problems:
> 
> 1. signed seconds overflow in y2038
> 2. the 'struct timeval' definition is deprecated in the kernel
> 3. time may jump or go backwards after a 'settimeofday()' syscall
> 4. other DRM timestamps are in CLOCK_MONOTONIC domain, so they
>    can't be compared
> 5. exporting microseconds requires a division by 1000, which may
>    be slow on some architectures.
> 
> The code existed in two places before, but the IPP portion was
> removed in 8ded59413ccc ("drm/exynos: ipp: Remove Exynos DRM
> IPP subsystem"), so we no longer need to worry about it.
> 
> Ideally timestamps should just use 64-bit nanoseconds instead, but
> of course we can't change that now. Instead, this tries to address
> the first four points above by using monotonic 'timespec' values.
> 
> According to Tobias Jakobi, user space doesn't care about the
> timestamp at the moment, so we can change the format. Even if
> there is something looking at them, it will work just fine with
> monotonic times as long as the application only looks at the
> relative values between two events.
> 
> Link: https://patchwork.kernel.org/patch/10038593/
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Picked it up.

Thanks,
Inki Dae

> ---
> v2: rebased to what will be in 4.15, now that ipp is gone,
>     updated changelog text based on input from Tobias.
> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index 2b8bf2dd6387..9effe40f5fa5 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -926,7 +926,7 @@ static void g2d_finish_event(struct g2d_data *g2d, u32 cmdlist_no)
>  	struct drm_device *drm_dev = g2d->subdrv.drm_dev;
>  	struct g2d_runqueue_node *runqueue_node = g2d->runqueue_node;
>  	struct drm_exynos_pending_g2d_event *e;
> -	struct timeval now;
> +	struct timespec64 now;
>  
>  	if (list_empty(&runqueue_node->event_list))
>  		return;
> @@ -934,9 +934,9 @@ static void g2d_finish_event(struct g2d_data *g2d, u32 cmdlist_no)
>  	e = list_first_entry(&runqueue_node->event_list,
>  			     struct drm_exynos_pending_g2d_event, base.link);
>  
> -	do_gettimeofday(&now);
> +	ktime_get_ts64(&now);
>  	e->event.tv_sec = now.tv_sec;
> -	e->event.tv_usec = now.tv_usec;
> +	e->event.tv_usec = now.tv_nsec / NSEC_PER_USEC;
>  	e->event.cmdlist_no = cmdlist_no;
>  
>  	drm_send_event(drm_dev, &e->base);
> 
