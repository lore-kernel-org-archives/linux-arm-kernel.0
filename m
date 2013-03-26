From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 Mar 2013 19:47:58 +0100
Subject: [PATCH 2/2] ARM: kirkwood: extend the kirkwood i2s driver for DT
 usage
In-Reply-To: <20130326190539.494d96d9@armhf>
References: <20130326190539.494d96d9@armhf>
Message-ID: <20130326184758.GE631@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 07:05:39PM +0100, Jean-Francois Moine wrote:
> The kirkwood i2s driver is used without DT in the Kirkwood machine.
> This patch adds a DT compatible definition for use in other Marvell
> machines as the Armada 88AP510 (Dove).
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  .../devicetree/bindings/sound/kirkwood-i2s.txt     |   24 +++++++++++++
>  sound/soc/kirkwood/kirkwood-i2s.c                  |   36 ++++++++++++++++++--
>  2 files changed, 58 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/kirkwood-i2s.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/kirkwood-i2s.txt b/Documentation/devicetree/bindings/sound/kirkwood-i2s.txt
> new file mode 100644
> index 0000000..a089504
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/kirkwood-i2s.txt
> @@ -0,0 +1,24 @@
> +* Kirkwood I2S controller
> +
> +Required properties:
> +
> +- compatible: "marvell,kirkwood-i2s"

Hi Jean-Francois

We should maybe change this to marvell,mvebu-i2s. Kirkwood, Dove, and
370 have i2s. We know Dove and Kirkwood are compatible, and its likely
370 is also compatible. So a renaming will avoid confusion in the long
run. We can leave the filename of the driver alone for the moment,
since that is not an ABI.

> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: list of two irq numbers.
> +  The first irq is used for data flow and the second one is used for errors.
> +- clocks: phandle of the internal or external clock.
> +
> +Non-standard property:

There does not appear to be an i2s standard, so saying a property is
non-standard is a bit odd. I would just say Optional Properties, and
drop the (optional) below.

> +
> +- marvell,burst-size (optional): burst size which can be only 32 or 128.
> +  Default is 128.
> +
> +Example:
> +
> +i2s1: audio-controller at b4000 {
> +	compatible = "marvell,kirkwood-i2s";
> +	reg = <0xb4000 0x4000>;

I've not looked, but 0x4000 seem rather large for an register range.

> +	interrupts = <21>, <22>;
> +	clocks = <&gate_clk 13>;
> +};
> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> index afca1ec..dceb9f8 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -12,7 +12,6 @@
>  
>  #include <linux/init.h>
>  #include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/mbus.h>
> @@ -22,6 +21,8 @@
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
>  #include <linux/platform_data/asoc-kirkwood.h>
> +#include <linux/of.h>
> +
>  #include "kirkwood.h"
>  
>  #define DRV_NAME	"kirkwood-i2s"
> @@ -485,10 +486,30 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> +#ifdef CONFIG_OF
> +	if (!data) {
> +		struct device_node *np = pdev->dev.of_node;
> +		u32 val;
> +
> +		if (!np
> +		 || of_property_read_u32(np, "marvell,burst-size", &val)) {

It is normal to put the || on the previous line.

> +			val = 128;
> +		} else if (val != 32 && val != 128) {
> +			dev_warn(&pdev->dev,
> +				"'marvell,burst-size' can be only 32 or 128"
> +				 "- value forced to 128\n");

I would prefer to return EINVAL, or some other error code. Invalid DT
contents will get noticed faster that way.

> +			val = 128;
> +		}
> +		priv->burst = val;
> +	} else {
> +		priv->burst = data->burst;
> +	}
> +#else
>  	if (!data) {
>  		dev_err(&pdev->dev, "no platform data ?!\n");
>  		return -EINVAL;
>  	}
> +#endif
>  
>  	priv->burst = data->burst;
>  
> @@ -519,7 +540,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>  	priv->ctl_rec = KIRKWOOD_RECCTL_SIZE_24;
>  
>  	/* Select the burst size */
> -	if (data->burst == 32) {
> +	if (priv->burst == 32) {
>  		priv->ctl_play |= KIRKWOOD_PLAYCTL_BURST_32;
>  		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_32;
>  	} else {
> @@ -556,12 +577,23 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static struct of_device_id kirkwood_i2s_of_match[] = {
> +	{ .compatible = "marvell,kirkwood-i2s" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, kirkwood_i2s_of_match);
> +#endif
> +
>  static struct platform_driver kirkwood_i2s_driver = {
>  	.probe  = kirkwood_i2s_dev_probe,
>  	.remove = kirkwood_i2s_dev_remove,
>  	.driver = {
>  		.name = DRV_NAME,
>  		.owner = THIS_MODULE,
> +#ifdef CONFIG_OF
> +		.of_match_table??=??kirkwood_i2s_of_match,
> +#endif

You should be able to skip all these #ifdefs.

    Andrew
