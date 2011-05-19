From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 19 May 2011 12:12:41 +0530
Subject: [PATCH] ARM: mach-shmobile: sh73a0 twd_base fix
In-Reply-To: <20110519062620.27921.52669.sendpatchset@t400s>
References: <20110519062620.27921.52669.sendpatchset@t400s>
Message-ID: <4DD4BBE1.90004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/19/2011 11:56 AM, Magnus Damm wrote:
> From: Magnus Damm<damm@opensource.se>
>
> Fix the case of too late twd_base initialization for SMP
> on sh73a0 which bas been broken because sh73a0 specific
> smp_prepare_cpu() and percpu_timer_setup() changed order
> in the commits:
>
> 05c74a6cbcfb416286a947668ba32f63d99fe74a
> c413521eb4e2d7ffd5ce432a144708d479054bd3
>
> Without this fix the sh73a0 SMP kernel panics on boot.
>
> Signed-off-by: Magnus Damm<damm@opensource.se>
> ---
>
>   arch/arm/mach-shmobile/smp-sh73a0.c |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> --- 0001/arch/arm/mach-shmobile/smp-sh73a0.c
> +++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2011-05-19 14:50:24.000000000 +0900
> @@ -59,6 +59,11 @@ unsigned int __init sh73a0_get_core_coun
>   {
>   	void __iomem *scu_base = scu_base_addr();
>
> +#ifdef CONFIG_HAVE_ARM_TWD
> +	/* twd_base needs to be initialized before percpu_timer_setup() */
> +	twd_base = (void __iomem *)0xf0000600;
You might want to ioremap(PA) instead of hard-coding it. Even if you
want a fixed VA, at least use macro.

Regards,
Santosh
