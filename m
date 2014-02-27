From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 27 Feb 2014 21:12:10 +0800
Subject: [PATCH 1/4] ARM: imx6: move v7_cpu_resume() into suspend-imx6.S
In-Reply-To: <201402271359.28159.arnd@arndb.de>
References: <1393422280-22283-1-git-send-email-shawn.guo@linaro.org>
 <201402271359.28159.arnd@arndb.de>
Message-ID: <20140227131205.GG13537@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 01:59:27PM +0100, Arnd Bergmann wrote:
> On Wednesday 26 February 2014, Shawn Guo wrote:
> > 
> >  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> > -obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o suspend-imx6.o
> > +obj-$(CONFIG_SUSPEND) += suspend-imx6.o
> > +obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o
> >  # i.MX6SL reuses i.MX6Q code
> > -obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o suspend-imx6.o
> > +obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o
> >  
> 
> I noticed a small bug during randconfig testing (starting to like
> my tests more recently):

Sorry for that.

> 
> You build suspend-imx6.o for all SoCs now when SUSPEND is enabled,
> so this will fail for an ARMv5-only configuration. You probably
> need something like

I received a report from 0-DAY kbuild test robot on this, and sent a
small cleanup series which fixes the error along the way.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/305262

> 
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 9c776a0..4dd45db 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -103,10 +103,10 @@ obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
>  obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
>  
>  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> -obj-$(CONFIG_SUSPEND) += suspend-imx6.o
> -obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o
> +imx6-$(CONFIG_SUSPEND) += suspend-imx6.o
> +obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o $(imx6-y)
>  # i.MX6SL reuses i.MX6Q code
> -obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o
> +obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o $(imx6-y)
>  
>  # i.MX5 based machines
>  obj-$(CONFIG_MACH_MX51_BABBAGE) += mach-mx51_babbage.o
> 
> 
> 
> 
> 	Arnd
