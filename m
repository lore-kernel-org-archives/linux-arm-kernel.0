From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 5 May 2010 00:06:53 +0800
Subject: [PATCH 2/2] lockdep: allow user to disable CONFIG_TRACE_IRQFLAGS
In-Reply-To: <1272988944-2448-1-git-send-email-tom.leiming@gmail.com>
References: <1272988944-2448-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <k2jd82e647a1005040906of4d64006s7a2236a0dcd9f845@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: ARM

2010/5/5  <tom.leiming@gmail.com>:
> From: Ming Lei <tom.leiming@gmail.com>
>
> There is still the lost irq-on tracing issue on ARM,
> (see http://marc.info/?l=linux-arm-kernel&m=126047420005553&w=2)
> which may disable lockdep after kernel boot, seems no
> good solution for the issue up to now.
>
> The patch exports the config option of CONFIG_TRACE_IRQFLAGS
> and allows user to disable it for support of checking circular
> dead lock only if irq flags tracing can't work correctly always.
>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
> ?lib/Kconfig.debug ? ? ?| ? ?3 +++
> ?lib/locking-selftest.c | ? ?2 ++
> ?2 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 935248b..448f18f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -550,11 +550,14 @@ config DEBUG_LOCKDEP
> ? ? ? ? ?of more runtime overhead.
>
> ?config TRACE_IRQFLAGS
> + ? ? ? bool "Lock prove: IRQ flags tracing"
> ? ? ? ?depends on DEBUG_KERNEL
> ? ? ? ?bool
> ? ? ? ?default y
> ? ? ? ?depends on TRACE_IRQFLAGS_SUPPORT
> ? ? ? ?depends on PROVE_LOCKING
> + ? ? ? help
> + ? ? ? ? If you say Y here, IRQ flags will be traced to prove locking.
>
> ?config DEBUG_SPINLOCK_SLEEP
> ? ? ? ?bool "Spinlock debugging: sleep-inside-spinlock checking"
> diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
> index 619313e..d9e5bfe 100644
> --- a/lib/locking-selftest.c
> +++ b/lib/locking-selftest.c
> @@ -1176,6 +1176,7 @@ void locking_selftest(void)
>
> ? ? ? ?printk(" ?--------------------------------------------------------------------------\n");
>
> +#ifdef CONFIG_TRACE_IRQFLAGS
> ? ? ? ?/*
> ? ? ? ? * irq-context testcases:
> ? ? ? ? */
> @@ -1188,6 +1189,7 @@ void locking_selftest(void)
>
> ? ? ? ?DO_TESTCASE_6x2("irq read-recursion", irq_read_recursion);
> ?// ? ? DO_TESTCASE_6x2B("irq read-recursion #2", irq_read_recursion2);
> +#endif
>
> ? ? ? ?if (unexpected_testcase_failures) {
> ? ? ? ? ? ? ? ?printk("-----------------------------------------------------------------\n");
> --
> 1.6.2.5
>
>



-- 
Lei Ming
