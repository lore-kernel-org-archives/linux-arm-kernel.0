From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Wed, 5 Aug 2015 21:11:19 +0000
Subject: [PATCH v3 1/1] misc: sram: add dev_pm_ops to support module power
 gate
In-Reply-To: <1438272681-29338-1-git-send-email-shenwei.wang@freescale.com>
References: <1438272681-29338-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <CY1PR0301MB0843E511B3A98E7EADDD25D483750@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.

Shenwei

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On
> Behalf Of Shenwei Wang
> Sent: 2015?7?30? 11:11
> To: gregkh at linuxfoundation.org; arnd at arndb.de
> Cc: Huang Yongcai-B20788; linux-arm-kernel at lists.infradead.org
> Subject: [PATCH v3 1/1] misc: sram: add dev_pm_ops to support module power
> gate
> 
> When system goes into low power states like SUSPEND_MEM and HIBERNATION,
> the hardware IP block may be powered off to reduce the power consumption.
> This power down will lost all the data inside the ram. This patch added the
> dev_pm_ops and implemented two callbacks: suspend_noirq and resume_noirq,
> which will save the data in the on-chip-ram right before power down and restore
> it after system resumes.
> 
> A new property string named "can-power-gate" is added to the devicetree
> bindings too.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
> Change log:
> 
> PATCH v3
> 	Removed the unnecessary clk_enable/clk_disable.
> 
> PATCH v2
> 	Use vmalloc to allocate the SRAM backup memory.
> 	Code clean up.
> 
>  Documentation/devicetree/bindings/misc/sram.txt |  2 ++
>  drivers/misc/sram.c                             | 42
> +++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/sram.txt
> b/Documentation/devicetree/bindings/misc/sram.txt
> index 36cbe5a..1170086 100644
> --- a/Documentation/devicetree/bindings/misc/sram.txt
> +++ b/Documentation/devicetree/bindings/misc/sram.txt
> @@ -33,6 +33,8 @@ Optional properties in the area nodes:
> 
>  - compatible : standard definition, should contain a vendor specific string
>                 in the form <vendor>,[<device>-]<usage>
> +- can-power-gate: a property to tell the driver that the sram can support
> +		power gate
> 
>  Example:
> 
> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c index 15c33cc..db9f1fa
> 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c
> @@ -30,7 +30,9 @@
> 
>  struct sram_dev {
>  	struct device *dev;
> +	void *power_off_save;
>  	void __iomem *virt_base;
> +	u32 size;
> 
>  	struct gen_pool *pool;
>  	struct clk *clk;
> @@ -156,6 +158,33 @@ static int sram_reserve_regions(struct sram_dev
> *sram, struct resource *res)
>  	return ret;
>  }
> 
> +static int sram_suspend_noirq(struct device *dev) {
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sram_dev *sram = platform_get_drvdata(pdev);
> +
> +	if (!sram->power_off_save)
> +		return 0;
> +
> +	/* Save necessary regs */
> +	memcpy(sram->power_off_save, sram->virt_base, sram->size);
> +
> +	return 0;
> +}
> +
> +static int sram_resume_noirq(struct device *dev) {
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sram_dev *sram = platform_get_drvdata(pdev);
> +
> +	if (!sram->power_off_save)
> +		return 0;
> +
> +	memcpy(sram->virt_base, sram->power_off_save, sram->size);
> +
> +	return 0;
> +}
> +
>  static int sram_probe(struct platform_device *pdev)  {
>  	struct sram_dev *sram;
> @@ -176,6 +205,7 @@ static int sram_probe(struct platform_device *pdev)
>  	}
> 
>  	size = resource_size(res);
> +	sram->size = size;
> 
>  	if (!devm_request_mem_region(sram->dev, res->start, size, pdev->name)) {
>  		dev_err(sram->dev, "could not request region for resource\n"); @@
> -203,6 +233,9 @@ static int sram_probe(struct platform_device *pdev)
> 
>  	platform_set_drvdata(pdev, sram);
> 
> +	if (of_property_read_bool(pdev->dev.of_node, "can-power-gate"))
> +		sram->power_off_save = vmalloc(size);
> +
>  	dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
>  		gen_pool_size(sram->pool) / 1024, sram->virt_base);
> 
> @@ -219,6 +252,9 @@ static int sram_remove(struct platform_device *pdev)
>  	if (sram->clk)
>  		clk_disable_unprepare(sram->clk);
> 
> +	if (sram->power_off_save)
> +		vfree(sram->power_off_save);
> +
>  	return 0;
>  }
> 
> @@ -229,10 +265,16 @@ static const struct of_device_id sram_dt_ids[] = {  };
> #endif
> 
> +static const struct dev_pm_ops sram_pm_ops = {
> +	.suspend_noirq = sram_suspend_noirq,
> +	.resume_noirq = sram_resume_noirq,
> +};
> +
>  static struct platform_driver sram_driver = {
>  	.driver = {
>  		.name = "sram",
>  		.of_match_table = of_match_ptr(sram_dt_ids),
> +		.pm	= &sram_pm_ops,
>  	},
>  	.probe = sram_probe,
>  	.remove = sram_remove,
> --
> 2.5.0.rc2
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
