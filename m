From: horms@verge.net.au (Simon Horman)
Date: Tue, 4 Dec 2012 14:50:29 +0900
Subject: [PATCH shmobile/DT 1/2] ARM: shmobile: Remove some of_sh_intc_*
 functions
In-Reply-To: <1353572619-29098-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1353572619-29098-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <20121204055029.GC15969@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 05:23:38PM +0900, Nobuhiro Iwamatsu wrote:
> This removes of_sh_intc_get_meminfo, of_sh_intc_get_pint and of_sh_intc_get_intc functions.
> These are not already used.

Hi Iwamatsu-san,

these patches are for Paul, right?

> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>  drivers/sh/intc/of_intc.c |   76 ---------------------------------------------
>  include/linux/sh_intc.h   |   28 -----------------
>  2 files changed, 104 deletions(-)
> 
> diff --git a/drivers/sh/intc/of_intc.c b/drivers/sh/intc/of_intc.c
> index 30b1090..e833e48 100644
> --- a/drivers/sh/intc/of_intc.c
> +++ b/drivers/sh/intc/of_intc.c
> @@ -529,49 +529,6 @@ void __init of_sh_intc_get_skip_syscore_suspend(struct device_node *np,
>  		d->skip_syscore_suspend = false;
>  }
>  
> -int __init of_sh_intc_get_meminfo(struct device_node *np,
> -				struct resource *res, int res_no)
> -{
> -	int ret = 0, i;
> -
> -	for (i = 0 ; i < res_no ; i++) {
> -		ret = of_address_to_resource(np, i, &res[i]);
> -		if (ret) {
> -			pr_err("could not determine device base address\n");
> -			return ret;
> -		}
> -
> -		pr_debug("%s: Address 0x%x, size %d\n",
> -					__func__, res[i].start, resource_size(&res[i]));
> -	}
> -
> -	return ret;
> -}
> -
> -int __init of_sh_intc_get_pint(struct device_node *np, struct intc_desc *d)
> -{
> -	/* pint uses vector, mask and sence. */
> -	int ret = of_sh_intc_get_vector(np, &d->hw.vectors,
> -				&d->hw.nr_vectors);
> -	if (ret)
> -		return ret;
> -
> -	ret = of_sh_intc_get_mask(np, &d->hw.mask_regs,
> -				&d->hw.nr_mask_regs);
> -	if (ret)
> -		return ret;
> -
> -	ret = of_sh_intc_get_sense(np, &d->hw.sense_regs,
> -				&d->hw.nr_sense_regs);
> -	/* INTC may not need Sence register. */
> -	if (ret && ret != -ENOENT)
> -		return ret;
> -
> -	d->of_node = np;
> -
> -	return 0;
> -}
> -
>  int __init of_sh_intc_get_intc(struct device_node *np, struct intc_desc *d)
>  {
>  	int ret = of_sh_intc_get_vector(np, &d->hw.vectors,
> @@ -611,36 +568,3 @@ int __init of_sh_intc_get_intc(struct device_node *np, struct intc_desc *d)
>  
>  	return 0;
>  }
> -
> -int __init of_sh_intc_get_intc_pins(struct device_node *np,
> -				struct intc_desc *d)
> -{
> -	int ret = of_sh_intc_get_vector(np, &d->hw.vectors,
> -				&d->hw.nr_vectors);
> -	if (ret)
> -		return ret;
> -
> -	ret = of_sh_intc_get_mask(np, &d->hw.mask_regs,
> -				&d->hw.nr_mask_regs);
> -	if (ret)
> -		return ret;
> -
> -	ret = of_sh_intc_get_prio(np, &d->hw.prio_regs,
> -				&d->hw.nr_prio_regs);
> -	if (ret)
> -		return ret;
> -
> -	ret = of_sh_intc_get_sense(np, &d->hw.sense_regs,
> -				&d->hw.nr_sense_regs);
> -	if (ret)
> -		return ret;
> -
> -	ret = of_sh_intc_get_ack(np, &d->hw.ack_regs,
> -				&d->hw.nr_ack_regs);
> -	if (ret)
> -		return ret;
> -
> -	d->of_node = np;
> -
> -	return 0;
> -}
> diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
> index 6603da6..c7954ee 100644
> --- a/include/linux/sh_intc.h
> +++ b/include/linux/sh_intc.h
> @@ -161,26 +161,6 @@ static inline int register_intc_userimask(unsigned long addr)
>  int of_sh_intc_get_intc(struct device_node *np, struct intc_desc *d);
>  
>  /*
> - * of_sh_initc_get_intc_pins() - Get INTC Pins table.
> - * @np:     device node to get INTC from
> - * @d:      a pointer of intc pins table
> - *
> - * Return: one of the errno value on the error condition
> - */
> -int of_sh_intc_get_intc_pins(struct device_node *np, struct intc_desc *d);
> -
> -/*
> - * of_sh_intc_get_meminfo() - Get and set INTC register of memory.
> - * @np:     device node to get INTC from
> - * @res_mem:   a pointer of resource
> - * @res_no:  resource number
> - *
> - * Return: one of the errno value on the error condition
> - */
> -int of_sh_intc_get_meminfo(struct device_node *np,
> -				struct resource *res_mem, int resno);
> -
> -/*
>   * of_sh_intc_get_force_enable - Get and set force_enable vector in
>   *                               struct intc_desc.
>   * @np:  device node to get INTC from
> @@ -221,13 +201,5 @@ void of_sh_intc_get_skip_syscore_suspend(struct device_node *np,
>   * Return: one of the errno value on the error condition
>   */
>  int of_sh_intc_get_intevtsa_vect(struct device_node *np, unsigned short *vect);
> -/*
> - * of_sh_initc_get_intc_pint() - Get INTC Pint table.
> - * @np:     device node to get INTC from
> - * @d:      a pointer of intc pint table
> - *
> - * Return: one of the errno value on the error condition
> - */
> -int of_sh_intc_get_pint(struct device_node *np, struct intc_desc *d);
>  
>  #endif /* __SH_INTC_H */
> -- 
> 1.7.10.4
> 
