From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 12:12:08 +0000
Subject: [PATCH] mach-shmobile: Emma Mobile EV2 SMP prototype code
In-Reply-To: <20120509075407.5991.60556.sendpatchset@w520>
References: <20120509075407.5991.60556.sendpatchset@w520>
Message-ID: <201205091212.08239.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Magnus Damm wrote:
>  static unsigned int __init shmobile_smp_get_core_count(void)
>  {
> @@ -31,6 +32,9 @@ static unsigned int __init shmobile_smp_
>  	if (is_r8a7779())
>  		return r8a7779_get_core_count();
>  
> +	if (is_emev2())
> +		return emev2_get_core_count();
> +
>  	return 1;
>  }
>  
> @@ -41,6 +45,9 @@ static void __init shmobile_smp_prepare_
>  
>  	if (is_r8a7779())
>  		r8a7779_smp_prepare_cpus();
> +
> +	if (is_emev2())
> +		emev2_smp_prepare_cpus();
>  }
>  
>  int shmobile_platform_cpu_kill(unsigned int cpu)
> ...

This shows that we really want an abstraction for soc-specific SMP ops
even within one platform, and we'll need the same thing for multiplatform.

Marc Zyngier already proposed a solution for this last year, but I
think we couldn't agree on the details back then before he lost interest.
I think we should pick that up again and get it into 3.6 so the code above
can be simplified and we can do the multiplatform solution. We'll probably
discuss the details in Hong Kong in a couple of weeks, so there is no
point in changing it now, but I'd hope that you can migrate this to
whatever we come up with in the following merge window.

> +#define SMU_GENERAL_REG0	IOMEM(0xe01107c0)

I would keep this together with the other SMU handling code and export a
function to set it, rather than hardcoding the address.

> +static DEFINE_SPINLOCK(scu_lock);
> +static unsigned long tmp;
> +
> +static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
> +{
> +	void __iomem *scu_base = scu_base_addr();
> +
> +	spin_lock(&scu_lock);
> +	tmp = readl(scu_base + 8);
> +	tmp &= ~clr;
> +	tmp |= set;
> +	spin_unlock(&scu_lock);
> +
> +	/* disable cache coherency after releasing the lock */
> +	writel(tmp, scu_base + 8);
> +}

This looks strange: why is tmp a file-level static variable rather than
local to the modify_scu_cpu_psr function? Why do you do the writel
without the spinlock held?

	Arnd
