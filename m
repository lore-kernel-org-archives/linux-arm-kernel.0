From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Mar 2014 15:33:49 +0100
Subject: [PATCH2] CNS3xxx: Fix a WARN() related to IRQ allocation.
In-Reply-To: <m338iynsp0.fsf@t19.piap.pl>
References: <m3eh2nqz7n.fsf@t19.piap.pl> <m338iynsp0.fsf@t19.piap.pl>
Message-ID: <201403171533.50200.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 March 2014, Krzysztof Ha?asa wrote:
> WARNING: at drivers/irqchip/irq-gic.c:952 gic_init_bases+0xe4/0x2b8()
> Cannot allocate irq_descs @ IRQ16, assuming pre-allocated
> Backtrace:
> gic_init_bases    from cns3xxx_init_irq+0x24/0x34
> cns3xxx_init_irq  from init_IRQ+0x24/0x2c
> init_IRQ          from start_kernel+0x1a8/0x338
> start_kernel      from 0x2000806c
> 
> The problem is that 64 CNS3xxx CPU interrupts, starting at 32, are
> allocated by the ARM platform-independent code (as requested by
> machine_desc->nr_irqs = 96), and then the GIC code tries to allocate
> them again.
> 
> Tested on Gateworks Laguna board, masqueraded as CNS3420VB.
> 
> Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

Applied to next/fixes-non-critical.

	Arnd

> --- a/arch/arm/mach-cns3xxx/cns3420vb.c
> +++ b/arch/arm/mach-cns3xxx/cns3420vb.c
> @@ -246,7 +246,6 @@ static void __init cns3420_map_io(void)
>  
>  MACHINE_START(CNS3420VB, "Cavium Networks CNS3420 Validation Board")
>         .atag_offset    = 0x100,
> -       .nr_irqs        = NR_IRQS_CNS3XXX,
>         .map_io         = cns3420_map_io,
>         .init_irq       = cns3xxx_init_irq,
>         .init_time      = cns3xxx_timer_init,
> --- a/arch/arm/mach-cns3xxx/core.c
> +++ b/arch/arm/mach-cns3xxx/core.c
> @@ -400,7 +400,6 @@ static const char *cns3xxx_dt_compat[] __initdata = {
>  
>  DT_MACHINE_START(CNS3XXX_DT, "Cavium Networks CNS3xxx")
>         .dt_compat      = cns3xxx_dt_compat,
> -       .nr_irqs        = NR_IRQS_CNS3XXX,
>         .map_io         = cns3xxx_map_io,
>         .init_irq       = cns3xxx_init_irq,
>         .init_time      = cns3xxx_timer_init,
