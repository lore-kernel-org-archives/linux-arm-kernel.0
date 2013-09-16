From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Sep 2013 11:25:01 +0200
Subject: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
In-Reply-To: <1379319655-20210-4-git-send-email-xobs@kosagi.com>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
 <1379319655-20210-4-git-send-email-xobs@kosagi.com>
Message-ID: <20130916092501.GY30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 08:20:54AM +0000, Sean Cross wrote:
> Add support for the PCIe port present on the i.MX6 family of controllers.
> These use the Synopsis Designware core tied to their own PHY.
> 
> +static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
> +{
> +	u32 val;
> +	u32 max_iterations = 10;
> +	u32 wait_counter = 0;
> +
> +	do {
> +		val = readl(dbi_base + PCIE_PHY_STAT);
> +		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
> +		wait_counter++;
> +
> +		if (val == exp_val)
> +			return 0;
> +
> +		udelay(1);
> +	} while ((wait_counter < max_iterations) && (val != exp_val));

The test for val != exp_val is unnecessary now of course.

With this and the devm_clk_get Shawn mentioned:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
