From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 01 Oct 2013 11:29:54 +0100
Subject: [PATCH 2/3] ARM: allow MULTIPLATFORM on no-MMU machines
In-Reply-To: <1380534577-15076-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380534577-15076-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <524AA422.9040106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/13 10:49, Uwe Kleine-K?nig wrote:
> There is no technical reason to not use the benefits of MULTIPLATFORM on a
> no-MMU machine and my not-yet-mainline efm32 port does work just fine with
> it. So drop the dependency.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>   arch/arm/Kconfig | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0f63a70..d873a34 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -296,8 +296,7 @@ choice
>
>   config ARCH_MULTIPLATFORM
>   	bool "Allow multiple platforms to be selected"
> -	depends on MMU
> -	select ARM_PATCH_PHYS_VIRT
> +	select ARM_PATCH_PHYS_VIRT if MMU && !XIP_KERNEL
>   	select AUTO_ZRELADDR
>   	select COMMON_CLK
>   	select MULTI_IRQ_HANDLER
>


A patch much like this has been submitted in the past by Arnd and me, 
and Russell wasn't too happy with the idea because ARCH_MULTIPLATFORM 
doesn't really make sense for !MMU.

However, back then we were talking R/A class. For M-class the memory map 
is more clearly mandated, the idea of V7M platforms that are 
ARCH_MULTIPLATFORM compatible is much more feasible. One of the big 
issues for !MMU/ARCH_MULTIPLATFORM in the past was the need to select 
the vector configuration at build time - not something we need to worry 
about with V7M (where we have a configurable vector base), so from that 
point of view, this change makes sense.

But I'm not sure about the XIP_KERNEL part. Once you're using XIP_KERNEL 
again, multi-platform doesn't make much sense. Uwe, can you correct me 
on that?

Jonny
