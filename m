From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Jul 2016 17:10:37 +0100
Subject: [PATCH] arm64: Add config to limit user space to 47bits
In-Reply-To: <1468424567-15925-1-git-send-email-agraf@suse.de>
References: <1468424567-15925-1-git-send-email-agraf@suse.de>
Message-ID: <20160713160828.GA28666@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 05:42:47PM +0200, Alexander Graf wrote:
> Some user space applications are known to break with 48 bits virtual
> address space. As interim step until the world is healed and everyone
> embraces correct code, this patch allows to only expose 47 bits of
> virtual address space to user space.

These applications have *always* been broken with 48-bit VA.

Per Documentation/arm64/tagged-pointers.txt, the *only* upper bits that
an application can assume will be zero (and therefore use for tags) are
bits 63:56.

The clear architectural intent here is that bits 55:0 can be valid
pointer bits, and it seems likely that the kernel will expand to use
bits 55:48 in future, e.g. with 52-bit VAs as part of ARMv8.2 [1]. I
hope those applications are being fixed to leave bits 55:48 well alone
also.

For this as a config option, NAK. It removes any incentive to actually
fix the problem, and perpetuates the idea that it's the kernel's
responsibility to bodge around things that never worked in the first
place. It works directly against the goal of a single kernel Image.

[1] https://community.arm.com/groups/processors/blog/2016/01/05/armv8-a-architecture-evolution

Thanks,
Mark.

> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/arm64/Kconfig              | 9 +++++++++
>  arch/arm64/include/asm/memory.h | 4 ++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5a0a691..9ff5a74 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -538,6 +538,15 @@ config ARM64_VA_BITS
>  	default 47 if ARM64_VA_BITS_47
>  	default 48 if ARM64_VA_BITS_48
>  
> +config ARM64_USER_VA_BITS_47
> +	bool "Limit user space to 47 bits address space"
> +	depends on ARM64_VA_BITS_48
> +	help
> +	  Some user space applications are known to break with 48 bits virtual
> +	  address space. As interim step until the world is healed and everyone
> +	  embraces correct code, this option allows to only expose 47 bits of
> +	  virtual address space to user space. If unsure say N here.
> +
>  config CPU_BIG_ENDIAN
>         bool "Build big-endian kernel"
>         help
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 31b7322..ef268c6 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -74,7 +74,11 @@
>  #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
>  #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
>  #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
> +#ifdef CONFIG_ARM64_USER_VA_BITS_47
> +#define TASK_SIZE_64		(UL(1) << (VA_BITS - 1))
> +#else
>  #define TASK_SIZE_64		(UL(1) << VA_BITS)
> +#endif
>  
>  #ifdef CONFIG_COMPAT
>  #define TASK_SIZE_32		UL(0x100000000)
> -- 
> 1.8.5.6
> 
