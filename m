From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 02 Aug 2017 01:32:40 +0300
Subject: [PATCH v2 3/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <E1dcBhf-00088t-Os@rmk-PC.armlinux.org.uk>
References: <20170731142906.GX31807@n2100.armlinux.org.uk>
 <E1dcBhf-00088t-Os@rmk-PC.armlinux.org.uk>
Message-ID: <1884159.hmXKyeR78T@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thank you for the patch.

On Monday 31 Jul 2017 15:29:51 Russell King wrote:
> Add a CEC driver for the dw-hdmi hardware.
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/gpu/drm/bridge/synopsys/Kconfig       |   9 +
>  drivers/gpu/drm/bridge/synopsys/Makefile      |   1 +
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 326 +++++++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h |  19 ++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  42 +++-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     |   1 +
>  6 files changed, 397 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
>  create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h

[snip]

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c new file mode 100644
> index 000000000000..52c9d93b9602
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c

[snip]

> +static int dw_hdmi_cec_probe(struct platform_device *pdev)
> +{
> +	struct dw_hdmi_cec_data *data = dev_get_platdata(&pdev->dev);
> +	struct dw_hdmi_cec *cec;
> +	int ret;
> +
> +	if (!data)
> +		return -ENXIO;
> +
> +	/*
> +	 * Our device is just a convenience - we want to link to the real
> +	 * hardware device here, so that userspace can see the association
> +	 * between the HDMI hardware and its associated CEC chardev.
> +	 */
> +	cec = devm_kzalloc(&pdev->dev, sizeof(*cec), GFP_KERNEL);
> +	if (!cec)
> +		return -ENOMEM;
> +
> +	cec->irq = data->irq;
> +	cec->ops = data->ops;
> +	cec->hdmi = data->hdmi;
> +
> +	platform_set_drvdata(pdev, cec);
> +
> +	dw_hdmi_write(cec, 0, HDMI_CEC_TX_CNT);
> +	dw_hdmi_write(cec, ~0, HDMI_CEC_MASK);
> +	dw_hdmi_write(cec, ~0, HDMI_IH_MUTE_CEC_STAT0);
> +	dw_hdmi_write(cec, 0, HDMI_CEC_POLARITY);
> +
> +	cec->adap = cec_allocate_adapter(&dw_hdmi_cec_ops, cec, "dw_hdmi",
> +					 CEC_CAP_LOG_ADDRS | CEC_CAP_TRANSMIT 
|
> +					 CEC_CAP_RC, CEC_MAX_LOG_ADDRS);
> +	if (IS_ERR(cec->adap))
> +		return PTR_ERR(cec->adap);
> +
> +	/* override the module pointer */
> +	cec->adap->owner = THIS_MODULE;
> +
> +	ret = devm_add_action(&pdev->dev, dw_hdmi_cec_del, cec);
> +	if (ret) {
> +		cec_delete_adapter(cec->adap);
> +		return ret;
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, cec->irq,
> +					dw_hdmi_cec_hardirq,
> +					dw_hdmi_cec_thread, IRQF_SHARED,
> +					"dw-hdmi-cec", cec->adap);
> +	if (ret < 0)
> +		return ret;
> +
> +	cec->notify = cec_notifier_get(pdev->dev.parent);
> +	if (!cec->notify)
> +		return -ENOMEM;
> +
> +	ret = cec_register_adapter(cec->adap, pdev->dev.parent);
> +	if (ret < 0) {
> +		cec_notifier_put(cec->notify);
> +		return ret;
> +	}
> +
> +	/*
> +	 * CEC documentation says we must not call cec_delete_adapter
> +	 * after a successful call to cec_register_adapter().
> +	 */
> +	devm_remove_action(&pdev->dev, dw_hdmi_cec_del, cec);

dw_hdmi_cec_del() is only used to clean up in the error path of the probe 
function. It would be simpler and less resource-consuming to add an error 
label to this function instead of using devm.

> +
> +	cec_register_cec_notifier(cec->adap, cec->notify);
> +
> +	return 0;
> +}
> +
> +static int dw_hdmi_cec_remove(struct platform_device *pdev)
> +{
> +	struct dw_hdmi_cec *cec = platform_get_drvdata(pdev);
> +
> +	cec_unregister_adapter(cec->adap);
> +	cec_notifier_put(cec->notify);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver dw_hdmi_cec_driver = {
> +	.probe	= dw_hdmi_cec_probe,
> +	.remove	= dw_hdmi_cec_remove,
> +	.driver = {
> +		.name = "dw-hdmi-cec",
> +	},
> +};
> +module_platform_driver(dw_hdmi_cec_driver);

Is there a particular reason why this has to be a separate module instead of 
simply calling the CEC init/cleanup functions directly from the main dw-hdmi 
driver ?

> +MODULE_AUTHOR("Russell King <rmk+kernel@armlinux.org.uk>");
> +MODULE_DESCRIPTION("Synopsys Designware HDMI CEC driver for i.MX");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS(PLATFORM_MODULE_PREFIX "dw-hdmi-cec");

-- 
Regards,

Laurent Pinchart
