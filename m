From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Apr 2015 21:09:31 +0100
Subject: [PATCH v4 07/11] ARM: allow MULTIPLATFORM with !MMU
In-Reply-To: <1428090292-21693-8-git-send-email-stefan@agner.ch>
References: <1428090292-21693-1-git-send-email-stefan@agner.ch>
 <1428090292-21693-8-git-send-email-stefan@agner.ch>
Message-ID: <20150403200931.GD13898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 09:44:48PM +0200, Stefan Agner wrote:
> In order to support SoC with heterogenous CPU architectures (such
> as Freescale Vybrid/i.MXSX) it is preferable to use the same
> architecture (ARCH_MXC in this case) for the MMU enabled and !MMU
> CPU. Hence allow to select MULTIPLATFORM even without MMU.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/Kconfig | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9f1f09a..636cb3f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -230,7 +230,7 @@ config VECTORS_BASE
>  	  in size.
>  
>  config ARM_PATCH_PHYS_VIRT
> -	bool "Patch physical to virtual translations at runtime" if EMBEDDED
> +	bool "Patch physical to virtual translations at runtime" if EMBEDDED || (ARCH_MULTIPLATFORM && MMU)
>  	default y

This makes no sense.  Multiplatform MMU _requires_ this feature, so why
offer it to the user when multiplatform is enabled _and_ MMU is enabled?

Patch 7817/1 in the patch system tried doing something like you're trying
to do here - I wonder whether you've reviewed the mailing list for
previous discussions.

Given that it's Easter, I'm not going to re-state what I said last time
this came up, but instead leave you to do some research.  For example,
reading message id <20130819232411.GX23006@n2100.arm.linux.org.uk>...

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
