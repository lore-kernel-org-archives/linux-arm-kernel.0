From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Jul 2016 18:45:56 +0100
Subject: [PATCH] arm64: Fix Kconfig dependencies for RANDOMIZE_BASE
In-Reply-To: <1469553415-26839-1-git-send-email-jeffv@google.com>
References: <1469553415-26839-1-git-send-email-jeffv@google.com>
Message-ID: <20160726174556.GH2423@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 10:16:55AM -0700, Jeff Vander Stoep wrote:
> Selecting CONFIG_RANDOMIZE_BASE=y and CONFIG_MODULES=n causes a
> build error due to dependencies on modules. This patch makes KASLR
> module config options dependent on CONFIG_MODULES=y.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
>  arch/arm64/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7e23f95..c9eff79 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -891,7 +891,6 @@ config RELOCATABLE
>  
>  config RANDOMIZE_BASE
>  	bool "Randomize the address of the kernel image"
> -	select ARM64_MODULE_PLTS
>  	select RELOCATABLE
>  	help
>  	  Randomizes the virtual address at which the kernel image is

I thought we need the module PLTs once we randomize the kernel base,
independent of whether we randomize the modules base or not. Could we do
something like:

	select ARM64_MODULE_PLTS if MODULES

Whichever way we fix this, we probably need:

Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
Cc: <stable@vger.kernel.org> # 4.6+

-- 
Catalin
