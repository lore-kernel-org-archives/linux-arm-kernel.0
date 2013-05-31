From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 31 May 2013 13:22:54 +0200
Subject: [PATCH 2/2] ARM: imx6q: Mark VPU and IPU AXI transfers as
 cacheable, increase IPU priority
In-Reply-To: <1369919399-24370-2-git-send-email-mpa@pengutronix.de>
References: <1369919399-24370-1-git-send-email-mpa@pengutronix.de>
 <1369919399-24370-2-git-send-email-mpa@pengutronix.de>
Message-ID: <51A8880E.4010600@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.05.2013 15:09, Markus Pargmann wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
>
> This is needed so that the IPU framebuffer scanout cannot be starved
> by VPU or GPU activity.
> The Freescale SabreLite and SabreSD boards seem to set this in the boot
> rom already, but the documented register reset values do not contain
> the necessary settings.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>   arch/arm/mach-imx/mach-imx6q.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 5536fd8..7bef242 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -29,6 +29,7 @@
>   #include <linux/regmap.h>
>   #include <linux/micrel_phy.h>
>   #include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>   #include <asm/hardware/cache-l2x0.h>
>   #include <asm/mach/arch.h>
>   #include <asm/mach/map.h>
> @@ -161,6 +162,36 @@ static void __init imx6q_usb_init(void)
>   	imx_anatop_usb_chrg_detect_disable();
>   }
>
> +static void __init imx6q_gpr_init(void)
> +{
> +	struct regmap *gpr;
> +
> +	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +	if (IS_ERR(gpr)) {
> +		pr_warn("failed to find fsl,imx6q-iomuxc-gpr regmap\n");
> +		return;
> +	}
> +
> +	/* Enable the cacheable attribute of VPU and IPU AXI transactions */
> +	regmap_update_bits(gpr, IOMUXC_GPR4, 0,
> +			IMX6Q_GPR4_VPU_WR_CACHE_SEL |
> +			IMX6Q_GPR4_VPU_RD_CACHE_SEL |
> +			IMX6Q_GPR4_VPU_P_WR_CACHE_VAL |
> +			IMX6Q_GPR4_VPU_P_RD_CACHE_VAL_MASK |
> +			IMX6Q_GPR4_IPU_WR_CACHE_CTL |
> +			IMX6Q_GPR4_IPU_RD_CACHE_CTL);

I have to admit that I don't understand much of this ;) But comparing 
this with the U-Boot settings

http://git.denx.de/?p=u-boot.git;a=blob;f=board/freescale/imx/ddr/mx6q_4x_mt41j128.cfg;h=d0f581582113647b06e5f7ab7f72207746613bc6;hb=refs/heads/master#l170

U-Boot additionally sets GPR4[31-28]:

/* enable AXI cache for VDOA/VPU/IPU */
DATA 4 0x020e0010 0xF00000CF

> +	/* Increase IPU read QoS priority */
> +	regmap_update_bits(gpr, IOMUXC_GPR6,
> +			IMX6Q_GPR6_IPU1_ID00_RD_QOS_MASK |
> +			IMX6Q_GPR6_IPU1_ID01_RD_QOS_MASK,
> +			(0xf << 16) | (0x7 << 20));
> +	regmap_update_bits(gpr, IOMUXC_GPR7,
> +			IMX6Q_GPR7_IPU2_ID00_RD_QOS_MASK |
> +			IMX6Q_GPR7_IPU2_ID01_RD_QOS_MASK,
> +			(0xf << 16) | (0x7 << 20));

and here U-Boot additionally touches GPR6/7[6-0]:

/* set IPU AXI-id0 Qos=0xf(bypass) AXI-id1 Qos=0x7 */
DATA 4 0x020e0018 0x007F007F
DATA 4 0x020e001c 0x007F007F

As mentioned above, I have no idea if/why this is necessary ;)

Best regards

Dirk
