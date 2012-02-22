From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Feb 2012 23:58:05 +0000
Subject: [PATCH 3/7] rtc: sa1100: use ioremap to map registers
In-Reply-To: <1329815096-6200-4-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <1329815096-6200-4-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20120222235804.GJ7041@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 05:04:52PM +0800, Haojian Zhuang wrote:
> diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
> index bb10ee2..04a62a3 100644
> --- a/arch/arm/mach-sa1100/generic.c
> +++ b/arch/arm/mach-sa1100/generic.c
> @@ -345,9 +345,29 @@ void sa11x0_register_irda(struct irda_platform_data *irda)
>  	sa11x0_register_device(&sa11x0ir_device, irda);
>  }
>  
> +static struct resource sa1100_rtc_resources[] = {
> +	{
> +		.start	= 0x90010000,
> +		.end	= 0x9001003f,
> +		.flags	= IORESOURCE_MEM,
> +	}, {
> +		.start  = IRQ_RTC1Hz,
> +		.end    = IRQ_RTC1Hz,
> +		.name	= "rtc 1Hz",
> +		.flags  = IORESOURCE_IRQ,
> +	}, {
> +		.start  = IRQ_RTCAlrm,
> +		.end    = IRQ_RTCAlrm,
> +		.name	= "rtc alarm",
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};

As I've converted all resources in this file to use the DEFINE_RES_foo()
macros, it would be a shame to have this initialization reintroduced.
Please use DEFINE_RES_foo() here.
