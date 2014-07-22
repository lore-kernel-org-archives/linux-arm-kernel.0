From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Jul 2014 16:50:56 +0800
Subject: [PATCH] ARM: imx6: fix SMP compilation again
In-Reply-To: <37015543.ZyZKZyEIPW@wuerfel>
References: <37015543.ZyZKZyEIPW@wuerfel>
Message-ID: <20140722085055.GX8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 10:30:50AM +0200, Arnd Bergmann wrote:
> My earlier patch 1fc593feaf8e ("ARM: imx: build i.MX6 functions
> only when needed") fixed a problem with building an i.MX5 kernel,
> but missed the corner case of building a kernel for i.MX5 with
> SMP enabled. It is an extremely rare case that has only now
> happened after many thousands of randconfig kernel builds.
> 
> The error message I get is
> arch/arm/mach-imx/built-in.o: In function `v7_secondary_startup':
> :(.text+0x5124): undefined reference to `v7_invalidate_l1'

I cannot reproduce it, and unsure how it happens.

The v7_invalidate_l1() is defined in arch/arm/mm/cache-v7.S, and should
be available for i.MX5 build.

Shawn

> 
> This puts the code inside of an "ifdef CONFIG_SMP" to hopefully
> do the right thing in all configurations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index ac88599ca080..23c02932bf84 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -93,9 +93,11 @@ obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
>  obj-$(CONFIG_HAVE_IMX_SRC) += src.o
> +ifdef CONFIG_SOC_IMX6
>  AFLAGS_headsmp.o :=-Wa,-march=armv7-a
>  obj-$(CONFIG_SMP) += headsmp.o platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
> +endif
>  obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
>  obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
>  obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o mach-imx6sx.o
> 
