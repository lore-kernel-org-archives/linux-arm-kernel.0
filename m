From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 19 May 2013 09:05:38 +0200
Subject: [PATCH] net: dm9000: Allow instantiation using device tree
In-Reply-To: <1368918194-24030-1-git-send-email-tomasz.figa@gmail.com>
References: <1368918194-24030-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130519070538.GX32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Sun, May 19, 2013 at 01:03:14AM +0200, Tomasz Figa wrote:
> This patch adds Device Tree support to dm9000 driver.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  .../devicetree/bindings/net/davicom-dm9000.txt     | 27 ++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  drivers/net/ethernet/davicom/dm9000.c              | 60 ++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/davicom-dm9000.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/davicom-dm9000.txt b/Documentation/devicetree/bindings/net/davicom-dm9000.txt
> new file mode 100644
> index 0000000..d2902db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/davicom-dm9000.txt
> @@ -0,0 +1,27 @@
> +Davicom DM9000 Fast Ethernet controller
> +
> +Required properties:
> +- compatible = "davicom,dm9000";
> +- reg : physical addresses and sizes of registers, must contain 2 entries:
> +    first entry : address register,
> +    second entry : address register.
> +- interrupt-parent : interrupt controller to which the device is connected
> +- interrupts : interrupt specifier specific to interrupt controller
> +
> +Optional properties:
> +- local-mac-address : A bytestring of 6 bytes specifying Ethernet MAC address
> +    to use (from firmware or bootloader)
> +- davicom,no-eeprom : Configuration EEPROM is not available
> +- davicom,ext-phy : Use external PHY
> +- davicom,simple-phy : Use NSR to find LinkStatus

Do we really need to expose this simple-phy property? Looking at the
drvier code this more looks like a work around shortcomings of the
driver code rather than something really necessary.

> +#ifdef CONFIG_OF
> +static struct dm9000_plat_data *dm9000_parse_dt(struct device *dev)
> +{
> +	struct dm9000_plat_data *pdata;
> +	struct device_node *np = dev->of_node;
> +	const void *prop;
> +	int len;
> +
> +	if (!np)
> +		return NULL;

You should be able to kill the ifdef around this function by doing

	if (!IS_ENABLED(CONFIG_OF) || !np)
		return NULL;

> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(dev, "failed to allocate platform data struct\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	if (of_find_property(np, "davicom,ext-phy", NULL))
> +		pdata->flags |= DM9000_PLATF_EXT_PHY;
> +	if (of_find_property(np, "davicom,no-eeprom", NULL))
> +		pdata->flags |= DM9000_PLATF_NO_EEPROM;
> +	if (of_find_property(np, "davicom,simple-phy", NULL))
> +		pdata->flags |= DM9000_PLATF_SIMPLE_PHY;
> +
> +	prop = of_get_property(np, "local-mac-address", &len);
> +	if (!prop)
> +		return pdata;

I think you should use of_get_mac_address() here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
