From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 8 Aug 2012 08:55:02 +0200
Subject: [PATCH 1/2] ARM: build ssi-fiq.S in ARM mode to prevent
 CONFIG_THUMB2_KERNEL build breakage
In-Reply-To: <1344379514-30076-2-git-send-email-matt@genesi-usa.com>
References: <1344379514-30076-1-git-send-email-matt@genesi-usa.com>
 <1344379514-30076-2-git-send-email-matt@genesi-usa.com>
Message-ID: <20120808065502.GI1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 05:45:13PM -0500, Matt Sealey wrote:
> If i.MX SSI FIQ support is enabled then it is impossible to build a Thumb2
> kernel image due to the code not being written with Thumb2 in mind (over-use
> of registers). In order not to break Thumb2 kernels, compile this as ARM. All
> the processors which require this support will run ARM code so there is no
> problem at runtime in doing this, even if it does produce a strange mix of
> code that may not be desired.
> 
> In theory this should only be needed on configs based on imx_v4_v5_defconfig
> where CONFIG_THUMB2_KERNEL cannot be selected anyway since these SoCs do not
> have ARM cores capable of running Thumb2 code. This also makes rewriting the
> code as Thumb-compatible kind of redundant. But since one Eukrea board audio
> driver needs it, and there is an i.MX51 CPU module for this board, it gets
> pulled in for imx_v6_v7_defconfig too, making this a necessity.
> 
> Signed-off-by: Matt Sealey <matt@genesi-usa.com>
> ---
>  arch/arm/plat-mxc/ssi-fiq.S |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/plat-mxc/ssi-fiq.S b/arch/arm/plat-mxc/ssi-fiq.S
> index 8397a2d..ac09af8 100644
> --- a/arch/arm/plat-mxc/ssi-fiq.S
> +++ b/arch/arm/plat-mxc/ssi-fiq.S
> @@ -28,6 +28,7 @@
>  #define SSI_SIER_RFF0_EN	(1 << 2)
>  
>  		.text
> +		.arm
>  		.global	imx_ssi_fiq_start
>  		.global	imx_ssi_fiq_end
>  		.global imx_ssi_fiq_base

I think it would be better to add a depends on !THUMB2_KERNEL to
SND_IMX_SOC_PCM_FIQ. The above may result in broken code in a thumb2
kernel, so I'd rather keep the compile error instead.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
