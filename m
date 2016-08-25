From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 25 Aug 2016 17:41:24 +0100
Subject: [PATCH v7 01/16] remoteproc: st_slim_rproc: add a slimcore rproc
 driver
In-Reply-To: <20160810192922.GR26240@tuxbot>
References: <1470071453-10730-1-git-send-email-peter.griffin@linaro.org>
 <1470071453-10730-2-git-send-email-peter.griffin@linaro.org>
 <20160810192922.GR26240@tuxbot>
Message-ID: <20160825164124.GE3281@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Wed, 10 Aug 2016, Bjorn Andersson wrote:

> On Mon 01 Aug 10:10 PDT 2016, Peter Griffin wrote:
> 
> Sorry for the slow response, but I have a few more (small) concerns.

No problem, thanks for reviewing. Equally I've been away on holiday last 3
weeks, so sorry about my delay as well :)
> 
> [..]
> > diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
> [..]
> > +static int slim_rproc_start(struct rproc *rproc)
> > +{
> > +	struct device *dev = &rproc->dev;
> > +	struct st_slim_rproc *slim_rproc = rproc->priv;
> > +	unsigned long hw_id, hw_ver, fw_rev;
> > +	u32 val;
> > +	int ret;
> > +
> > +	ret = slim_clk_enable(slim_rproc);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable clocks\n");
> > +		goto err_clk;
> 
> Nit. just return ret here and have a static "return 0" at the bottom.

Will fix.

> 
> > +	}
> > +
> > +	/* disable CPU pipeline clock & reset cpu pipeline */
> > +	val = SLIM_CLK_GATE_DIS | SLIM_CLK_GATE_RESET;
> > +	writel(val, slim_rproc->slimcore + SLIM_CLK_GATE_OFST);
> > +
> > +	/* disable SLIM core STBus sync */
> > +	writel(SLIM_STBUS_SYNC_DIS, slim_rproc->peri + SLIM_STBUS_SYNC_OFST);
> > +
> > +	/* enable cpu pipeline clock */
> > +	writel(!SLIM_CLK_GATE_DIS,
> > +		slim_rproc->slimcore + SLIM_CLK_GATE_OFST);
> > +
> > +	/* clear int & cmd mailbox */
> > +	writel(~0U, slim_rproc->peri + SLIM_INT_CLR_OFST);
> > +	writel(~0U, slim_rproc->peri + SLIM_CMD_CLR_OFST);
> > +
> > +	/* enable all channels cmd & int */
> > +	writel(~0U, slim_rproc->peri + SLIM_INT_MASK_OFST);
> > +	writel(~0U, slim_rproc->peri + SLIM_CMD_MASK_OFST);
> > +
> > +	/* enable cpu */
> > +	writel(SLIM_EN_RUN, slim_rproc->slimcore + SLIM_EN_OFST);
> > +
> > +	hw_id = readl_relaxed(slim_rproc->slimcore + SLIM_ID_OFST);
> > +	hw_ver = readl_relaxed(slim_rproc->slimcore + SLIM_VER_OFST);
> > +
> > +	fw_rev = readl(slim_rproc->mem[SLIM_DMEM].cpu_addr +
> > +			SLIM_REV_ID_OFST);
> > +
> > +	dev_info(dev, "fw rev:%ld.%ld on SLIM %ld.%ld\n",
> > +		 SLIM_REV_ID_MAJ(fw_rev), SLIM_REV_ID_MIN(fw_rev),
> > +		 hw_id, hw_ver);
> > +
> > +err_clk:
> > +	return ret;
> > +}
> > +
> > +static int slim_rproc_stop(struct rproc *rproc)
> > +{
> > +	struct st_slim_rproc *slim_rproc = rproc->priv;
> > +	u32 val;
> > +
> > +	/* mask all (cmd & int) channels */
> > +	writel(0UL, slim_rproc->peri + SLIM_INT_MASK_OFST);
> > +	writel(0UL, slim_rproc->peri + SLIM_CMD_MASK_OFST);
> > +
> > +	/* disable cpu pipeline clock */
> > +	writel(SLIM_CLK_GATE_DIS
> > +		, slim_rproc->slimcore + SLIM_CLK_GATE_OFST);
> 
> Odd placement of ','

Will fix.

> 
> > +
> > +	writel(!SLIM_EN_RUN, slim_rproc->slimcore + SLIM_EN_OFST);
> > +
> > +	val = readl(slim_rproc->slimcore + SLIM_EN_OFST);
> > +	if (val & SLIM_EN_RUN)
> > +		dev_warn(&rproc->dev, "Failed to disable SLIM");
> > +
> > +	slim_clk_disable(slim_rproc);
> > +
> > +	dev_dbg(&rproc->dev, "slim stopped\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static void *slim_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
> > +{
> > +	struct st_slim_rproc *slim_rproc = rproc->priv;
> > +	void *va = NULL;
> > +	int i;
> > +
> > +	for (i = 0; i < SLIM_MEM_MAX; i++) {
> > +		if (da != slim_rproc->mem[i].bus_addr)
> > +			continue;
> 
> Are you sure you want to enforce this being called with da == base? (I'm
> not totally against it).

Yes.

> 
> But you should probably double check that len is <= mem[i].size.

Good point, I will add a check for this.

> 
> > +		/* __force to make sparse happy with type conversion */
> > +		va = (__force void *)slim_rproc->mem[i].cpu_addr;
> > +		break;
> > +	}
> > +
> > +	dev_dbg(&rproc->dev, "%s: da = 0x%llx len = 0x%x va = 0x%p\n",
> > +		__func__, da, len, va);
> > +
> > +	return va;
> > +}
> > +
> > +static struct rproc_ops slim_rproc_ops = {
> > +	.start		= slim_rproc_start,
> > +	.stop		= slim_rproc_stop,
> > +	.da_to_va       = slim_rproc_da_to_va,
> > +};
> > +
> > +/**
> > + * Firmware handler operations: sanity, boot address, load ...
> > + */
> > +
> > +static struct resource_table empty_rsc_tbl = {
> > +	.ver = 1,
> > +	.num = 0,
> > +};
> > +
> > +static struct resource_table *slim_rproc_find_rsc_table(struct rproc *rproc,
> > +					       const struct firmware *fw,
> > +					       int *tablesz)
> > +{
> > +	if (!fw)
> > +		return NULL;
> 
> I consider it a BUG in the core to get here with fw == NULL, so please
> drop this.

Ok will drop in next version.

> 
> > +
> > +	*tablesz = sizeof(empty_rsc_tbl);
> > +	return &empty_rsc_tbl;
> > +}
> > +
> > +static struct resource_table *slim_rproc_find_loaded_rsc_table(struct rproc *rproc,
> > +						      const struct firmware *fw)
> > +{
> > +	if (!fw)
> > +		return NULL;
> > +
> 
> fw can't be NULL, so please drop this check.

Ok will fix.
> 
> > +	return &empty_rsc_tbl;
> 
> This function is supposed to return a pointer to the resource table as
> it appears in the space of the running firmware, so that any vring
> updates etc are visible to the remote.
> 
> As your firmware doesn't do this you should return NULL here, rather
> than a pointer back to the fake resource table.
> 
> But rproc_find_loaded_rsc_table() will do the same if you omit the
> reference in the fw_ops struct, so just make that NULL instead.

Good point. Will omit the reference in fw_ops struct in the next version.

> 
> > +}
> > +
> > +static struct rproc_fw_ops slim_rproc_fw_ops = {
> > +	.find_rsc_table = slim_rproc_find_rsc_table,
> > +	.find_loaded_rsc_table = slim_rproc_find_loaded_rsc_table,
> > +};
> > +
> > +
> > +/**
> > + * slim_rproc_alloc() - allocate and initialise slim rproc
> > + * @pdev: Pointer to the platform_device struct
> > + * @fw_name: Name of firmware for rproc to use
> > + *
> > + * Function for allocating and initialising a slim rproc for use by
> > + * device drivers whose IP is based around the slim slim core. It
> > + * obtains and enables any clocks required by the slim core and also
> > + * ioremaps the various IO.
> > + *
> > + * Returns st_slim_rproc pointer or PTR_ERR() on error.
> > + */
> > +
> > +struct st_slim_rproc *slim_rproc_alloc(struct platform_device *pdev,
> > +				char *fw_name)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct st_slim_rproc *slim_rproc;
> > +	struct device_node *np = dev->of_node;
> > +	struct rproc *rproc;
> > +	struct resource *res;
> > +	int err, i;
> > +	const struct rproc_fw_ops *elf_ops;
> > +
> > +	if (WARN_ON(!np || !fw_name))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (!of_device_is_compatible(np, "st,slim-rproc"))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	rproc = rproc_alloc(dev, np->name, &slim_rproc_ops,
> > +			fw_name, sizeof(*slim_rproc));
> > +	if (!rproc)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rproc->has_iommu = false;
> > +
> > +	slim_rproc = rproc->priv;
> > +	slim_rproc->rproc = rproc;
> > +
> > +	elf_ops = rproc->fw_ops;
> > +	/* Use some generic elf ops */
> > +	slim_rproc_fw_ops.load = elf_ops->load;
> > +	slim_rproc_fw_ops.sanity_check = elf_ops->sanity_check;
> > +
> > +	rproc->fw_ops = &slim_rproc_fw_ops;
> > +
> > +	/* get imem and dmem */
> > +	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
> > +
> > +		res = platform_get_resource_byname
> > +			(pdev, IORESOURCE_MEM, mem_names[i]);
> 
> This is an odd line breakage.

Will fix.
 
> 
> > +
> > +		slim_rproc->mem[i].cpu_addr = devm_ioremap_resource(dev, res);
> > +		if (IS_ERR(slim_rproc->mem[i].cpu_addr)) {
> > +			dev_err(&pdev->dev, "devm_ioremap_resource failed\n");
> > +			err = PTR_ERR(slim_rproc->mem[i].cpu_addr);
> > +			goto err;
> > +		}
> > +		slim_rproc->mem[i].bus_addr = res->start;
> > +		slim_rproc->mem[i].size = resource_size(res);
> > +	}
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "slimcore");
> > +
> > +	slim_rproc->slimcore = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(slim_rproc->slimcore)) {
> > +		dev_err(&pdev->dev,
> > +			"devm_ioremap_resource failed for slimcore\n");
> > +		err = PTR_ERR(slim_rproc->slimcore);
> > +		goto err;
> > +	}
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "peripherals");
> > +
> > +	slim_rproc->peri = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(slim_rproc->peri)) {
> > +		dev_err(&pdev->dev, "devm_ioremap_resource failed for peri\n");
> > +		err = PTR_ERR(slim_rproc->peri);
> > +		goto err;
> > +	}
> > +
> > +	err = slim_clk_get(slim_rproc, dev);
> > +	if (err)
> > +		goto err;
> > +
> > +	/* Register as a remoteproc device */
> > +	err = rproc_add(rproc);
> > +	if (err) {
> > +		dev_err(dev, "registration of slim remoteproc failed\n");
> > +		goto err_clk;
> > +	}
> > +
> > +	return slim_rproc;
> > +
> > +err_clk:
> > +	for (i = 0; i < SLIM_MAX_CLK && slim_rproc->clks[i]; i++)
> > +		clk_put(slim_rproc->clks[i]);
> 
> Is there any chance to could acquire these clocks by name instead of
> just picking up 4 "random" clocks from the DT node?

Not using clock names here was deliberate because the slim core is used as a
basis for various IP's in the SoC, the clock names and number of them in the
functional spec for the particular IP can change a lot.

For instance all fdma instances have 4 clocks of various names, but the
c8sectpfe demux IP also based around slim core only has one clock called STFE.

The inspiration for this approach was taken from ehci-platform.c and
ohci-platform.c drivers which have to work across a wide range of SoC's from different
vendors and can also have many different clocks and clock names / reset lines
and reset names & phys etc.

> 
> You are generally supposed to use clock-names and could then use
> devm_clk_get() instead...
> 
> > +err:
> > +	rproc_put(rproc);
> > +	return ERR_PTR(err);
> > +}
> > +EXPORT_SYMBOL(slim_rproc_alloc);
> > +
> > +/**
> > +  * slim_rproc_put() - put slim rproc resources
> > +  * @slim_rproc: Pointer to the st_slim_rproc struct
> > +  *
> > +  * Function for calling respective _put() functions on
> > +  * slim_rproc resources.
> > +  *
> > +  */
> > +void slim_rproc_put(struct st_slim_rproc *slim_rproc)
> > +{
> > +	int clk;
> > +
> > +	if (!slim_rproc)
> > +		return;
> > +
> > +	for (clk = 0; clk < SLIM_MAX_CLK && slim_rproc->clks[clk]; clk++)
> > +		clk_put(slim_rproc->clks[clk]);
> > +
> 
> You need to rproc_del() here before calling rproc_put().

Will fix.

> 
> > +	rproc_put(slim_rproc->rproc);
> > +}
> > +EXPORT_SYMBOL(slim_rproc_put);
> > +
> > +MODULE_AUTHOR("Peter Griffin");
> > +MODULE_DESCRIPTION("STMicroelectronics SLIM rproc driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/remoteproc/st_slim_rproc.h b/include/linux/remoteproc/st_slim_rproc.h
> > new file mode 100644
> > index 0000000..c300b3e
> > --- /dev/null
> > +++ b/include/linux/remoteproc/st_slim_rproc.h
> > @@ -0,0 +1,53 @@
> > +/*
> > + * st_slim_rproc.h
> > + *
> > + * Copyright (C) 2016 STMicroelectronics
> > + * Author: Peter Griffin <peter.griffin@linaro.org>
> > + * License terms:  GNU General Public License (GPL), version 2
> > + */
> > +#ifndef _ST_SLIM_H
> > +#define _ST_SLIM_H
> > +
> > +#define SLIM_MEM_MAX 2
> > +#define SLIM_MAX_CLK 4
> > +
> > +enum {
> > +	SLIM_DMEM,
> > +	SLIM_IMEM,
> > +};
> > +
> > +/**
> > + * struct slim_mem - slim internal memory structure
> > + * @cpu_addr: MPU virtual address of the memory region
> > + * @bus_addr: Bus address used to access the memory region
> > + * @size: Size of the memory region
> > + */
> > +struct slim_mem {
> > +	void __iomem *cpu_addr;
> > +	phys_addr_t bus_addr;
> > +	size_t size;
> > +};
> > +
> 
> With things like slimbus being worked on I don't think it's appropriate
> to introduce public constants named SLIM_* or slim_*. Please rename
> these ST_SLIM_* and st_slim_*

Ok, will fix.

Regards,

Peter.
