From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 22 May 2014 20:36:07 +0900
Subject: [GIT PULL 4/5] Samsung DT updates for 3.16
In-Reply-To: <20140522054547.GA4021@quad.lixom.net>
References: <014701cf73c8$752a65c0$5f7f3140$@samsung.com>
 <20140522054547.GA4021@quad.lixom.net>
Message-ID: <031701cf75b2$05572760$10057620$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Tue, May 20, 2014 at 10:11:41AM +0900, Kukjin Kim wrote:
> 
> > Sachin Kamat (4):
> >       ARM: EXYNOS: Map SYSRAM through generic DT bindings
> 
> This patch has a conflict with your own fixes. You should have based this
> branch on top of the fixes to avoid it.
> 
Oops, I forgot the previous my fixes. Sorry about that...

> Not only that, but it seems to break 4212, which the other fix was meant
> to
> take care of.
> 
> I think I've fixed it in my merge, please double check. You really have to
> be more careful than this in the future.
> 
OK, I checked and it should be fine. BTW, another cleanup branch in my tree
has dependency with following and s3c24xx-clk already queued in arm-soc so I
need to sort out the branch before sending pull-request...

Anyway thanks for your pulling.

- Kukjin

> My resolution is:
> 
> index aa01c4222b40,483dfcd69065..000000000000
> --- a/arch/arm/mach-exynos/firmware.c
> +++ b/arch/arm/mach-exynos/firmware.c
> @@@ -18,8 -18,7 +18,9 @@@
> 
>   #include <mach/map.h>
> 
>  +#include <plat/cpu.h>
>  +
> + #include "common.h"
>   #include "smc.h"
> 
>   static int exynos_do_idle(void)
> @@@ -44,10 -35,12 +45,15 @@@ static int exynos_cpu_boot(int cpu
> 
>   static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
>   {
> -       void __iomem *boot_reg = S5P_VA_SYSRAM_NS + 0x1c;
> +       void __iomem *boot_reg;
> +
> +       if (!sysram_ns_base_addr)
> +               return -ENODEV;
> +
>  -      boot_reg = sysram_ns_base_addr + 0x1c + 4*cpu;
> ++      boot_reg = sysram_ns_base_addr + 0x1c;
>  +
>  +      if (!soc_is_exynos4212())
>  +              boot_reg += 4*cpu;
> 
