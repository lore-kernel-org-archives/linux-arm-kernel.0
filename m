From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Feb 2011 15:53:48 +0000
Subject: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
	cause data corruption
In-Reply-To: <4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com>
	<13596bec9184b117d6a1d02da8e017bf@mail.gmail.com>
	<AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com>
	<33573d5cfc91cf45dc58ee861cccc2ae@mail.gmail.com>
	<4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
Message-ID: <AANLkTikEjTgisftQV46djrOP8iWMFV267v-efHsVf_Nd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 February 2011 07:14, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1140,7 +1140,7 @@ config ARM_ERRATA_742231
>
> ?config PL310_ERRATA_588369
> ? ? ? ?bool "Clean & Invalidate maintenance operations do not invalidate
> clean lines"
> - ? ? ? depends on CACHE_L2X0 && ARCH_OMAP4
> + ? ? ? depends on CACHE_L2X0 && CACHE_PL310

It can just depend on CACHE_PL310 as this depends on CACHE_L2X0.

> +config PL310_ERRATA_727915
> + ? ? ? bool "Background Clean & Invalidate by Way operation can cause
> data corruption"
> + ? ? ? depends on CACHE_L2X0 && CACHE_PL310

Same here.

> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -45,7 +45,10 @@ config ARCH_OMAP4
> ? ? ? ?select CPU_V7
> ? ? ? ?select ARM_GIC
> ? ? ? ?select LOCAL_TIMERS
> + ? ? ? select CACHE_L2X0

CACHE_L2X0 has a long dependency list. You could add ARCH_OMAP4 in
there or just change the other platforms to select a HAVE_CACHE_L2X0.
Ideally we would like this option to be selectable in config just in
case you want to debug some issues.

> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -52,6 +52,12 @@ static void omap4_l2x0_disable(void)
> ? ? ? ?omap_smc1(0x102, 0x0);
> ?}
>
> +static void omap4_l2x0_set_debug(unsigned long val)
> +{
> + ? ? ? /* Program PL310 L2 Cache controller debug register */
> + ? ? ? omap_smc1(0x100, val);
> +}

This part together with the Kconfig changes for OMAP4 could be a
separate patch, OMAP-specific.

The rest seems fine.

-- 
Catalin
