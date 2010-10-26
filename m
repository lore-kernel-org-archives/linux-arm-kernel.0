From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Oct 2010 11:23:33 +0200
Subject: [PATCH RFC] MXC IOMUX-V3 replace struct pad_desc with
	bitmapped cookie
In-Reply-To: <1288084042-21722-1-git-send-email-LW@KARO-electronics.de>
References: <20101025072126.GG8554@pengutronix.de>
	<1288084042-21722-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20101026092333.GQ8554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lothar,

great you follow up on this.

On Tue, Oct 26, 2010 at 11:07:21AM +0200, Lothar Wa?mann wrote:
> The following patch is a first step to convert the 'struct pad_desc'
> to a bitmapped cookie to facilitate adding platform specific pullup or
> drive strength definitions to existing pad definitions without need to
> rewrite the complete pad def.
> 
> The patch wraps 'struct pad_desc' in an opaque data type and
> introduces macros to access the individual members.
> This patch does not constitute any functional change!
great
 
> BTW: 'mx51_defconfig' produces the following compile error:
> |fs/built-in.o: In function `nfs_callback_authenticate':
> |file.c:(.text+0xd9274): undefined reference to `svc_gss_principal'
If you enable CRYPTO or disable NFSv4 this is gone.  See
http://thread.gmane.org/gmane.linux.kernel/1027380 for some details.
Linus tree doesn't have this problem anymore.

> and 'mx3_defconfig':
> |/usr/local/src/arm/linux-2.6-ptx/arch/arm/mach-mx3/devices.c:91: error: 'MX35_INT_MMC_SDHC2' undeclared here (not in a function)
This is already fixed in Saschas imx-for-2.6.37 branch.
 
> Signed-Off-By: Lothar Wa?mann <LW@KARO-electronics.de>
Something between your fingers and my eyes messed up the encoding of
your mail.


> ---
>  mach-mx25/eukrea_mbimxsd-baseboard.c |    2 +-
>  mach-mx25/mach-cpuimx25.c            |    2 +-
>  mach-mx25/mach-mx25_3ds.c            |    2 +-
>  mach-mx3/eukrea_mbimxsd-baseboard.c  |    2 +-
>  mach-mx3/mach-cpuimx35.c             |    2 +-
>  mach-mx3/mach-mx35_3ds.c             |    2 +-
>  mach-mx3/mach-pcm043.c               |   16 ++++++++--------
>  mach-mx5/board-cpuimx51.c            |    2 +-
>  mach-mx5/board-cpuimx51sd.c          |    2 +-
>  mach-mx5/board-mx51_3ds.c            |    2 +-
>  mach-mx5/board-mx51_babbage.c        |    8 ++++----
>  mach-mx5/board-mx51_efikamx.c        |    2 +-
>  mach-mx5/eukrea_mbimx51-baseboard.c  |    2 +-
>  mach-mx5/eukrea_mbimxsd-baseboard.c  |    2 +-
>  plat-mxc/include/mach/iomux-v3.h     |   15 +++++++++++----
>  plat-mxc/iomux-v3.c                  |   22 +++++++++++-----------
>  16 files changed, 46 insertions(+), 39 deletions(-)
> 
> [...]
> --- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> @@ -44,7 +44,7 @@
>   *
>   */
>  
> -struct pad_desc {
> +typedef struct pad_desc {
if you remove the "pad_desc" here all users of the old name are catched
by the compiler.

>  	unsigned mux_ctrl_ofs:12; /* IOMUXC_SW_MUX_CTL_PAD offset */
>  	unsigned mux_mode:8;
>  	unsigned pad_ctrl_ofs:12; /* IOMUXC_SW_PAD_CTRL offset */
> @@ -52,7 +52,14 @@ struct pad_desc {
>  	unsigned pad_ctrl:17;
>  	unsigned select_input_ofs:12; /* IOMUXC_SELECT_INPUT offset */
>  	unsigned select_input:3;
> -};
> +} iomux_v3_cfg_t;
> +
> +#define MUX_CTRL_OFS(pad)		(pad)->mux_ctrl_ofs
> +#define MUX_MODE(pad)			(pad)->mux_mode
> +#define MUX_SELECT_INPUT_OFS(pad)	(pad)->select_input_ofs
> +#define MUX_SELECT_INPUT(pad)		(pad)->select_input
> +#define MUX_PAD_CTRL_OFS(pad)		(pad)->pad_ctrl_ofs
> +#define MUX_PAD_CTRL(pad)		(pad)->pad_ctrl
Maybe make these static inlines?  This adds basic type-checking and
doesn't have any downsides AFAIK.

>  #define IOMUX_PAD(_pad_ctrl_ofs, _mux_ctrl_ofs, _mux_mode, _select_input_ofs, \
>  		_select_input, _pad_ctrl)				\
> @@ -107,13 +114,13 @@ struct pad_desc {
>  /*
>   * setups a single pad in the iomuxer
>   */
> -int mxc_iomux_v3_setup_pad(struct pad_desc *pad);
> +int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t *pad);
>  
>  /*
>   * setups mutliple pads
>   * convenient way to call the above function with tables
>   */
> -int mxc_iomux_v3_setup_multiple_pads(struct pad_desc *pad_list, unsigned count);
> +int mxc_iomux_v3_setup_multiple_pads(iomux_v3_cfg_t *pad_list, unsigned count);
>  
>  /*
>   * Initialise the iomux controller
> diff --git a/arch/arm/plat-mxc/iomux-v3.c b/arch/arm/plat-mxc/iomux-v3.c
> index b318c6a..975ca7c 100644
> --- a/arch/arm/plat-mxc/iomux-v3.c
> +++ b/arch/arm/plat-mxc/iomux-v3.c
> @@ -32,26 +32,26 @@
>  static void __iomem *base;
>  
>  /*
> - * setups a single pad in the iomuxer
> + * configures a single pad in the iomuxer
>   */
> -int mxc_iomux_v3_setup_pad(struct pad_desc *pad)
> +int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t *pad)
>  {
> -	if (pad->mux_ctrl_ofs)
> -		__raw_writel(pad->mux_mode, base + pad->mux_ctrl_ofs);
> +	if (MUX_CTRL_OFS(pad))
> +		__raw_writel(MUX_MODE(pad), base + MUX_CTRL_OFS(pad));
>  
> -	if (pad->select_input_ofs)
> -		__raw_writel(pad->select_input,
> -				base + pad->select_input_ofs);
> +	if (MUX_SELECT_INPUT_OFS(pad))
> +		__raw_writel(MUX_SELECT_INPUT(pad),
> +			base + MUX_SELECT_INPUT(pad));
>  
> -	if (!(pad->pad_ctrl & NO_PAD_CTRL) && pad->pad_ctrl_ofs)
> -		__raw_writel(pad->pad_ctrl, base + pad->pad_ctrl_ofs);
> +	if (!(MUX_PAD_CTRL(pad) & NO_PAD_CTRL) && MUX_PAD_CTRL_OFS(pad))
> +		__raw_writel(MUX_PAD_CTRL(pad), base + MUX_PAD_CTRL_OFS(pad));
unrelated to this patch:  I wonder if this is correct.  Maybe something
like:

	if (MUX_PAD_CTRL_OFS(pad))
		__raw_writel(MUX_PAD_CTRL(pad) & ~NO_PAD_CTRL, ...);

to get a defined value (here 0) into the MUX_PAD_CTRL register?  Not
sure this is needed/correct though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
