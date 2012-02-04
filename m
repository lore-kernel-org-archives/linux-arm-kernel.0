From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Sat, 04 Feb 2012 13:57:42 +0100
Subject: [PATCH 2/2] misc: c2c: Add C2C(Chip to Chip) device driver for
 EXYNOS
In-Reply-To: <000601cce315$18c82510$4a586f30$%lee@samsung.com>
References: <000601cce315$18c82510$4a586f30$%lee@samsung.com>
Message-ID: <4F2D2B46.2030201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/04/2012 09:15 AM, Kisang Lee wrote:
> Cc: Arnd Bergmann<arnd<at>  arndb.de>
> Cc: Greg Kroah-Hartman<greg<at>  kroah.com>

Commit description aren't expected to be empty, especially when
you're adding a new driver. There is little clue what the driver
is needed for. Could you please be a little bit more verbose 
here ?

> Signed-off-by: Kisang Lee<kisang80.lee@samsung.com>
> ---
>   drivers/misc/Kconfig           |    1 +
>   drivers/misc/Makefile          |    1 +
>   drivers/misc/c2c/Kconfig       |   10 +
>   drivers/misc/c2c/Makefile      |    5 +
>   drivers/misc/c2c/samsung-c2c.c |  500 ++++++++++++++++++++++++++++++++++++++++
>   drivers/misc/c2c/samsung-c2c.h |  300 ++++++++++++++++++++++++
>   6 files changed, 817 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/misc/c2c/Kconfig
>   create mode 100644 drivers/misc/c2c/Makefile
>   create mode 100644 drivers/misc/c2c/samsung-c2c.c
>   create mode 100644 drivers/misc/c2c/samsung-c2c.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 6a1a092..2ec3f48 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -516,5 +516,6 @@ source "drivers/misc/ti-st/Kconfig"
>   source "drivers/misc/lis3lv02d/Kconfig"
>   source "drivers/misc/carma/Kconfig"
>   source "drivers/misc/altera-stapl/Kconfig"
> +source "drivers/misc/c2c/Kconfig"
> 
>   endif # MISC_DEVICES
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 3e1d801..bd96ed7 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -49,3 +49,4 @@ obj-y				+= carma/
>   obj-$(CONFIG_USB_SWITCH_FSA9480) += fsa9480.o
>   obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
>   obj-$(CONFIG_MAX8997_MUIC)	+= max8997-muic.o
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

The default is 'n' so you can drop this line.

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
                    ^^^
White-space after C2C ?
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

2012 or 2011 - 2012 ?

I think the proper form is:

Copyright (C) 2012 Samsung Electronics Co., Ltd.

> + * Author: Kisang Lee<kisang80.lee@samsung.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include<linux/clk.h>
> +#include<linux/err.h>
> +#include<linux/init.h>
> +#include<linux/input.h>
> +#include<linux/interrupt.h>
> +#include<linux/io.h>
> +#include<linux/module.h>
> +#include<linux/miscdevice.h>
> +#include<linux/platform_device.h>
> +#include<linux/sched.h>
> +#include<linux/sysfs.h>
> +#include<asm/mach-types.h>
> +
> +#include<mach/c2c.h>
> +#include<mach/regs-c2c.h>
> +#include<plat/cpu.h>
> +
> +#include "samsung-c2c.h"
> +
> +void c2c_reset_ops(void)
> +{
> +	u32 set_clk = 0;
> +
> +	if (c2c_con.opp_mode == C2C_OPP100)

Would it make sense to make an effort to get rid of the global c2c_con
variable ? I mean when there is more than one instance of the C2C device
in the system this driver won't work as is. However if there is always
only one hardware instance then there is no issue.
I would strongly recommend not relying on such a global variable though.

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

nit: You could use "%#x" notation here and anywhere else for
hex numbers, that's one character less... :)	

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
> +	sscanf(buf, "%d",&ops_num);
> +
> +	switch (ops_num) {
> +	case 1:
> +		c2c_reset_ops();
> +		break;
> +	case 2:
> +	case 3:
> +	case 4:

What about:
	case 2 ... 4:
?
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
> +			if (c2c_con.opp_mode>  opp_val) {
> +				/* increase case */
> +				clk_set_rate(c2c_con.c2c_sclk,
> +					(req_clk + 1) * MHZ);
> +				c2c_writel(req_clk, EXYNOS_C2C_FCLK_FREQ);
> +				c2c_set_func_clk(req_clk);
> +				c2c_writel(req_clk, EXYNOS_C2C_RX_MAX_FREQ);
> +			} else if (c2c_con.opp_mode<  opp_val) {
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

How about using a local variable pointing to the device at the beginning 
of this function, e.g.
	struct device *dev = &c2c_con.c2c_dev;

Better might be to store &c2c_con as the driver's data, for example.
c2c_con.c2c_dev is used quite often and this could make code more readable.
 
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
> +				addr, 1<<  (2 + size));
> +
> +	/* Set DRAM Base Addr&  Size */
> +	c2c_set_shdmem_size(size);
> +	c2c_set_base_addr((addr>>  22));

Superfluous parentheses.

> +
> +	return 0;
> +}
> +
> +static void c2c_set_interrupt(u32 genio_num, enum c2c_interrupt set_int)
> +{
> +	u32 cur_int_reg, cur_lev_reg;
> +
> +	cur_int_reg = c2c_readl(EXYNOS_C2C_GENO_INT);
> +	cur_lev_reg = c2c_readl(EXYNOS_C2C_GENO_LEVEL);
> +
> +	switch (set_int) {
> +	case C2C_INT_TOGGLE:
> +		cur_int_reg&= ~(0x1<<  genio_num);
> +		c2c_writel(cur_int_reg, EXYNOS_C2C_GENO_INT);
> +		break;
> +	case C2C_INT_HIGH:
> +		cur_int_reg |= (0x1<<  genio_num);
> +		cur_lev_reg |= (0x1<<  genio_num);
> +		c2c_writel(cur_int_reg, EXYNOS_C2C_GENO_INT);
> +		c2c_writel(cur_lev_reg, EXYNOS_C2C_GENO_LEVEL);
> +		break;
> +	case C2C_INT_LOW:
> +		cur_int_reg |= (0x1<<  genio_num);
> +		cur_lev_reg&= ~(0x1<<  genio_num);
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

Should it be just removed for now ?

> +
> +static irqreturn_t c2c_sscm1_irq(int irq, void *data)
> +{
> +	u32 raw_irq, opp_val, req_clk;
> +	raw_irq = c2c_readl(EXYNOS_C2C_IRQ_EN_STAT1);
> +
> +	if ((raw_irq>>  C2C_GENIO_OPP_INT)&  1) { /* OPP Change */
> +		/*
> +		 * OPP mode GENI/O bit definition[29:27]
> +		 * OPP100 GENI/O[29:28] : 1 1
> +		 * OPP50 GENI/O[29:28] : 1 0
> +		 * OPP25 GENI/O[29:28] : 0 1
> +		 * GENI[27] is only used for making interrupt.
> +		*/
> +		opp_val = (c2c_readl(EXYNOS_C2C_GENO_STATUS)>>  28)&  3;
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
> +			if (c2c_con.opp_mode>  opp_val) {
> +				/* increase case */
> +				clk_set_rate(c2c_con.c2c_sclk,
> +					(req_clk + 1) * MHZ);
> +				c2c_writel(req_clk, EXYNOS_C2C_FCLK_FREQ);
> +				c2c_set_func_clk(req_clk);
> +				c2c_writel(req_clk, EXYNOS_C2C_RX_MAX_FREQ);
> +			} else if (c2c_con.opp_mode<  opp_val) {
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
> +		c2c_writel((0x1<<  C2C_GENIO_OPP_INT), EXYNOS_C2C_IRQ_EN_STAT1);
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

switch statement ? e.g

	switch (c2c_con.opp_mode) {
	case C2C_OPP100: 
		default_clk = c2c_con.clk_opp100;
		break;
	case C2C_OPP25: 
		default_clk = c2c_con.clk_opp25;
		break;
	case C2C_OPP50: 
		default_clk = c2c_con.clk_opp50;
		/* fall through */
	default:
		dev_info(c2c_con.c2c_dev, "Fallback to OPP50 mode\n");
		c2c_con.opp_mode = C2C_OPP50;
	}
?
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

We should be avoiding callbacks in the platform data. These cause trouble
for device tree based platforms.

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
> +	c2c_writel(((pdata->rx_width<<  4) | (pdata->tx_width)),
> +			EXYNOS_C2C_PORTCONFIG);
> +	c2c_set_tx_buswidth(pdata->tx_width);
> +	c2c_set_rx_buswidth(pdata->rx_width);
> +
> +	/* Enable defined GENI/O Interrupt */
> +	c2c_writel((0x1<<  C2C_GENIO_OPP_INT), EXYNOS_C2C_IRQ_EN_SET1);
> +	c2c_con.retention_reg = (0x1<<  C2C_GENIO_OPP_INT);
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

Unneeded initialization.

> +	int sscm_irq0, sscm_irq1;
> +	int err = 0;
> +
> +	c2c_con.c2c_dev =&pdev->dev;
> +
> +	/* resource for AP's SSCM region */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no memory resource defined(AP's SSCM)\n");
> +		return -ENOENT;
> +	}
> +	res = request_mem_region(res->start, resource_size(res), pdev->name);
> +	if (!res) {
> +		dev_err(&pdev->dev, "failded to request memory resource(AP)\n");
> +		return -ENOENT;
> +	}
> +	pdata->ap_sscm_addr = ioremap(res->start, resource_size(res));

What ? You're overwriting the platform data ? Please don't do that. 
I wonder why do you need the IO memory region address at the platform
data in the first place. Instead what's needed should be copied to 
driver's internal data structures so platform_data can be marked with
__init and discarded after the system initialization.

> +	if (!pdata->ap_sscm_addr) {
> +		dev_err(&pdev->dev, "failded to request memory resource(AP)\n");
> +		goto release_ap_sscm;
> +	}

How about using the device managed resources, i.e. devm_request_and_ioremap()
in this case and...

> +	c2c_con.ap_sscm_addr = pdata->ap_sscm_addr;
> +
> +	/* resource for CP's SSCM region */
> +	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res1) {
> +		dev_err(&pdev->dev, "no memory resource defined(AP's SSCM)\n");
> +		goto unmap_ap_sscm;
> +	}
> +	res1 = request_mem_region(res1->start, resource_size(res1), pdev->name);
> +	if (!res1) {
> +		dev_err(&pdev->dev, "failded to request memory resource(AP)\n");
> +		goto unmap_ap_sscm;
> +	}
> +	pdata->cp_sscm_addr = ioremap(res1->start, resource_size(res1));
> +	if (!pdata->cp_sscm_addr) {
> +		dev_err(&pdev->dev, "failded to request memory resource(CP)\n");
> +		goto release_cp_sscm;
> +	}
> +	c2c_con.cp_sscm_addr = pdata->cp_sscm_addr;
> +
> +	/* Request IRQ for SSCM0 */
> +	sscm_irq0 = platform_get_irq(pdev, 0);
> +	if (sscm_irq0<  0) {
> +		dev_err(&pdev->dev, "no irq specified\n");
> +		goto unmap_cp_sscm;
> +	}
> +	err = request_irq(sscm_irq0, c2c_sscm0_irq, 0, pdev->name, pdev);

... devm_request_irq() ?

Your error handling would then simplify significantly.

> +	if (err) {
> +		dev_err(&pdev->dev, "Can't request SSCM0 IRQ\n");
> +		goto unmap_cp_sscm;
> +	}
> +	/* SSCM0 irq will be only used for master device */
> +	disable_irq(sscm_irq0);

I personally would just not request the irq for now, it's unused.

> +
> +	/* Request IRQ for SSCM1 */
> +	sscm_irq1 = platform_get_irq(pdev, 1);
> +	if (sscm_irq1<  0) {
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
> +	err = device_create_file(&pdev->dev,&dev_attr_c2c_ctrl);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to create sysfs for C2C\n");
> +		goto release_sscm_irq1;
> +	}
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
> +	release_mem_region(res->start, resource_size(res));
> +	release_mem_region(res1->start, resource_size(res1));
> +
> +	free_irq(sscm_irq0, pdev);
> +	free_irq(sscm_irq1, pdev);

If you have used the devm_* API for requesting resources everything
in this function could go away.

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
> +#else
> +#define samsung_c2c_suspend NULL
> +#define samsung_c2c_resume NULL

This #else statement is not needed when you use SET_SYSTEM_SLEEP_PM_OPS()
macro for assigning the PM helpers below.

> +#endif
> +
> +static struct platform_driver samsung_c2c_driver = {
> +	.probe		= samsung_c2c_probe,
> +	.remove		= __devexit_p(samsung_c2c_remove),
> +	.suspend	= samsung_c2c_suspend,
> +	.resume		= samsung_c2c_resume,

Please don't use legacy PM callbacks, struct dev_pm_ops should be 
used instead, e.g.

static const struct dev_pm_ops exynos_c2c_pm_ops = {
	SET_SYSTEM_SLLEP_PM_OPS(exynos_c2c_suspend, exynos_c2c_resume, 
				NULL)
};

> +	.driver		= {
		.pm	= &exynos_c2c_pm_ops,
> +		.name	= "samsung-c2c",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +

Nevertheless you PM callbacks are empty, how about dropping them
for now and adding in a subsequent patch that implements proper power
management ? 

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

You could use module_platform_driver macro to simplify that, e.g.

module_platform_driver(&samsung_c2c_driver);

BTW, isn't it better to just use "exynos_" prefix rather than 
"samsung_" ? Just in case there is other C2C driver for different 
SoC family ?

> +
> +MODULE_DESCRIPTION("Samsung C2C driver");
> +MODULE_AUTHOR("Kisang Lee<kisang80.lee@samsung.com>");
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

	Copyright (C) 2012 Samsung Electronics Co., Ltd.

> + * Author: Kisang Lee<kisang80.lee@samsung.com>
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

nit: What about not prefixing the individual struct members with "c2c", 
     since they already belong to struct "c2c_state_control" ?

> +};
> +
> +static struct c2c_state_control c2c_con;
> +
> +static inline void c2c_writel(u32 val, int reg)
> +{
> +	writel(val, c2c_con.ap_sscm_addr + reg);
> +}

As I already pointed out, might be good to get rid of the global
c2c_con variable and be passing a relevant pointer to these helpers.

--

Thanks,
Sylwester
