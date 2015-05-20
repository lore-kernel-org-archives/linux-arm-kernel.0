From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 May 2015 00:18:06 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <555D030F.8030100@free.fr>
References: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <76003699.Oyq777txnm@wuerfel> <555D030F.8030100@free.fr>
Message-ID: <2681862.SyQNaSxams@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 23:56:31 Mason wrote:
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 6591e26fc13f..3e867b2f067f 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -32,6 +32,7 @@ static void __iomem *twd_base;
>  static struct clk *twd_clk;
>  static unsigned long twd_timer_rate;
>  static DEFINE_PER_CPU(bool, percpu_setup_called);
> +static int feat_c3stop = CLOCK_EVT_FEAT_C3STOP;
>  
>  static struct clock_event_device __percpu *twd_evt;
>  static int twd_ppi;
> @@ -294,7 +295,7 @@ static void twd_timer_setup(void)
>  
>         clk->name = "local_timer";
>         clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
> -                       CLOCK_EVT_FEAT_C3STOP;
> +                       feat_c3stop;
>         clk->rating = 350;
>         clk->set_mode = twd_set_mode;
>         clk->set_next_event = twd_set_next_event;
> @@ -346,6 +347,7 @@ static int __init twd_local_timer_common_register(struct device_node *np)
>                 goto out_irq;
>  
>         twd_get_clock(np);
> +       if (of_get_property(np, "twd_never_stops", NULL)) feat_c3stop = 0;

of_property_read_bool(), and newline between the condition and the
assignment.

>         /*
>          * Immediately configure the timer on the boot CPU, unless we need
> 
> 
> Or perhaps the other way around?
> i.e. feat_c3stop initialized to 0 (thus in the bss section)
> and set to FEAT_C3STOP if "twd_never_stops" doesn't exist...

yes.

> Russell, when you added the FEAT_C3STOP flag unconditionally in
> commit 5388a6b266, didn't that potentially break platforms that
> didn't expect the flag to be set?

To take a step back, you should first figure out whether clearing
this flag is actually the correct behavior for your hardware, or
just happens to work by accident.

	Arnd
