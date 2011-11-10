From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Nov 2011 22:57:37 +0000
Subject: [PATCH v8 16/16] ARM: LPAE: Add the Kconfig entries
In-Reply-To: <1320682618-1182-17-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-17-git-send-email-catalin.marinas@arm.com>
Message-ID: <20111110225737.GX12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 04:16:58PM +0000, Catalin Marinas wrote:
> This patch adds the ARM_LPAE and ARCH_PHYS_ADDR_T_64BIT Kconfig entries
> allowing LPAE support to be compiled into the kernel.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/Kconfig    |    2 +-
>  arch/arm/mm/Kconfig |   17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 44789ef..885c04e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1959,7 +1959,7 @@ endchoice
>  
>  config XIP_KERNEL
>  	bool "Kernel Execute-In-Place from ROM"
> -	depends on !ZBOOT_ROM
> +	depends on !ZBOOT_ROM && !ARM_LPAE
>  	help
>  	  Execute-In-Place allows the kernel to run from non-volatile storage
>  	  directly addressable by the CPU, such as NOR flash. This saves RAM
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 67f75a0..d289cdb 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -629,6 +629,23 @@ config IO_36
>  
>  comment "Processor Features"
>  
> +config ARM_LPAE
> +	bool "Support for the Large Physical Address Extension"
> +	depends on MMU && CPU_V7
> +	help
> +	  Say Y if you have an ARMv7 processor supporting the LPAE page
> +	  table format and you would like to access memory beyond the
> +	  4GB limit. The resulting kernel image will not run on
> +	  processors without the LPA extension.
> +
> +	  If unsure, say N.
> +
> +config ARCH_PHYS_ADDR_T_64BIT
> +	def_bool ARM_LPAE
> +
> +config ARCH_DMA_ADDR_T_64BIT
> +	def_bool ARM_LPAE
> +

I still say this shouldn't depend on the host page table format.  LPAE
itself has nothing to do with whether 64-bit DMA addresses are supported
by the system.
