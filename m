From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 8 Oct 2013 10:32:53 -0500
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <525425A5.2020500@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2013 04:06 AM, Shawn Guo wrote:
> The imx6q_restart() works fine with normal reboot but will run into
> problem with emergency reboot like sysrq-b.  In that case, of_iomap()
> gets called from interrupt context and hence triggers the BUG_ON in
> __get_vm_area_node().
> 
> Actually, since commit c1e31d1 (ARM: imx: create
> mxc_arch_reset_init_dt() for DT boot), imx6q/dl should try to use
> mxc_restart() by calling mxc_arch_reset_init_dt() beforehand, where
> things like of_iomap() can be done.
> 
> The patch updates mxc_restart() a little bit to get it work for imx6q/dl
> and kill imx6q_restart() completely.
> 
> Reported-by: Nathan Lynch <nathan_lynch@mentor.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks Shawn, works for me.  One minor comment on the patch below.


> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 7230cf8..9ebca9e 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -130,7 +130,11 @@ static inline void imx_smp_prepare(void) {}
>  static inline void imx_scu_standby_enable(void) {}
>  #endif
>  extern void imx_src_init(void);
> +#ifdef CONFIG_HAVE_IMX_SRC
>  extern void imx_src_prepare_restart(void);
> +#else
> +extern inline void imx_src_prepare_restart(void) {}

Should be static inline?
