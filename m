From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Mar 2015 16:35:50 +0000
Subject: Reading twd_base at run-time
In-Reply-To: <55158261.9010108@free.fr>
References: <55158261.9010108@free.fr>
Message-ID: <551586E6.3020200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mason,

On 27/03/15 16:16, Mason wrote:
> Hello everyone,
> 
> In arch/arm/kernel/smp_twd.c, twd_local_timer_register() receives a
> struct twd_local_timer argument, which specifies
> 
>    1) the physical address of twd_base
>    2) the twd interrupt number
> 
> There's a helper to fill out the static struct: DEFINE_TWD_LOCAL_TIMER()
> 
> But it seems to me (please correct me if I'm wrong) that the address
> of twd_base can be read at run-time, making it one less parameter to
> specify by hand at compile-time (with the risk that a HW engineer
> change the address in the next chip with no warning).

The main problem with that is that said HW engineer has ^%$%^%-up
PERIPHBASE, and that you can't trust it. I've seen a number of these
kicking around.

> Here's an incomplete patch to express my intent:
> 
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 6591e26..5177db8 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -369,14 +369,14 @@ out_free:
>          return err;
>   }
>   
> -int __init twd_local_timer_register(struct twd_local_timer *tlt)
> +int __init twd_local_timer_register(void)
>   {
>          if (twd_base || twd_evt)
>                  return -EBUSY;
>   
> -       twd_ppi = tlt->res[1].start;
> +       twd_ppi = 29;
>   
> -       twd_base = ioremap(tlt->res[0].start, resource_size(&tlt->res[0]));
> +       twd_base = ioremap(scu_a9_get_base() + 0x600, 0x10);
>          if (!twd_base)
>                  return -ENOMEM;
>   
> 
> As far as I can tell, all platforms use 29 for twd_ppi, but I can make
> sure if people agree this patch is indeed an improvement.

I don't think we'll see that many new platforms not using DT, so this
would effectively remove one line from the helper, and generate a bit of
churn on platforms that are usually left in a dusty corner...

	M.
-- 
Jazz is not dead. It just smells funny...
