From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2010 12:31:35 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <1266927716.3123.57.camel@e102109-lin.cambridge.arm.com>
References: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
	<20100223111036.GA10501@n2100.arm.linux.org.uk>
	<1266927716.3123.57.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100223123135.GD10501@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 12:21:56PM +0000, Catalin Marinas wrote:
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 058e7e9..0db8b06 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -138,10 +138,12 @@ extern unsigned int user_debug;
>  #define dmb() __asm__ __volatile__ ("" : : : "memory")
>  #endif
>  
> -#if __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
> -#define mb()		dmb()
> +#ifdef CONFIG_ARCH_HAS_BARRIERS
> +#include <mach/barriers.h>
> +#elif __LINUX_ARM_ARCH__ >= 5
> +#define mb()		dsb()
>  #define rmb()		dmb()
> -#define wmb()		dmb()
> +#define wmb()		dsb()

Why do we need these to be anything more than compiler barriers on PXA?
