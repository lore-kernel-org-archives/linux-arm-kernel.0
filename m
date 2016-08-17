From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 17 Aug 2016 09:37:54 +0900
Subject: [PATCH v6 7/8] PM / devfreq: rockchip: add devfreq driver for
 rk3399 dmc
In-Reply-To: <1471386989-9541-8-git-send-email-hl@rock-chips.com>
References: <1471386989-9541-1-git-send-email-hl@rock-chips.com>
 <CGME20160816223901epcas1p3a2e8b0d0c0ca7e01643bcce90729de5a@epcas1p3.samsung.com>
 <1471386989-9541-8-git-send-email-hl@rock-chips.com>
Message-ID: <57B3B1E2.3040505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

I add just one comment to remove the blank line.

On 2016? 08? 17? 07:36, Lin Huang wrote:
> base on dfi result, we do ddr frequency scaling, register
> dmc driver to devfreq framework, and use simple-ondemand
> policy.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes in v6:
> - fix some nit suggest by Chanwoo Choi
> 
> Changes in v5:
> - improve dmc driver suggest by Chanwoo Choi
> 
> Changes in v4:
> - use arm_smccc_smc() function talk to bl31
> - delete rockchip_dmc.c file and config
> - delete dmc_notify
> - adjust probe order
> 
> Changes in v3:
> - operate dram setting through sip call
> - imporve set rate flow
> 
> Changes in v2:
> - None
> 
> Changes in v1:
> - move dfi controller to event
> - fix set voltage sequence when set rate fail
> - change Kconfig type from tristate to bool
> - move unuse EXPORT_SYMBOL_GPL()
> 
>  drivers/devfreq/Kconfig      |  11 +
>  drivers/devfreq/Makefile     |   1 +
>  drivers/devfreq/rk3399_dmc.c | 497 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 509 insertions(+)
>  create mode 100644 drivers/devfreq/rk3399_dmc.c
> 

[snip]

> +
> +static int rk3399_dmcfreq_probe(struct platform_device *pdev)
> +{
> +	struct arm_smccc_res res;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct rk3399_dmcfreq *data;
> +	int ret, irq, index, size;
> +	uint32_t *timing;
> +	struct dev_pm_opp *opp;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Cannot get the dmc interrupt resource\n");
> +		return -EINVAL;
> +	}
> +	data = devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	mutex_init(&data->lock);
> +
> +	data->vdd_center = devm_regulator_get(dev, "center");
> +	if (IS_ERR(data->vdd_center)) {
> +		dev_err(dev, "Cannot get the regulator \"center\"\n");
> +		return PTR_ERR(data->vdd_center);
> +	}
> +
> +	data->dmc_clk = devm_clk_get(dev, "dmc_clk");
> +	if (IS_ERR(data->dmc_clk)) {
> +		dev_err(dev, "Cannot get the clk dmc_clk\n");
> +		return PTR_ERR(data->dmc_clk);
> +	};
> +
> +	data->irq = irq;
> +	ret = devm_request_irq(dev, irq, rk3399_dmc_irq, 0,
> +			       dev_name(dev), data);
> +	if (ret) {
> +		dev_err(dev, "Failed to request dmc irq: %d\n", ret);
> +		return ret;
> +	}
> +
> +	

Remove the unneeded blank line.

[snip]

Regards,
Chanwoo Choi
