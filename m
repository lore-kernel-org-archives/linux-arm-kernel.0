From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 24 Jul 2015 13:16:59 -0700
Subject: [PATCH 1/1] misc: sram: add dev_pm_ops to support module power
 gate
In-Reply-To: <1437757979-25889-1-git-send-email-shenwei.wang@freescale.com>
References: <1437757979-25889-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <55B29D3B.8030402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/15 10:12, Shenwei Wang wrote:
> When system goes into low power states like SUSPEND_MEM and
> HIBERNATION, the hardware IP block may be powered off to reduce
> the power consumption. This power down will lost all the
> data inside the ram. This patch added the dev_pm_ops and
> implemented two callbacks: suspend_noirq and resume_noirq, which
> will save the data in the on-chip-ram right before power down
> and restore it after system resumes.
> 
> A new property string named "can-power-gate" is added to
> the devicetree bindings too.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---

[snip]

> +static int sram_suspend_noirq(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sram_dev *sram = platform_get_drvdata(pdev);
> +
> +	if (!sram->power_off_save)
> +		return 0;
> +
> +	/* Save necessary regs */
> +	clk_enable(sram->clk);
> +	memcpy(sram->power_off_save, sram->virt_base,gen_pool_size(sram->pool));
> +	clk_disable(sram->clk);

memcpy_fromio()?

> +
> +	return 0;
> +}
> +
> +static int sram_resume_noirq(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sram_dev *sram = platform_get_drvdata(pdev);
> +
> +	if (!sram->power_off_save)
> +		return 0;
> +
> +	clk_enable(sram->clk);
> +	memcpy(sram->virt_base, sram->power_off_save, gen_pool_size(sram->pool));

memcpy_toio()?

> +	clk_disable(sram->clk);
> +
> +	return 0;
> +}
> +
>  static int sram_probe(struct platform_device *pdev)
>  {
>  	struct sram_dev *sram;
> @@ -203,6 +235,12 @@ static int sram_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sram);
>  
> +	if (of_get_property(pdev->dev.of_node, "can-power-gate", NULL))

Since this is a boolean you could use of_property_read_bool()

> +	{
> +		sram->power_off_save = devm_kzalloc(&pdev->dev,
> +				gen_pool_size(sram->pool), GFP_KERNEL);

Parenthesis not needed.

This will only work with SRAM sizes which are small enough they can be
serviced by kzalloc() allocations. The problem is that you might
actually need direct-mapped memory but what if you have larger SRAMs
that are several MB? Maybe there should be a check here to prevent that.

> +	}
> +
>  	dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
>  		gen_pool_size(sram->pool) / 1024, sram->virt_base);
>  
> @@ -229,10 +267,16 @@ static const struct of_device_id sram_dt_ids[] = {
>  };
>  #endif
>  
> +static const struct dev_pm_ops sram_pm_ops = {
> +	.suspend_noirq = sram_suspend_noirq,
> +	.resume_noirq = sram_resume_noirq,
> +};

You may have to enclose this within an ifdef CONFIG_PM_SLEEP/endif
statement not to cause warnings if CONFIG_PM_SLEEP is disabled.
-- 
Florian
