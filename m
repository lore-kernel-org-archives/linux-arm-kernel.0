From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2016 10:13:33 +0100
Subject: [PATCH RFC 04/10] ARM: V7M: Add support for reading the CTR with
 CPUID_CACHETYPE
In-Reply-To: <1461226702-27160-5-git-send-email-vladimir.murzin@arm.com>
References: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
 <1461226702-27160-5-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20160427091333.GH19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 09:18:16AM +0100, Vladimir Murzin wrote:
> @@ -79,5 +80,19 @@ static inline unsigned int read_ccsidr(void)
>  	asm volatile("mrc p15, 1, %0, c0, c0, 0" : "=r" (val));
>  	return val;
>  }
> +#else /* CONFIG_CPU_V7M */
> +#include <asm/io.h>

Please use linux/io.h

> +#include "asm/v7m.h"
> +
> +static inline void set_csselr(unsigned int cache_selector)
> +{
> +	writel(cache_selector, (void *)(BASEADDR_V7M_SCB + V7M_SCB_CTR));

writel() doesn't take a void pointer.  It takes a void __iomem pointer.
BASEADDR_V7M_SCB may need to be defined more appropriately.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
