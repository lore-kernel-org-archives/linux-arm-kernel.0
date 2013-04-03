From: olof@lixom.net (Olof Johansson)
Date: Wed, 3 Apr 2013 11:52:32 -0700
Subject: [PATCHv2 1/2] ARM: socfpga: Enable soft reset
In-Reply-To: <20130320152915.GA32083@amd.pavel.ucw.cz>
References: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
 <20130320152915.GA32083@amd.pavel.ucw.cz>
Message-ID: <20130403185232.GA11360@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 04:29:15PM +0100, Pavel Machek wrote:
> Hi!
> 
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Enable a cold or warm reset to the HW from userspace.
> > 
> > Also fix a few sparse errors:
> > 
> > warning: symbol 'sys_manager_base_addr' was not declared. Should it be static?
> > warning: symbol 'rst_manager_base_addr' was not declared. Should it be static?
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> 
> Tested-by: Pavel Machek <pavel@denx.de>
> 
> Would it make sense to apply something like this? Struct looks cleaner
> than offset defines... 
> 
> Thanks,
> 									Pavel
> 
>     Switch reset manager to using struct (not defines), cleanups.
>     
>     Convert SMP code to use the struct instead of open-coded numbers.
> 
>     Also none of the code is time-critical, so it
>     does not make sense to use __raw_writel variants.
>     
>     Signed-off-by: Pavel Machek <pavel@denx.de>
> 
> diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
> index d2a251f..f4b6048 100644
> --- a/arch/arm/mach-socfpga/core.h
> +++ b/arch/arm/mach-socfpga/core.h
> @@ -20,19 +20,21 @@
>  #ifndef __MACH_CORE_H
>  #define __MACH_CORE_H
>  
> -#define SOCFPGA_RSTMGR_CTRL	0x04
> -#define SOCFPGA_RSTMGR_MODPERRST	0x14
> -#define SOCFPGA_RSTMGR_BRGMODRST	0x1c
> -
> -/* System Manager bits */
> -#define RSTMGR_CTRL_SWCOLDRSTREQ	0x1	/* Cold Reset */
> -#define RSTMGR_CTRL_SWWARMRSTREQ	0x2	/* Warm Reset */
> -/*MPU Module Reset Register */
> -#define RSTMGR_MPUMODRST_CPU0	0x1	/*CPU0 Reset*/
> -#define RSTMGR_MPUMODRST_CPU1	0x2	/*CPU1 Reset*/
> -#define RSTMGR_MPUMODRST_WDS		0x4	/*Watchdog Reset*/
> -#define RSTMGR_MPUMODRST_SCUPER	0x8	/*SCU and periphs reset*/
> -#define RSTMGR_MPUMODRST_L2		0x10	/*L2 Cache reset*/
> +struct socfpga_rstmgr_hw {
> +	u32 unk;
> +	u32 ctrl;		/* 0x04 */
> +	u32 unk2, unk3;
> +/* MPU Module Reset Register */
> +#define RSTMGR_MPUMODRST_CPU0	0x1	/* CPU0 Reset */
> +#define RSTMGR_MPUMODRST_CPU1	0x2	/* CPU1 Reset */
> +#define RSTMGR_MPUMODRST_WDS	0x4	/* Watchdog Reset */
> +#define RSTMGR_MPUMODRST_SCUPER	0x8	/* SCU and periphs reset */
> +#define RSTMGR_MPUMODRST_L2	0x10	/* L2 Cache reset */
> +	u32 mpumodrst; 		/* 0x10 */
> +	u32 modperrst;		/* 0x14 */
> +	u32 unk5;
> +	u32 bgrmodrst;		/* 0x1c */
> +};

As Russell already replied, struct used to represent register layout is
normally frowned upon in drivers.

If you want to tighten up the code in this case, make a local helper
function that just takes the register offset instead, i.e.:

> -	temp = __raw_readl(rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
> +	temp = readl(&rst_manager_base_addr->ctrl);

	temp = rst_readl(SOCFPGA_RSTMGR_CTRL);

(and then have rst_readl/rst_writel do the math based on base address).



-Olof
