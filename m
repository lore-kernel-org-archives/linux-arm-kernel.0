From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Apr 2011 11:08:44 +0200
Subject: [PATCH 1/7] Add a mfd IPUv3 driver
In-Reply-To: <1302710016-3569-1-git-send-email-weitway@gmail.com>
References: <1302710016-3569-1-git-send-email-weitway@gmail.com>
Message-ID: <20110414090844.GZ7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 11:53:30PM +0800, weitway at gmail.com wrote:
> From: Jason Chen <b02280@freescale.com>
> 
> +
> +static irqreturn_t ipu_irq_handler(int irq, void *desc)
> +{
> +	struct ipu_soc *ipu = container_of(desc, struct ipu_soc, ipu_dev);
> +	DECLARE_IPU_IRQ_BITMAP(status);
> +	struct ipu_irq_handler *handler;
> +	unsigned long flags;
> +	int i;
> +
> +	spin_lock_irqsave(&ipu->ipu_lock, flags);
> +
> +	for (i = 0; i < BITS_TO_LONGS(IPU_IRQ_COUNT); i++) {
> +		status[i] = ipu_cm_read(ipu, IPU_INT_STAT(i + 1));
> +		ipu_cm_write(ipu, status[i], IPU_INT_STAT(i + 1));
> +	}
> +
> +	list_for_each_entry(handler, &ipu->ipu_irq_handlers_list, list) {
> +		DECLARE_IPU_IRQ_BITMAP(tmp);
> +		if (bitmap_and(tmp, status, handler->ipu_irqs, IPU_IRQ_COUNT))
> +			handler->handler(tmp, handler->context);
> +	}
> +
> +	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
> +
> +	return IRQ_HANDLED;
> +}

Arnd and Thomas have objected to the custom interrupt handling code and
prefer a standard chained interrupt handler for the IPU interrupts.


> +
> +static int ipu_add_subdevice_pdata(struct platform_device *pdev,
> +		const char *name, int id, void *pdata, size_t pdata_size)
> +{
> +	struct mfd_cell cell = {
> +		.platform_data = pdata,
> +		.data_size = pdata_size,
> +	};

These fields do not exist anymore.

> +static int __devinit ipu_probe(struct platform_device *pdev)
> +{
> +	struct ipu_soc *ipu;
> +	struct imx_ipuv3_platform_data *plat_data = pdev->dev.platform_data;
> +	struct resource *res;
> +	int ret;
> +
> +	ipu = kzalloc(sizeof(struct ipu_soc), GFP_KERNEL);
> +	if (!ipu)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&ipu->ipu_lock);
> +	mutex_init(&ipu->ipu_channel_lock);
> +	INIT_LIST_HEAD(&ipu->ipu_irq_handlers_list);
> +
> +	ipu->ipu_dev = &pdev->dev;
> +
> +	if (plat_data->init)
> +		plat_data->init(pdev);
> +
> +	ipu->irq1 = platform_get_irq(pdev, 0);
> +	ipu->irq2 = platform_get_irq(pdev, 1);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (!res || ipu->irq1 < 0 || ipu->irq2 < 0)
> +		return -ENODEV;

You already allocated memory which you forget to free here.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
