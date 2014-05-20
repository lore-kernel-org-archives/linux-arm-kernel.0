From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 May 2014 11:03:12 +0200
Subject: [PATCH] ARM: imx6: init enet MAC address
In-Reply-To: <1400566266-22746-1-git-send-email-b38611@freescale.com>
References: <1400566266-22746-1-git-send-email-b38611@freescale.com>
Message-ID: <20140520090312.GH5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 02:11:06PM +0800, Fugang Duan wrote:
> Enet get MAC address order:
> From module parameters or kernel command line -> device tree ->
> pfuse -> mac registers set by bootloader -> random mac address.
> 
> When there have no "fec.macaddr" parameters set in kernel command
> line, enet driver get MAC address from device tree. And then if
> the MAC address set in device tree and is valid, enet driver get
> MAC address from device tree. Otherwise, enet get MAC address from
> pfuse. So, in the condition, update the MAC address (read from pfuse)
> to device tree.
> 
> +#define OCOTP_MACn(n)		(0x00000620 + (n) * 0x10)
> +#define IMX_MAX_ENET_NUM	2
> +void __init imx6_enet_mac_init(const char *compatible)

static

> +{
> +	struct device_node *ocotp_np, *enet_np, *from = NULL;
> +	void __iomem *base;
> +	struct property *newmac;
> +	u32 macaddr0_low;
> +	u32 macaddr0_high = 0;
> +	u32 macaddr1_high = 0;
> +	u8 *macaddr;
> +	int i;
> +
> +	for (i = 0; i < IMX_MAX_ENET_NUM; i++) {
> +		enet_np = of_find_compatible_node(from, NULL, compatible);
> +		if (!enet_np)
> +			return;
> +
> +		from = enet_np;
> +
> +		if (of_get_mac_address(enet_np))
> +			goto put_enet_node;
> +
> +		ocotp_np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
> +		if (!ocotp_np) {
> +			pr_warn("failed to find ocotp node\n");
> +			goto put_enet_node;
> +		}
> +
> +		base = of_iomap(ocotp_np, 0);
> +		if (!base) {
> +			pr_warn("failed to map ocotp\n");
> +			goto put_ocotp_node;
> +		}

Move this outside the loop.

> +
> +		macaddr0_low = readl_relaxed(base + OCOTP_MACn(1));
> +		if (i)
> +			macaddr1_high = readl_relaxed(base + OCOTP_MACn(2));
> +		else
> +			macaddr0_high = readl_relaxed(base + OCOTP_MACn(0));

You go over these register reads two times and read the very same
registers two times. Argh! Could please look at your code before posting
it?

> +
> +		newmac = kzalloc(sizeof(*newmac) + 6, GFP_KERNEL);
> +		if (!newmac)
> +			goto put_ocotp_node;
> +
> +		newmac->value = newmac + 1;
> +		newmac->length = 6;
> +		newmac->name = kstrdup("local-mac-address", GFP_KERNEL);
> +		if (!newmac->name) {
> +			kfree(newmac);
> +			goto put_ocotp_node;
> +		}
> +
> +		macaddr = newmac->value;
> +		if (i) {
> +			macaddr[0] = (macaddr1_high >> 24) & 0xff;
> +			macaddr[1] = (macaddr1_high >> 16) & 0xff;
> +			macaddr[2] = (macaddr1_high >> 8) & 0xff;
> +			macaddr[3] = macaddr1_high & 0xff;
> +			macaddr[4] = (macaddr0_low >> 24) & 0xff;
> +			macaddr[5] = (macaddr0_low >> 16) & 0xff;
> +		} else {
> +			macaddr[0] = (macaddr0_low >> 8) & 0xff;
> +			macaddr[1] = macaddr0_low & 0xff;
> +			macaddr[2] = (macaddr0_high >> 24) & 0xff;
> +			macaddr[3] = (macaddr0_high >> 16) & 0xff;
> +			macaddr[4] = (macaddr0_high >> 8) & 0xff;
> +			macaddr[5] = macaddr0_high & 0xff;
> +		}

It makes no sense to have a IMX_MAX_ENET_NUM define when the code
assumes that the only valid value is 2.

All this is probably far more readable and less fishy when you move the
fixup of a single enet device to a extra function which you call from
the loop.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
