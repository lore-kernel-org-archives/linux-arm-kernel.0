From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Jul 2012 19:14:26 +0100
Subject: [PATCH 1/9] ARM: vexpress: remove automatic errata workaround
 selection
In-Reply-To: <4FFDC0A5.7000300@gmail.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-2-git-send-email-pawel.moll@arm.com>
 <4FFD956D.7020901@gmail.com>
 <20120711151846.GE13498@mudshark.cambridge.arm.com>
 <4FFD9F7F.7020103@gmail.com>
 <20120711155303.GF13498@mudshark.cambridge.arm.com>
 <4FFDC0A5.7000300@gmail.com>
Message-ID: <20120711181426.GI13498@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 07:06:29PM +0100, Rob Herring wrote:
> On 07/11/2012 10:53 AM, Will Deacon wrote:
> > On Wed, Jul 11, 2012 at 04:45:03PM +0100, Rob Herring wrote:
> >> What if you just make the existing config option user selectable?
> > 
> > I think that's harder than it sounds. How would you do this without adding
> > vexpress-specific dependencies to the erratum config option itself? I
> > suppose you could make them default y for multi-platform kernels (I can't
> > remember if Arnd's single zImage changes had a config option for that).
> > 
> 
> You're not following what I meant. Something like this:

Indeed, I thought you were referring to the workaround options themselves.

> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index cf8730d..fc3730f 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -2,7 +2,8 @@ menu "Versatile Express platform type"
>         depends on ARCH_VEXPRESS
> 
>  config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
> -       bool
> +       bool "Enable A5 and A9 only errata work-arounds"
> +       default y
>         select ARM_ERRATA_720789
>         select ARM_ERRATA_751472
>         select PL310_ERRATA_753970 if CACHE_PL310
> @@ -14,7 +15,6 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
> 
>  config ARCH_VEXPRESS_CA9X4
>         bool "Versatile Express Cortex-A9x4 tile"
> -       select ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
>         select ARM_GIC
>         select CPU_V7
>         select HAVE_SMP
> @@ -22,7 +22,6 @@ config ARCH_VEXPRESS_CA9X4
> 
>  config ARCH_VEXPRESS_DT
>         bool "Device Tree support for Versatile Express platforms"
> -       select ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
>         select ARM_GIC
>         select ARM_PATCH_PHYS_VIRT
>         select AUTO_ZRELADDR

Gotcha, thanks for the diff. That works nicely for the current situation and
we can revisit the whole errata workaround config options issue when the
single zimage changes are in.

Cheers,

Will
