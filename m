From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 30 Jun 2016 13:48:26 +0200
Subject: [PATCH] ARM: mvebu: compile pm code conditionally
In-Reply-To: <20160620160931.2714557-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Mon, 20 Jun 2016 18:08:22 +0200")
References: <20160620160931.2714557-1-arnd@arndb.de>
Message-ID: <87lh1mx5h1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On lun., juin 20 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> A cleanup to include the headers correctly caused another build problem:
>
> arch/arm/mach-mvebu/kirkwood-pm.c:70:13: error: redefinition of 'kirkwood_pm_init'
> arch/arm/mach-mvebu/kirkwood-pm.h:23:20: note: previous definition of 'kirkwood_pm_init' was here
>
> The underlying issue is that kirkwood-pm.o is not actually meant to be
> used when CONFIG_PM is disabled, so we should also leave it out of the
> Makefile.
>
> The same seems to be true for the PM code in MACH_MVEBU_V7, and I'm
> treating it the same way here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: d705c1a66e15 ("ARM: Kirkwood: fix kirkwood_pm_init() declaration/type")

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm/mach-mvebu/Makefile | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
> index 568863e1513c..6c6497e80a7b 100644
> --- a/arch/arm/mach-mvebu/Makefile
> +++ b/arch/arm/mach-mvebu/Makefile
> @@ -6,9 +6,15 @@ CFLAGS_pmsu.o			:= -march=armv7-a
>  obj-$(CONFIG_MACH_MVEBU_ANY)	 += system-controller.o mvebu-soc-id.o
>  
>  ifeq ($(CONFIG_MACH_MVEBU_V7),y)
> -obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o pm.o pm-board.o
> +obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o
> +
> +obj-$(CONFIG_PM)		 += pm.o pm-board.o
>  obj-$(CONFIG_SMP)		 += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
>  endif
>  
>  obj-$(CONFIG_MACH_DOVE)		 += dove.o
> -obj-$(CONFIG_MACH_KIRKWOOD)	 += kirkwood.o kirkwood-pm.o
> +
> +ifeq ($(CONFIG_MACH_KIRKWOOD),y)
> +obj-y				 += kirkwood.o
> +obj-$(CONFIG_PM)		 += kirkwood-pm.o
> +endif
> -- 
> 2.9.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
