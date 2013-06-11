From: avinashphilip@ti.com (Philip, Avinash)
Date: Tue, 11 Jun 2013 12:55:22 +0000
Subject: [PATCH 03/11] gpio: davinci: Modify to platform driver
In-Reply-To: <51B71056.9010103@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-4-git-send-email-avinashphilip@ti.com>
 <51B71056.9010103@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EAD9D75@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 17:26:06, Nori, Sekhar wrote:
> 
> 
> On 5/22/2013 12:40 PM, Philip Avinash wrote:
> > From: KV Sujith <sujithkv@ti.com>
> > 
> > Modify GPIO Davinci driver to be compliant to standard platform drivers.
> > The driver did not have platform driver structure or a probe. Instead,
> > had a davinci_gpio_setup() function which is called in the pure_init
> > sequence. The function also had dependency on davinci_soc_info structure
> > of the corresponding platform. For Device Tree(DT) implementation, we
> > need to get rid of the dependency on the davinci_soc_info structure.
> > Hence as a first stage of DT conversion, we implement a probe. Future
> > commits shall modify the probe to read platform related data from DT.
> > 
> > - Add platform_driver structure and driver register function for davinci
> >   GPIO driver. The driver registration is made to happen in
> >   postcore_initcall. This is required since machine init functions like
> >   da850_lcd_hw_init() make use of GPIO.
> > - Convert the davinci_gpio_setup() to davinci_gpio_probe().
> > - Remove access of members in soc_info structure. Instead, relevant data
> >   are taken from davinci_gpio_platform_data structure pointed by
> >   pdev->dev.platform_data.
> > - Change clk_get() to devm_clk_get() as devm_clk_get() is a device
> >   managed function and makes error handling simpler.
> > - Change pr_err to dev_err for ngpio error reporting.
> > - Arrange include files and variables in alphabetical order
> > 
> > Signed-off-by: KV Sujith <sujithkv@ti.com>
> > [avinashphilip at ti.com: Move global definition for "struct
> > davinci_gpio_controller" variable to local in probe and set it as driver
> > data.]
> > Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> > ---
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/platform_data/gpio-davinci.h>
> 
> > +#include <mach/gpio-davinci.h>
> 
> This include seems unnecessary.

This include is not required.

> 
> >  
> >  #include <asm/mach/irq.h>
> 
> While at it, you can get rid of this include and use <linux/irq.h> instead?

Ok

> 
> >  
> > +	pdata = dev->platform_data;
> > +	if (!pdata) {
> > +		dev_err(dev, "GPIO: No Platform Data Supplied\n");
> 
> dev_err should already tell that the error is coming from davinci-gpio
> so no need to prefix GPIO: again.

Ok

> 
> > +		return -EINVAL;
> > +	}
> > -	if (WARN_ON(!gpio_base))
> > +	ctlrs = devm_kzalloc(dev,
> > +		ngpio * sizeof(struct davinci_gpio_controller), GFP_KERNEL);
> 
> Line break alignment needs fixing.

Ok

> 
> > +	if (!ctlrs) {
> > +		dev_err(dev, "Memory alloc failed\n");
> >  		return -ENOMEM;
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (unlikely(!res)) {
> > +		dev_err(dev, "Invalid mem resource\n");
> > +		return -ENODEV;
> 
> -EBUSY is better if you cannot get the resource.

Ok

> 
> > +	}
> > +
> > +	gpio_base = devm_ioremap_resource(dev, res);
> > +	if (!gpio_base)
> > +		return -EADDRNOTAVAIL;
> 
> devm_ioremap_resource gives an error encoder pointer if it fails so
> please use that instead of masking it.

Ok

> 
> >  
> >  	for (i = 0, base = 0; base < ngpio; i++, base += 32) {
> >  		ctlrs[i].chip.label = "DaVinci";
> > @@ -179,13 +204,10 @@ static int __init davinci_gpio_setup(void)
> >  		gpiochip_add(&ctlrs[i].chip);
> >  	}
> >  
> > -	soc_info->gpio_ctlrs = ctlrs;
> 
> > -	soc_info->gpio_ctlrs_num = DIV_ROUND_UP(ngpio, 32);
> 
> You drop setting gpio_ctlrs_num here and don't introduce it anywhere
> else in the patchset so in effect you render the inline gpio get/set API
> useless. Looks like this initialization should be moved to platform code?

With [PATCH 08/11] ARM: davinci: start using gpiolib support gpio get/set API
Has no more dependency on soc_info->gpio_ctlrs_num.

I can merge [PATCH 08/11] ARM: davinci: start using gpiolib support to
[PATCH 03/11] gpio: davinci: Modify to platform driver

> 
> > -

> > +	pdata = dev->platform_data;
> > +	ngpio = pdata->ngpio;
> > +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +	if (unlikely(!res)) {
> > +		dev_err(dev, "Invalid IRQ resource\n");
> > +		return -ENODEV;
> 
> -EBUSY again?

Ok

Thanks
Avinash

> 
> Thanks,
> Sekhar
> 
