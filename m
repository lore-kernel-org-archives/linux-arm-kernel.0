From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 27 Jan 2016 17:56:18 +0800
Subject: [PATCH] clk: Move vendor's Kconfig into CCF menu section
In-Reply-To: <4711589.Ig064LES4c@wuerfel>
References: <201601271708.gQUxXACW%fengguang.wu@intel.com>
 <4711589.Ig064LES4c@wuerfel>
Message-ID: <1453888578.28646.7.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, 2016-01-27 at 10:27 +0100, Arnd Bergmann wrote:
> On Wednesday 27 January 2016 17:18:03 kbuild test robot wrote:
> > Hi James,
> > 
> > [auto build test ERROR on clk/clk-next]
> > [also build test ERROR on v4.5-rc1 next-20160127]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/James-Liao/clk-Move-vendor-s-Kconfig-into-CCF-menu-section/20160127-152850
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> > config: arm-samsung (attached as .config)
> > reproduce:
> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=arm 
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> > warning: (ARCH_BAST && MACH_VR1000 && MACH_ANUBIS && MACH_OSIRIS && MACH_RX1950) selects S3C2410_COMMON_DCLK which has unmet direct dependencies (COMMON_CLK)
> > warning: (CPU_S3C2410 && CPU_S3C2440 && CPU_S3C2442) selects S3C2410_COMMON_CLK which has unmet direct dependencies (COMMON_CLK)
> > warning: (CPU_S3C2412) selects S3C2412_COMMON_CLK which has unmet direct dependencies (COMMON_CLK)
> > warning: (CPU_S3C2416 && CPU_S3C2443) selects S3C2443_COMMON_CLK which has unmet direct dependencies (COMMON_CLK)
> >    drivers/built-in.o: In function `pwm_samsung_remove':
> > >> :(.text+0xba68): undefined reference to `clk_disable'
> >    drivers/built-in.o: In function `pwm_samsung_config':
> > >> :(.text+0xbc18): undefined reference to `clk_get_rate'
> >    :(.text+0xbc30): undefined reference to `clk_get_rate'
> 
> I think you should include this change in your patch, or as a preparation.
> All other samsung platforms already select COMMON_CLK through ARCH_MULTIPLATFORM,
> and all SoCs that are part of ARCH_S3C24XX individually select a symbol that
> selects COMMON_CLK.

Oops, I didn't notice there are warnings after moving these Kconfigs
into menu section.

The original motivation of this patch is preventing new clk drivers
include their Kconfig in a wrong place, so it's not critical. Do you
think we should apply this patch (with your changes below) or drop this
patch directly?


Best regards,

James

> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index bf66c8334822..85e051d1c2d6 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -15,6 +15,7 @@ config PLAT_S3C24XX
>  	select NO_IOPORT_MAP
>  	select S3C_DEV_NAND
>  	select IRQ_DOMAIN
> +	select COMMON_CLK
>  	help
>  	  Base platform code for any Samsung S3C24XX device
>  
> diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
> index 84196ecdaa12..b3fe5cb01afe 100644
> --- a/drivers/clk/samsung/Kconfig
> +++ b/drivers/clk/samsung/Kconfig
> @@ -1,6 +1,5 @@
>  config COMMON_CLK_SAMSUNG
>  	bool
> -	select COMMON_CLK
>  
>  config S3C2410_COMMON_CLK
>  	bool
> 
