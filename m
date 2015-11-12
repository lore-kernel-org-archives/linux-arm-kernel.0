From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 12 Nov 2015 15:53:31 +0100
Subject: [PATCH] sched/rt: hide push_irq_work_func declaration
In-Reply-To: <3810009.VdDTV0h1Qp@wuerfel>
References: <3810009.VdDTV0h1Qp@wuerfel>
Message-ID: <20151112145331.GC17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 03:22:22PM +0100, Arnd Bergmann wrote:
> -#ifdef CONFIG_SMP
> +#if IS_ENABLED(CONFIG_SMP) && defined(HAVE_RT_PUSH_IPI)
>  static void push_irq_work_func(struct irq_work *work);
>  #endif

I think we can get tid of the whole HAVE_RT_PUSH_IPI thing after:
8053871d0f7f ("smp: Fix smp_call_function_single_async() locking")

That should allow us to use smp_calling_function_single_async() instead
of irq_work_queue_on(), removing the dependency on irq_work.
