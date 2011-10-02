From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Oct 2011 12:07:24 +0100
Subject: [PATCH 2/2] ARM: SAMSUNG: Cleanup resources by using macro
In-Reply-To: <001e01cc80e5$1c9eb150$55dc13f0$%kim@samsung.com>
References: <001e01cc80e5$1c9eb150$55dc13f0$%kim@samsung.com>
Message-ID: <20111002110724.GT11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 06:24:40PM +0900, Kukjin Kim wrote:
> This patch adds macro SAMSUNG_RES_MEM and SAMSUNG_RES_IRQ to cleanup
> regarding 'struct resource'

Why not include the braces inside the macro as well?

> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
> index 8f19241..8b8bd1c 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -18,6 +18,16 @@
>  
>  #include <linux/platform_device.h>
>  
> +#define SAMSUNG_RES_MEM(soc, ip, sz)			\
> +		.start	= soc##_PA_##ip,		\
> +		.end	= soc##_PA_##ip + sz - 1,	\
> +		.flags	= IORESOURCE_MEM,
> +
> +#define SAMSUNG_RES_IRQ(ip)				\
> +		.start	= IRQ_##ip,			\
> +		.end	= IRQ_##ip,			\
> +		.flags	= IORESOURCE_IRQ,
> +

How about using DEFINE_RES_MEM and DEFINE_RES_IRQ here?

#define SAMSUNG_RES_MEM(soc, ip, sz) DEFINE_RES_MEM(soc##_PA_##ip, sz)
#define SAMSUNG_RES_IRQ(ip) DEFINE_RES_IRQ(IRQ_##ip)
