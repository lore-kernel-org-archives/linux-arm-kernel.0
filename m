From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jun 2011 13:37:15 +0200
Subject: [PATCH 2/2] pwm: Add a i.MX23/28 pwm driver
In-Reply-To: <1309338215-10702-3-git-send-email-s.hauer@pengutronix.de>
References: <1309338215-10702-1-git-send-email-s.hauer@pengutronix.de>
	<1309338215-10702-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <201106291337.15336.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 June 2011, Sascha Hauer wrote:
> +/*
> + * each pwm has a separate register space but all share a common
> + * enable register.
> + */
> +static int mxs_pwm_common_get(struct platform_device *pdev)
> +{
> +       struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       resource_size_t start = r->start & ~0xfff;
> +       int ret = 0;
> +
> +       if (!num_instances) {
> +               r = request_mem_region(start, 0x10, "mxs-pwm-common");
> +               if (!r)
> +                       goto err_request;

Yes, this looks better than the original approach, but it still feels
a bit awkward: 

You are requesting a region outside of the platform device resource.
This will cause problems with the device tree conversion, where the
idea is to list all registers that are used for each device.
It also becomes a problem if a system has multiple PWM regions
that are a page long each -- you only map one of them currently,
so the first one would win.

When you model the pwm device in the device tree, the most logical
representation IMHO would be to have a nested device, like:

/amba/pwm_core at 0fa0000/pwm at 0
                      /pwm at 1
                      /pwm at 2

The pwm_core then has the MMIO registers and provides an interface
for the individual pwms to access the registers, like an MFD
device. The resources for the slave devices are not MMIO ranges
but simply offsets. The pwm_enable function will then do something
like 

static void __pwm_enable(struct mxs_pwm_device *pwm, int enable)
{
	struct device *parent = &pwm->chip.dev.parent->parent;
	void __iomem *pwm_base_common = dev_get_drvdata(parent);

        if (enable)
                reg = pwm_base_common + REG_PWM_CTRL_SET;
        else
                reg = pwm_base_common + REG_PWM_CTRL_CLEAR;
 
        writel(PWM_ENABLE(pwm->chip.pwm_id), reg);
}

The pwm driver obviously has to register for both device types,
the parent and the child, and do different things in the two
cases, e.g.

static int __devinit mxs_pwm_probe(struct platform_device *pdev)
{
	switch (pdev->id_entry->driver_data) {
	case MXS_PWM_MASTER:
		return mxs_pwm_map_master_resources(pdev);
	case MXS_PWM_SLAVE:
		return mxs_pwm_register_pwmchip(pdev, to_platform_device(pdev->dev.parent));
	}
	return -ENODEV;
}

I'm normally not that picky, but I think we should have the best
possible solution for this in the mx23 driver, because it will
likely be used as an example for other drivers that have the
same problem.

	Arnd
