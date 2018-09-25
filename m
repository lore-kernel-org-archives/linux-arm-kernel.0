From: joel@joelfernandes.org (Joel Fernandes)
Date: Tue, 25 Sep 2018 14:25:34 -0700
Subject: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints go
 to pstore
In-Reply-To: <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <CAEXW_YRQtJb=3V0RKHSAejfQXKssh5qBp7nmD1OUC-wTyqGDEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 8, 2018 at 1:28 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Add the kernel command line tp_pstore option that will have
> tracepoints go to persistent ram buffer as well as to the
> trace buffer for further debugging. This is similar to tp_printk
> cmdline option of ftrace.
>
> Pstore support for event tracing is already added and we enable
> logging to pstore only if cmdline is specified.
>
> Passing "tp_pstore" will activate logging to pstore. To turn it
> off, the sysctl /proc/sys/kernel/tracepoint_pstore can have '0'
> echoed into it. Note, this only works if the cmdline option is
> used. Echoing 1 into the sysctl file without the cmdline option
> will have no affect.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  .../admin-guide/kernel-parameters.txt         | 21 ++++++++
>  include/linux/ftrace.h                        |  6 ++-
>  kernel/sysctl.c                               |  7 +++
>  kernel/trace/Kconfig                          | 22 +++++++-
>  kernel/trace/trace.c                          | 51 +++++++++++++++++++
>  kernel/trace/trace.h                          |  7 +++
>  6 files changed, 112 insertions(+), 2 deletions(-)
>
[...]
>  config GCOV_PROFILE_FTRACE
>         bool "Enable GCOV profiling on ftrace subsystem"
>         depends on GCOV_KERNEL
> @@ -789,4 +810,3 @@ config GCOV_PROFILE_FTRACE
>  endif # FTRACE
>
>  endif # TRACING_SUPPORT
> -
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index bf6f1d70484d..018cbbefb769 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -73,6 +73,11 @@ struct trace_iterator *tracepoint_print_iter;
>  int tracepoint_printk;
>  static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
>
> +/* Pipe tracepoints to pstore */
> +struct trace_iterator *tracepoint_pstore_iter;
> +int tracepoint_pstore;
> +static DEFINE_STATIC_KEY_FALSE(tracepoint_pstore_key);
> +
>  /* For tracers that don't implement custom flags */
>  static struct tracer_opt dummy_tracer_opt[] = {
>         { }
> @@ -238,6 +243,14 @@ static int __init set_tracepoint_printk(char *str)
>  }
>  __setup("tp_printk", set_tracepoint_printk);
>
> +static int __init set_tracepoint_pstore(char *str)
> +{
> +       if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
> +               tracepoint_pstore = 1;
> +       return 1;
> +}
> +__setup("tp_pstore", set_tracepoint_pstore);
> +
>  unsigned long long ns2usecs(u64 nsec)
>  {
>         nsec += 500;
> @@ -2376,11 +2389,45 @@ int tracepoint_printk_sysctl(struct ctl_table *table, int write,
>         return ret;
>  }
>
> +static DEFINE_MUTEX(tracepoint_pstore_mutex);
> +
> +int tracepoint_pstore_sysctl(struct ctl_table *table, int write,
> +                            void __user *buffer, size_t *lenp,
> +                            loff_t *ppos)
> +{
> +       int save_tracepoint_pstore;
> +       int ret;
> +
> +       mutex_lock(&tracepoint_pstore_mutex);
> +       save_tracepoint_pstore = tracepoint_pstore;
> +
> +       ret = proc_dointvec(table, write, buffer, lenp, ppos);
> +
> +       if (!tracepoint_pstore_iter)
> +               tracepoint_pstore = 0;
> +
> +       if (save_tracepoint_pstore == tracepoint_pstore)
> +               goto out;
> +
> +       if (tracepoint_pstore)
> +               static_key_enable(&tracepoint_pstore_key.key);
> +       else
> +               static_key_disable(&tracepoint_pstore_key.key);
> +
> + out:
> +       mutex_unlock(&tracepoint_pstore_mutex);
> +
> +       return ret;
> +}
> +
>  void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
>  {
>         if (static_key_false(&tracepoint_printk_key.key))
>                 output_printk(fbuffer);
>
> +       if (static_key_false(&tracepoint_pstore_key.key))
> +               pstore_event_call(fbuffer);

Can you not find a way to pass the size of the even record here, to
pstore? Then you can directly allocate and store the binary record in
pstore itself instead of rendering and storing the text in pstore
which will be more space (and I think time) efficient. I also think if
you do this, then you will not need to use the spinlock in the pstore
(which AIUI is preventing the warning you're seeing in the
event_call->event.funcs->trace() call).

- Joel
