From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 4 Mar 2011 10:34:33 +0800
Subject: [PATCH v3] ARM: mx51: Print silicon revision on boot
In-Reply-To: <1299199058-5539-1-git-send-email-festevam@gmail.com>
References: <1299199058-5539-1-git-send-email-festevam@gmail.com>
Message-ID: <20110304023431.GA23099@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Mar 03, 2011 at 09:37:38PM -0300, Fabio Estevam wrote:
> Having the silicon revision to appear on the boot log is a useful information.
> 
> MX31 and MX35 already show the silicon revision on boot. Add support for displaying such information for MX51 as well.
80 character limit?
> 
> Tested on a MX51EVK, where it shows:
> 
> CPU identified as i.MX51, silicon rev 3.0
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v2:
> - Remove unneeded return inside mx51_display_revision 
> Changes since v1:
> - Added patch description
>  arch/arm/mach-mx5/clock-mx51-mx53.c   |    1 +
>  arch/arm/mach-mx5/cpu.c               |   20 ++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/mx51.h |    1 +
>  3 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 652ace4..1282a60 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1510,6 +1510,7 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
>  
>  	clk_enable(&iim_clk);
>  	mx51_revision();
> +	mx51_display_revision();
move down one line?
>  	clk_disable(&iim_clk);
>  
>  	/* move usb_phy_clk to 24MHz */
> diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
> index df46b5e..da3d8c9 100644
> --- a/arch/arm/mach-mx5/cpu.c
> +++ b/arch/arm/mach-mx5/cpu.c
> @@ -51,6 +51,26 @@ int mx51_revision(void)
>  }
>  EXPORT_SYMBOL(mx51_revision);
>  
> +void mx51_display_revision(void)
> +{
> +	int rev;
> +	char *srev;
> +	rev = mx51_revision();
> +
> +	switch (rev) {
> +	case IMX_CHIP_REVISION_2_0:
> +		srev = "2.0";
Is the string common? Add a common func like imx_revision_to_str ?

Thanks
Richard
> +		break;
> +	case IMX_CHIP_REVISION_3_0:
> +		srev = "3.0";
> +		break;
> +	default:
> +		srev = "unknown";
> +	}
> +	printk(KERN_INFO "CPU identified as i.MX51, silicon rev %s\n", srev);
> +}
> +EXPORT_SYMBOL(mx51_display_revision);
> +
>  #ifdef CONFIG_NEON
>  
>  /*
> diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
> index 1eb339e..dede19a 100644
> --- a/arch/arm/plat-mxc/include/mach/mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/mx51.h
> @@ -347,6 +347,7 @@
>  
>  #if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
>  extern int mx51_revision(void);
> +extern void mx51_display_revision(void);
>  #endif
>  
>  /* tape-out 1 defines */
> -- 
> 1.6.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
