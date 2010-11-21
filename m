From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 22 Nov 2010 09:02:45 +1300
Subject: [PATCH v6 08/12] gpio: add ti-ssp gpio driver
In-Reply-To: <1290182156-20104-9-git-send-email-cyril@ti.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
	<1290182156-20104-9-git-send-email-cyril@ti.com>
Message-ID: <4CE97AE5.3040801@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2010 04:55 AM, Cyril Chemparathy wrote:
> TI's SSP controller pins can be directly read and written to behave like a
> GPIO.  This patch adds a GPIO driver that exposes such functionality.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> ---

> +static int __devinit ti_ssp_gpio_probe(struct platform_device *pdev)
> +{
> +	const struct ti_ssp_gpio_data *pdata = pdev->dev.platform_data;
> +	struct device *dev = &pdev->dev;
> +	struct ti_ssp_gpio_chip *gpio;
> +	int error;
> +
> +	if (!pdata) {
> +		dev_err(dev, "platform data not found\n");
> +		return -EINVAL;
> +	}
> +
> +	gpio = kzalloc(sizeof(*gpio), GFP_KERNEL);
> +	if (!gpio) {
> +		dev_err(dev, "cannot allocate driver data\n");
> +		return -ENOMEM;
> +	}
> +
> +	gpio->dev = dev;
> +	gpio->iosel = SSP_PIN_SEL(0, SSP_IN) | SSP_PIN_SEL(1, SSP_IN) |
> +		      SSP_PIN_SEL(2, SSP_IN) | SSP_PIN_SEL(3, SSP_IN);
> +	error = ti_ssp_set_iosel(gpio->dev, gpio->iosel);
> +	if (error < 0) {
> +		dev_err(dev, "gpio io setup failed (%d)\n", error);
> +		goto error;
> +	}
> +
> +	spin_lock_init(&gpio->lock);
> +	platform_set_drvdata(pdev, gpio);

This looks wrong. gpio is of type ti_ssp_gpio_chip, but the ssp core
functions, ssp_read, etc, use dev_to_ssp:

static inline struct ti_ssp *dev_to_ssp(struct device *dev)
{
	return dev_get_drvdata(dev->parent);
}

If I understand correctly, the ssp core can only be used to for one
peripheral at a time. Currently the code will allow you to install
several peripherals at once, which will lead to odd behaviour at
runtime. Maybe a better approach would be to have something like this in
drivers/mfd/ti-ssp.c:

struct ti_ssp {
	struct resource		*res;
	struct device		*dev;
	void __iomem		*regs;
	struct clk		*clk;
	int			irq;
	wait_queue_head_t	wqh;
	int			in_use;
};

static struct ti_ssp ti_ssp = {
	.in_use = 0,
};
static DEFINE_SPINLOCK(ti_ssp_lock);

struct ti_ssp *ti_ssp_get(void)
{
	spin_lock(&ti_ssp_lock);
	if (ti_ssp.in_use) {
		spin_unlock(&ti_ssp_lock);
		return NULL;
	}

	ti_ssp.in_use = 1;
	spin_unlock(&ti_ssp_lock);
	return &ti_ssp;
}

int ti_ssp_put(void)
{
	spin_lock(&ti_ssp_lock);
	if (!ti_ssp.in_use) {
		spin_unlock(&ti_ssp_lock);
		return -ENODEV;
	}
	
	ti_ssp.in_use = 0;	
	spin_unlock(&ti_ssp_lock);
	return 0;
}

This way, the ssp core api functions can take struct ti_ssp * as their
first argument (which can still be an opaque pointer) and the code
protects against multiple peripherals attempting to register the ssp core.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
