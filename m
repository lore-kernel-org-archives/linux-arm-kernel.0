From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 27 Apr 2017 22:57:21 +0300
Subject: [PATCH] IMX: Rearm watchdog after loading value for restart
In-Reply-To: <20170427131434.17085-1-Frederik.juul@3shape.com>
References: <20170427131434.17085-1-Frederik.juul@3shape.com>
Message-ID: <20170427195721.nqvliulrbbh3gef4@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frederik,

On Thu, Apr 27, 2017 at 03:14:34PM +0200, frederikj at gmail.com wrote:
> When calling the restart function the watchdog is activated and the WDOG
> timeout field is set to 0. This gives a reset time of 500 ms, which is
> consistent with the following delay. However this new time is not loaded
> into the WDOG until the WDOG service routine is run (see IMX6SXRM section
> 70.5.1.1 "Servicing WDOG to reload the counter").
> 
> Not reloading the counter could result in a random delay up to 128 seconds
> before the system restarts, depending on the previous value of the WDOG
> timeout field and when it has last been serviced. That bug is fixed with
> this patch.

Which platform are you using? This code seems to only be used on legacy 
platforms that were not converted to DT. For DT based systems, including all 
i.MX6, the equivalent version is at 
drivers/watchdog/imx2_wdt.c:imx2_wdt_restart().

baruch

> Signed-off-by: Frederik Juul <Frederik.juul@3shape.com>
> 
> --- linux/arch/arm/mach-imx/system.c.orig	2017-04-20 10:41:33.207558297 +0200
> +++ linux/arch/arm/mach-imx/system.c	2017-04-27 14:27:19.225474885 +0200
> @@ -32,6 +32,8 @@
>  #include "common.h"
>  #include "hardware.h"
>  
> +#define IMX_WATCHDOG_SERVICE_REGISTER 2
> +
>  static void __iomem *wdog_base;
>  static struct clk *wdog_clk;
>  static int wcr_enable = (1 << 2);
> @@ -59,6 +61,10 @@ void mxc_restart(enum reboot_mode mode,
>  	imx_writew(wcr_enable, wdog_base);
>  	imx_writew(wcr_enable, wdog_base);
>  
> +	/* Rearm WDOG to load 500ms value */
> +	imx_writew(0x5555, wdog_base+IMX_WATCHDOG_SERVICE_REGISTER);
> +	imx_writew(0xaaaa, wdog_base+IMX_WATCHDOG_SERVICE_REGISTER);
> +
>  	/* wait for reset to assert... */
>  	mdelay(500);

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
