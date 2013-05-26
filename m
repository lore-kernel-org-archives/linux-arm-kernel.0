From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 May 2013 19:00:11 +0200
Subject: [PATCHv2 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
In-Reply-To: <24460034.7lWPC5EJAp@flatron>
References: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369563642-4390-2-git-send-email-maxime.ripard@free-electrons.com>
 <24460034.7lWPC5EJAp@flatron>
Message-ID: <20130526170011.GK17847@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 26, 2013 at 04:38:19PM +0200, Tomasz Figa wrote:
> On Sunday 26 of May 2013 12:20:37 Maxime Ripard wrote:
> > +	/*
> > +	 * Address + Read bit have been transmitted, ACK has not been
> > +	 * received. If we don't care about the NAKs, we just treat
> > +	 * this case as if an ACK would have been received, and fall
> > +	 * through to the next case.
> > +	 */
> > +	case SUNXI_I2C_STA_MASTER_RADDR_NAK:
> > +		if (!(i2c_dev->msg_cur->flags & I2C_M_IGNORE_NAK)) {
> > +			i2c_dev->msg_err = SUNXI_I2C_NAK;
> > +			goto out;
> > +		}
> 
> I meant something more like:
> 
> +
> +	/* Intentional fall through. */
> 
> This is enough to let the reader know that there is no break missing here 
> and you can keep those nice short state descriptions from v1.

Ok, I'll do it that way

[..]

> > +static int sunxi_i2c_probe(struct platform_device *pdev)
> > +{
> > +	struct sunxi_i2c_dev *i2c_dev;
> > +	struct device_node *np;
> > +	u32 freq, div_m, div_n;
> > +	struct resource res;
> 
> 	struct resource *res;
> 
> and then...
> 
> > +	int ret;
> > +
> > +	np = pdev->dev.of_node;
> > +	if (!np)
> > +		return -EINVAL;
> > +
> > +	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
> > +	if (!i2c_dev)
> > +		return -ENOMEM;
> > +	platform_set_drvdata(pdev, i2c_dev);
> > +	i2c_dev->dev = &pdev->dev;
> > +
> > +	init_completion(&i2c_dev->completion);
> > +
> > +	ret = of_address_to_resource(np, 0, &res);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "could not get IO memory\n");
> > +		return ret;
> > +	}
> > +
> > +	i2c_dev->membase = devm_ioremap_resource(&pdev->dev, &res);
> 
> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 	i2c_dev->membase = devm_ioremap_resource(&pdev->dev, res);
> 
> This way you can save yourself from parsing device tree again, one error 
> check and few lines of code. Remember that of_platform_populate() creates 
> all the resources of platform_devices based on reg and interrupts 
> properties, so there is no point in wasting this effort in drivers by 
> parsing them manually again.

Ah, right, I didn't thought about the double dt parsing. I'll switch to
platform_get_resource and platform_get_irq as you suggested.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
