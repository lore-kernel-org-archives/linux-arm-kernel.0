From: patrice.chotard@st.com (Patrice Chotard)
Date: Fri, 27 May 2016 15:15:19 +0200
Subject: [PATCH v4 01/18] remoteproc: st_xp70_rproc: add a xp70 slimcore
 rproc driver
In-Reply-To: <1464192412-16386-3-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <57484867.6030608@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/25/2016 06:06 PM, Peter Griffin wrote:
> XP70 slim core is used as a basis for many IPs in the STi
> chipsets such as fdma, display, and demux. To avoid
> duplicating the elf loading code in each device driver
> an xp70 rproc driver has been created.
>
> This driver is designed to be used by other device drivers
> such as fdma, or demux whose IP is based around a xp70 slimcore.
> The device driver can call xp70_rproc_alloc() to allocate
> an xp70 rproc and xp70_rproc_put() when finished.
>
> This driver takes care of ioremapping the xp70
> registers (dmem, imem, slimcore, peripherals), whose offsets
> and sizes can change between IP's. It also obtains and enables
> any clocks used by the device. This approach avoids having
> a double mapping of the registers as xp70_rproc does not register
> its own platform device. It also maps well to device tree
> abstraction as it allows us to have one dt node for the whole
> device.
>
> All of the generic rproc elf loading code can be reused, and
> we provide start() stop() hooks to start and stop the xp70
> core once the firmware has been loaded. This has been tested
> successfully with fdma driver.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   drivers/remoteproc/Kconfig               |   8 +
>   drivers/remoteproc/Makefile              |   1 +
>   drivers/remoteproc/st_xp70_rproc.c       | 380 +++++++++++++++++++++++++++++++
>   include/linux/remoteproc/st_xp70_rproc.h |  56 +++++
>   4 files changed, 445 insertions(+)
>   create mode 100644 drivers/remoteproc/st_xp70_rproc.c
>   create mode 100644 include/linux/remoteproc/st_xp70_rproc.h
>
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 72e97d7..9e48fd1 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -86,4 +86,12 @@ config ST_REMOTEPROC
>   	  processor framework.
>   	  This can be either built-in or a loadable module.
>   
> +config ST_XP70_REMOTEPROC
> +	tristate "XP70 slim remoteproc support"
> +	depends on ARCH_STI
> +	select REMOTEPROC
> +	help
> +	  Say y here to support xp70 slim core.
> +	  If unsure say N.
> +
>   endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 279cb2e..b5dab8e 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_STE_MODEM_RPROC)	 	+= ste_modem_rproc.o
>   obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>   obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
>   obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
> +obj-$(CONFIG_ST_XP70_REMOTEPROC)	+= st_xp70_rproc.o
> diff --git a/drivers/remoteproc/st_xp70_rproc.c b/drivers/remoteproc/st_xp70_rproc.c
> new file mode 100644
> index 0000000..6a78e7c
> --- /dev/null
> +++ b/drivers/remoteproc/st_xp70_rproc.c
> @@ -0,0 +1,380 @@
> +/*
> + * st_xp70_rproc.c
> + *
> + * Copyright (C) 2016 STMicroelectronics
> + * Author: Peter Griffin <peter.griffin@st.com>
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/elf.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/remoteproc/st_xp70_rproc.h>
> +#include "remoteproc_internal.h"
> +
> +/* slimcore registers */
> +#define XP70_ID_OFST		0x0
> +#define XP70_VER_OFST		0x4
> +
> +#define XP70_EN_OFST		0x8
> +#define XP70_EN_RUN			BIT(0)
> +
> +#define XP70_CLK_GATE_OFST	0xC
> +#define XP70_CLK_GATE_DIS		BIT(0)
> +#define XP70_CLK_GATE_RESET		BIT(2)
> +
> +#define XP70_SLIM_PC_OFST	0x20
> +
> +/* dmem registers */
> +#define XP70_REV_ID_OFST	0x0
> +#define XP70_REV_ID_MIN_MASK		GENMASK(15, 8)
> +#define XP70_REV_ID_MIN(id)		((id & XP70_REV_ID_MIN_MASK) >> 8)
> +#define XP70_REV_ID_MAJ_MASK		GENMASK(23, 16)
> +#define XP70_REV_ID_MAJ(id)		((id & XP70_REV_ID_MAJ_MASK) >> 16)
> +
> +
> +/* peripherals registers */
> +#define XP70_STBUS_SYNC_OFST	0xF88
> +#define XP70_STBUS_SYNC_DIS		BIT(0)
> +
> +#define XP70_INT_SET_OFST	0xFD4
> +#define XP70_INT_CLR_OFST	0xFD8
> +#define XP70_INT_MASK_OFST	0xFDC
> +
> +#define XP70_CMD_CLR_OFST	0xFC8
> +#define XP70_CMD_MASK_OFST	0xFCC
> +
> +const char *mem_names[XP70_MEM_MAX] = {
> +	[DMEM]		= "dmem",
> +	[IMEM]		= "imem",
> +};
> +
> +static int xp70_clk_get(struct st_xp70_rproc *xp70_rproc, struct device *dev)
> +{
> +	int clk, err = 0;
> +
> +	for (clk = 0; clk < XP70_MAX_CLK; clk++) {
> +		xp70_rproc->clks[clk] = of_clk_get(dev->of_node, clk);
> +		if (IS_ERR(xp70_rproc->clks[clk])) {
> +			err = PTR_ERR(xp70_rproc->clks[clk]);
> +			if (err == -EPROBE_DEFER)
> +				goto err_put_clks;
> +			xp70_rproc->clks[clk] = NULL;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_put_clks:
> +	while (--clk >= 0)
> +		clk_put(xp70_rproc->clks[clk]);
> +
> +	return err;
> +}
> +
> +static void xp70_clk_disable(struct st_xp70_rproc *xp70_rproc)
> +{
> +	int clk;
> +
> +	for (clk = 0; clk < XP70_MAX_CLK && xp70_rproc->clks[clk]; clk++)
> +		clk_disable_unprepare(xp70_rproc->clks[clk]);
> +}
> +
> +static int xp70_clk_enable(struct st_xp70_rproc *xp70_rproc)
> +{
> +	int clk, ret;
> +
> +	for (clk = 0; clk < XP70_MAX_CLK && xp70_rproc->clks[clk]; clk++) {
> +		ret = clk_prepare_enable(xp70_rproc->clks[clk]);
> +		if (ret)
> +			goto err_disable_clks;
> +	}
> +
> +	return 0;
> +
> +err_disable_clks:
> +	while (--clk >= 0)
> +		clk_disable_unprepare(xp70_rproc->clks[clk]);
> +
> +	return ret;
> +}
> +
> +/**
> + * Remoteproc xp70 specific device handlers
> + */
> +static int xp70_rproc_start(struct rproc *rproc)
> +{
> +	struct device *dev = &rproc->dev;
> +	struct st_xp70_rproc *xp70_rproc = rproc->priv;
> +	unsigned long hw_id, hw_ver, fw_rev;
> +	u32 val, ret = 0;
> +
> +	ret = xp70_clk_enable(xp70_rproc);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clocks\n");
> +		goto err_clk;
> +	}
> +
> +	/* disable CPU pipeline clock & reset cpu pipeline */
> +	val = XP70_CLK_GATE_DIS | XP70_CLK_GATE_RESET;
> +	writel_relaxed(val, xp70_rproc->slimcore + XP70_CLK_GATE_OFST);
> +
> +	/* disable SLIM core STBus sync */
> +	writel_relaxed(XP70_STBUS_SYNC_DIS,
> +		xp70_rproc->peri + XP70_STBUS_SYNC_OFST);
> +
> +	/* enable cpu pipeline clock */
> +	writel_relaxed(!XP70_CLK_GATE_DIS,
> +		xp70_rproc->slimcore + XP70_CLK_GATE_OFST);
> +
> +	/* clear int & cmd mailbox */
> +	writel_relaxed(~0UL, xp70_rproc->peri + XP70_INT_CLR_OFST);
> +	writel_relaxed(~0UL, xp70_rproc->peri + XP70_CMD_CLR_OFST);
> +
> +	/* enable all channels cmd & int */
> +	writel_relaxed(~0UL, xp70_rproc->peri + XP70_INT_MASK_OFST);
> +	writel_relaxed(~0UL, xp70_rproc->peri + XP70_CMD_MASK_OFST);
> +
> +	/* enable cpu */
> +	writel(XP70_EN_RUN, xp70_rproc->slimcore + XP70_EN_OFST);
> +
> +	hw_id = readl_relaxed(xp70_rproc->slimcore + XP70_ID_OFST);
> +	hw_ver = readl_relaxed(xp70_rproc->slimcore + XP70_VER_OFST);
> +
> +	fw_rev = readl_relaxed(xp70_rproc->mem[DMEM].cpu_addr +
> +			XP70_REV_ID_OFST);
> +
> +	dev_info(dev, "fw rev:%ld.%ld on SLIM %ld.%ld\n",
> +		 XP70_REV_ID_MAJ(fw_rev), XP70_REV_ID_MIN(fw_rev),
> +		 hw_id, hw_ver);
> +
> +	dev_dbg(dev, "XP70 started\n");
> +
> +err_clk:
> +	return ret;
> +}
> +
> +static int xp70_rproc_stop(struct rproc *rproc)
> +{
> +	struct st_xp70_rproc *xp70_rproc = rproc->priv;
> +	u32 val;
> +
> +	/* mask all (cmd & int) channels */
> +	writel_relaxed(0UL, xp70_rproc->peri + XP70_INT_MASK_OFST);
> +	writel_relaxed(0UL, xp70_rproc->peri + XP70_CMD_MASK_OFST);
> +
> +	/* disable cpu pipeline clock */
> +	writel_relaxed(XP70_CLK_GATE_DIS
> +		, xp70_rproc->slimcore + XP70_CLK_GATE_OFST);
> +
> +	writel_relaxed(!XP70_EN_RUN, xp70_rproc->slimcore + XP70_EN_OFST);
> +
> +	val = readl_relaxed(xp70_rproc->slimcore + XP70_EN_OFST);
> +	if (val & XP70_EN_RUN)
> +		dev_warn(&rproc->dev, "Failed to disable XP70");
> +
> +	xp70_clk_disable(xp70_rproc);
> +
> +	dev_dbg(&rproc->dev, "xp70 stopped\n");
> +
> +	return 0;
> +}
> +
> +static void *xp70_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
> +{
> +	struct st_xp70_rproc *xp70_rproc = rproc->priv;
> +	void *va = NULL;
> +	int i;
> +
> +	for (i = 0; i < XP70_MEM_MAX; i++) {
> +
> +		if (da != xp70_rproc->mem[i].bus_addr)
> +			continue;
> +
> +		va = xp70_rproc->mem[i].cpu_addr;
> +			break;
> +	}
> +
> +	dev_dbg(&rproc->dev, "%s: da = 0x%llx len = 0x%x va = 0x%p\n"
> +		, __func__, da, len, va);
> +
> +	return va;
> +}
> +
> +static struct rproc_ops xp70_rproc_ops = {
> +	.start		= xp70_rproc_start,
> +	.stop		= xp70_rproc_stop,
> +	.da_to_va       = xp70_rproc_da_to_va,
> +};
> +
> +/**
> + * Firmware handler operations: sanity, boot address, load ...
> + */
> +
> +static struct resource_table empty_rsc_tbl = {
> +	.ver = 1,
> +	.num = 0,
> +};
> +
> +static struct resource_table *xp70_rproc_find_rsc_table(struct rproc *rproc,
> +					       const struct firmware *fw,
> +					       int *tablesz)
> +{
> +	if (!fw)
> +		return NULL;
> +
> +	*tablesz = sizeof(empty_rsc_tbl);
> +	return &empty_rsc_tbl;
> +}
> +
> +static struct resource_table *xp70_rproc_find_loaded_rsc_table(struct rproc *rproc,
> +						      const struct firmware *fw)
> +{
> +	if (!fw)
> +		return NULL;
> +
> +	return &empty_rsc_tbl;
> +}
> +
> +static struct rproc_fw_ops xp70_rproc_fw_ops = {
> +	.find_rsc_table = xp70_rproc_find_rsc_table,
> +	.find_loaded_rsc_table = xp70_rproc_find_loaded_rsc_table,
> +};
> +
> +/**
> +  * xp70_rproc_alloc - allocate and initialise xp70 rproc
> +  * @pdev: Pointer to the platform_device struct
> +  * @fw_name: Name of firmware for rproc to use
> +  *
> +  * Function for allocating and initialising a xp70 rproc for use by
> +  * device drivers whose IP is based around the xp70 slim core. It
> +  * obtains and enables any clocks required by the xp70 core and also
> +  * ioremaps the various IO.
> +  *
> +  * Returns rproc pointer or PTR_ERR() on error.
> +  */
> +
> +struct rproc *xp70_rproc_alloc(struct platform_device *pdev, char *fw_name)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct st_xp70_rproc *xp70_rproc;
> +	struct device_node *np = dev->of_node;
> +	struct rproc *rproc;
> +	struct resource *res;
> +	int err, i;
> +	const struct rproc_fw_ops *elf_ops;
> +
> +	if (!np || !fw_name)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!of_device_is_compatible(np, "st,xp70-rproc"))
> +		return ERR_PTR(-EINVAL);
> +
> +	rproc = rproc_alloc(dev, np->name, &xp70_rproc_ops,
> +			fw_name, sizeof(*xp70_rproc));
> +	if (!rproc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rproc->has_iommu = false;
> +
> +	xp70_rproc = rproc->priv;
> +	xp70_rproc->rproc = rproc;
> +
> +	/* Get standard ELF ops */
> +	elf_ops = rproc_get_elf_ops();
> +
> +	/* Use some generic elf ops */
> +	xp70_rproc_fw_ops.load = elf_ops->load;
> +	xp70_rproc_fw_ops.sanity_check = elf_ops->sanity_check;
> +
> +	rproc->fw_ops = &xp70_rproc_fw_ops;
> +
> +	/* get imem and dmem */
> +	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
> +		res = xp70_rproc->mem[i].io_res;
> +
> +		res = platform_get_resource_byname
> +			(pdev, IORESOURCE_MEM, mem_names[i]);
> +
> +		xp70_rproc->mem[i].cpu_addr = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(xp70_rproc->mem[i].cpu_addr)) {
> +			dev_err(&pdev->dev, "devm_ioremap_resource failed\n");
> +			err = PTR_ERR(xp70_rproc->mem[i].cpu_addr);
> +			goto err;
> +		}
> +		xp70_rproc->mem[i].bus_addr = res->start;
> +		xp70_rproc->mem[i].size = resource_size(res);
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "slimcore");
> +
> +	xp70_rproc->slimcore = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(xp70_rproc->slimcore)) {
> +		dev_err(&pdev->dev, "devm_ioremap_resource failed for slimcore\n");
> +		err = PTR_ERR(xp70_rproc->slimcore);
> +		goto err;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "peripherals");
> +
> +	xp70_rproc->peri = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(xp70_rproc->peri)) {
> +		dev_err(&pdev->dev, "devm_ioremap_resource failed for peri\n");
> +		err = PTR_ERR(xp70_rproc->peri);
> +		goto err;
> +	}
> +
> +	err = xp70_clk_get(xp70_rproc, dev);
> +	if (err)
> +		goto err;
> +
> +	/* Register as a remoteproc device */
> +	err = rproc_add(rproc);
> +	if (err) {
> +		dev_err(dev, "registration of xp70 remoteproc failed\n");
> +		goto err;
> +	}
> +
> +	dev_dbg(dev, "XP70 rproc init successful\n");
> +	return rproc;
> +
> +err:
> +	rproc_put(rproc);
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL(xp70_rproc_alloc);
> +
> +/**
> +  * xp70_rproc_put - put xp70 rproc resources
> +  * @xp70_rproc: Pointer to the st_xp70_rproc struct
> +  *
> +  * Function for calling respective _put() functions on
> +  * xp70_rproc resources.
> +  *
> +  * Returns rproc pointer or PTR_ERR() on error.
> +  */
> +void xp70_rproc_put(struct st_xp70_rproc *xp70_rproc)
> +{
> +	int clk;
> +
> +	if (!xp70_rproc)
> +		return;
> +
> +	rproc_put(xp70_rproc->rproc);
> +
> +	for (clk = 0; clk < XP70_MAX_CLK && xp70_rproc->clks[clk]; clk++)
> +		clk_put(xp70_rproc->clks[clk]);
> +
> +}
> +EXPORT_SYMBOL(xp70_rproc_put);
> +
> +MODULE_AUTHOR("Peter Griffin");
> +MODULE_DESCRIPTION("STMicroelectronics XP70 rproc driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/remoteproc/st_xp70_rproc.h b/include/linux/remoteproc/st_xp70_rproc.h
> new file mode 100644
> index 0000000..3aba2de
> --- /dev/null
> +++ b/include/linux/remoteproc/st_xp70_rproc.h
> @@ -0,0 +1,56 @@
> +/*
> + * st_xp70_rproc.h
> + *
> + * Copyright (C) 2016 STMicroelectronics
> + * Author: Peter Griffin <peter.griffin@linaro.org>
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +#ifndef _ST_XP70_H
> +#define _ST_XP70_H
> +
> +#define XP70_MEM_MAX 2
> +#define XP70_MAX_CLK 4
> +#define NAME_SZ 10
> +
> +enum {
> +	DMEM,
> +	IMEM,
> +};
> +
> +/**
> + * struct xp70_mem - xp70 internal memory structure
> + * @cpu_addr: MPU virtual address of the memory region
> + * @bus_addr: Bus address used to access the memory region
> + * @dev_addr: Device address from Wakeup M3 view
> + * @size: Size of the memory region
> + */
> +struct xp70_mem {
> +	void __iomem *cpu_addr;
> +	phys_addr_t bus_addr;
> +	u32 dev_addr;
> +	size_t size;
> +	struct resource *io_res;
> +};
> +
> +/**
> + * struct st_xp70_rproc - XP70 slim core
> + * @rproc: rproc handle
> + * @pdev: pointer to platform device
> + * @mem: xp70 memory information
> + * @slimcore: xp70 slimcore regs
> + * @peri: xp70 peripheral regs
> + * @clks: xp70 clocks
> + */
> +struct st_xp70_rproc {
> +	struct rproc *rproc;
> +	struct platform_device *pdev;
> +	struct xp70_mem mem[XP70_MEM_MAX];
> +	void __iomem *slimcore;
> +	void __iomem *peri;
> +	struct clk *clks[XP70_MAX_CLK];
> +};
> +
> +struct rproc *xp70_rproc_alloc(struct platform_device *pdev, char *fw_name);
> +void xp70_rproc_put(struct st_xp70_rproc *xp70_rproc);
> +
> +#endif

Hi Peter

Applying this series on top of v4.6 kernel leads to the following 
compilation error due to patch 01/18 :

drivers/remoteproc/st_xp70_rproc.c: In function 'xp70_rproc_alloc':
drivers/remoteproc/st_xp70_rproc.c:291:2: error: implicit declaration of 
function 'rproc_get_elf_ops' [-Werror=implicit-function-declaration]
   elf_ops = rproc_get_elf_ops();
   ^
   LD [M]  drivers/remoteproc/remoteproc.o


Patrice
