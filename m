From: frowand.list@gmail.com (Frank Rowand)
Date: Mon, 05 Oct 2015 16:52:35 -0700
Subject: [PATCH v6 21/22] driver core: Start processing deferred probes
 earlier
In-Reply-To: <1442844182-27787-22-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-22-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <56130D43.10200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/21/2015 7:03 AM, Tomeu Vizoso wrote:
> Some initcalls in the late level assume that some devices will have
> already probed without explicitly checking for that.
> 
> After the recent move to defer most device probes when they are
> registered, pressure increased in the late initcall level.
> 
> By starting the processing of the deferred queue in device_initcall_sync
> we increase the chances that the initcalls mentioned before will find
> the devices they depend on to have already probed.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
> 
> Changes in v4:
> - Start processing deferred probes in device_initcall_sync
> 
>  drivers/base/dd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 269ea76c1a4f..f0ef9233fcd6 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -176,7 +176,7 @@ static void driver_deferred_probe_trigger(void)
>   *
>   * We don't want to get in the way when the bulk of drivers are getting probed.
>   * Instead, this initcall makes sure that deferred probing is delayed until
> - * late_initcall time.
> + * device_initcall_sync time.

This is a misuse of the *_sync initcall level.

If a deferred probe created a thread and expected a wait at the
following *_sync level then the wait would not occur because
there is no subsequent *_sync level.  This is not a problem today
because (as far as I know) there are no threads in the probe
functions.  But there has been interest in adding parallel
probing and that could expose this problem.

The purpose of the *_sync initcall levels is to allow the corresponding
initcall level to use multiple threads of execution instead of a single
thread.  The *_sync level provides a location for a wait for all of the
threads at the corresponding init level to complete.  This is better
explained in the git log:

commit 735a7ffb739b6efeaeb1e720306ba308eaaeb20e
Author: Andrew Morton <akpm@osdl.org>
Date:   Fri Oct 27 11:42:37 2006 -0700

    [PATCH] drivers: wait for threaded probes between initcall levels

    The multithreaded-probing code has a problem: after one initcall level (eg,
    core_initcall) has been processed, we will then start processing the next
    level (postcore_initcall) while the kernel threads which are handling
    core_initcall are still executing.  This breaks the guarantees which the
    layered initcalls previously gave us.

    IOW, we want to be multithreaded _within_ an initcall level, but not between
    different levels.

    Fix that up by causing the probing code to wait for all outstanding probes at
    one level to complete before we start processing the next level.

>   */
>  static int deferred_probe_initcall(void)
>  {
> @@ -190,7 +190,7 @@ static int deferred_probe_initcall(void)
>  	flush_workqueue(deferred_wq);
>  	return 0;
>  }
> -late_initcall(deferred_probe_initcall);
> +device_initcall_sync(deferred_probe_initcall);
>  
>  static void driver_bound(struct device *dev)
>  {
> 
