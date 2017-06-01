From: Jose.Abreu@synopsys.com (Jose Abreu)
Date: Thu, 1 Jun 2017 01:53:21 +0100
Subject: [PATCH 4/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <E1dFi3P-0004lv-2K@rmk-PC.armlinux.org.uk>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3P-0004lv-2K@rmk-PC.armlinux.org.uk>
Message-ID: <e254fcf9-79bc-4ffc-284f-e52c80069fe3@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,


On 30-05-2017 15:23, Russell King wrote:
> Add a CEC driver for the dw-hdmi hardware.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/gpu/drm/bridge/synopsys/Kconfig       |   8 +
>  drivers/gpu/drm/bridge/synopsys/Makefile      |   1 +
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 320 ++++++++++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h |  19 ++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  40 +++-
>  5 files changed, 387 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
>  create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
> index 40d2827a6d19..bd30a0a07272 100644
> --- a/drivers/gpu/drm/bridge/synopsys/Kconfig
> +++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
> @@ -21,3 +21,11 @@ config DRM_DW_HDMI_I2S_AUDIO
>  	help
>  	  Support the I2S Audio interface which is part of the Synopsys
>  	  Designware HDMI block.
> +
> +config DRM_DW_HDMI_CEC
> +	tristate "Synopsis Designware CEC interface"
> +	depends on DRM_DW_HDMI && MEDIA_CEC_SUPPORT
> +	select MEDIA_CEC_NOTIFIER
> +	help
> +	  Support the CE interface which is part of the Synopsis

Synopsis -> Synopsys

> +	  Designware HDMI block.
> diff --git a/drivers/gpu/drm/bridge/synopsys/Makefile b/drivers/gpu/drm/bridge/synopsys/Makefile
> index 17aa7a65b57e..6fe415903668 100644
> --- a/drivers/gpu/drm/bridge/synopsys/Makefile
> +++ b/drivers/gpu/drm/bridge/synopsys/Makefile
> @@ -3,3 +3,4 @@
>  obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
>  obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
>  obj-$(CONFIG_DRM_DW_HDMI_I2S_AUDIO) += dw-hdmi-i2s-audio.o
> +obj-$(CONFIG_DRM_DW_HDMI_CEC) += dw-hdmi-cec.o
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> new file mode 100644
> index 000000000000..761ef5ae687d
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> @@ -0,0 +1,320 @@
> +/*
> + * Designware HDMI CEC driver
> + *
> + * Copyright (C) 2015-2017 Russell King.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +
> +#include <drm/drm_edid.h>
> +
> +#include <media/cec.h>
> +#include <media/cec-notifier.h>
> +
> +#include "dw-hdmi-cec.h"
> +
> +enum {
> +	HDMI_IH_CEC_STAT0	= 0x0106,
> +	HDMI_IH_MUTE_CEC_STAT0	= 0x0186,
> +
> +	HDMI_CEC_CTRL		= 0x7d00,
> +	CEC_CTRL_START		= BIT(0),
> +	CEC_CTRL_NORMAL		= 1 << 1,
> +
> +	HDMI_CEC_STAT		= 0x7d01,
> +	CEC_STAT_DONE		= BIT(0),
> +	CEC_STAT_EOM		= BIT(1),
> +	CEC_STAT_NACK		= BIT(2),
> +	CEC_STAT_ARBLOST	= BIT(3),
> +	CEC_STAT_ERROR_INIT	= BIT(4),
> +	CEC_STAT_ERROR_FOLL	= BIT(5),
> +	CEC_STAT_WAKEUP		= BIT(6),

I rather like the format HDMI_{REGISTER_NAME}_{FIELD_NAME} so
that it clearly identifies this is a internal driver register and
not a CEC core register, but I guess its up to you :)

> +
> +	HDMI_CEC_MASK		= 0x7d02,
> +	HDMI_CEC_POLARITY	= 0x7d03,
> +	HDMI_CEC_INT		= 0x7d04,
> +	HDMI_CEC_ADDR_L		= 0x7d05,
> +	HDMI_CEC_ADDR_H		= 0x7d06,
> +	HDMI_CEC_TX_CNT		= 0x7d07,
> +	HDMI_CEC_RX_CNT		= 0x7d08,
> +	HDMI_CEC_TX_DATA0	= 0x7d10,
> +	HDMI_CEC_RX_DATA0	= 0x7d20,
> +	HDMI_CEC_LOCK		= 0x7d30,
> +	HDMI_CEC_WKUPCTRL	= 0x7d31,
> +};
> +
> +struct dw_hdmi_cec {
> +	struct dw_hdmi *hdmi;
> +	const struct dw_hdmi_cec_ops *ops;
> +	u32 addresses;
> +	struct cec_adapter *adap;
> +	struct cec_msg rx_msg;
> +	unsigned int tx_status;
> +	bool tx_done;
> +	bool rx_done;
> +	struct cec_notifier *notify;
> +	int retries;
> +	int irq;
> +};
> +
> +static void dw_hdmi_write(struct dw_hdmi_cec *cec, u8 val, int offset)
> +{
> +	cec->ops->write(cec->hdmi, val, offset);
> +}
> +
> +static u8 dw_hdmi_read(struct dw_hdmi_cec *cec, int offset)
> +{
> +	return cec->ops->read(cec->hdmi, offset);
> +}
> +
> +static int dw_hdmi_cec_log_addr(struct cec_adapter *adap, u8 logical_addr)
> +{
> +	struct dw_hdmi_cec *cec = adap->priv;

You can use "cec = cec_get_drvdata(adap)" here, as in the rest of
the code.

> +	u32 addresses;
> +
> +	if (logical_addr == CEC_LOG_ADDR_INVALID)
> +		addresses = cec->addresses = 0;
> +	else
> +		addresses = cec->addresses |= BIT(logical_addr) | BIT(15);
> +
> +	dw_hdmi_write(cec, addresses & 255, HDMI_CEC_ADDR_L);
> +	dw_hdmi_write(cec, addresses >> 8, HDMI_CEC_ADDR_H);
> +
> +	return 0;
> +}
> +
> +static int dw_hdmi_cec_transmit(struct cec_adapter *adap, u8 attempts,
> +				u32 signal_free_time, struct cec_msg *msg)
> +{
> +	struct dw_hdmi_cec *cec = adap->priv;
> +	unsigned i;
> +
> +	cec->retries = attempts;

I think you should check first if CEC engine is in normal
operation mode, as a safety measure.

> +
> +	for (i = 0; i < msg->len; i++)
> +		dw_hdmi_write(cec, msg->msg[i], HDMI_CEC_TX_DATA0 + i);
> +
> +	dw_hdmi_write(cec, msg->len, HDMI_CEC_TX_CNT);
> +	dw_hdmi_write(cec, CEC_CTRL_NORMAL | CEC_CTRL_START, HDMI_CEC_CTRL);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t dw_hdmi_cec_hardirq(int irq, void *data)
> +{
> +	struct cec_adapter *adap = data;
> +	struct dw_hdmi_cec *cec = adap->priv;
> +	unsigned stat = dw_hdmi_read(cec, HDMI_IH_CEC_STAT0);
> +	irqreturn_t ret = IRQ_HANDLED;
> +
> +	if (stat == 0)
> +		return IRQ_NONE;
> +
> +	dw_hdmi_write(cec, stat, HDMI_IH_CEC_STAT0);
> +
> +	if (stat & CEC_STAT_ERROR_INIT) {
> +		if (cec->retries) {
> +			unsigned v = dw_hdmi_read(cec, HDMI_CEC_CTRL);
> +			dw_hdmi_write(cec, v | CEC_CTRL_START, HDMI_CEC_CTRL);
> +			cec->retries -= 1;
> +		} else {
> +			cec->tx_status = CEC_TX_STATUS_MAX_RETRIES;
> +			cec->tx_done = true;
> +			ret = IRQ_WAKE_THREAD;
> +		}
> +	} else if (stat & CEC_STAT_DONE) {
> +		cec->tx_status = CEC_TX_STATUS_OK;
> +		cec->tx_done = true;
> +		ret = IRQ_WAKE_THREAD;
> +	} else if (stat & CEC_STAT_NACK) {
> +		cec->tx_status = CEC_TX_STATUS_NACK;
> +		cec->tx_done = true;
> +		ret = IRQ_WAKE_THREAD;
> +	}
> +
> +	if (stat & CEC_STAT_EOM) {
> +		unsigned len, i;
> +
> +		len = dw_hdmi_read(cec, HDMI_CEC_RX_CNT);
> +		if (len > sizeof(cec->rx_msg.msg))
> +			len = sizeof(cec->rx_msg.msg);
> +
> +		for (i = 0; i < len; i++)
> +			cec->rx_msg.msg[i] =
> +				dw_hdmi_read(cec, HDMI_CEC_RX_DATA0 + i);
> +
> +		dw_hdmi_write(cec, 0, HDMI_CEC_LOCK);
> +
> +		cec->rx_msg.len = len;
> +		smp_wmb();
> +		cec->rx_done = true;
> +
> +		ret = IRQ_WAKE_THREAD;
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t dw_hdmi_cec_thread(int irq, void *data)
> +{
> +	struct cec_adapter *adap = data;
> +	struct dw_hdmi_cec *cec = adap->priv;
> +
> +	if (cec->tx_done) {
> +		cec->tx_done = false;
> +		cec_transmit_done(adap, cec->tx_status, 0, 0, 0, 0);
> +	}
> +	if (cec->rx_done) {
> +		cec->rx_done = false;
> +		smp_rmb();
> +		cec_received_msg(adap, &cec->rx_msg);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static int dw_hdmi_cec_enable(struct cec_adapter *adap, bool enable)
> +{
> +	struct dw_hdmi_cec *cec = adap->priv;
> +
> +	if (!enable) {
> +		dw_hdmi_write(cec, ~0, HDMI_CEC_MASK);
> +		dw_hdmi_write(cec, ~0, HDMI_IH_MUTE_CEC_STAT0);
> +		dw_hdmi_write(cec, 0, HDMI_CEC_POLARITY);
> +
> +		cec->ops->disable(cec->hdmi);
> +	} else {
> +		unsigned irqs;
> +
> +		dw_hdmi_write(cec, 0, HDMI_CEC_CTRL);
> +		dw_hdmi_write(cec, ~0, HDMI_IH_CEC_STAT0);
> +		dw_hdmi_write(cec, 0, HDMI_CEC_LOCK);
> +
> +		dw_hdmi_cec_log_addr(cec->adap, CEC_LOG_ADDR_INVALID);
> +
> +		cec->ops->enable(cec->hdmi);
> +
> +		irqs = CEC_STAT_ERROR_INIT | CEC_STAT_NACK | CEC_STAT_EOM |
> +		       CEC_STAT_DONE;
> +		dw_hdmi_write(cec, irqs, HDMI_CEC_POLARITY);
> +		dw_hdmi_write(cec, ~irqs, HDMI_CEC_MASK);
> +		dw_hdmi_write(cec, ~irqs, HDMI_IH_MUTE_CEC_STAT0);
> +	}
> +	return 0;
> +}
> +
> +static const struct cec_adap_ops dw_hdmi_cec_ops = {
> +	.adap_enable = dw_hdmi_cec_enable,
> +	.adap_log_addr = dw_hdmi_cec_log_addr,
> +	.adap_transmit = dw_hdmi_cec_transmit,
> +};
> +
> +static void dw_hdmi_cec_del(void *data)
> +{
> +	struct dw_hdmi_cec *cec = data;
> +
> +	cec_delete_adapter(cec->adap);
> +}
> +
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
> +					 CEC_CAP_LOG_ADDRS | CEC_CAP_TRANSMIT |
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
> +
> +MODULE_AUTHOR("Russell King <rmk+kernel@armlinux.org.uk>");
> +MODULE_DESCRIPTION("Synopsis Designware HDMI CEC driver for i.MX");

Synopsis -> Synopsys

> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS(PLATFORM_MODULE_PREFIX "dw-hdmi-cec");
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h
> new file mode 100644
> index 000000000000..cf4dc121a2c4
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h
> @@ -0,0 +1,19 @@
> +#ifndef DW_HDMI_CEC_H
> +#define DW_HDMI_CEC_H
> +
> +struct dw_hdmi;
> +
> +struct dw_hdmi_cec_ops {
> +	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
> +	u8 (*read)(struct dw_hdmi *hdmi, int offset);
> +	void (*enable)(struct dw_hdmi *hdmi);
> +	void (*disable)(struct dw_hdmi *hdmi);
> +};
> +
> +struct dw_hdmi_cec_data {
> +	struct dw_hdmi *hdmi;
> +	const struct dw_hdmi_cec_ops *ops;
> +	int irq;
> +};
> +
> +#endif
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 58781d4c1034..5a389f1f58d9 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -35,6 +35,7 @@
>  
>  #include "dw-hdmi.h"
>  #include "dw-hdmi-audio.h"
> +#include "dw-hdmi-cec.h"
>  
>  #include <media/cec-notifier.h>
>  
> @@ -133,6 +134,7 @@ struct dw_hdmi {
>  	unsigned int version;
>  
>  	struct platform_device *audio;
> +	struct platform_device *cec;
>  	struct device *dev;
>  	struct clk *isfr_clk;
>  	struct clk *iahb_clk;
> @@ -1766,7 +1768,6 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
>  	hdmi_writeb(hdmi, 0xff, HDMI_AUD_HBR_MASK);
>  	hdmi_writeb(hdmi, 0xff, HDMI_GP_MASK);
>  	hdmi_writeb(hdmi, 0xff, HDMI_A_APIINTMSK);
> -	hdmi_writeb(hdmi, 0xff, HDMI_CEC_MASK);
>  	hdmi_writeb(hdmi, 0xff, HDMI_I2CM_INT);
>  	hdmi_writeb(hdmi, 0xff, HDMI_I2CM_CTLINT);
>  
> @@ -2223,6 +2224,29 @@ static int dw_hdmi_detect_phy(struct dw_hdmi *hdmi)
>  	return -ENODEV;
>  }
>  
> +static void dw_hdmi_cec_enable(struct dw_hdmi *hdmi)
> +{
> +	mutex_lock(&hdmi->mutex);
> +	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_CECCLK_DISABLE;
> +	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
> +	mutex_unlock(&hdmi->mutex);
> +}
> +
> +static void dw_hdmi_cec_disable(struct dw_hdmi *hdmi)
> +{
> +	mutex_lock(&hdmi->mutex);
> +	hdmi->mc_clkdis |= HDMI_MC_CLKDIS_CECCLK_DISABLE;
> +	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
> +	mutex_unlock(&hdmi->mutex);
> +}
> +
> +static const struct dw_hdmi_cec_ops dw_hdmi_cec_ops = {
> +	.write = hdmi_writeb,
> +	.read = hdmi_readb,
> +	.enable = dw_hdmi_cec_enable,
> +	.disable = dw_hdmi_cec_disable,
> +};
> +
>  static const struct regmap_config hdmi_regmap_8bit_config = {
>  	.reg_bits	= 32,
>  	.val_bits	= 8,
> @@ -2245,6 +2269,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  	struct device_node *np = dev->of_node;
>  	struct platform_device_info pdevinfo;
>  	struct device_node *ddc_node;
> +	struct dw_hdmi_cec_data cec;
>  	struct dw_hdmi *hdmi;
>  	struct resource *iores = NULL;
>  	int irq;
> @@ -2445,6 +2470,17 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  		hdmi->audio = platform_device_register_full(&pdevinfo);
>  	}
>  
> +	cec.hdmi = hdmi;
> +	cec.ops = &dw_hdmi_cec_ops;
> +	cec.irq = irq;
> +
> +	pdevinfo.name = "dw-hdmi-cec";
> +	pdevinfo.data = &cec;
> +	pdevinfo.size_data = sizeof(cec);
> +	pdevinfo.dma_mask = 0;
> +
> +	hdmi->cec = platform_device_register_full(&pdevinfo);
> +
>  	/* Reset HDMI DDC I2C master controller and mute I2CM interrupts */
>  	if (hdmi->i2c)
>  		dw_hdmi_i2c_init(hdmi);
> @@ -2475,6 +2511,8 @@ static void __dw_hdmi_remove(struct dw_hdmi *hdmi)
>  {
>  	if (hdmi->audio && !IS_ERR(hdmi->audio))
>  		platform_device_unregister(hdmi->audio);
> +	if (!IS_ERR(hdmi->cec))
> +		platform_device_unregister(hdmi->cec);
>  
>  	/* Disable all interrupts */
>  	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);

Best regards,
Jose Miguel Abreu
