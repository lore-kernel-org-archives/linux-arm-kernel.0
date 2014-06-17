From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jun 2014 16:00:11 +0200
Subject: [PATCH 01/14] ARM: mvebu: fix randconfig builds for pmsu driver
In-Reply-To: <1402675276-538682-2-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
 <1402675276-538682-2-git-send-email-arnd@arndb.de>
Message-ID: <20140617160011.03b1ea15@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Fri, 13 Jun 2014 18:01:03 +0200, Arnd Bergmann wrote:

> @@ -200,7 +201,9 @@ static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
>  	/* If we are here, wfi failed. As processors run out of
>  	 * coherency for some time, tlbs might be stale, so flush them
>  	 */
> +#ifdef CONFIG_MMU
>  	local_flush_tlb_all();
> +#endif

So noMMU builds are supported in a single image with MMU builds?
Instead of having to #ifdef all around the place, wouldn't it be better
for the noMMU headers to provide an empty definition for this function?

>  static int armada_370_xp_cpu_suspend(unsigned long deepidle)
>  {
> +	if (!IS_ENABLED(CONFIG_CPU_IDLE))
> +		return -ENODEV;
> +
>  	return cpu_suspend(deepidle, do_armada_370_xp_cpu_suspend);
>  }

This unfortunately isn't really correct, and the patch I sent in
"[PATCH] ARM: mvebu: select ARM_CPU_SUSPEND for Marvell EBU v7
platforms" on June, 11th already fixes the cpu_suspend()/cpu_resume()
problem.

The issue with your solution is that it assumes this function is only
used for cpuidle. That is indeed the case in v3.16, but will be wrong
as soon as we add CPU hotplug support, which I have posted on May, 30th
in "[PATCH 0/5] CPU hotplug for Marvell Armada XP", and which I hope to
see included in v3.17.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
