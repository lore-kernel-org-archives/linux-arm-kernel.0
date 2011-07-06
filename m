From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 00:04:55 +0100
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110706230455.GZ8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 10:30:33PM -0400, Nicolas Pitre wrote:
> +extern unsigned long arm_dma_zone_size;
> +#define MAX_DMA_ADDRESS	(PAGE_OFFSET + arm_dma_zone_size)
...
> -#ifndef ARM_DMA_ZONE_SIZE
> +#ifndef CONFIG_ZONE_DMA
>  #define ISA_DMA_THRESHOLD	(0xffffffffULL)
>  #else
> -#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + ARM_DMA_ZONE_SIZE - 1)
> +#define ISA_DMA_THRESHOLD	({ \
> +	extern unsigned long arm_dma_zone_size; \
> +	arm_dma_zone_size ? \
> +		(PHYS_OFFSET + arm_dma_zone_size - 1) : 0xffffffffULL; })

These two usages do not agree.  With unrestricted DMA, both
MAX_DMA_ADDRESS and ISA_DMA_THRESHOLD should be 0xffffffff.  However,
you get that with arm_dma_zone_size=0 for ISA_DMA_THRESHOLD, which
then gives a MAX_DMA_ADDRESS of PAGE_OFFSET.  So this potentially
changes the behaviour of these macros.
