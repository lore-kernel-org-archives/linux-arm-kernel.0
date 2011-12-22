From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 22 Dec 2011 11:39:16 +0000
Subject: [PATCH 02/10] arm: vexpress: fix kconfig warning
In-Reply-To: <1324341747-5922-3-git-send-email-felipe.contreras@gmail.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
 <1324341747-5922-3-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20111222113916.GA2625@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 02:42:19AM +0200, Felipe Contreras wrote:
> warning: (ARCH_OMAP4 && ARCH_VEXPRESS_CA9X4) selects ARM_ERRATA_720789 which has unmet direct dependencies (CPU_V7 && SMP)
> warning: (ARCH_VEXPRESS_CA9X4) selects ARM_ERRATA_751472 which has unmet direct dependencies (CPU_V7 && SMP)
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mach-vexpress/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index 9311484..3fbcb8c 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -5,8 +5,8 @@ config ARCH_VEXPRESS_CA9X4
>  	bool "Versatile Express Cortex-A9x4 tile"
>  	select CPU_V7
>  	select ARM_GIC
> -	select ARM_ERRATA_720789
> -	select ARM_ERRATA_751472
> +	select ARM_ERRATA_720789 if SMP
> +	select ARM_ERRATA_751472 if SMP
>  	select ARM_ERRATA_753970

NAK -- I hit this problem too, but in fact the errata configs should not
really be dependent on SMP; these are fixed in a couple of patches
currently queued in Russell's patch system:

7196/1 - errata: remove SMP dependency for erratum 720789
7197/1 - errata: remove SMP dependency for erratum 751472

...so we should avoid duplicating knowledge about exactly what these
errata workarounds do, where it can be avoided.

In the meantime, the warning is harmless.

Cheers
---Dave
