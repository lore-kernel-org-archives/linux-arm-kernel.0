From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 Sep 2011 22:22:48 +0800
Subject: [PATCH 4/6] arm/imx: remove cpu_is_xxx() from arch_idle()
In-Reply-To: <20110929085936.GD31404@pengutronix.de>
References: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
	<1317201368-6403-5-git-send-email-shawn.guo@linaro.org>
	<20110929085936.GD31404@pengutronix.de>
Message-ID: <20110929142247.GL19318@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:59:36AM +0200, Sascha Hauer wrote:
> On Wed, Sep 28, 2011 at 05:16:06PM +0800, Shawn Guo wrote:
> > This patch adds an idle hook imx_idle to be called in arch_idle().
> > Any soc that needs a customized idle implementation other than
> > cpu_do_idle() can set up this hook in soc specific call.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mach-imx/mm-imx3.c             |   30 ++++++++++++++++++++++++++
> >  arch/arm/mach-mx5/mm.c                  |    6 +++++
> >  arch/arm/mach-mx5/pm-imx5.c             |    3 +-
> >  arch/arm/plat-mxc/include/mach/common.h |    2 +
> >  arch/arm/plat-mxc/include/mach/system.h |   35 ++----------------------------
> >  arch/arm/plat-mxc/system.c              |    2 +
> >  6 files changed, 45 insertions(+), 33 deletions(-)
> > 
> 
> I had to fold the following into this commit, otherwise we end
> up with:
> 
> In file included from arch/arm/mach-mx5/pm-imx5.c:17:0:arch/arm/plat-mxc/include/mach/common.h:77:33: warning: 'enum mxc_cpu_pwr_mode' declared inside parameter list
> arch/arm/plat-mxc/include/mach/common.h:77:33: warning: its scope is only this definition or declaration, which is probably not what you want
> 

Aha, I based this series off imx6q one.  I have the following change
in patch 'arm/imx6q: add suspend/resume support'.

diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 571e91d..318b995 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -13,6 +13,7 @@

 struct platform_device;
 struct clk;
+enum mxc_cpu_pwr_mode;

 extern void mx1_map_io(void);
 extern void mx21_map_io(void);

But I'm fine with your changes below.

> Sascha
> 
> diff --git a/arch/arm/mach-mx5/system.c b/arch/arm/mach-mx5/system.c
> index 76ae8dc..144ebeb 100644
> --- a/arch/arm/mach-mx5/system.c
> +++ b/arch/arm/mach-mx5/system.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <mach/hardware.h>
> +#include <mach/common.h>
>  #include "crm_regs.h"
>  
>  /* set cpu low power mode before WFI instruction. This function is called
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 2b298d8..afaa967 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -72,6 +72,15 @@ extern void mxc_arch_reset_init(void __iomem *);
>  extern void mx51_efikamx_reset(void);
>  extern int mx53_revision(void);
>  extern int mx53_display_revision(void);
> +
> +enum mxc_cpu_pwr_mode {
> +	WAIT_CLOCKED,		/* wfi only */
> +	WAIT_UNCLOCKED,		/* WAIT */
> +	WAIT_UNCLOCKED_POWER_OFF,	/* WAIT + SRPG */
> +	STOP_POWER_ON,		/* just STOP */
> +	STOP_POWER_OFF,		/* STOP + SRPG */
> +};
> +
>  extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
>  extern void (*imx_idle)(void);
>  #endif
> diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
> index 0987923..00a7819 100644
> --- a/arch/arm/plat-mxc/include/mach/mxc.h
> +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> @@ -183,13 +183,6 @@ struct cpu_op {
>  };
>  
>  int tzic_enable_wake(int is_idle);
> -enum mxc_cpu_pwr_mode {
> -	WAIT_CLOCKED,		/* wfi only */
> -	WAIT_UNCLOCKED,		/* WAIT */
> -	WAIT_UNCLOCKED_POWER_OFF,	/* WAIT + SRPG */
> -	STOP_POWER_ON,		/* just STOP */
> -	STOP_POWER_OFF,		/* STOP + SRPG */
> -};
>  
>  extern struct cpu_op *(*get_cpu_op)(int *op);
>  #endif
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Regards,
Shawn
