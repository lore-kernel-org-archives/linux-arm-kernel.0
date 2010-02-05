From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 5 Feb 2010 09:11:09 -0800
Subject: [PATCH 5/5] input: support onkey in 88pm860x
In-Reply-To: <20100205154211.GE3448@sortiz.org>
References: <771cded01002030504ye3416c8nafe21be405237ace@mail.gmail.com>
	<20100203173628.GB30600@core.coreip.homeip.net>
	<771cded01002040308t3fe112e5leb60bc969fbfcfb@mail.gmail.com>
	<20100205154211.GE3448@sortiz.org>
Message-ID: <20100205171108.GA28694@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Fri, Feb 05, 2010 at 04:42:12PM +0100, Samuel Ortiz wrote:
> On Thu, Feb 04, 2010 at 06:08:42AM -0500, Haojian Zhuang wrote:
> > Fix and format the new patch.
> Dmitry, are you ok with this new version ?
> 

Looks OK. It could be made a bit simpler in error path by requesting IRQ
after allocating input device but before registering it (input devices
can take events s soon as they ghave been allocated with
input_allocate_device) but it is not that important.

> Cheers,
> Samuel.
> 
>  
> > Thanks
> > Haojian
> 
> > From d4b0a94d7777ce14dc6041ee618090360780987f Mon Sep 17 00:00:00 2001
> > From: Haojian Zhuang <haojian.zhuang@marvell.com>
> > Date: Wed, 3 Feb 2010 15:40:59 -0500
> > Subject: [PATCH] input: support onkey in 88pm860x
> > 
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> > ---
> >  drivers/input/misc/88pm860x_onkey.c |  155 +++++++++++++++++++++++++++++++++++
> >  drivers/input/misc/Kconfig          |   10 ++
> >  drivers/input/misc/Makefile         |    1 +
> >  3 files changed, 166 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/input/misc/88pm860x_onkey.c
> > 
> > diff --git a/drivers/input/misc/88pm860x_onkey.c b/drivers/input/misc/88pm860x_onkey.c
> > new file mode 100644
> > index 0000000..69a48e8
> > --- /dev/null
> > +++ b/drivers/input/misc/88pm860x_onkey.c
> > @@ -0,0 +1,155 @@
> > +/*
> > + * 88pm860x_onkey.c - Marvell 88PM860x ONKEY driver
> > + *
> > + * Copyright (C) 2009-2010 Marvell International Ltd.
> > + *      Haojian Zhuang <haojian.zhuang@marvell.com>
> > + *
> > + * This file is subject to the terms and conditions of the GNU General
> > + * Public License. See the file "COPYING" in the main directory of this
> > + * archive for more details.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/88pm860x.h>
> > +
> > +#define PM8607_WAKEUP		0x0b
> > +
> > +#define LONG_ONKEY_EN		(1 << 1)
> > +#define ONKEY_STATUS		(1 << 0)
> > +
> > +struct pm860x_onkey_info {
> > +	struct input_dev	*idev;
> > +	struct pm860x_chip	*chip;
> > +	struct i2c_client	*i2c;
> > +	struct device		*dev;
> > +	int			irq;
> > +};
> > +
> > +/* 88PM860x gives us an interrupt when ONKEY is held */
> > +static irqreturn_t pm860x_onkey_handler(int irq, void *data)
> > +{
> > +	struct pm860x_onkey_info *info = data;
> > +	int ret;
> > +
> > +	ret = pm860x_reg_read(info->i2c, PM8607_STATUS_2);
> > +	ret &= ONKEY_STATUS;
> > +	input_report_key(info->idev, KEY_POWER, ret);
> > +	input_sync(info->idev);
> > +
> > +	/* Enable 8-second long onkey detection */
> > +	pm860x_set_bits(info->i2c, PM8607_WAKEUP, 3, LONG_ONKEY_EN);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int __devinit pm860x_onkey_probe(struct platform_device *pdev)
> > +{
> > +	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
> > +	struct pm860x_onkey_info *info;
> > +	int irq, ret;
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "No IRQ resource!\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	info = kzalloc(sizeof(struct pm860x_onkey_info), GFP_KERNEL);
> > +	if (!info)
> > +		return -ENOMEM;
> > +	info->chip = chip;
> > +	info->i2c = (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
> > +	info->dev = &pdev->dev;
> > +	info->irq = irq + chip->irq_base;
> > +
> > +	info->idev = input_allocate_device();
> > +	if (!info->idev) {
> > +		dev_err(chip->dev, "Failed to allocate input dev\n");
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	info->idev->name = "88pm860x_on";
> > +	info->idev->phys = "88pm860x_on/input0";
> > +	info->idev->id.bustype = BUS_I2C;
> > +	info->idev->dev.parent = &pdev->dev;
> > +	info->irq = irq;
> > +	info->idev->evbit[0] = BIT_MASK(EV_KEY);
> > +	info->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
> > +
> > +	ret = input_register_device(info->idev);
> > +	if (ret) {
> > +		dev_err(chip->dev, "Can't register input device: %d\n", ret);
> > +		goto out_reg;
> > +	}
> > +
> > +	ret = request_threaded_irq(info->irq, NULL, pm860x_onkey_handler,
> > +				   IRQF_ONESHOT, "onkey", info);
> > +	if (ret < 0) {
> > +		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
> > +			info->irq, ret);
> > +		goto out_irq;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, info);
> > +	return 0;
> > +
> > +out_irq:
> > +	input_unregister_device(info->idev);
> > +	kfree(info);
> > +	return ret;
> > +
> > +out_reg:
> > +	input_free_device(info->idev);
> > +out:
> > +	kfree(info);
> > +	return ret;
> > +}
> > +
> > +static int __devexit pm860x_onkey_remove(struct platform_device *pdev)
> > +{
> > +	struct pm860x_onkey_info *info = platform_get_drvdata(pdev);
> > +
> > +	free_irq(info->irq, info);
> > +	input_unregister_device(info->idev);
> > +	kfree(info);
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver pm860x_onkey_driver = {
> > +	.driver		= {
> > +		.name	= "88pm860x-onkey",
> > +		.owner	= THIS_MODULE,
> > +	},
> > +	.probe		= pm860x_onkey_probe,
> > +	.remove		= __devexit_p(pm860x_onkey_remove),
> > +};
> > +
> > +static int __init pm860x_onkey_init(void)
> > +{
> > +	return platform_driver_register(&pm860x_onkey_driver);
> > +}
> > +module_init(pm860x_onkey_init);
> > +
> > +static void __exit pm860x_onkey_exit(void)
> > +{
> > +	platform_driver_unregister(&pm860x_onkey_driver);
> > +}
> > +module_exit(pm860x_onkey_exit);
> > +
> > +MODULE_DESCRIPTION("Marvell 88PM860x ONKEY driver");
> > +MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index 32f9e02..3cd878f 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -12,6 +12,16 @@ menuconfig INPUT_MISC
> >  
> >  if INPUT_MISC
> >  
> > +config INPUT_88PM860X_ONKEY
> > +	tristate "88PM860x ONKEY support"
> > +	depends on MFD_88PM860X
> > +	help
> > +	  Support the ONKEY of Marvell 88PM860x PMICs as an input device
> > +	  reporting power button status.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called 88pm860x_onkey.
> > +
> >  config INPUT_PCSPKR
> >  	tristate "PC Speaker support"
> >  	depends on PCSPKR_PLATFORM
> > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > index d903dab..6d6130f 100644
> > --- a/drivers/input/misc/Makefile
> > +++ b/drivers/input/misc/Makefile
> > @@ -4,6 +4,7 @@
> >  
> >  # Each configuration option enables a list of files.
> >  
> > +obj-$(CONFIG_INPUT_88PM860X_ONKEY)	+= 88pm860x_onkey.o
> >  obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
> >  obj-$(CONFIG_INPUT_ATI_REMOTE)		+= ati_remote.o
> >  obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
> > -- 
> > 1.5.6.5
> > 
> 
> 
> -- 
> Intel Open Source Technology Centre
> http://oss.intel.com/

-- 
Dmitry
