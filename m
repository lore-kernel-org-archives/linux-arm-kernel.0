From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Oct 2016 16:32:45 +0100
Subject: [PATCH v14 3/9] clocksource/drivers/arm_arch_timer: Improve
 printk relevant code
In-Reply-To: <1475086637-1914-4-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-4-git-send-email-fu.wei@linaro.org>
Message-ID: <20161020153244.GB27598@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 02:17:11AM +0800, fu.wei at linaro.org wrote:
>  static void arch_timer_banner(unsigned type)
>  {
> -	pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
> -		     type & ARCH_CP15_TIMER ? "cp15" : "",
> -		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
> -		     type & ARCH_MEM_TIMER ? "mmio" : "",
> -		     (unsigned long)arch_timer_rate / 1000000,
> -		     (unsigned long)(arch_timer_rate / 10000) % 100,
> -		     type & ARCH_CP15_TIMER ?
> -		     (arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
> -			"",
> -		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
> -		     type & ARCH_MEM_TIMER ?
> -			arch_timer_mem_use_virtual ? "virt" : "phys" :
> -			"");
> +	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
> +		type & ARCH_CP15_TIMER ? "cp15" : "",
> +		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
> +		type & ARCH_MEM_TIMER ? "mmio" : "",
> +		(unsigned long)arch_timer_rate / 1000000,
> +		(unsigned long)(arch_timer_rate / 10000) % 100,
> +		type & ARCH_CP15_TIMER ?
> +		(arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
> +		"",
Please restore the additional indent on this line...

> +		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
> +		type & ARCH_MEM_TIMER ?
> +		arch_timer_mem_use_virtual ? "virt" : "phys" :
> +		"");

... and these two.

No matter what checkpatch says, I prefer the code that way so as to keep
the ternary clear.

[...]

> @@ -768,7 +769,7 @@ static int __init arch_timer_init(void)
>  		return ret;
>  
>  	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[VIRT_PPI];
> -	
> +

Please mention the whitespace fixup in the commit message. It's
surprising otherwise.

With all that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
