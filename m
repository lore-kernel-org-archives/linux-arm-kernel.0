From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 19 Oct 2013 13:04:59 +0200
Subject: [Patch v2][ 08/37] video: mx3fb: Add device tree suport.
In-Reply-To: <1382022155-21954-9-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-9-git-send-email-denis@eukrea.com>
Message-ID: <20131019110459.GM18477@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:02 Thu 17 Oct     , Denis Carikli wrote:
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev at vger.kernel.org
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../devicetree/bindings/video/fsl,mx3-fb.txt       |   52 ++++++++
>  drivers/video/Kconfig                              |    2 +
>  drivers/video/mx3fb.c                              |  133 +++++++++++++++++---
>  3 files changed, 171 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
> new file mode 100644
> index 0000000..ae0b343
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
> @@ -0,0 +1,52 @@
> +Freescale mx3 Framebuffer
> +
> +This framebuffer driver supports the imx31 and imx35 devices.
> +
> +Required properties:
> +- compatible : Must be "fsl,mx3-fb".
> +- reg : Should contain 1 register ranges(address and length).
> +- dmas : Phandle to the ipu dma node as described in
> +	Documentation/devicetree/bindings/dma/dma.txt
> +- dma-names : Must be "tx".
> +- clocks : Phandle to the ipu source clock.
> +- display: Phandle to a display node as described in
> +	Documentation/devicetree/bindings/video/display-timing.txt
> +	Additional, the display node has to define properties:
> +	- bits-per-pixel: lcd panel bit-depth.
> +
> +Optional properties:
> +- ipu-disp-format: could be "rgb666", "rgb565", or "rgb888".
> +  If not specified defaults to "rgb666".
> +
> +Example:
> +
> +	lcdc: mx3fb at 53fc00b4 {
> +		compatible = "fsl,mx3-fb";
> +		reg = <0x53fc00b4 0x0b>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcdc_1>;
> +		clocks = <&clks 55>;
> +		dmas = <&ipu 14>;
> +		dma-names = "tx";
> +	};
> +
> +	...
> +
> +	cmo_qvga: display {
> +		model = "CMO-QVGA";
> +		bits-per-pixel = <16>;
> +		native-mode = <&qvga_timings>;
> +		display-timings {
> +			qvga_timings: 320x240 {
> +				clock-frequency = <6500000>;
> +				hactive = <320>;
> +				vactive = <240>;
> +				hback-porch = <30>;
> +				hfront-porch = <38>;
> +				vback-porch = <20>;
> +				vfront-porch = <3>;
> +				hsync-len = <15>;
> +				vsync-len = <4>;
> +			};
> +		};
> +	};
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 14317b7..2a638df 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2359,6 +2359,8 @@ config FB_MX3
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> +	select VIDEOMODE_HELPERS
> +	select FB_MODE_HELPERS
>  	default y
>  	help
>  	  This is a framebuffer device for the i.MX31 LCD Controller. So
> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> index 37704da..8683dda 100644
> --- a/drivers/video/mx3fb.c
> +++ b/drivers/video/mx3fb.c
> @@ -32,6 +32,8 @@
>  #include <linux/platform_data/dma-imx.h>
>  #include <linux/platform_data/video-mx3fb.h>
>  
> +#include <video/of_display_timing.h>
> +
>  #include <asm/io.h>
>  #include <asm/uaccess.h>
>  
> @@ -759,11 +761,13 @@ static int __set_par(struct fb_info *fbi, bool lock)
>  			sig_cfg.Hsync_pol = true;
>  		if (fbi->var.sync & FB_SYNC_VERT_HIGH_ACT)
>  			sig_cfg.Vsync_pol = true;
> -		if (fbi->var.sync & FB_SYNC_CLK_INVERT)
> +		if ((fbi->var.sync & FB_SYNC_CLK_INVERT) ||
> +		    (fbi->var.sync & FB_SYNC_PIXDAT_HIGH_ACT))
>  			sig_cfg.clk_pol = true;
>  		if (fbi->var.sync & FB_SYNC_DATA_INVERT)
>  			sig_cfg.data_pol = true;
> -		if (fbi->var.sync & FB_SYNC_OE_ACT_HIGH)
> +		if ((fbi->var.sync & FB_SYNC_OE_ACT_HIGH) ||
> +		    (fbi->var.sync & FB_SYNC_DE_HIGH_ACT))
>  			sig_cfg.enable_pol = true;
>  		if (fbi->var.sync & FB_SYNC_CLK_IDLE_EN)
>  			sig_cfg.clkidle_en = true;
> @@ -1392,21 +1396,63 @@ static struct fb_info *mx3fb_init_fbinfo(struct device *dev, struct fb_ops *ops)
>  	return fbi;
>  }
>  
> +static int match_dt_disp_data(const char *property)
> +{
> +	if (!strcmp("rgb666", property))
> +		return IPU_DISP_DATA_MAPPING_RGB666;
> +	else if (!strcmp("rgb565", property))
> +		return IPU_DISP_DATA_MAPPING_RGB565;
> +	else if (!strcmp("rgb888", property))
> +		return IPU_DISP_DATA_MAPPING_RGB888;
> +	else
> +		return -EINVAL;
> +}

mode parsing to be a geneirc API

otherwise looks good

Best Regards,
J.
