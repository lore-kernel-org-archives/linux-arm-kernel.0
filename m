From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Nov 2011 11:43:30 +0000
Subject: [PATCH] ARM: errata: Remove SMP dependency for erratum 720789
In-Reply-To: <1322586755-12740-1-git-send-email-dave.martin@linaro.org>
References: <1322586755-12740-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20111130114330.GB13025@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 05:12:35PM +0000, Dave Martin wrote:
> Activation conditions for a workaround should not be encoded in the
> workaround's direct dependencies if this makes otherwise reasonable
> configuration choices impossible.
> 
> The workaround for erratum 720789 only affects a code path which is
> not active in UP kernels; hence it should be safe to turn on in UP
> kernels, without penalty.
> 
> This patch simply removes the extra dependency on SMP from Kconfig.
> 
> This means that configs for buggy silicon can simply select
> ARM_ERRATA_720789, without preventing a UP kernel from being built
> or duplicatiing knowledge about when to activate the workaround.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 44789ef..31bbad3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1245,7 +1245,7 @@ config PL310_ERRATA_588369
>  
>  config ARM_ERRATA_720789
>  	bool "ARM errata: TLBIASIDIS and TLBIMVAIS operations can broadcast a faulty ASID"
> -	depends on CPU_V7 && SMP
> +	depends on CPU_V7
>  	help
>  	  This option enables the workaround for the 720789 Cortex-A9 (prior to
>  	  r2p0) erratum. A faulty ASID can be sent to the other CPUs for the

Having this applied on a UP kernel should have no effect given that it only
affects the UIS TLB flags. So:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
