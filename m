From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Tue, 9 Oct 2018 10:20:02 +0800
Subject: [RESEND PATCH] ARM: prevent tracing IPI_CPU_BACKTRACE
In-Reply-To: <1538019697-14673-1-git-send-email-chunyan.zhang@unisoc.com>
References: <1538019697-14673-1-git-send-email-chunyan.zhang@unisoc.com>
Message-ID: <CAAfSe-ugVfdsSf_jQBYH8QObbjJJpBE+QcN75VzgS9eczbOdyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

If there's no comments, should I submit this patch on RMK's Patch system?

Thanks,
Chunyan

On 27 September 2018 at 11:41, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When function tracing for IPIs is enabled, we get a warning for an
> overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
> as triggered by raise_nmi():
>
> arch/arm/kernel/smp.c: In function 'raise_nmi':
> arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
>         trace_ipi_raise(target, ipi_types[ipinr]);
>
> This is a correct warning as we actually overflow the array here.
>
> This patch raise_nmi() to call __smp_cross_call() instead of
> smp_cross_call(), to avoid calling into ftrace. For clarification,
> I'm also adding a two new code comments describing how this one
> is special.
>
> The warning appears to have shown up after patch e7273ff49acf
> ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI"), which
> changed the number assignment from '15' to '8', but as far as I can
> tell has existed since the IPI tracepoints were first introduced.
> If we decide to backport this patch to stable kernels, we probably
> need to backport e7273ff49acf as well.
>
> Resubmiting this patch is because that I found coverity is complaining
> the issue this patch fixed, and also I got the traces like below:
> "ipi_raise: target_mask=00000001 (machine_suspend)" which actually was
> the TPS of suspend_resume[1] rather than ipi_raise.
>
> [1]
> https://elixir.bootlin.com/linux/latest/source/kernel/power/suspend.c#L80
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
> Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  arch/arm/include/asm/hardirq.h | 1 +
>  arch/arm/kernel/smp.c          | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
> index cba23ea..7a88f16 100644
> --- a/arch/arm/include/asm/hardirq.h
> +++ b/arch/arm/include/asm/hardirq.h
> @@ -6,6 +6,7 @@
>  #include <linux/threads.h>
>  #include <asm/irq.h>
>
> +/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
>  #define NR_IPI 7
>
>  typedef struct {
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 0978282..123be77 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -75,6 +75,10 @@ enum ipi_msg_type {
>         IPI_CPU_STOP,
>         IPI_IRQ_WORK,
>         IPI_COMPLETION,
> +       /*
> +        * CPU_BACKTRACE is special and not included in NR_IPI
> +        * or tracable with trace_ipi_*
> +        */
>         IPI_CPU_BACKTRACE,
>         /*
>          * SGI8-15 can be reserved by secure firmware, and thus may
> @@ -755,7 +759,7 @@ core_initcall(register_cpufreq_notifier);
>
>  static void raise_nmi(cpumask_t *mask)
>  {
> -       smp_cross_call(mask, IPI_CPU_BACKTRACE);
> +       _smp_cross_call(mask, IPI_CPU_BACKTRACE);
>  }
>
>  void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> --
> 2.7.4
>
