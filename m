From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 25 May 2016 10:10:43 -0700
Subject: [PATCH v4 01/18] remoteproc: st_xp70_rproc: add a xp70 slimcore
 rproc driver
In-Reply-To: <1464192412-16386-3-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160525171043.GT1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 25 May 09:06 PDT 2016, Peter Griffin wrote:

> XP70 slim core is used as a basis for many IPs in the STi
> chipsets such as fdma, display, and demux. To avoid
> duplicating the elf loading code in each device driver
> an xp70 rproc driver has been created.
> 
I like this approach.

[..]

> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
[..]
>  
> +config ST_XP70_REMOTEPROC
> +	tristate "XP70 slim remoteproc support"

As this "driver" in itself doesn't do anything I don't think it makes
sense to have it user selectable. Please make the "clients" select it
instead.

> +	depends on ARCH_STI
> +	select REMOTEPROC
> +	help
> +	  Say y here to support xp70 slim core.
> +	  If unsure say N.
> +
>  endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
[..]
> +#include <linux/clk.h>
> +#include <linux/elf.h>

You should be able to drop inclusion of elf.h now.

[..]
> +static int xp70_clk_get(struct st_xp70_rproc *xp70_rproc, struct device *dev)
> +{
> +	int clk, err = 0;

No need to initialize err.

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
[..]
> +/**
> + * Remoteproc xp70 specific device handlers
> + */
> +static int xp70_rproc_start(struct rproc *rproc)
> +{
> +	struct device *dev = &rproc->dev;
> +	struct st_xp70_rproc *xp70_rproc = rproc->priv;
> +	unsigned long hw_id, hw_ver, fw_rev;
> +	u32 val, ret = 0;

ret should be signed and there's no need to initialize it.

> +
> +	ret = xp70_clk_enable(xp70_rproc);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clocks\n");
> +		goto err_clk;
> +	}
[..]
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

Don't you want to ensure ordering of these writes? Perhaps making this
last one a writel()?

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

Please clean up the indentation and drop the extra newline at the
beginning in this loop.

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


I'm looking at making the resource table optional, good to see another
vote for that. Looks good for now though.

[..]

> +
> +/**
> +  * xp70_rproc_alloc - allocate and initialise xp70 rproc

Drop one of the two spaces indenting this block and add () after then
function name.

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

This should, I believe, only ever happen in development. So if you want
to keep it to aid developers feel free to throw in a WARN_ON() in the
condition.

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

io_res is NULL here, and res is directly assigned again. So drop this
and io_res from the struct.

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

In this case you should also put the clocks.

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

rproc_put() will free your private data, i.e. xp70_rproc, so you must
put your clocks before that.

> +
> +}
> +EXPORT_SYMBOL(xp70_rproc_put);
> +
> +MODULE_AUTHOR("Peter Griffin");
> +MODULE_DESCRIPTION("STMicroelectronics XP70 rproc driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/remoteproc/st_xp70_rproc.h b/include/linux/remoteproc/st_xp70_rproc.h
[..]
> +
> +#define XP70_MEM_MAX 2
> +#define XP70_MAX_CLK 4
> +#define NAME_SZ 10

NAME_SZ seems unused and would be too generic.

> +
> +enum {
> +	DMEM,
> +	IMEM,

These are too generic for a header file.

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

dev_addr is unused.

> +	size_t size;
> +	struct resource *io_res;

io_res is unused.

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

pdev is unused.

> +	struct xp70_mem mem[XP70_MEM_MAX];
> +	void __iomem *slimcore;
> +	void __iomem *peri;
> +	struct clk *clks[XP70_MAX_CLK];
> +};

I generally don't like sharing a struct like this between two
implementations, but I don't think it's worth working around it in this
case.

Perhaps you can group the members into a section of "public" and a
section of "private" members; with a /* st_xp70_rproc private */ heading
the latter?

> +
> +struct rproc *xp70_rproc_alloc(struct platform_device *pdev, char *fw_name);

For consistency I think xp70_rproc_alloc() should return a st_xp70_rproc
reference, rather than forcing the clients pull that pointer out of
rproc->priv.

> +void xp70_rproc_put(struct st_xp70_rproc *xp70_rproc);
> +
> +#endif

Regards,
Bjorn
