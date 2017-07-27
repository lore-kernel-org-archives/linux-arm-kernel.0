From: will.deacon@arm.com (Will Deacon)
Date: Thu, 27 Jul 2017 11:24:58 +0100
Subject: [PATCH] genirq/cpuhotplug: Revert "Set force affinity flag on
 hotplug migration"
In-Reply-To: <alpine.DEB.2.20.1707271217590.3109@nanos>
References: <alpine.DEB.2.20.1707271217590.3109@nanos>
Message-ID: <20170727102458.GB20746@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Thomas, this should fix our nightly testing which is currently
failing the CPU hotplug tests.

On Thu, Jul 27, 2017 at 12:21:11PM +0200, Thomas Gleixner wrote:
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -95,8 +95,13 @@ static bool migrate_one_irq(struct irq_d
>  		affinity = cpu_online_mask;
>  		brokeaff = true;
>  	}
> -
> -	err = irq_do_set_affinity(d, affinity, true);
> +	/*
> +	 * Do not set the force argument of irq_do_set_affinity() as this
> +	 * disables the masking of offline CPUs from the supplied affinity
> +	 * mask and therefor might keep/reassign the irq to the outgoing

Typo: therefore

> +	 * CPU.
> +	 */
> +	err = irq_do_set_affinity(d, affinity, false);

With that fixed:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
