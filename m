From: tj@kernel.org (Tejun Heo)
Date: Wed, 22 Jun 2016 11:21:26 -0400
Subject: [PATCH] PM / suspend: show workqueues busy name in suspend flow
In-Reply-To: <1466586509-32400-1-git-send-email-roger.lu@mediatek.com>
References: <1466586509-32400-1-git-send-email-roger.lu@mediatek.com>
Message-ID: <20160622152126.GV3262@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jun 22, 2016 at 05:08:29PM +0800, Roger Lu wrote:
> When suspend flow is aborted because of workqueues busy,
> show workqueues busy name for debug purpose.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  include/linux/workqueue.h |  1 +
>  kernel/power/process.c    |  3 +++
>  kernel/workqueue.c        | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index ca73c50..c9f9b24 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -609,6 +609,7 @@ long work_on_cpu(int cpu, long (*fn)(void *), void
>  *arg);
>  #ifdef CONFIG_FREEZER
>  extern void freeze_workqueues_begin(void);
>  extern bool freeze_workqueues_busy(void);
> +extern void show_workqueues_busy(void);
>  extern void thaw_workqueues(void);
>  #endif /* CONFIG_FREEZER */
>  
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index df058be..b538881 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -89,6 +89,9 @@ static int try_to_freeze_tasks(bool user_only)
>  		       elapsed_msecs / 1000, elapsed_msecs % 1000,
>  		       todo - wq_busy, wq_busy);
>  
> +		if (wq_busy)
> +			show_workqueues_busy();

I think it'd probably be better to call show_workqueue_state() instead
so that we can get a full picture of what's going on.

Thanks.

-- 
tejun
