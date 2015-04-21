From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 21 Apr 2015 12:19:48 +0200 (CEST)
Subject: [PATCH v2] irqchip/gicv3-its: ITS table size should not be
 smaller than PSZ
In-Reply-To: <1429162259-11344-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1429162259-11344-1-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <alpine.DEB.2.11.1504211218330.13914@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Apr 2015, Minghuan Lian wrote:

> The default page size of ITS table has been changed to 64KB,
> but for some platforms the real size of allocated memory which
> calculated by DEVBITS of register GITS_TYPER may be smaller than
> default size. In this case, the allocation size must be increased
> to the default size, otherwise, the wrong page number will cause
> kernel hang.

This changelog fails to explain WHY the kernel hangs if the allocated
table is smaller than the default
 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> v2-v1:
> Increase allocation size instead of decreasing PSZ
> 
>  drivers/irqchip/irq-gic-v3-its.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 9687f8a..19ab86d 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -828,7 +828,8 @@ static int its_alloc_tables(struct its_node *its)
>  			u64 typer = readq_relaxed(its->base + GITS_TYPER);
>  			u32 ids = GITS_TYPER_DEVBITS(typer);
>  
> -			order = get_order((1UL << ids) * entry_size);
> +			order = max(get_order((1UL << ids) * entry_size),
> +				    order);

Lacks a comment explaining WHY we do that max() here.

Thanks,

	tglx
