From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 Jan 2014 13:10:16 +0100
Subject: [PATCH V4 1/6] ARM: dts: imx6q: add common compatible name for
 reused modules
In-Reply-To: <1389614031-7253-1-git-send-email-b20788@freescale.com>
References: <1389614031-7253-1-git-send-email-b20788@freescale.com>
Message-ID: <20140113121016.GJ16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 07:53:46PM +0800, Anson Huang wrote:
> As some modules are common for all i.MX6 SOCs, to avoid
> checking cpu type for drivers that needs them, just add a
> new compatible name for them.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q.dtsi   |    2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 021e0cb..5bc79c7 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -91,7 +91,7 @@
>  			};
>  
>  			iomuxc: iomuxc at 020e0000 {
> -				compatible = "fsl,imx6q-iomuxc";
> +				compatible = "fsl,imx6q-iomuxc", "fsl,iomuxc";
>  
>  				ipu2 {
>  					pinctrl_ipu2_1: ipu2grp-1 {
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 8a86502..cb9129b 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -622,7 +622,7 @@
>  			};
>  
>  			src: src at 020d8000 {
> -				compatible = "fsl,imx6q-src", "fsl,imx51-src";
> +				compatible = "fsl,imx6q-src", "fsl,imx51-src", "fsl,src";
>  				reg = <0x020d8000 0x4000>;
>  				interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>,
>  					     <0 96 IRQ_TYPE_LEVEL_HIGH>;
> @@ -630,7 +630,7 @@
>  			};
>  
>  			gpc: gpc at 020dc000 {
> -				compatible = "fsl,imx6q-gpc";
> +				compatible = "fsl,imx6q-gpc", "fsl,gpc";
>  				reg = <0x020dc000 0x4000>;
>  				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>,
>  					     <0 90 IRQ_TYPE_LEVEL_HIGH>;
> @@ -840,7 +840,7 @@
>  			};
>  
>  			mmdc0: mmdc at 021b0000 { /* MMDC0 */
> -				compatible = "fsl,imx6q-mmdc";
> +				compatible = "fsl,imx6q-mmdc", "fsl,mmdc";

This is not nice. Here you introduce a fsl,mmdc compatible claiming all
mmdc are compatible to each other and in the driver code you have:

static const u32 imx6q_mmdc_io_dsm_offset[]
static const u32 imx6dl_mmdc_io_dsm_offset[]

which proves they are *not* compatible.

You do this just to share a

imx6_pm_get_base(&pm_info->mmdc_base, "fsl,mmdc");

across the different i.MX6 SoCs.

You can sanitize this by introducing a SoC struct which you populate
differently for the SoCs

static pm_soc_data imx6q_data {
	.mmdc_compat = "fsl,imx6q-mmdc",
};

And by putting cpu_type, mmdc_io_num and others in this struct you can
also remove the if(cpu_is_x()) else if (cpu_is_y()) else...

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
