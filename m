From: atull@kernel.org (Alan Tull)
Date: Mon, 12 Dec 2016 10:01:30 -0600 (CST)
Subject: [PATCH 2/2] FPGA: Add TS-7300 FPGA manager
In-Reply-To: <20161211221750.27743-3-f.fainelli@gmail.com>
References: <20161211221750.27743-1-f.fainelli@gmail.com>
 <20161211221750.27743-3-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.10.1612120951520.3310@atull-730U3E-740U3E>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Dec 2016, Florian Fainelli wrote:

> Add support for loading bitstreams on the Altera Cyclone II FPGA
> populated on the TS-7300 board. This is done through the configuration
> and data registers offered through a memory interface between the EP93xx
> SoC and the FPGA.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Hi Florain,

Thanks for submitting!

How specific is this to the tx7300 board?

I'm unclear about the programming method here.  Are these registers
exposed by the EP93xx?  Is it possible that another cpu could access
these two registers to configure the cyclone ii?  Is this passive
serial?

Please cc linux-fpga at vger.kernel.org for the next version.

Other comments below...

> ---
>  drivers/fpga/Kconfig       |   7 ++
>  drivers/fpga/Makefile      |   1 +
>  drivers/fpga/ts73xx-fpga.c | 165 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 173 insertions(+)
>  create mode 100644 drivers/fpga/ts73xx-fpga.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index cd84934774cc..109625707ef0 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -26,6 +26,13 @@ config FPGA_MGR_ZYNQ_FPGA
>  	help
>  	  FPGA manager driver support for Xilinx Zynq FPGAs.
>  
> +config FPGA_MGR_TS73XX
> +	tristate "Technologic Systems TS-73xx SBC FPGA Manager"
> +	depends on ARCH_EP93XX && MACH_TS72XX
> +	help
> +	  FPGA manager driver support for the Altera Cyclone II FPGA
> +	  present on the TS-73xx SBC boards.
> +
>  endif # FPGA
>  
>  endmenu
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 8d83fc6b1613..5d51265cc1b4 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_FPGA)			+= fpga-mgr.o
>  # FPGA Manager Drivers
>  obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
> +obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
> new file mode 100644
> index 000000000000..2b3d5d668dfc
> --- /dev/null
> +++ b/drivers/fpga/ts73xx-fpga.c
> @@ -0,0 +1,165 @@
> +/*
> + * Technologic Systems TS-73xx SBC FPGA loader
> + *
> + * Copyright (C) 2016 Florian Fainelli <f.fainelli@gmail.com>
> + *
> + * FPGA Manager Driver for the on-board Altera Cyclone II FPGA found on
> + * TS-7300, heavily based on load_fpga.c in their vendor tree.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/bitrev.h>
> +#include <linux/fpga/fpga-mgr.h>
> +
> +#define TS73XX_FPGA_DATA_REG	0
> +#define TS73XX_FPGA_CONFIG_REG	1
> +
> +struct ts73xx_fpga_priv {
> +	void __iomem	*io_base;
> +	struct device	*dev;
> +};
> +
> +static enum fpga_mgr_states ts73xx_fpga_state(struct fpga_manager *mgr)
> +{
> +	return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static int ts73xx_fpga_write_init(struct fpga_manager *mgr, u32 flags,
> +				  const char *buf, size_t count)
> +{
> +	struct ts73xx_fpga_priv *priv = mgr->priv;
> +
> +	/* Reset the FPGA */
> +	writeb(0, priv->io_base + TS73XX_FPGA_CONFIG_REG);
> +	udelay(30);
> +	writeb(0x2, priv->io_base + TS73XX_FPGA_CONFIG_REG);
> +	udelay(80);

Could these udelay values be macros?

> +
> +	return 0;
> +}
> +
> +static inline int ts73xx_fpga_can_write(struct ts73xx_fpga_priv *priv)
> +{
> +	unsigned int timeout = 1000;

Another macro?

> +	u8 reg;
> +
> +	while (timeout--) {
> +		reg = readb(priv->io_base + TS73XX_FPGA_CONFIG_REG);
> +		if (!(reg & 0x1))

Macro to tell us what the bit name of this bit.

> +			return 0;
> +		cpu_relax();
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int ts73xx_fpga_write(struct fpga_manager *mgr, const char *buf,
> +			     size_t count)
> +{
> +	struct ts73xx_fpga_priv *priv = mgr->priv;
> +	size_t i = 0;
> +	int ret;
> +	u8 reg;
> +
> +	while (count--) {
> +		ret = ts73xx_fpga_can_write(priv);
> +		if (ret < 0)
> +			return ret;
> +
> +		writeb(buf[i], priv->io_base + TS73XX_FPGA_DATA_REG);
> +		i++;
> +	}
> +
> +	usleep_range(1000, 2000);
> +	reg = readb(priv->io_base + TS73XX_FPGA_CONFIG_REG);
> +	reg |= 0x8;

A macro for this bit.

> +	writeb(reg, priv->io_base + TS73XX_FPGA_CONFIG_REG);
> +	usleep_range(1000, 2000);
> +
> +	reg = readb(priv->io_base + TS73XX_FPGA_CONFIG_REG);
> +	reg &= ~0x8;
> +	writeb(reg, priv->io_base + TS73XX_FPGA_CONFIG_REG);
> +
> +	return 0;
> +}
> +
> +static int ts73xx_fpga_write_complete(struct fpga_manager *mgr, u32 flags)
> +{
> +	struct ts73xx_fpga_priv *priv = mgr->priv;
> +	u8 reg;
> +
> +	reg = readb(priv->io_base + TS73XX_FPGA_CONFIG_REG);
> +	if ((reg & 0x4) != 0x4)

Another macro...

> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static const struct fpga_manager_ops ts73xx_fpga_ops = {
> +	.state		= ts73xx_fpga_state,
> +	.write_init	= ts73xx_fpga_write_init,
> +	.write		= ts73xx_fpga_write,
> +	.write_complete	= ts73xx_fpga_write_complete,
> +};
> +
> +static int ts73xx_fpga_probe(struct platform_device *pdev)
> +{
> +	struct device *kdev = &pdev->dev;
> +	struct ts73xx_fpga_priv *priv;
> +	struct fpga_manager *mgr;
> +	struct resource *res;
> +	int err;
> +
> +	priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = kdev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->io_base = devm_ioremap_resource(kdev, res);
> +	if (IS_ERR(priv->io_base))
> +		return PTR_ERR(priv->io_base);
> +
> +	err = fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
> +				&ts73xx_fpga_ops, priv);
> +	if (err) {
> +		dev_err(kdev, "failed to register FPGA manager\n");
> +		return err;
> +	}
> +
> +	return err;
> +}
> +
> +static int ts73xx_fpga_remove(struct platform_device *pdev)
> +{
> +	fpga_mgr_unregister(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ts73xx_fpga_driver = {
> +	.driver	= {
> +		.name	= "ts73xx-fpga-mgr",
> +	},
> +	.probe	= ts73xx_fpga_probe,
> +	.remove	= ts73xx_fpga_remove,
> +};
> +module_platform_driver(ts73xx_fpga_driver);
> +
> +MODULE_AUTHOR("Florian Fainelli <f.fainelli@gmail.com>");
> +MODULE_DESCRIPTION("TS-73xx FPGA Manager driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.9.3
> 
> 
