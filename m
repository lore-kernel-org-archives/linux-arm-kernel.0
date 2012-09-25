From: robherring2@gmail.com (Rob Herring)
Date: Tue, 25 Sep 2012 14:28:36 -0500
Subject: [PATCH] ARM: GIC: dont warn on pre-allocated IRQ descs
In-Reply-To: <1348600794-2395-1-git-send-email-linus.walleij@stericsson.com>
References: <1348600794-2395-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <506205E4.4050803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2012 02:19 PM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Currently, if you try to turn on CONFIG_SPARSE_IRQS for a platform
> using the GIC, you will get this in your face:
> 
> ------------[ cut here ]------------
> WARNING: at /home/elinwal/linux-stericsson/arch/arm/common/gic.c:713 gic_init_bases+0xe8/0x290()
> Cannot allocate irq_descs @ IRQ16, assuming pre-allocated
> Modules linked in:
> [<c0014710>] (unwind_backtrace+0x0/0xf8) from [<c001d304>] (warn_slowpath_common+0x4c/0x64)
> [<c001d304>] (warn_slowpath_common+0x4c/0x64) from [<c001d3b0>] (warn_slowpath_fmt+0x30/0x40)
> [<c001d3b0>] (warn_slowpath_fmt+0x30/0x40) from [<c03e60f8>] (gic_init_bases+0xe8/0x290)
> [<c03e60f8>] (gic_init_bases+0xe8/0x290) from [<c03e6560>] (ux500_init_irq+0xb0/0xfc)
> [<c03e6560>] (ux500_init_irq+0xb0/0xfc) from [<c03e2114>] (init_IRQ+0x14/0x1c)
> [<c03e2114>] (init_IRQ+0x14/0x1c) from [<c03df698>] (start_kernel+0x198/0x2ec)
> [<c03df698>] (start_kernel+0x198/0x2ec) from [<00008044>] (0x8044)
> ---[ end trace 1b75b31a2719ed1c ]---
> 
> This is because the GIC tries to allocate fresh IRQ descs for
> its IRQs, and that would work with non-sparse IRQs but fails
> with sparse IRQs because the .nr_irqs from the platform always
> get pre-allocated at boot time.
> 
> The allocation will succeed if the platform define .nr_irqs
> to 0 as an ideal device tree platform would do, but I think it
> is a bit thick to require that every platform that wants to
> use sparse IRQs must first or simultaneously switch to
> device tree. So make this to a simple pr_debug().

It's not a matter of switching to DT or not. It is a matter of whether
an irq_chip allocates it's descriptors or not either directly or
indirectly via irqdomain. The gic does this, so it is secondary
controllers which are the problem. A platform could allocate the ranges
needed for those controllers and leave a hole for the gic to allocate.

A prefer to leave this so platforms get fixed.

Rob

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/common/gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index aa52699..fcda633 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -707,7 +707,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  	gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
>  	irq_base = irq_alloc_descs(irq_start, 16, gic_irqs, numa_node_id());
>  	if (IS_ERR_VALUE(irq_base)) {
> -		WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
> +		pr_debug("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
>  		     irq_start);
>  		irq_base = irq_start;
>  	}
> 
