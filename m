From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Feb 2012 14:02:56 +0000
Subject: [PATCH 2/2] misc: c2c: Add C2C(Chip to Chip) device driver for
 EXYNOS
In-Reply-To: <000601cce315$18c82510$4a586f30$%lee@samsung.com>
References: <000601cce315$18c82510$4a586f30$%lee@samsung.com>
Message-ID: <20120204140256.GV889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 04, 2012 at 05:15:03PM +0900, Kisang Lee wrote:
> Cc: Arnd Bergmann <arnd <at> arndb.de>
> Cc: Greg Kroah-Hartman <greg <at> kroah.com>
> 
> Signed-off-by: Kisang Lee <kisang80.lee@samsung.com>

What follows is a quick review of this driver.  I think there's quite
a number of issues which need to be fixed before this driver is ready,
some of them are rather serious.  Please take a look and try to address
as many of these comments as possible.

Thanks.

> ---
>  drivers/misc/Kconfig           |    1 +
>  drivers/misc/Makefile          |    1 +
>  drivers/misc/c2c/Kconfig       |   10 +
>  drivers/misc/c2c/Makefile      |    5 +
>  drivers/misc/c2c/samsung-c2c.c |  500 ++++++++++++++++++++++++++++++++++++++++
>  drivers/misc/c2c/samsung-c2c.h |  300 ++++++++++++++++++++++++
>  6 files changed, 817 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/misc/c2c/Kconfig
>  create mode 100644 drivers/misc/c2c/Makefile
>  create mode 100644 drivers/misc/c2c/samsung-c2c.c
>  create mode 100644 drivers/misc/c2c/samsung-c2c.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 6a1a092..2ec3f48 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -516,5 +516,6 @@ source "drivers/misc/ti-st/Kconfig"
>  source "drivers/misc/lis3lv02d/Kconfig"
>  source "drivers/misc/carma/Kconfig"
>  source "drivers/misc/altera-stapl/Kconfig"
> +source "drivers/misc/c2c/Kconfig"
>  
>  endif # MISC_DEVICES
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 3e1d801..bd96ed7 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -49,3 +49,4 @@ obj-y				+= carma/
>  obj-$(CONFIG_USB_SWITCH_FSA9480) += fsa9480.o
>  obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
>  obj-$(CONFIG_MAX8997_MUIC)	+= max8997-muic.o
> +obj-$(CONFIG_SAMSUNG_C2C)	+= c2c/
> diff --git a/drivers/misc/c2c/Kconfig b/drivers/misc/c2c/Kconfig
> new file mode 100644
> index 0000000..cd13078
> --- /dev/null
> +++ b/drivers/misc/c2c/Kconfig
> @@ -0,0 +1,10 @@
> +#
> +# C2C(Chip to Chip) Device
> +#
> +
> +config SAMSUNG_C2C
> +	tristate "C2C Support"
> +	depends on SOC_EXYNOS4212 || SOC_EXYNOS5250
> +	default n
> +	help
> +	  It is for supporting C2C driver.
> diff --git a/drivers/misc/c2c/Makefile b/drivers/misc/c2c/Makefile
> new file mode 100644
> index 0000000..1af7d3a
> --- /dev/null
> +++ b/drivers/misc/c2c/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for C2C(Chip to Chip) device
> +#
> +
> +obj-$(CONFIG_SAMSUNG_C2C)	+= samsung-c2c.o
> diff --git a/drivers/misc/c2c/samsung-c2c.c b/drivers/misc/c2c/samsung-c2c.c
> new file mode 100644
> index 0000000..ee08ac6
> --- /dev/null
> +++ b/drivers/misc/c2c/samsung-c2c.c
> @@ -0,0 +1,500 @@
> +/*
> + * Samsung C2C driver
> + *
> + * Copyright (C) 2011 Samsung Electronics Co.Ltd
> + * Author: Kisang Lee <kisang80.lee@samsung.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/input.h>

I can find nothing related to the input layer in this file - is this
header required?

> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>

I can find nothing which declares a misc_device in this file - is this
header required?

> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/sysfs.h>
> +#include <asm/mach-types.h>

You appear to use nothing from this header, please remove it.  Drivers
should not depend on the type of platform they're running on.

> +
> +#include <mach/c2c.h>
> +#include <mach/regs-c2c.h>
> +#include <plat/cpu.h>

Is plat/cpu.h necessary?

> +
> +#include "samsung-c2c.h"
> +
> +void c2c_reset_ops(void)
> +{
> +	u32 set_clk = 0;
> +
> +	if (c2c_con.opp_mode == C2C_OPP100)
> +		set_clk = c2c_con.clk_opp100;
> +	else if (c2c_con.opp_mode == C2C_OPP50)
> +		set_clk = c2c_con.clk_opp50;
> +	else if (c2c_con.opp_mode == C2C_OPP25)
> +		set_clk = c2c_con.clk_opp25;
> +
> +	dev_info(c2c_con.c2c_dev, "c2c_reset_ops()\n");
> +	clk_set_rate(c2c_con.c2c_sclk, (set_clk + 1) * MHZ);
> +	c2c_set_func_clk(set_clk);
> +
> +	/* C2C block reset */
> +	c2c_set_reset(C2C_CLEAR);
> +	c2c_set_reset(C2C_SET);
> +
> +	c2c_set_clock_gating(C2C_CLEAR);
> +	c2c_writel(c2c_con.retention_reg, EXYNOS_C2C_IRQ_EN_SET1);
> +	c2c_writel(set_clk, EXYNOS_C2C_FCLK_FREQ);
> +	c2c_writel(set_clk, EXYNOS_C2C_RX_MAX_FREQ);
> +	c2c_set_clock_gating(C2C_SET);
> +}
> +
> +static ssize_t c2c_ctrl_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	int ret = 0;
> +	ret = sprintf(buf, "C2C State");
> +	ret += sprintf(&buf[ret], "SysReg : 0x%x\n",
> +			readl(c2c_con.c2c_sysreg));
> +	ret += sprintf(&buf[ret], "Port Config : 0x%x\n",
> +			c2c_readl(EXYNOS_C2C_PORTCONFIG));
> +	ret += sprintf(&buf[ret], "FCLK_FREQ : %d\n",
> +			c2c_readl(EXYNOS_C2C_FCLK_FREQ));
> +	ret += sprintf(&buf[ret], "RX_MAX_FREQ : %d\n",
> +			c2c_readl(EXYNOS_C2C_RX_MAX_FREQ));
> +	ret += sprintf(&buf[ret], "IRQ_EN_SET1 : 0x%x\n",
> +			c2c_readl(EXYNOS_C2C_IRQ_EN_SET1));
> +	ret += sprintf(&buf[ret], "Get C2C sclk rate : %ld\n",
> +			clk_get_rate(c2c_con.c2c_sclk));
> +	ret += sprintf(&buf[ret], "Get C2C aclk rate : %ld\n",
> +			clk_get_rate(c2c_con.c2c_aclk));
> +
> +	return ret;
> +}
> +
> +static ssize_t c2c_ctrl_store(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	int ops_num, opp_val, req_clk;
> +	sscanf(buf, "%d", &ops_num);

What if sscanf fails?

> +
> +	switch (ops_num) {
> +	case 1:
> +		c2c_reset_ops();
> +		break;
> +	case 2:
> +	case 3:
> +	case 4:
> +		opp_val = ops_num - 1;
> +		req_clk = 0;
> +		dev_info(c2c_con.c2c_dev, "Set current OPP mode (%d)\n",
> +			opp_val);
> +
> +		if (opp_val == C2C_OPP100)
> +			req_clk = c2c_con.clk_opp100;
> +		else if (opp_val == C2C_OPP50)
> +			req_clk = c2c_con.clk_opp50;
> +		else if (opp_val == C2C_OPP25)
> +			req_clk = c2c_con.clk_opp25;
> +
> +		if (opp_val == 0 || req_clk == 1) {
> +			dev_info(c2c_con.c2c_dev,
> +				"This mode is not reserved in OPP mode.\n");
> +		} else {
> +			c2c_set_clock_gating(C2C_CLEAR);
> +			if (c2c_con.opp_mode > opp_val) {
> +				/* increase case */
> +				clk_set_rate(c2c_con.c2c_sclk,
> +					(req_clk + 1) * MHZ);
> +				c2c_writel(req_clk, EXYNOS_C2C_FCLK_FREQ);
> +				c2c_set_func_clk(req_clk);
> +				c2c_writel(req_clk, EXYNOS_C2C_RX_MAX_FREQ);
> +			} else if (c2c_con.opp_mode < opp_val) {
> +				/* decrease case */
> +				c2c_writel(req_clk, EXYNOS_C2C_RX_MAX_FREQ);
> +				clk_set_rate(c2c_con.c2c_sclk,
> +					(req_clk + 1) * MHZ);
> +				c2c_writel(req_clk, EXYNOS_C2C_FCLK_FREQ);
> +				c2c_set_func_clk(req_clk);
> +			} else{
> +				dev_info(c2c_con.c2c_dev,
> +					"Requested same OPP mode\n");
> +			}
> +			c2c_con.opp_mode = opp_val;
> +			c2c_set_clock_gating(C2C_SET);
> +		}
> +
> +		dev_info(c2c_con.c2c_dev, "Get C2C sclk rate : %ld\n",
> +					clk_get_rate(c2c_con.c2c_sclk));
> +		dev_info(c2c_con.c2c_dev, "Get C2C aclk rate : %ld\n",
> +					clk_get_rate(c2c_con.c2c_aclk));
> +		break;
> +	default:
> +		dev_info(c2c_con.c2c_dev, "---C2C Operation Number---\n");
> +		dev_info(c2c_con.c2c_dev, "1. C2C Reset\n");
> +		dev_info(c2c_con.c2c_dev, "2. Set OPP25\n");
> +		dev_info(c2c_con.c2c_dev, "3. Set OPP50\n");
> +		dev_info(c2c_con.c2c_dev, "4. Set OPP100\n");
> +	}
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(c2c_ctrl, 0644, c2c_ctrl_show, c2c_ctrl_store);
> +
> +static int c2c_set_sharedmem(enum c2c_shrdmem_size size, u32 addr)
> +{
> +	dev_info(c2c_con.c2c_dev, "Set BaseAddr(0x%x) and Size(%d)\n",
> +				addr, 1 << (2 + size));
> +
> +	/* Set DRAM Base Addr & Size */
> +	c2c_set_shdmem_size(size);
> +	c2c_set_base_addr((addr >> 22));
> +
> +	return 0;
> +}
> +
> +static void c2c_set_interrupt(u32 genio_num, enum c2c_interrupt set_int)
> +{

Is this function ever called with anything other than C2C_INT_HIGH ?

> +	u32 cur_int_reg, cur_lev_reg;
> +
> +	cur_int_reg = c2c_readl(EXYNOS_C2C_GENO_INT);
> +	cur_lev_reg = c2c_readl(EXYNOS_C2C_GENO_LEVEL);
> +
> +	switch (set_int) {
> +	case C2C_INT_TOGGLE:
> +		cur_int_reg &= ~(0x1 << genio_num);
> +		c2c_writel(cur_int_reg, EXYNOS_C2C_GENO_INT);
> +		break;
> +	case C2C_INT_HIGH:
> +		cur_int_reg |= (0x1 << genio_num);
> +		cur_lev_reg |= (0x1 << genio_num);
> +		c2c_writel(cur_int_reg, EXYNOS_C2C_GENO_INT);
> +		c2c_writel(cur_lev_reg, EXYNOS_C2C_GENO_LEVEL);
> +		break;
> +	case C2C_INT_LOW:
> +		cur_int_reg |= (0x1 << genio_num);
> +		cur_lev_reg &= ~(0x1 << genio_num);
> +		c2c_writel(cur_int_reg, EXYNOS_C2C_GENO_INT);
> +		c2c_writel(cur_lev_reg, EXYNOS_C2C_GENO_LEVEL);
> +		break;
> +	}
> +}
> +
> +static irqreturn_t c2c_sscm0_irq(int irq, void *data)
> +{
> +	/* Nothing here yet */
> +	return IRQ_HANDLED;
> +}

So is there any reason to even request this interrupt, potentially causing
an interrupt storm if it's triggered?  By returning IRQ_HANDLED you're
telling the IRQ core that you serviced and cleared it, so if it gets
triggered, you're going to get stuck here.

> +
> +static irqreturn_t c2c_sscm1_irq(int irq, void *data)
> +{

If you passed &c2c_con into request_irq(), fixed c2c_readl etc to take a
c2c_con pointer, then you don't need to keep dereferencing a global symbol.
Note that the structure does nothing to optimize the generated code - the
compiler _won't_ keep the base address of it in a register and use offsets.
It'll just load the individual addresses to structure members.

If you want efficient code, then you have to use a pointer to the structure.

> +	u32 raw_irq, opp_val, req_clk;
> +	raw_irq = c2c_readl(EXYNOS_C2C_IRQ_EN_STAT1);
> +
> +	if ((raw_irq >> C2C_GENIO_OPP_INT) & 1) { /* OPP Change */
> +		/*
> +		 * OPP mode GENI/O bit definition[29:27]
> +		 * OPP100 GENI/O[29:28] : 1 1
> +		 * OPP50 GENI/O[29:28] : 1 0
> +		 * OPP25 GENI/O[29:28] : 0 1
> +		 * GENI[27] is only used for making interrupt.
> +		*/
> +		opp_val = (c2c_readl(EXYNOS_C2C_GENO_STATUS) >> 28) & 3;
> +		req_clk = 0;
> +		dev_info(c2c_con.c2c_dev, "OPP interrupt occured (%d)\n",
> +				opp_val);
> +
> +		if (opp_val == C2C_OPP100)
> +			req_clk = c2c_con.clk_opp100;
> +		else if (opp_val == C2C_OPP50)
> +			req_clk = c2c_con.clk_opp50;
> +		else if (opp_val == C2C_OPP25)
> +			req_clk = c2c_con.clk_opp25;
> +
> +		if (opp_val == 0 || req_clk == 1) {
> +			dev_info(c2c_con.c2c_dev,
> +				"This mode is not reserved in OPP mode.\n");
> +		} else {
> +			if (c2c_con.opp_mode > opp_val) {
> +				/* increase case */
> +				clk_set_rate(c2c_con.c2c_sclk,
> +					(req_clk + 1) * MHZ);
> +				c2c_writel(req_clk, EXYNOS_C2C_FCLK_FREQ);
> +				c2c_set_func_clk(req_clk);
> +				c2c_writel(req_clk, EXYNOS_C2C_RX_MAX_FREQ);
> +			} else if (c2c_con.opp_mode < opp_val) {
> +				/* decrease case */
> +				c2c_writel(req_clk, EXYNOS_C2C_RX_MAX_FREQ);
> +				clk_set_rate(c2c_con.c2c_sclk,
> +					(req_clk + 1) * MHZ);
> +				c2c_writel(req_clk, EXYNOS_C2C_FCLK_FREQ);
> +				c2c_set_func_clk(req_clk);
> +			} else{
> +				dev_info(c2c_con.c2c_dev, "Requested same OPP mode\n");
> +			}
> +			c2c_con.opp_mode = opp_val;
> +		}
> +
> +		/* Interrupt Clear */
> +		c2c_writel((0x1 << C2C_GENIO_OPP_INT), EXYNOS_C2C_IRQ_EN_STAT1);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void set_c2c_device(struct platform_device *pdev)
> +{
> +	struct exynos_c2c_platdata *pdata = pdev->dev.platform_data;
> +	u32 default_clk;
> +
> +	c2c_con.c2c_sysreg = pdata->c2c_sysreg;
> +	c2c_con.rx_width = pdata->rx_width;
> +	c2c_con.tx_width = pdata->tx_width;
> +	c2c_con.clk_opp100 = pdata->clk_opp100;
> +	c2c_con.clk_opp50 = pdata->clk_opp50;
> +	c2c_con.clk_opp25 = pdata->clk_opp25;
> +	c2c_con.opp_mode = pdata->default_opp_mode;
> +	c2c_con.c2c_sclk = clk_get(&pdev->dev, "sclk_c2c");
> +	c2c_con.c2c_aclk = clk_get(&pdev->dev, "aclk_c2c");

Where's the error checking?  Nowhere in this file do you prepare and
enable the clock, so I assume that these can be deleted because they
don't ever actually supply any clock to the device at all.

> +
> +	/* Set clock to default mode */
> +	if (c2c_con.opp_mode == C2C_OPP100)
> +		default_clk = c2c_con.clk_opp100;
> +	else if (c2c_con.opp_mode == C2C_OPP50)
> +		default_clk = c2c_con.clk_opp50;
> +	else if (c2c_con.opp_mode == C2C_OPP25)
> +		default_clk = c2c_con.clk_opp25;
> +	else {
> +		dev_info(c2c_con.c2c_dev, "Default OPP mode is not selected.\n");
> +		c2c_con.opp_mode = C2C_OPP50;
> +		default_clk = c2c_con.clk_opp50;
> +	}
> +
> +	clk_set_rate(c2c_con.c2c_sclk, (default_clk + 1)  * MHZ);
> +	clk_set_rate(c2c_con.c2c_aclk, ((default_clk / 2) + 1) * MHZ);
> +
> +	dev_info(c2c_con.c2c_dev, "Get C2C sclk rate : %ld\n",
> +				clk_get_rate(c2c_con.c2c_sclk));
> +	dev_info(c2c_con.c2c_dev, "Get C2C aclk rate : %ld\n",
> +				clk_get_rate(c2c_con.c2c_aclk));
> +
> +	if (pdata->setup_gpio)
> +		pdata->setup_gpio(pdata->rx_width, pdata->tx_width);
> +
> +	c2c_set_sharedmem(pdata->shdmem_size, pdata->shdmem_addr);
> +
> +	/* Set SYSREG to memdone */
> +	c2c_set_memdone(C2C_SET);
> +	c2c_set_clock_gating(C2C_CLEAR);
> +
> +	/* Set C2C clock register */
> +	c2c_writel(default_clk, EXYNOS_C2C_FCLK_FREQ);
> +	c2c_writel(default_clk, EXYNOS_C2C_RX_MAX_FREQ);
> +	c2c_set_func_clk(default_clk);
> +
> +	/* Set C2C buswidth */
> +	c2c_writel(((pdata->rx_width << 4) | (pdata->tx_width)),
> +			EXYNOS_C2C_PORTCONFIG);
> +	c2c_set_tx_buswidth(pdata->tx_width);
> +	c2c_set_rx_buswidth(pdata->rx_width);
> +
> +	/* Enable defined GENI/O Interrupt */
> +	c2c_writel((0x1 << C2C_GENIO_OPP_INT), EXYNOS_C2C_IRQ_EN_SET1);
> +	c2c_con.retention_reg = (0x1 << C2C_GENIO_OPP_INT);
> +
> +	c2c_set_interrupt(C2C_GENIO_OPP_INT, C2C_INT_HIGH);
> +
> +	dev_info(c2c_con.c2c_dev, "Port Config : 0x%x\n",
> +			c2c_readl(EXYNOS_C2C_PORTCONFIG));
> +	dev_info(c2c_con.c2c_dev, "FCLK_FREQ register : %d\n",
> +			c2c_readl(EXYNOS_C2C_FCLK_FREQ));
> +	dev_info(c2c_con.c2c_dev, "RX_MAX_FREQ register : %d\n",
> +			c2c_readl(EXYNOS_C2C_RX_MAX_FREQ));
> +	dev_info(c2c_con.c2c_dev, "IRQ_EN_SET1 register : 0x%x\n",
> +			c2c_readl(EXYNOS_C2C_IRQ_EN_SET1));
> +
> +	c2c_set_clock_gating(C2C_SET);
> +}
> +
> +static int __devinit samsung_c2c_probe(struct platform_device *pdev)
> +{
> +	struct exynos_c2c_platdata *pdata = pdev->dev.platform_data;
> +	struct resource *res = NULL;
> +	struct resource *res1 = NULL;
> +	int sscm_irq0, sscm_irq1;
> +	int err = 0;
> +
> +	c2c_con.c2c_dev = &pdev->dev;
> +
> +	/* resource for AP's SSCM region */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no memory resource defined(AP's SSCM)\n");
> +		return -ENOENT;
> +	}
> +	res = request_mem_region(res->start, resource_size(res), pdev->name);

Driver name?  The parent resource already contains the device name.

> +	if (!res) {
> +		dev_err(&pdev->dev, "failded to request memory resource(AP)\n");
> +		return -ENOENT;
> +	}
> +	pdata->ap_sscm_addr = ioremap(res->start, resource_size(res));
> +	if (!pdata->ap_sscm_addr) {

This is silly.  Please name 'pdata' a const and fix the build warnings
that fall out from that.  You really shouldn't be writing to random
data that you - as a driver - don't own.  And as you seem to have
c2c_con.ap_sscm_addr to store it in, I see no reason for this to even
be happening.

> +		dev_err(&pdev->dev, "failded to request memory resource(AP)\n");
> +		goto release_ap_sscm;
> +	}
> +	c2c_con.ap_sscm_addr = pdata->ap_sscm_addr;
> +
> +	/* resource for CP's SSCM region */
> +	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res1) {
> +		dev_err(&pdev->dev, "no memory resource defined(AP's SSCM)\n");
> +		goto unmap_ap_sscm;
> +	}
> +	res1 = request_mem_region(res1->start, resource_size(res1), pdev->name);

Driver name?  The parent resource already contains the device name.

> +	if (!res1) {
> +		dev_err(&pdev->dev, "failded to request memory resource(AP)\n");
> +		goto unmap_ap_sscm;
> +	}
> +	pdata->cp_sscm_addr = ioremap(res1->start, resource_size(res1));
> +	if (!pdata->cp_sscm_addr) {

Same comments as for pdata->ap_sscm_addr.

> +		dev_err(&pdev->dev, "failded to request memory resource(CP)\n");
> +		goto release_cp_sscm;
> +	}
> +	c2c_con.cp_sscm_addr = pdata->cp_sscm_addr;
> +
> +	/* Request IRQ for SSCM0 */
> +	sscm_irq0 = platform_get_irq(pdev, 0);
> +	if (sscm_irq0 < 0) {
> +		dev_err(&pdev->dev, "no irq specified\n");
> +		goto unmap_cp_sscm;
> +	}
> +	err = request_irq(sscm_irq0, c2c_sscm0_irq, 0, pdev->name, pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Can't request SSCM0 IRQ\n");
> +		goto unmap_cp_sscm;
> +	}
> +	/* SSCM0 irq will be only used for master device */
> +	disable_irq(sscm_irq0);
> +
> +	/* Request IRQ for SSCM1 */
> +	sscm_irq1 = platform_get_irq(pdev, 1);
> +	if (sscm_irq1 < 0) {
> +		dev_err(&pdev->dev, "no irq specified\n");
> +		goto release_sscm_irq0;
> +	}
> +	err = request_irq(sscm_irq1, c2c_sscm1_irq, 1, pdev->name, pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Can't request SSCM1 IRQ\n");
> +		goto release_sscm_irq0;
> +	}
> +
> +	if (err) {
> +		dev_err(&pdev->dev, "Can't register chrdev!\n");
> +		goto release_sscm_irq0;
> +	}
> +
> +	set_c2c_device(pdev);
> +
> +	/* Create sysfs file for C2C debug */
> +	err = device_create_file(&pdev->dev, &dev_attr_c2c_ctrl);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to create sysfs for C2C\n");
> +		goto release_sscm_irq1;
> +	}

Where do you remove this device file?  It looks like an oops waiting to
happen if you remove this module.

> +
> +	return 0;
> +
> +release_sscm_irq1:
> +	free_irq(sscm_irq1, pdev);
> +
> +release_sscm_irq0:
> +	free_irq(sscm_irq0, pdev);
> +
> +unmap_cp_sscm:
> +	iounmap(pdata->cp_sscm_addr);
> +
> +release_cp_sscm:
> +	release_mem_region(res1->start, resource_size(res1));
> +
> +unmap_ap_sscm:
> +	iounmap(pdata->ap_sscm_addr);
> +
> +release_ap_sscm:
> +	release_mem_region(res->start, resource_size(res));
> +
> +	return err;
> +}
> +
> +static int __devexit samsung_c2c_remove(struct platform_device *pdev)
> +{
> +	struct exynos_c2c_platdata *pdata = pdev->dev.platform_data;
> +	struct resource *res = NULL;
> +	struct resource *res1 = NULL;
> +	int sscm_irq0, sscm_irq1;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	sscm_irq0 = platform_get_irq(pdev, 0);
> +	sscm_irq1 = platform_get_irq(pdev, 1);
> +
> +	iounmap(pdata->ap_sscm_addr);
> +	iounmap(pdata->cp_sscm_addr);

Why not use c2c_con.cp_sscm_addr ?  Why not put &c2c_con into the
device driver data in the probe, and retrieve it at remove and
suspend/resume time?

> +	release_mem_region(res->start, resource_size(res));
> +	release_mem_region(res1->start, resource_size(res1));
> +
> +	free_irq(sscm_irq0, pdev);
> +	free_irq(sscm_irq1, pdev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int samsung_c2c_suspend(struct platform_device *dev, pm_message_t pm)
> +{
> +	/* Nothing here yet */
> +	return 0;
> +}
> +
> +static int samsung_c2c_resume(struct platform_device *dev)
> +{
> +	/* Nothing here yet */
> +	return 0;
> +}

If there's nothing that you want to do here, don't provide these
functions until you've thought of something to do.  It just adds
unnecessary patch noise.

> +#else
> +#define samsung_c2c_suspend NULL
> +#define samsung_c2c_resume NULL
> +#endif
> +
> +static struct platform_driver samsung_c2c_driver = {
> +	.probe		= samsung_c2c_probe,
> +	.remove		= __devexit_p(samsung_c2c_remove),
> +	.suspend	= samsung_c2c_suspend,
> +	.resume		= samsung_c2c_resume,

These two suspend/resume methods are superseded by the dev_pm_ops stuff.
Please convert to use this instead.

> +	.driver		= {
> +		.name	= "samsung-c2c",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init samsung_c2c_init(void)
> +{
> +	return platform_driver_register(&samsung_c2c_driver);
> +}
> +module_init(samsung_c2c_init);
> +
> +static void __exit samsung_c2c_exit(void)
> +{
> +	platform_driver_unregister(&samsung_c2c_driver);
> +}
> +module_exit(samsung_c2c_exit);
> +
> +MODULE_DESCRIPTION("Samsung C2C driver");
> +MODULE_AUTHOR("Kisang Lee <kisang80.lee@samsung.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/misc/c2c/samsung-c2c.h b/drivers/misc/c2c/samsung-c2c.h
> new file mode 100644
> index 0000000..3f72137
> --- /dev/null
> +++ b/drivers/misc/c2c/samsung-c2c.h
> @@ -0,0 +1,300 @@
> +/*
> + * Samsung C2C driver
> + *
> + * Copyright (C) 2011 Samsung Electronics Co.Ltd
> + * Author: Kisang Lee <kisang80.lee@samsung.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#ifndef SAMSUNG_C2C_H
> +#define SAMSUNG_C2C_H
> +
> +enum c2c_set_clear {
> +	C2C_CLEAR = 0,
> +	C2C_SET = 1,
> +};
> +
> +enum c2c_interrupt {
> +	C2C_INT_TOGGLE = 0,
> +	C2C_INT_HIGH = 1,
> +	C2C_INT_LOW = 2,
> +};
> +
> +struct c2c_state_control {
> +	void __iomem *ap_sscm_addr;
> +	void __iomem *cp_sscm_addr;
> +	struct device *c2c_dev;
> +
> +	u32 rx_width;
> +	u32 tx_width;
> +
> +	u32 clk_opp100;
> +	u32 clk_opp50;
> +	u32 clk_opp25;
> +
> +	struct clk *c2c_sclk;
> +	struct clk *c2c_aclk;
> +
> +	enum c2c_opp_mode opp_mode;
> +
> +	u32 retention_reg;
> +	void __iomem *c2c_sysreg;
> +};
> +
> +static struct c2c_state_control c2c_con;

Why is this in a header file - and why do you only allow one of these
devices in the driver (with no protection against a second one being
registered.)

I see no reason why this file exists anyway - why isn't this in
drivers/misc/c2c/samsung-c2c.c ?

> +
> +static inline void c2c_writel(u32 val, int reg)
> +{
> +	writel(val, c2c_con.ap_sscm_addr + reg);
> +}
> +
> +static inline void c2c_writew(u16 val, int reg)
> +{
> +	writew(val, c2c_con.ap_sscm_addr + reg);
> +}
> +
> +static inline void c2c_writeb(u8 val, int reg)
> +{
> +	writeb(val, c2c_con.ap_sscm_addr + reg);
> +}
> +
> +static inline u32 c2c_readl(int reg)
> +{
> +	return readl(c2c_con.ap_sscm_addr + reg);
> +}
> +
> +static inline u16 c2c_readw(int reg)
> +{
> +	return readw(c2c_con.ap_sscm_addr + reg);
> +}
> +
> +static inline u8 c2c_readb(int reg)
> +{
> +	return readb(c2c_con.ap_sscm_addr + reg);
> +}
> +
> +static inline void c2c_writel_cp(u32 val, int reg)
> +{
> +	writel(val, c2c_con.cp_sscm_addr + reg);
> +}
> +
> +static inline void c2c_writew_cp(u16 val, int reg)
> +{
> +	writew(val, c2c_con.cp_sscm_addr + reg);
> +}
> +
> +static inline void c2c_writeb_cp(u8 val, int reg)
> +{
> +	writeb(val, c2c_con.cp_sscm_addr + reg);
> +}
> +
> +static inline u32 c2c_readl_cp(int reg)
> +{
> +	return readl(c2c_con.cp_sscm_addr + reg);
> +}
> +
> +static inline u16 c2c_readw_cp(int reg)
> +{
> +	return readw(c2c_con.cp_sscm_addr + reg);
> +}
> +
> +static inline u8 c2c_readb_cp(int reg)
> +{
> +	return readb(c2c_con.cp_sscm_addr + reg);
> +}
> +
> +static inline enum c2c_set_clear c2c_get_clock_gating(void)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +	if (sysreg & (1 << C2C_SYSREG_CG))
> +		return C2C_SET;
> +	else
> +		return C2C_CLEAR;
> +}
> +
> +static inline void c2c_set_clock_gating(enum c2c_set_clear val)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	if (val == C2C_SET)
> +		sysreg |= (1 << C2C_SYSREG_CG);
> +	else
> +		sysreg &= ~(1 << C2C_SYSREG_CG);
> +
> +	writel(sysreg, c2c_con.c2c_sysreg);
> +}
> +
> +static inline enum c2c_set_clear c2c_get_memdone(void)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +	if (sysreg & (1 << C2C_SYSREG_MD))
> +		return C2C_SET;
> +	else
> +		return C2C_CLEAR;
> +}
> +
> +static inline void c2c_set_memdone(enum c2c_set_clear val)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	if (val == C2C_SET)
> +		sysreg |= (1 << C2C_SYSREG_MD);
> +	else
> +		sysreg &= ~(1 << C2C_SYSREG_MD);
> +
> +	writel(sysreg, c2c_con.c2c_sysreg);
> +}
> +
> +static inline enum c2c_set_clear c2c_get_master_on(void)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +	if (sysreg & (1 << C2C_SYSREG_MO))
> +		return C2C_SET;
> +	else
> +		return C2C_CLEAR;
> +}
> +
> +static inline void c2c_set_master_on(enum c2c_set_clear val)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	if (val == C2C_SET)
> +		sysreg |= (1 << C2C_SYSREG_MO);
> +	else
> +		sysreg &= ~(1 << C2C_SYSREG_MO);
> +
> +	writel(sysreg, c2c_con.c2c_sysreg);
> +}
> +
> +static inline u32 c2c_get_func_clk(void)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	sysreg &= (0x3ff << C2C_SYSREG_FCLK);
> +
> +	return sysreg >> C2C_SYSREG_FCLK;
> +}
> +
> +static inline void c2c_set_func_clk(u32 val)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	sysreg &= ~(0x3ff << C2C_SYSREG_FCLK);
> +	sysreg |= (val << C2C_SYSREG_FCLK);
> +
> +	writel(sysreg, c2c_con.c2c_sysreg);
> +}
> +
> +static inline u32 c2c_get_tx_buswidth(void)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	sysreg &= (0x3 << C2C_SYSREG_TXW);
> +
> +	return sysreg >> C2C_SYSREG_TXW;
> +}
> +
> +static inline void c2c_set_tx_buswidth(u32 val)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	sysreg &= ~(0x3 << C2C_SYSREG_TXW);
> +	sysreg |= (val << C2C_SYSREG_TXW);
> +
> +	writel(sysreg, c2c_con.c2c_sysreg);
> +}
> +
> +static inline u32 c2c_get_rx_buswidth(void)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	sysreg &= (0x3 << C2C_SYSREG_RXW);
> +
> +	return sysreg >> C2C_SYSREG_RXW;
> +}
> +
> +static inline void c2c_set_rx_buswidth(u32 val)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	sysreg &= ~(0x3 << C2C_SYSREG_RXW);
> +	sysreg |= (val << C2C_SYSREG_RXW);
> +
> +	writel(sysreg, c2c_con.c2c_sysreg);
> +}
> +
> +static inline enum c2c_set_clear c2c_get_reset(void)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +	if (sysreg & (1 << C2C_SYSREG_RST))
> +		return C2C_SET;
> +	else
> +		return C2C_CLEAR;
> +}
> +
> +static inline void c2c_set_reset(enum c2c_set_clear val)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	if (val == C2C_SET)
> +		sysreg |= (1 << C2C_SYSREG_RST);
> +	else
> +		sysreg &= ~(1 << C2C_SYSREG_RST);
> +
> +	writel(sysreg, c2c_con.c2c_sysreg);
> +}
> +
> +static inline void c2c_set_rtrst(enum c2c_set_clear val)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	if (val == C2C_SET)
> +		sysreg |= (1 << C2C_SYSREG_RTRST);
> +	else
> +		sysreg &= ~(1 << C2C_SYSREG_RTRST);
> +
> +	writel(sysreg, c2c_con.c2c_sysreg);
> +}
> +
> +static inline u32 c2c_get_base_addr(void)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	sysreg &= (0x3ff << C2C_SYSREG_BASE_ADDR);
> +
> +	return sysreg >> C2C_SYSREG_BASE_ADDR;
> +}
> +
> +static inline void c2c_set_base_addr(u32 val)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	sysreg &= ~(0x3ff << C2C_SYSREG_BASE_ADDR);
> +	sysreg |= (val << C2C_SYSREG_BASE_ADDR);
> +
> +	writel(sysreg, c2c_con.c2c_sysreg);
> +}
> +
> +static inline u32 c2c_get_shdmem_size(void)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	sysreg &= (0x7 << C2C_SYSREG_DRAM_SIZE);
> +
> +	return sysreg >> C2C_SYSREG_DRAM_SIZE;
> +}
> +
> +static inline void c2c_set_shdmem_size(u32 val)
> +{
> +	u32 sysreg = readl(c2c_con.c2c_sysreg);
> +
> +	sysreg &= ~(0x7 << C2C_SYSREG_DRAM_SIZE);
> +	sysreg |= (val << C2C_SYSREG_DRAM_SIZE);
> +
> +	writel(sysreg, c2c_con.c2c_sysreg);
> +}
> +
> +#endif
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
