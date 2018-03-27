From: roy.pledge@nxp.com (Roy Pledge)
Date: Tue, 27 Mar 2018 13:19:48 +0000
Subject: [PATCH v3 2/4] drivers/staging/fsl-mc: Fix DPIO error path issues
References: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
 <1522091134-24646-3-git-send-email-roy.pledge@nxp.com>
 <5e91615b-b2b4-4fe3-4d25-1ae56624976b@arm.com>
Message-ID: <DB6PR04MB2999389243117938BCBA141686AC0@DB6PR04MB2999.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/27/2018 7:05 AM, Robin Murphy wrote:
> Hi Roy,
>
> On 26/03/18 20:05, Roy Pledge wrote:
>> The error path in the dpaa2_dpio_probe() function was not properly
>> unmapping the QBMan device memory on the error path. This was also
>> missing from the dpaa2_dpio_release() function.
>>
>> Also addresses a memory leak of the device private data structure.
>>
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
>> ---
>>    drivers/staging/fsl-mc/bus/dpio/dpio-driver.c | 49 +++++++++++++++++++--------
>>    1 file changed, 34 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
>> index e00f473..e7a0009 100644
>> --- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
>> +++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
>> @@ -28,6 +28,7 @@ MODULE_DESCRIPTION("DPIO Driver");
>>    
>>    struct dpio_priv {
>>    	struct dpaa2_io *io;
>> +	struct dpaa2_io_desc desc;
>>    };
>>    
>>    static irqreturn_t dpio_irq_handler(int irq_num, void *arg)
>> @@ -85,7 +86,6 @@ static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
>>    static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>>    {
>>    	struct dpio_attr dpio_attrs;
>> -	struct dpaa2_io_desc desc;
>>    	struct dpio_priv *priv;
>>    	int err = -ENOMEM;
>>    	struct device *dev = &dpio_dev->dev;
>> @@ -117,7 +117,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>>    		dev_err(dev, "dpio_get_attributes() failed %d\n", err);
>>    		goto err_get_attr;
>>    	}
>> -	desc.qman_version = dpio_attrs.qbman_version;
>> +	priv->desc.qman_version = dpio_attrs.qbman_version;
>>    
>>    	err = dpio_enable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
>>    	if (err) {
>> @@ -126,9 +126,9 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>>    	}
>>    
>>    	/* initialize DPIO descriptor */
>> -	desc.receives_notifications = dpio_attrs.num_priorities ? 1 : 0;
>> -	desc.has_8prio = dpio_attrs.num_priorities == 8 ? 1 : 0;
>> -	desc.dpio_id = dpio_dev->obj_desc.id;
>> +	priv->desc.receives_notifications = dpio_attrs.num_priorities ? 1 : 0;
>> +	priv->desc.has_8prio = dpio_attrs.num_priorities == 8 ? 1 : 0;
>> +	priv->desc.dpio_id = dpio_dev->obj_desc.id;
>>    
>>    	/* get the cpu to use for the affinity hint */
>>    	if (next_cpu == -1)
>> @@ -139,19 +139,28 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>>    	if (!cpu_possible(next_cpu)) {
>>    		dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
>>    		err = -ERANGE;
>> -		goto err_allocate_irqs;
>> +		goto err_too_many_cpu;
>>    	}
>> -	desc.cpu = next_cpu;
>> +	priv->desc.cpu = next_cpu;
>>    
>>    	/*
>>    	 * Set the CENA regs to be the cache inhibited area of the portal to
>>    	 * avoid coherency issues if a user migrates to another core.
>>    	 */
>> -	desc.regs_cena = memremap(dpio_dev->regions[1].start,
>> -				  resource_size(&dpio_dev->regions[1]),
>> -				  MEMREMAP_WC);
>> -	desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
>> -				 resource_size(&dpio_dev->regions[1]));
>> +	priv->desc.regs_cena = memremap(dpio_dev->regions[1].start,
>> +					resource_size(&dpio_dev->regions[1]),
>> +					MEMREMAP_WC);
> Since you already have some devres-managed resources in this driver,
> maybe use devm_memremap? (and perhaps convert the existing ioremap too)
That would make since - will do.
>
>> +	if (!priv->desc.regs_cena) {
>> +		dev_err(dev, "memremap failed\n");
>> +		goto err_too_many_cpu;
>> +	}
>> +
>> +	priv->desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
>> +				       resource_size(&dpio_dev->regions[1]));
>> +	if (!priv->desc.regs_cinh) {
>> +		dev_err(dev, "ioremap failed\n");
>> +		goto err_ioremap_failed;
>> +	}
>>    
>>    	err = fsl_mc_allocate_irqs(dpio_dev);
>>    	if (err) {
>> @@ -159,11 +168,11 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>>    		goto err_allocate_irqs;
>>    	}
>>    
>> -	err = register_dpio_irq_handlers(dpio_dev, desc.cpu);
>> +	err = register_dpio_irq_handlers(dpio_dev, priv->desc.cpu);
>>    	if (err)
>>    		goto err_register_dpio_irq;
>>    
>> -	priv->io = dpaa2_io_create(&desc);
>> +	priv->io = dpaa2_io_create(&priv->desc);
>>    	if (!priv->io) {
>>    		dev_err(dev, "dpaa2_io_create failed\n");
>>    		goto err_dpaa2_io_create;
>> @@ -171,7 +180,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>>    
>>    	dev_info(dev, "probed\n");
>>    	dev_dbg(dev, "   receives_notifications = %d\n",
>> -		desc.receives_notifications);
>> +		priv->desc.receives_notifications);
>>    	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
>>    	fsl_mc_portal_free(dpio_dev->mc_io);
>>    
>> @@ -182,6 +191,10 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>>    err_register_dpio_irq:
>>    	fsl_mc_free_irqs(dpio_dev);
>>    err_allocate_irqs:
>> +	iounmap(priv->desc.regs_cinh);
>> +err_ioremap_failed:
>> +	memunmap(priv->desc.regs_cena);
> ...then you wouldn't need to worry about this.
>
>> +err_too_many_cpu:
>>    	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
>>    err_get_attr:
>>    	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
>> @@ -189,6 +202,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>>    	fsl_mc_portal_free(dpio_dev->mc_io);
>>    err_mcportal:
>>    	dev_set_drvdata(dev, NULL);
>> +	devm_kfree(dev, priv);
> The whole point of devm_* is that you don't need to do this - the devres
> entries are freed automatically by the driver core upon probe failure or
> driver detach, i.e. priv was never leaking.
Right - Not sure what I was thinking yesterday. I think I saw the alloc 
without free and instinctively
added it.? I will remove this.
>
>>    err_priv_alloc:
>>    	return err;
>>    }
>> @@ -230,8 +244,13 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
>>    
>>    	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
>>    
>> +	iounmap(priv->desc.regs_cinh);
>> +	memunmap(priv->desc.regs_cena);
>> +
>>    	fsl_mc_portal_free(dpio_dev->mc_io);
>>    
>> +	devm_kfree(dev, priv);
>> +
>>    	dev_set_drvdata(dev, NULL);
> Note that clearing drvdata is something else the driver core already
> does at about the same time as cleaning up devres entries (see
> __device_release_driver() and the failure path of really_probe(), in
> drivers/base/dd.c), so this has been similarly superfluous all along.
Yes I'll clean this up too.? Thanks for the comments, this will make 
things better for sure.
>
> Robin.
>
