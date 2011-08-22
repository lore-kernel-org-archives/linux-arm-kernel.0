From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Aug 2011 21:49:02 +0100
Subject: [RFC][PATCH 1/1 v4] Add Thread Support for the Context ID
	Register of ARM v6 & v7 Architectures
In-Reply-To: <7c97233468c8cd179066476201cee616e4f69182.1314025227.git.wolfgang.betz@st.com>
References: <cover.1314025227.git.wolfgang.betz@st.com>
	<7c97233468c8cd179066476201cee616e4f69182.1314025227.git.wolfgang.betz@st.com>
Message-ID: <20110822204900.GA23088@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfgang,

On Mon, Aug 22, 2011 at 04:14:36PM +0100, Wolfgang BETZ wrote:
> From: Wolfgang Betz <wolfgang.betz@st.com>
> 
> The aim of this patch is to enable thread support in the context ID register
> (CONTEXTIDR) as it comes with ARM architectures v6 & v7.

[...]

> Signed-off-by: Wolfgang Betz <wolfgang.betz@st.com>
> ---
>  arch/arm/Kconfig.debug             |   13 +++++++
>  arch/arm/include/asm/mmu_context.h |   63 +++++++++++++++++++++++++++++++----
>  arch/arm/include/asm/proc-fns.h    |    9 ++---
>  arch/arm/kernel/smp.c              |    2 +-
>  arch/arm/mm/context.c              |   42 +++++++++++++++++++++++-
>  arch/arm/mm/proc-v6.S              |    4 +-
>  arch/arm/mm/proc-v7.S              |    4 +-
>  7 files changed, 117 insertions(+), 20 deletions(-)

I'm still less than thrilled by this patch.

> +#ifdef CONFIG_THREAD_CONTEXTID
> +/*
> + * Add support for threads in CONTEXTIDR by registering a
> + * 'sched_switch' tracepoint event function
> + */
> +static void thrctx_sched_switch(void *ignore, struct task_struct *prev,
> +                               struct task_struct *next)
> +{
> +       struct mm_struct *mm, *oldmm;
> +
> +       mm = next->mm;
> +       oldmm = prev->active_mm;
> +
> +       if (!mm) {
> +               set_context_id(next, oldmm);
> +       } else {
> +               if (oldmm == mm)
> +                       set_context_id(next, mm);
> +       }
> +}

Are interrupts disabled in this function? What happens if we receive an ASID
rollover IPI during set_context_id?

> +static int __init init_thread_contextid(void)
> +{
> +       int ret;
> +
> +       ret = register_trace_sched_switch(thrctx_sched_switch, NULL);
> +       if (ret)
> +               pr_info("ftrace_graph: Couldn't activate tracepoint"
> +                       " probe to kernel_sched_switch\n");
> +
> +       return ret;
> +}
> +device_initcall(init_thread_contextid);

I don't think this is the right hook for what you want. Firsly, it gives you
a dependence on CONFIG_TRACEPOINTS and secondly we already have context
switch notifiers that are probably better suited for your purposes.

I posted a smaller, less invasive prototype patch once before:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-July/058436.html

If you take that and change the ASID code to preserve the upper bits I think
you can do everything you need with a lot less difficulty. Additionally,
future CPUs (Cortex-A15 onwards) separate the ASID from the Context ID,
something which will require your patch to be reworked since it tightly
couples the PID writing with the ASID update in the context_id function.

If what I've proposed can't be made suitable for you, then I reckon you're
better off maintaining this as an out-of-tree patch.

Will
