From: pkondeti@codeaurora.org (Pavan Kondeti)
Date: Thu, 18 Nov 2010 16:22:57 +0530
Subject: [PATCH v3 1/2] msm: gpio: Add v2 gpio support to MSM SoCs.
In-Reply-To: <1289943516-11367-1-git-send-email-gbean@codeaurora.org>
References: <1289943516-11367-1-git-send-email-gbean@codeaurora.org>
Message-ID: <20101118105257.GC11700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Tue, Nov 16, 2010 at 01:38:35PM -0800, Gregory Bean wrote:
> Beginning with the MSM8x60, the hardware block responsible for gpio
> support changes.  Provide gpiolib support for the new v2 architecture.
> 
> Cc: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Gregory Bean <gbean@codeaurora.org>
> +static int __devinit msm_gpio_probe(struct platform_device *dev)
> +{
> +	int ret;
> +
> +	spin_lock_init(&tlmm_lock);

Not required. DEFINE_SPINLOCK() would have initialized the spinlock.
> +	msm_gpio.label = dev->name;
> +	ret = gpiochip_add(&msm_gpio);
> +
> +	return ret;
> +}
> +
> +static int __devexit msm_gpio_remove(struct platform_device *dev)
> +{
> +	int ret = gpiochip_remove(&msm_gpio);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	set_irq_handler(TLMM_SCSS_SUMMARY_IRQ, NULL);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver msm_gpio_driver = {
> +	.probe = msm_gpio_probe,
> +	.remove = __devexit_p(msm_gpio_remove),
> +	.driver = {
> +		.name = "msmgpio",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +static struct platform_device msm_device_gpio = {
> +	.name = "msmgpio",
> +	.id   = 0,
> +};
id = -1 right?
> +
> +static int __init msm_gpio_init(void)
> +{
> +	int rc;
> +
> +	rc = platform_driver_register(&msm_gpio_driver);
> +	if (rc == 0)
> +		rc = platform_device_register(&msm_device_gpio);

Should not we unregister the platform driver in case the above call returns
failure?
> +
> +	return rc;
> +}
> +
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
