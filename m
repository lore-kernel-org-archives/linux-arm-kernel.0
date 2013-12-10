From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Dec 2013 21:25:23 +0000
Subject: [PATCH 1/2] mm/ARM: dma: fix conflicting types for
 'arm_dma_zone_size'
In-Reply-To: <1386703798-26521-2-git-send-email-santosh.shilimkar@ti.com>
References: <1386703798-26521-1-git-send-email-santosh.shilimkar@ti.com>
 <1386703798-26521-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131210212523.GE4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 02:29:57PM -0500, Santosh Shilimkar wrote:
> diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
> index 58b8c6a..1439b80 100644
> --- a/arch/arm/include/asm/dma.h
> +++ b/arch/arm/include/asm/dma.h
> @@ -8,7 +8,7 @@
>  #define MAX_DMA_ADDRESS	0xffffffffUL
>  #else
>  #define MAX_DMA_ADDRESS	({ \
> -	extern unsigned long arm_dma_zone_size; \
> +	extern phys_addr_t arm_dma_zone_size; \
>  	arm_dma_zone_size ? \
>  		(PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })

This is wrong.  Take a moment to look at it more closely.  What does
"PAGE_OFFSET" tell you about what its returning?

What happens if arm_dma_zone_size is greater than 1GB when PAGE_OFFSET
is at the default setting of 3GB?
