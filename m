From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 23 Aug 2011 09:48:19 +0100
Subject: [PATCH v2 1/4] ARM: CSR: add rtc i/o bridge interface for
	SiRFprimaII
In-Reply-To: <1314080152-30503-2-git-send-email-Baohua.Song@csr.com>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
	<1314080152-30503-2-git-send-email-Baohua.Song@csr.com>
Message-ID: <20110823084819.GG2796@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

On Mon, Aug 22, 2011 at 11:15:49PM -0700, Barry Song wrote:
> From: Zhiwu Song <zhiwu.song@csr.com>
> 
> The module is a bridge between the RTC clock domain and the CPU interface
> clock domain. ARM access the register of SYSRTC, GPSRTC and PWRC through
> this module.
> 
> Signed-off-by: Zhiwu Song <zhiwu.song@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

A couple of minor nits inline (sorry if I didn't pick them up last 
time).  Feel free to add a:

	Reviewed-by: Jamie Iles <jamie@jamieiles.com>

if you choose to make those changes.

Jamie

> ---
>  -v2:
>  handle feedback from Jamie Iles <jamie@jamieiles.com>
>  make rtciobrg become a device driver
>  make devices behind rtciobrg not be compatible with simple-bus
>  replace EXPORT_SYMBOL by EXPORT_SYMBOL_GPL
> 
>  arch/arm/boot/dts/prima2-cb.dts      |    2 +-
>  arch/arm/mach-prima2/Makefile        |    1 +
>  arch/arm/mach-prima2/rtciobrg.c      |  136 ++++++++++++++++++++++++++++++++++
>  include/linux/rtc/sirfsoc_rtciobrg.h |   18 +++++
>  4 files changed, 156 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-prima2/rtciobrg.c
>  create mode 100644 include/linux/rtc/sirfsoc_rtciobrg.h
> 
> diff --git a/arch/arm/boot/dts/prima2-cb.dts b/arch/arm/boot/dts/prima2-cb.dts
> index 6fecc88..e5e9bc6 100644
> --- a/arch/arm/boot/dts/prima2-cb.dts
> +++ b/arch/arm/boot/dts/prima2-cb.dts
> @@ -358,7 +358,7 @@
>  		};
>  
>  		rtc-iobg {
> -			compatible = "sirf,prima2-rtciobg", "simple-bus";
> +			compatible = "sirf,prima2-rtciobg", "sirf-prima2-rtciobg-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x80030000 0x10000>;
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
> index 0000000..1163e2c
> --- /dev/null
> +++ b/arch/arm/mach-prima2/rtciobrg.c
> @@ -0,0 +1,136 @@
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
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +
> +#define SIRFSOC_CPUIOBRG_CTRL           0x00
> +#define SIRFSOC_CPUIOBRG_WRBE           0x04
> +#define SIRFSOC_CPUIOBRG_ADDR           0x08
> +#define SIRFSOC_CPUIOBRG_DATA           0x0c
> +
> +void __iomem *sirfsoc_rtciobrg_base;
> +static DEFINE_SPINLOCK(rtciobrg_lock);
> +
> +void sirfsoc_rtc_iobrg_wait_sync(void)
> +{
> +	while (readl_relaxed(sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_CTRL))
> +		continue;

It might be worth using cpu_relax() here as it includes a memory barrier 
that's what many busy wait loops do.

> +}
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
> +EXPORT_SYMBOL_GPL(sirfsoc_rtc_iobrg_besyncing);
> +
> +u32 __sirfsoc_rtc_iobrg_readl(u32 addr)
> +{
> +	unsigned long val;
> +
> +	sirfsoc_rtc_iobrg_wait_sync();
> +
> +	writel_relaxed(0x00, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_WRBE);
> +	writel_relaxed(addr, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_ADDR);
> +	writel_relaxed(0x01, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_CTRL);
> +
> +	sirfsoc_rtc_iobrg_wait_sync();
> +
> +	val = readl_relaxed(sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_DATA);
> +
> +	return val;

I don't think this needs the temporary 'val', but that's not a big 
problem.

> +}
> +
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
> +EXPORT_SYMBOL_GPL(sirfsoc_rtc_iobrg_readl);
> +
> +void sirfsoc_rtc_iobrg_pre_writel(u32 val, u32 addr)
> +{
> +	sirfsoc_rtc_iobrg_wait_sync();
> +
> +	writel_relaxed(0xf1, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_WRBE);
> +	writel_relaxed(addr, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_ADDR);
> +
> +	writel_relaxed(val, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_DATA);
> +}
> +
> +void sirfsoc_rtc_iobrg_writel(u32 val, u32 addr)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&rtciobrg_lock, flags);
> +
> +	sirfsoc_rtc_iobrg_pre_writel(val, addr);
> +
> +	writel_relaxed(0x01, sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_CTRL);
> +
> +	sirfsoc_rtc_iobrg_wait_sync();
> +
> +	spin_unlock_irqrestore(&rtciobrg_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(sirfsoc_rtc_iobrg_writel);
> +
> +static struct of_device_id rtciobrg_ids[] = {

const?

> +	{ .compatible = "sirf,prima2-rtciobg" },
> +	{}
> +};
> +
> +static int __devinit sirfsoc_rtciobrg_probe(struct platform_device *op)
> +{
> +	struct device_node *np = op->dev.of_node;
> +
> +	sirfsoc_rtciobrg_base = of_iomap(np, 0);
> +	if (!sirfsoc_rtciobrg_base)
> +		panic("unable to map rtc iobrg registers\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sirfsoc_rtciobrg_driver = {
> +	.probe		= sirfsoc_rtciobrg_probe,
> +	.driver = {
> +		.name = "sirfsoc-rtciobrg",
> +		.owner = THIS_MODULE,
> +		.of_match_table	= rtciobrg_ids,
> +	},
> +};
> +
> +static int __init sirfsoc_rtciobrg_init(void)
> +{
> +	return platform_driver_register(&sirfsoc_rtciobrg_driver);
> +}
> +postcore_initcall(sirfsoc_rtciobrg_init);
> +
> +MODULE_AUTHOR("Zhiwu Song <zhiwu.song@csr.com>, "
> +		"Barry Song <baohua.song@csr.com>");
> +MODULE_DESCRIPTION("CSR SiRFprimaII rtc io bridge");
> +MODULE_LICENSE("GPL");
> +
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
