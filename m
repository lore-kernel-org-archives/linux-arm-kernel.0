From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Jul 2013 10:24:42 +0900
Subject: [PATCH v2 01/04] ARM: shmobile: Only build clocks when
 COMMON_CLK=n
In-Reply-To: <20130717203059.27542.57468.sendpatchset@w520>
References: <20130717203049.27542.78385.sendpatchset@w520>
 <20130717203059.27542.57468.sendpatchset@w520>
Message-ID: <20130723012441.GC16481@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 05:30:59AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Move shared clock.c file and per-SoC clock-xxx.c files
> to only build when CONFIG_COMMON_CLK != y.
> 
> The regular ARCH_SHMOBILE case with legacy SH clock framework
> will build just as before with this patch applied, however
> the case when COMMON_CLK=y will exclude all the clock files.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.12 in a new multiarch branch
of the renesas tree.

> ---
> 
>  Changes since V1:
>  - wrap clock objects in ifndef, thanks Arnd and Laurent!
> 
>  arch/arm/mach-shmobile/Makefile |   31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/Makefile
> +++ work/arch/arm/mach-shmobile/Makefile	2013-07-18 05:05:41.000000000 +0900
> @@ -3,17 +3,30 @@
>  #
>  
>  # Common objects
> -obj-y				:= timer.o console.o clock.o
> +obj-y				:= timer.o console.o
>  
>  # CPU objects
> -obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7372.o intc-sh7372.o
> -obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o intc-sh73a0.o
> -obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o clock-r8a73a4.o
> -obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o clock-r8a7740.o intc-r8a7740.o
> -obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o clock-r8a7778.o
> -obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o clock-r8a7779.o intc-r8a7779.o
> -obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o clock-r8a7790.o
> -obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o clock-emev2.o
> +obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o
> +obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o intc-sh73a0.o
> +obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
> +obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o intc-r8a7740.o
> +obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
> +obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o intc-r8a7779.o
> +obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
> +obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
> +
> +# Clock objects
> +ifndef CONFIG_COMMON_CLK
> +obj-y				+= clock.o
> +obj-$(CONFIG_ARCH_SH7372)	+= clock-sh7372.o
> +obj-$(CONFIG_ARCH_SH73A0)	+= clock-sh73a0.o
> +obj-$(CONFIG_ARCH_R8A73A4)	+= clock-r8a73a4.o
> +obj-$(CONFIG_ARCH_R8A7740)	+= clock-r8a7740.o
> +obj-$(CONFIG_ARCH_R8A7778)	+= clock-r8a7778.o
> +obj-$(CONFIG_ARCH_R8A7779)	+= clock-r8a7779.o
> +obj-$(CONFIG_ARCH_R8A7790)	+= clock-r8a7790.o
> +obj-$(CONFIG_ARCH_EMEV2)	+= clock-emev2.o
> +endif
>  
>  # SMP objects
>  smp-y				:= platsmp.o headsmp.o
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
