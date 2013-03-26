From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 26 Mar 2013 20:37:34 +0100
Subject: [PATCH 2/2] ARM: kirkwood: extend the kirkwood i2s driver for
 DT usage
In-Reply-To: <20130326190539.494d96d9@armhf>
References: <20130326190539.494d96d9@armhf>
Message-ID: <5151F8FE.5040005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 07:05 PM, Jean-Francois Moine wrote:
> The kirkwood i2s driver is used without DT in the Kirkwood machine.
> This patch adds a DT compatible definition for use in other Marvell
> machines as the Armada 88AP510 (Dove).
>
> Signed-off-by: Jean-Francois Moine<moinejf@free.fr>
> ---
>   .../devicetree/bindings/sound/kirkwood-i2s.txt     |   24 +++++++++++++
>   sound/soc/kirkwood/kirkwood-i2s.c                  |   36 ++++++++++++++++++--
>   2 files changed, 58 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/sound/kirkwood-i2s.txt
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
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: list of two irq numbers.
> +  The first irq is used for data flow and the second one is used for errors.
> +- clocks: phandle of the internal or external clock.

Jean-Francois,

have you tested the driver with external clock set instead of internal clock?

I guess it will hang on access, as internal clock comes from a clock gate that
needs to be enabled prior use of i2s core. I suggest to have two clocks, 0 for
internal and optional (1) for external clock. You can get them with
of_clk_get(np, 0) and of_clk_get(np, 1) respectively.

> +
> +Non-standard property:
> +
> +- marvell,burst-size (optional): burst size which can be only 32 or 128.
> +  Default is 128.

Do we really want to expose this to the device node? If this is set to different
values for kirkwood, dove, and a370, we can still have it set by corresponding
compatible strings and match data. (See below)

> +
> +Example:
> +
> +i2s1: audio-controller at b4000 {
> +	compatible = "marvell,kirkwood-i2s";
> +	reg =<0xb4000 0x4000>;
> +	interrupts =<21>,<22>;
> +	clocks =<&gate_clk 13>;
> +};
> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> index afca1ec..dceb9f8 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -12,7 +12,6 @@
>
>   #include<linux/init.h>
>   #include<linux/module.h>
> -#include<linux/platform_device.h>
>   #include<linux/io.h>
>   #include<linux/slab.h>
>   #include<linux/mbus.h>
> @@ -22,6 +21,8 @@
>   #include<sound/pcm_params.h>
>   #include<sound/soc.h>
>   #include<linux/platform_data/asoc-kirkwood.h>
> +#include<linux/of.h>
> +
>   #include "kirkwood.h"
>
>   #define DRV_NAME	"kirkwood-i2s"
> @@ -485,10 +486,30 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>   		return -ENXIO;
>   	}
>
> +#ifdef CONFIG_OF
> +	if (!data) {

You can remove the #ifdef and check for pdev->dev.of_node instead. All of_xx functions
should have no-op counterparts if CONFIG_OF is not set.

> +		struct device_node *np = pdev->dev.of_node;
> +		u32 val;
> +
> +		if (!np
> +		 || of_property_read_u32(np, "marvell,burst-size",&val)) {
> +			val = 128;
> +		} else if (val != 32&&  val != 128) {
> +			dev_warn(&pdev->dev,
> +				"'marvell,burst-size' can be only 32 or 128"
> +				 "- value forced to 128\n");
> +			val = 128;
> +		}

If you initialize val with 128 you can just use of_property_read as it will
only modify val on success. You will have to check for valid values of course later on.

> +		priv->burst = val;
> +	} else {
> +		priv->burst = data->burst;
> +	}
> +#else
>   	if (!data) {
>   		dev_err(&pdev->dev, "no platform data ?!\n");
>   		return -EINVAL;
>   	}
> +#endif
>
>   	priv->burst = data->burst;
>
> @@ -519,7 +540,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>   	priv->ctl_rec = KIRKWOOD_RECCTL_SIZE_24;
>
>   	/* Select the burst size */
> -	if (data->burst == 32) {
> +	if (priv->burst == 32) {
>   		priv->ctl_play |= KIRKWOOD_PLAYCTL_BURST_32;
>   		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_32;
>   	} else {
> @@ -556,12 +577,23 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#ifdef CONFIG_OF
> +static struct of_device_id kirkwood_i2s_of_match[] = {
> +	{ .compatible = "marvell,kirkwood-i2s" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, kirkwood_i2s_of_match);
> +#endif

If there is SoC specific data (e.g. burst_size) you can use
.data to pass it according to the compatible string:

static struct of_device_id kirkwood_i2s_of_match[] = {
	{ .compatible = "marvell,kirkwood-i2s", .data = (void *)32 },
	{ .compatible = "marvell,dove-i2s", .data = (void *)128 },
	{ .compatible = "marvell,armada-370-i2s", .data = (void *)128 },
	{ }
};

Or have some SoC specific struct i2s_soc_data passed with .data,
if there is more than one value you need to pass.

> +
>   static struct platform_driver kirkwood_i2s_driver = {
>   	.probe  = kirkwood_i2s_dev_probe,
>   	.remove = kirkwood_i2s_dev_remove,
>   	.driver = {
>   		.name = DRV_NAME,
>   		.owner = THIS_MODULE,
> +#ifdef CONFIG_OF
> +		.of_match_table = kirkwood_i2s_of_match,
> +#endif

Remove the $ifdef and have .of_match_table = of_match_ptr(kirkwood_i2s_of_match),

>   	},
>   };
>

Sebastian
