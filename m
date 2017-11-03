From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Fri, 3 Nov 2017 15:04:15 +0100
Subject: [PATCH] exynos: drm: use monotonic timestamps
In-Reply-To: <20171102114415.1811842-1-arnd@arndb.de>
References: <20171102114415.1811842-1-arnd@arndb.de>
Message-ID: <f6a26bf4-e3b6-97c1-3a92-00ffe97ae293@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

I guess you could coordinate the IPP changes with Marek, who is rewriting the
IPP subsystem anyway (added Marek to Cc).

Here is the most recent IPPv2 series:
https://www.spinics.net/lists/linux-samsung-soc/msg61066.html

Concerning the G2D changes, I don't think anything in userspace uses the
timestamps (e.g. for synchronisation).

With best wishes,
Tobias


Arnd Bergmann wrote:
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
> Ideally timestamps should just use 64-bit nanoseconds instead, but
> of course we can't change that now. Instead, this tries to address
> the first four points above by using monotonic 'timespec' values.
> 
> The downside is that there is a small risk of breaking user space
> if that expects the absolute timestamp numbers to relate to the
> result of 'gettimeofday()'. Please review the user space driver
> before applying this patch to ensure this works.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 6 +++---
>  drivers/gpu/drm/exynos/exynos_drm_ipp.c | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
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
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
> index 3edda18cc2d2..3f9d8d79bbde 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
> @@ -1406,7 +1406,7 @@ static int ipp_send_event(struct exynos_drm_ippdrv *ippdrv,
>  	struct drm_exynos_ipp_queue_buf qbuf;
>  	struct drm_exynos_ipp_send_event *e;
>  	struct list_head *head;
> -	struct timeval now;
> +	struct timespec64 now;
>  	u32 tbuf_id[EXYNOS_DRM_OPS_MAX] = {0, };
>  	int ret, i;
>  
> @@ -1509,10 +1509,10 @@ static int ipp_send_event(struct exynos_drm_ippdrv *ippdrv,
>  	e = list_first_entry(&c_node->event_list,
>  		struct drm_exynos_ipp_send_event, base.link);
>  
> -	do_gettimeofday(&now);
> -	DRM_DEBUG_KMS("tv_sec[%ld]tv_usec[%ld]\n", now.tv_sec, now.tv_usec);
> +	ktime_get_ts64(&now);
> +	DRM_DEBUG_KMS("tv_sec[%lld]tv_nsec[%ld]\n", (s64)now.tv_sec, now.tv_nsec);
>  	e->event.tv_sec = now.tv_sec;
> -	e->event.tv_usec = now.tv_usec;
> +	e->event.tv_usec = now.tv_nsec / NSEC_PER_USEC;
>  	e->event.prop_id = property->prop_id;
>  
>  	/* set buffer id about source destination */
> 
