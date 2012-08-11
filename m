From: cyril@ti.com (Cyril Chemparathy)
Date: Sat, 11 Aug 2012 09:37:54 -0400
Subject: [PATCH v2 1/2] ARM: arch_timers: enable the use of the virtual
 timer
In-Reply-To: <1344681091-12652-2-git-send-email-marc.zyngier@arm.com>
References: <1344681091-12652-1-git-send-email-marc.zyngier@arm.com>
 <1344681091-12652-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <50266032.9070702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On 8/11/2012 6:31 AM, Marc Zyngier wrote:
> At the moment, the arch_timer driver only uses the physical timer,
> which can cause problem if PL2 hasn't enabled PL1 access in CNTHCTL,
> which is likely in a virtualized environment. Instead, the virtual
> timer is always available.
>
> This patch enables the use of both the virtual timer, unless no
> interrupt is provided in the DT for it, in which case is falls
> back to the physical timer.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/kernel/arch_timer.c |  261 +++++++++++++++++++++++++++++++----------
>   1 files changed, 197 insertions(+), 64 deletions(-)
>
> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> index cf25880..4a64733 100644
[...]
> +	if (arch_timer_use_virtual) {
> +		ppi = arch_timer_ppi[VIRT_PPI];
> +		err = request_percpu_irq(ppi, arch_timer_handler,
> +					 "arch_timer", arch_timer_evt);
> +	} else {
> +		ppi = arch_timer_ppi[PHYS_SECURE_PPI];
> +		err = request_percpu_irq(ppi, arch_timer_handler,
> +					 "arch_timer", arch_timer_evt);
> +		if (!err) {
> +			ppi = arch_timer_ppi[PHYS_NONSECURE_PPI];
> +			err = request_percpu_irq(ppi, arch_timer_handler,
> +						 "arch_timer", arch_timer_evt);
> +			if (err)
> +				free_percpu_irq(arch_timer_ppi[PHYS_SECURE_PPI],
> +						arch_timer_evt);
> +		}
> +	}
> +
>   	if (err) {
>   		pr_err("arch_timer: can't register interrupt %d (%d)\n",
> -		       arch_timer_ppi, err);
> +		       ppi, err);
>   		goto out_free;
>   	}
>
> -	if (arch_timer_ppi2) {
> -		err = request_percpu_irq(arch_timer_ppi2, arch_timer_handler,
> -					 "arch_timer", arch_timer_evt);
> -		if (err) {
> -			pr_err("arch_timer: can't register interrupt %d (%d)\n",
> -			       arch_timer_ppi2, err);
> -			arch_timer_ppi2 = 0;
> -			goto out_free_irq;
> -		}
> -	}
> -

In the original code, arch_timer_ppi2 appears to have been entirely 
optional.

With this change, the code appears to mandate that both nonsecure and 
secure PPIs be available (if !arch_timer_use_virtual).  Could you please 
explain this change?

-- 
Thanks
- Cyril
