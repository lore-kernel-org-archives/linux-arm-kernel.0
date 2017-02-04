From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 4 Feb 2017 09:41:18 +0100
Subject: [PATCH] clocksource: arm_arch_timer: print timer value at init
 time
In-Reply-To: <1482169657-15773-1-git-send-email-olof@lixom.net>
References: <1482169657-15773-1-git-send-email-olof@lixom.net>
Message-ID: <20170204084118.GB2160@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 09:47:37AM -0800, Olof Johansson wrote:
> This is useful to get an indication of how much time we spent in firmware.
> 
> It's not guaranteed that the timer started at 0 on reset, so it's just
> an approximation, and might very well be invalid on some systems. But
> it's still a useful metric to have access to.

Hi Olof,

[ ... ]

> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -521,6 +521,8 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
>  
>  static void arch_timer_banner(unsigned type)
>  {
> +	unsigned long cnt = arch_timer_read_counter();
> +

arch_timer_banner() is called before arch_counter_register() where the
arch_timer_read_counter() function pointer is set.

Perhaps the arch_timer_banner() and arch_counter_register() should be swapped in
arch_timer_common_init().

>  	pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
>  		     type & ARCH_CP15_TIMER ? "cp15" : "",
>  		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
> @@ -534,6 +536,8 @@ static void arch_timer_banner(unsigned type)
>  		     type & ARCH_MEM_TIMER ?
>  			arch_timer_mem_use_virtual ? "virt" : "phys" :
>  			"");
> +	pr_info("Initial timer value: 0x%lx: %ld.%02lds\n",
> +		cnt, cnt/arch_timer_rate, (cnt/(arch_timer_rate/100)) % 100);
>  }
>  

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
