From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Jan 2015 10:04:41 +0000
Subject: [PATCH] ARM: use default ioremap alignment for SMP or LPAE
In-Reply-To: <1421911075-8814-1-git-send-email-s.dyasly@samsung.com>
References: <1421911075-8814-1-git-send-email-s.dyasly@samsung.com>
Message-ID: <20150122100441.GA19811@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 07:17:55AM +0000, Sergey Dyasly wrote:
> 16MB alignment for ioremap mappings was added by commit a069c896d0d6 ("[ARM]
> 3705/1: add supersection support to ioremap()") in order to support supersection
> mappings. But __arm_ioremap_pfn_caller uses section and supersection mappings
> only in !SMP && !LPAE case. There is no need for such big alignment if either
> SMP or LPAE is enabled.
[...]
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 184def0..c3ef139 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -78,10 +78,12 @@
>   */
>  #define XIP_VIRT_ADDR(physaddr)  (MODULES_VADDR + ((physaddr) & 0x000fffff))
>  
> +#if !defined(CONFIG_SMP) && !defined(CONFIG_ARM_LPAE)
>  /*
>   * Allow 16MB-aligned ioremap pages
>   */
>  #define IOREMAP_MAX_ORDER	24
> +#endif

Actually, I think we could make this depend only on CONFIG_IO_36. That's
the only scenario where we get the supersections matter, and maybe make
CONFIG_IO_36 dependent on !SMP or !ARM_LPAE. My assumption is that we
don't support single zImage with CPU_XSC3 enabled (but I haven't
followed the latest developments here).

-- 
Catalin
