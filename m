From: gadiyar@ti.com (Anand Gadiyar)
Date: Mon, 8 Nov 2010 11:35:16 +0530
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
Message-ID: <eace9c309e371630528bc9f8fa208705@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
>
> On Tue, 2010-10-19 at 11:18 +0100, Anand Gadiyar wrote:
> > Commit ba1b9be5cd in linux-next (ARM: Add SWP/SWPB emulation for ARMv7
> > processors (v5)) introduced arch/arm/kernel/swp_emulate.c. This file
> > gets compiled when the omap2plus_defconfig is built - the
> > omap2plus_defconfig builds OMAP2420, OMAP2430, OMAP3 and OMAP4 in one
> > image, and has CPU_V6 and CPU_V7 both enabled.
>
> This patch should fix it:
>
>
> ARM: Do not enable SWP emulation if CPU_V6 && CPU_V7
>
> From: Catalin Marinas <catalin.marinas@arm.com>
>
> This option uses LDREXB/STREXB to emulate SWPB but these instructions
> are not supported on all the ARMv6 processors.
>
> Reported-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Leif Lindholm <Leif.Lindholm@arm.com>

Hi Catalin, Leif,

I can't find this patch in linux-next. Hope we haven't missed it.
Tony acked this btw.

Strangely, the omap2plus_defconfig in v2.6.37-rc1 no longer gets
CONFIG_SWP_EMULATE enabled even without this patch - I can't figure
out why.

- Anand

> ---
>  arch/arm/mm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 8493ed0..5195d61 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -638,7 +638,7 @@ config ARM_THUMBEE
>
>  config SWP_EMULATE
>  	bool "Emulate SWP/SWPB instructions"
> -	depends on CPU_V7
> +	depends on CPU_V7 && !CPU_V6
>  	select HAVE_PROC_CPU if PROC_FS
>  	default y if SMP
>  	help
>
>
>
