From: robherring2@gmail.com (Rob Herring)
Date: Mon, 28 Apr 2014 12:54:58 -0500
Subject: [PATCH 02/16] ARM: l2c: add platform independent core L2 cache
 initialisation
In-Reply-To: <E1WeosP-0002PO-5m@rmk-PC.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
 <E1WeosP-0002PO-5m@rmk-PC.arm.linux.org.uk>
Message-ID: <CAL_JsqJDj_JZT_Mo5=Y1NqObX19v7WvuWSrmAZ4UXi9s6-prXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 11:57 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Add a hook into the core ARM code to perform L2 cache initialisation
> in a platform independent manner.  Platforms still get to indicate
> their auxiliary control register values and mask, but the
> initialisation call will now be made from generic code.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

[...]

> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index 9723d17b8f38..2c4257604513 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -37,6 +37,7 @@
>  #include <linux/proc_fs.h>
>  #include <linux/export.h>
>
> +#include <asm/hardware/cache-l2x0.h>
>  #include <asm/exception.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/irq.h>
> @@ -115,10 +116,21 @@ EXPORT_SYMBOL_GPL(set_irq_flags);
>
>  void __init init_IRQ(void)
>  {
> +       int ret;
> +
>         if (IS_ENABLED(CONFIG_OF) && !machine_desc->init_irq)
>                 irqchip_init();
>         else
>                 machine_desc->init_irq();
> +
> +       if (IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_CACHE_L2X0) &&
> +           (machine_desc->l2c_aux_mask || machine_desc->l2c_aux_val)) {
> +               outer_cache.write_sec = machine_desc->l2c_write_sec;
> +               ret = l2x0_of_init(machine_desc->l2c_aux_val,
> +                                  machine_desc->l2c_aux_mask);

This function should be a nop if there is no DT node matching, so we
don't really need to trigger calling it based on machine_desc values.
If we do that, then we can have aux_mask and aux_val values of 0 for
both also mean don't do any aux ctrl setup. That would help minimize
the machine_desc for many platforms.

Rob
