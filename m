From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 5 Aug 2011 11:09:38 +0100
Subject: [RFC PATCH 1/2] ARM: CSR: add rtc i/o bridge interface for
	SiRFprimaII
In-Reply-To: <1312512888-25070-2-git-send-email-bs14@csr.com>
References: <1312512888-25070-1-git-send-email-bs14@csr.com>
	<1312512888-25070-2-git-send-email-bs14@csr.com>
Message-ID: <20110805100938.GP2899@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry, Zhiwu,

A couple of minor comments inline.

Jamie

On Thu, Aug 04, 2011 at 07:54:47PM -0700, Barry Song wrote:
> From: Zhiwu Song <zhiwu.song@csr.com>
> 
> The module is a bridge between the RTC clock domain and the CPU interface
> clock domain. ARM access the register of SYSRTC, GPSRTC and PWRC through
> this module.
> 
> Signed-off-by: Zhiwu Song <zhiwu.song@csr.com>
> Signed-off-by: Barry Song <baohua.song@csr.com>
> ---
>  arch/arm/mach-prima2/Makefile        |    1 +
>  arch/arm/mach-prima2/rtciobrg.c      |  118 ++++++++++++++++++++++++++++++++++
>  include/linux/rtc/sirfsoc_rtciobrg.h |   18 +++++
>  3 files changed, 137 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-prima2/rtciobrg.c
>  create mode 100644 include/linux/rtc/sirfsoc_rtciobrg.h
> 
> diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
> index 7af7fc0..f49d70b 100644
> --- a/arch/arm/mach-prima2/Makefile
> +++ b/arch/arm/mach-prima2/Makefile
> @@ -3,5 +3,6 @@ obj-y += irq.o
>  obj-y += clock.o
>  obj-y += rstc.o
>  obj-y += prima2.o
> +obj-y += rtciobrg.o
>  obj-$(CONFIG_DEBUG_LL) += lluart.o
>  obj-$(CONFIG_CACHE_L2X0) += l2x0.o
> diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-prima2/rtciobrg.c
> new file mode 100644
> index 0000000..0dc29f8
> --- /dev/null
> +++ b/arch/arm/mach-prima2/rtciobrg.c
> @@ -0,0 +1,118 @@
> +/*
> + * RTC I/O Bridge interfaces for CSR SiRFprimaII
> + * ARM access the registers of SYSRTC, GPSRTC and PWRC through this module
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#define SIRFSOC_CPUIOBRG_CTRL           0x00
> +#define SIRFSOC_CPUIOBRG_WRBE           0x04
> +#define SIRFSOC_CPUIOBRG_ADDR           0x08
> +#define SIRFSOC_CPUIOBRG_DATA           0x0c
> +
> +void __iomem *sirfsoc_rtciobrg_base;

static void __iomem?

> +static DEFINE_SPINLOCK(rtciobrg_lock);
> +
> +void sirfsoc_rtc_iobrg_wait_sync(void)
> +{
> +	while (readl(sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_CTRL))
> +		cpu_relax();
> +}

I think this can be static too.

> +
> +void sirfsoc_rtc_iobrg_besyncing(void)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&rtciobrg_lock, flags);
> +
> +	sirfsoc_rtc_iobrg_wait_sync();
> +
> +	spin_unlock_irqrestore(&rtciobrg_lock, flags);
> +}
> +EXPORT_SYMBOL(sirfsoc_rtc_iobrg_besyncing);
> +
> +u32 __sirfsoc_rtc_iobrg_readl(u32 addr)
> +{

Maybe for clarity have offset rather than address for these accessors to 
indicate the nature of their use?

> +	unsigned long val;
> +
> +	sirfsoc_rtc_iobrg_wait_sync();
> +
> +	writel(0x00, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_WRBE);
> +	writel(addr, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_ADDR);
> +	writel(0x01, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_CTRL);
> +
> +	sirfsoc_rtc_iobrg_wait_sync();
> +
> +	val = readl(sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_DATA);
> +
> +	return val;
> +}

Static again?  Also you could just do "return readl(..)" to eliminate 
the local variable.

> +u32 sirfsoc_rtc_iobrg_readl(u32 addr)
> +{
> +	unsigned long flags, val;
> +
> +	spin_lock_irqsave(&rtciobrg_lock, flags);
> +
> +	val = __sirfsoc_rtc_iobrg_readl(addr);
> +
> +	spin_unlock_irqrestore(&rtciobrg_lock, flags);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL(sirfsoc_rtc_iobrg_readl);
> +
> +void sirfsoc_rtc_iobrg_pre_writel(u32 val, u32 addr)
> +{
> +	sirfsoc_rtc_iobrg_wait_sync();
> +
> +	writel(0xf1, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_WRBE);
> +	writel(addr, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_ADDR);
> +
> +	writel(val, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_DATA);
> +}

Static?

> +
> +void sirfsoc_rtc_iobrg_writel(u32 val, u32 addr)
> +{
> +	unsigned long flags = 0;

Initializer not needed.

> +	spin_lock_irqsave(&rtciobrg_lock, flags);
> +
> +	sirfsoc_rtc_iobrg_pre_writel(val, addr);
> +
> +	writel(0x01, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_CTRL);
> +
> +	sirfsoc_rtc_iobrg_wait_sync();
> +
> +	spin_unlock_irqrestore(&rtciobrg_lock, flags);
> +}
> +EXPORT_SYMBOL(sirfsoc_rtc_iobrg_writel);
> +
> +static struct of_device_id rtciobrg_ids[] = {
> +	{ .compatible = "sirf,prima2-rtciobg" },
> +};

Missing an end of list {} sentinel?

> +
> +static int __init sirfsoc_of_rtciobrg_map(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, rtciobrg_ids);
> +	if (!np)
> +		panic("unable to find compatible rtc iobrg node in dtb\n");
> +	sirfsoc_rtciobrg_base = of_iomap(np, 0);
> +	if (!sirfsoc_rtciobrg_base)
> +		panic("unable to map rtc iobrg registers\n");
> +
> +	of_node_put(np);
> +
> +	return 0;
> +}
> +early_initcall(sirfsoc_of_rtciobrg_map);
> diff --git a/include/linux/rtc/sirfsoc_rtciobrg.h b/include/linux/rtc/sirfsoc_rtciobrg.h
> new file mode 100644
> index 0000000..2c92e1c
> --- /dev/null
> +++ b/include/linux/rtc/sirfsoc_rtciobrg.h
> @@ -0,0 +1,18 @@
> +/*
> + * RTC I/O Bridge interfaces for CSR SiRFprimaII
> + * ARM access the registers of SYSRTC, GPSRTC and PWRC through this module
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +#ifndef _SIRFSOC_RTC_IOBRG_H_
> +#define _SIRFSOC_RTC_IOBRG_H_
> +
> +extern void sirfsoc_rtc_iobrg_besyncing(void);
> +
> +extern u32 sirfsoc_rtc_iobrg_readl(u32 addr);
> +
> +extern void sirfsoc_rtc_iobrg_writel(u32 val, u32 addr);
> +
> +#endif
> -- 
> 1.7.1
> 
> 
> 
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
