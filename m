From: robherring2@gmail.com (Rob Herring)
Date: Wed, 08 Aug 2012 18:23:54 -0500
Subject: Platform data from devicetree
In-Reply-To: <1344467186.6707.6.camel@gitbox>
References: <1344467186.6707.6.camel@gitbox>
Message-ID: <5022F50A.3020105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2012 06:06 PM, Tony Prisk wrote:
> Quick question regarding platform_devices created from devicetree.
> 
> At the moment, we do a of_match_device() against vt8500_gpio_dt_ids[] to
> get an of_device_id that contains the .data field to pass into the
> driver.
> 
> Given that pdev is created from a match against vt8500_gpio_dt_ids[] as
> well, why does pdev->dev.of_node.data == NULL? Is this data not
> populated into this field? What data can be passed into this field?
> 

This commit may be why:

commit b1608d69cb804e414d0887140ba08a9398e4e638
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Wed May 18 11:19:24 2011 -0600

    drivercore: revert addition of of_match to struct device

    Commit b826291c, "drivercore/dt: add a match table pointer to struct
    device" added an of_match pointer to struct device to cache the
    of_match_table entry discovered at driver match time.  This was unsafe
    because matching is not an atomic operation with probing a driver.  If
    two or more drivers are attempted to be matched to a driver at the
    same time, then the cached matching entry pointer could get
    overwritten.

    This patch reverts the of_match cache pointer and reworks all users to
    call of_match_device() directly instead.

    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>



> Regards
> 
> Tony Prisk
> 
> 
> Example code below:
> 
> static struct of_device_id vt8500_gpio_dt_ids[] = {
> 	{ .compatible = "via,vt8500-gpio", .data = &vt8500_data, },
> 	{ .compatible = "wm,wm8505-gpio", .data = &wm8505_data, },
> 	{ .compatible = "wm,wm8650-gpio", .data = &wm8650_data, },
> 	{ /* Sentinel */ },
> };
> 
> static int __devinit vt8500_gpio_probe(struct platform_device *pdev)
> {
> 	void __iomem *gpio_base;
> 	struct device_node *np;
> 	const struct of_device_id *of_id =
> 			of_match_device(vt8500_gpio_dt_ids, &pdev->dev);
> 
> 	if (!of_id) {
> 		dev_err(&pdev->dev, "Failed to find gpio controller\n");
> 		return -ENODEV;
> 	}
> 
> 	np = pdev->dev.of_node;
> 	...
> }
> 
> static struct platform_driver vt8500_gpio_driver = {
> 	.probe		= vt8500_gpio_probe,
> 	.driver		= {
> 		.name	= "vt8500-gpio",
> 		.owner	= THIS_MODULE,
> 		.of_match_table = vt8500_gpio_dt_ids,
> 	},
> };
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
