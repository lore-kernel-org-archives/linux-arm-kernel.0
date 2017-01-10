From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 10 Jan 2017 16:11:26 +0530
Subject: [PATCH v2 5/6] ARM: davinci: da8xx: add pdata-quirks, use for
 VPIF capture
In-Reply-To: <20170109205531.3435-6-khilman@baylibre.com>
References: <20170109205531.3435-1-khilman@baylibre.com>
 <20170109205531.3435-6-khilman@baylibre.com>
Message-ID: <ae14dc7b-0e82-b1a8-19f4-768a74f86fda@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 January 2017 02:25 AM, Kevin Hilman wrote:
> For da8xx DT platforms, use pdata-quirks to add legacy platform data for
> vpif_capture driver.
> 
> Passing legacy platform_data is required until the V4L2 framework, and
> subdevice drivers (such as the tvp514x) grow a way of selecting input
> and output routing  (c.f. V4L2 s_routing API)
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arm/mach-davinci/Makefile       |   2 +-
>  arch/arm/mach-davinci/da8xx-dt.c     |   2 +
>  arch/arm/mach-davinci/pdata-quirks.c | 115 +++++++++++++++++++++++++++++++++++
>  3 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
> index 0a2e6da45f28..df96ca9eab6d 100644
> --- a/arch/arm/mach-davinci/Makefile
> +++ b/arch/arm/mach-davinci/Makefile
> @@ -21,7 +21,7 @@ obj-$(CONFIG_AINTC)			+= irq.o
>  obj-$(CONFIG_CP_INTC)			+= cp_intc.o
>  
>  # Board specific
> -obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o
> +obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o pdata-quirks.o

This should be done in 4/6 along with addition of pdata-quirks.c

>  obj-$(CONFIG_MACH_DAVINCI_EVM)  	+= board-dm644x-evm.o
>  obj-$(CONFIG_MACH_SFFSDR)		+= board-sffsdr.o
>  obj-$(CONFIG_MACH_NEUROS_OSD2)		+= board-neuros-osd2.o
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index 9ee44da6eb7b..fe4a9e30d937 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -42,6 +42,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>  	OF_DEV_AUXDATA("ti,da830-ohci", 0x01e25000, "ohci-da8xx", NULL),
>  	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
>  	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
> +	OF_DEV_AUXDATA("ti,da850-vpif", 0x01e17000, "vpif", NULL),
>  	{}
>  };
>  
> @@ -62,6 +63,7 @@ static void __init da850_init_machine(void)
>  
>  	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
>  	davinci_pm_init();
> +	pdata_quirks_init();

This too belongs to 4/6.

Rest of  the patch looks good to me. But I cannot apply it until I get a
branch from Mauro with driver changes hosted.

Thanks,
Sekhar
