From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 24 Dec 2014 07:16:00 +0530
Subject: [PATCH] cpufreq: suspend cpufreq governors on shutdown
In-Reply-To: <1419379901-17182-1-git-send-email-dianders@chromium.org>
References: <1419379901-17182-1-git-send-email-dianders@chromium.org>
Message-ID: <CAKohpo=Xm6sSqVtNaL=ycJ=mbFW0n6zddcu5pawDL3F10SaTEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 December 2014 at 05:41, Doug Anderson <dianders@chromium.org> wrote:
> We should stop cpufreq governors when we shut down the system.  If we
> don't do this, we can end up with this deadlock:

Can you also add what exactly happens in such deadlock? Some lockdeps?
Or just a hang ?

> 1. cpufreq governor may be running on a CPU other than CPU0.
> 2. In machine_restart() we call smp_send_stop() which stops CPUs.
>    If one of these CPUs was actively running a cpufreq governor
>    then it may have the mutex / spinlock needed to access the main
>    PMIC in the system (perhaps over I2C)
> 3. If a machine needs access to the main PMIC in order to shutdown
>    then it will never get it since the mutex was lost when the other
>    CPU stopped.
>
> Let's avoid the race by stopping the cpufreq governor at shutdown,
> which is a sensible thing to do anyway.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> NOTE: This was developed / tested / on a 3.14 kernel with backports.
> I have confirmed that it compiles on a mainline kernel and doesn't
> crash, but I haven't verified that there isn't some other fix in
> mainline that also fixes this problem.  If you are aware of such a fix
> then please drop this patch.

No, its a new problem.

>  drivers/cpufreq/cpufreq.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a09a29c..bd89721 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -27,6 +27,7 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
> +#include <linux/syscore_ops.h>
>  #include <linux/tick.h>
>  #include <trace/events/power.h>
>
> @@ -2550,6 +2551,15 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
>
> +static void cpufreq_shutdown(void)
> +{
> +       cpufreq_suspend();
> +}
> +
> +static struct syscore_ops cpufreq_syscore_ops = {
> +       .shutdown = cpufreq_shutdown,

directly pass cpufreq_suspend() here and add a note over the
cpufreq_syscore_ops on why it exists here.

> +};
> +
>  static int __init cpufreq_core_init(void)
>  {
>         if (cpufreq_disabled())
> @@ -2558,6 +2568,8 @@ static int __init cpufreq_core_init(void)
>         cpufreq_global_kobject = kobject_create();
>         BUG_ON(!cpufreq_global_kobject);
>
> +       register_syscore_ops(&cpufreq_syscore_ops);
> +
>         return 0;
>  }
>  core_initcall(cpufreq_core_init);
> --
> 2.2.0.rc0.207.ga3a616c
>
