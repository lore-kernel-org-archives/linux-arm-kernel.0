From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 21 Jul 2011 22:00:56 -0700
Subject: [PATCH 5/6] mc13783: add power button support
In-Reply-To: <1311271463-4356-6-git-send-email-philippe.retornaz@epfl.ch>
References: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch>
	<1311271463-4356-2-git-send-email-philippe.retornaz@epfl.ch>
	<1311271463-4356-3-git-send-email-philippe.retornaz@epfl.ch>
	<1311271463-4356-4-git-send-email-philippe.retornaz@epfl.ch>
	<1311271463-4356-5-git-send-email-philippe.retornaz@epfl.ch>
	<1311271463-4356-6-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20110722050056.GA16040@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Thu, Jul 21, 2011 at 08:04:22PM +0200, Philippe R?tornaz wrote:
> This adds support for the power-on buttons of MC13783 PMIC.
> This is done using a misc input device.
> 

Mostly looks good, just a couple of comments below.

> @@ -0,0 +1,288 @@
> +/**
> + * mc13783-pwrbutton.c - MC13783 Power Button Input Driver
> + *

Please drop the file name from comment - if we ever rename the file we
won't have to update it here as well.

> + * Copyright (C) 2011 Philippe R?tornaz
> + *
> + * Based on twl4030-pwrbutton driver by:
> + *     Peter De Schrijver <peter.de-schrijver@nokia.com>
> + *     Felipe Balbi <felipe.balbi@nokia.com>
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA 02110-1335  USA
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/mc13783.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +
> +struct mc13783_pwrb {
> +	struct input_dev *pwr;
> +	struct mc13xxx *mc13783;
> +#define MC13783_PWRB_B1_POL_INVERT	(1 << 0)
> +#define MC13783_PWRB_B2_POL_INVERT	(1 << 1)
> +#define MC13783_PWRB_B3_POL_INVERT	(1 << 2)
> +	int flags;
> +	unsigned short keymap[3];
> +};
> +
> +#define MC13783_REG_INTERRUPT_SENSE_1		5
> +#define MC13783_IRQSENSE1_ONOFD1S		(1 << 3)
> +#define MC13783_IRQSENSE1_ONOFD2S		(1 << 4)
> +#define MC13783_IRQSENSE1_ONOFD3S		(1 << 5)
> +
> +#define MC13783_REG_POWER_CONTROL_2		15
> +#define MC13783_POWER_CONTROL_2_ON1BDBNC	4
> +#define MC13783_POWER_CONTROL_2_ON2BDBNC	6
> +#define MC13783_POWER_CONTROL_2_ON3BDBNC	8
> +#define MC13783_POWER_CONTROL_2_ON1BRSTEN	(1 << 1)
> +#define MC13783_POWER_CONTROL_2_ON2BRSTEN	(1 << 2)
> +#define MC13783_POWER_CONTROL_2_ON3BRSTEN	(1 << 3)
> +
> +static irqreturn_t button_irq(int irq, void *_priv)
> +{
> +	struct mc13783_pwrb *priv = _priv;
> +	int val;

Please have blank lines between variable declarations and code.

> +	mc13xxx_irq_ack(priv->mc13783, irq);
> +	mc13xxx_reg_read(priv->mc13783, MC13783_REG_INTERRUPT_SENSE_1, &val);
> +
> +	switch (irq) {
> +	case MC13783_IRQ_ONOFD1:
> +		val = val & MC13783_IRQSENSE1_ONOFD1S ? 1 : 0;
> +		if (priv->flags & MC13783_PWRB_B1_POL_INVERT)
> +			val ^= 1;
> +		input_report_key(priv->pwr, priv->keymap[0], val);
> +		break;
> +
> +	case MC13783_IRQ_ONOFD2:
> +		val = val & MC13783_IRQSENSE1_ONOFD2S ? 1 : 0;
> +		if (priv->flags & MC13783_PWRB_B2_POL_INVERT)
> +			val ^= 1;
> +		input_report_key(priv->pwr, priv->keymap[1], val);
> +		break;
> +
> +	case MC13783_IRQ_ONOFD3:
> +		val = val & MC13783_IRQSENSE1_ONOFD3S ? 1 : 0;
> +		if (priv->flags & MC13783_PWRB_B3_POL_INVERT)
> +			val ^= 1;
> +		input_report_key(priv->pwr, priv->keymap[2], val);
> +		break;
> +	}
> +
> +	input_sync(priv->pwr);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __devinit mc13783_pwrbutton_probe(struct platform_device *pdev)
> +{
> +	struct mc13xxx_buttons_platform_data *pdata;

const?

> +	struct mc13xxx *mc13783 = dev_get_drvdata(pdev->dev.parent);
> +	struct input_dev *pwr;
> +	struct mc13783_pwrb *priv;
> +	int err = 0;
> +	int reg = 0;
> +
> +	pdata = dev_get_platdata(&pdev->dev);
> +	if (pdata == NULL) {

	if (!pdata) { ..

> +		dev_err(&pdev->dev, "missing platform data\n");
> +		return -ENODEV;
> +	}
> +
> +	pwr = input_allocate_device();
> +	if (!pwr) {
> +		dev_dbg(&pdev->dev, "Can't allocate power button\n");
> +		return -ENOMEM;
> +	}
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +

Unneeded blank line here.

> +	if (!priv) {
> +		err = -ENOMEM;
> +		dev_dbg(&pdev->dev, "Can't allocate power button\n");
> +		goto free_input_dev;
> +	}
> +
> +	pwr->evbit[0] = BIT_MASK(EV_KEY);

Just use __set_bit() here as well. Also, why this initialization is
separate from the rest of the code initializing input device. I think it
is good practice to keep related pieces together.

> +
> +	reg |= (pdata->b1on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON1BDBNC;
> +	reg |= (pdata->b2on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON2BDBNC;
> +	reg |= (pdata->b3on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON3BDBNC;
> +
> +	priv->pwr = pwr;
> +	priv->mc13783 = mc13783;
> +
> +	mc13xxx_lock(mc13783);
> +
> +	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE) {
> +		priv->keymap[0] = pdata->b1on_key;
> +		if (pdata->b1on_key != KEY_RESERVED)
> +			__set_bit(pdata->b1on_key, pwr->keybit);
> +
> +		if (pdata->b1on_flags & MC13783_BUTTON_POL_INVERT)
> +			priv->flags |= MC13783_PWRB_B1_POL_INVERT;
> +
> +		if (pdata->b1on_flags & MC13783_BUTTON_RESET_EN)
> +			reg |= MC13783_POWER_CONTROL_2_ON1BRSTEN;
> +
> +		err = mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD1,
> +					  button_irq, "b1on", priv);
> +

Another unneeded blank line.

> +		if (err) {
> +			mc13xxx_unlock(mc13783);

Why irregular error handling in this case? Just have a separate label
for the unlock statement and jump to it.

> +
> +			dev_dbg(&pdev->dev, "Can't request irq\n");
> +			goto free_priv;
> +		}
> +	}
> +
> +	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE) {
> +		priv->keymap[0] = pdata->b2on_key;
> +		if (pdata->b2on_key != KEY_RESERVED)
> +			__set_bit(pdata->b2on_key, pwr->keybit);
> +
> +		if (pdata->b2on_flags & MC13783_BUTTON_POL_INVERT)
> +			priv->flags |= MC13783_PWRB_B2_POL_INVERT;
> +
> +		if (pdata->b2on_flags & MC13783_BUTTON_RESET_EN)
> +			reg |= MC13783_POWER_CONTROL_2_ON2BRSTEN;
> +
> +		err = mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD2,
> +					  button_irq, "b2on", priv);
> +
> +		if (err) {
> +			dev_dbg(&pdev->dev, "Can't request irq\n");
> +			goto free_irq_b1;
> +		}
> +	}
> +
> +	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE) {
> +		priv->keymap[0] = pdata->b3on_key;
> +		if (pdata->b3on_key != KEY_RESERVED)
> +			__set_bit(pdata->b3on_key, pwr->keybit);
> +
> +		if (pdata->b3on_flags & MC13783_BUTTON_POL_INVERT)
> +			priv->flags |= MC13783_PWRB_B3_POL_INVERT;
> +
> +		if (pdata->b3on_flags & MC13783_BUTTON_RESET_EN)
> +			reg |= MC13783_POWER_CONTROL_2_ON3BRSTEN;
> +
> +		err = mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD3,
> +					  button_irq, "b3on", priv);
> +
> +		if (err) {
> +			dev_dbg(&pdev->dev, "Can't request irq: %d\n", err);
> +			goto free_irq_b2;
> +		}
> +	}
> +
> +	mc13xxx_reg_rmw(mc13783, MC13783_REG_POWER_CONTROL_2, 0x3FE, reg);
> +
> +	mc13xxx_unlock(mc13783);
> +
> +	pwr->name = "mc13783_pwrbutton";
> +	pwr->phys = "mc13783_pwrbutton/input0";
> +	pwr->dev.parent = &pdev->dev;
> +
> +	pwr->keycode = priv->keymap;
> +	pwr->keycodemax = ARRAY_SIZE(priv->keymap);
> +	pwr->keycodesize = sizeof(priv->keymap[0]);
> +
> +	err = input_register_device(pwr);
> +	if (err) {
> +		dev_dbg(&pdev->dev, "Can't register power button: %d\n", err);
> +		goto free_irq;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +free_irq:
> +	mc13xxx_lock(mc13783);
> +
> +	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD3, priv);
> +free_irq_b2:
> +	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD2, priv);
> +
> +free_irq_b1:
> +	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD1, priv);
> +
> +	mc13xxx_unlock(mc13783);
> +
> +free_priv:
> +	kfree(priv);
> +
> +free_input_dev:
> +	input_free_device(pwr);
> +
> +	return err;
> +}
> +
> +static int __devexit mc13783_pwrbutton_remove(struct platform_device *pdev)
> +{
> +	struct mc13783_pwrb *priv = platform_get_drvdata(pdev);
> +	struct mc13xxx_buttons_platform_data *pdata;

const + entra line.

> +	pdata = dev_get_platdata(&pdev->dev);
> +
> +	mc13xxx_lock(priv->mc13783);
> +
> +	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD3, priv);
> +	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD2, priv);
> +	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD1, priv);
> +
> +	mc13xxx_unlock(priv->mc13783);
> +
> +	input_unregister_device(priv->pwr);
> +	kfree(priv);
> +
> +	return 0;
> +}
> +
> +struct platform_driver mc13783_pwrbutton_driver = {
> +	.probe		= mc13783_pwrbutton_probe,
> +	.remove		= __devexit_p(mc13783_pwrbutton_remove),
> +	.driver		= {
> +		.name	= "mc13783-pwrbutton",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init mc13783_pwrbutton_init(void)
> +{
> +	return platform_driver_register(&mc13783_pwrbutton_driver);
> +}
> +module_init(mc13783_pwrbutton_init);
> +
> +static void __exit mc13783_pwrbutton_exit(void)
> +{
> +	platform_driver_unregister(&mc13783_pwrbutton_driver);
> +}
> +module_exit(mc13783_pwrbutton_exit);
> +
> +MODULE_ALIAS("platform:mc13783-pwrbutton");
> +MODULE_DESCRIPTION("MC13783 Power Button");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Philippe Retornaz");
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 2867c21..da8d276 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -776,6 +776,10 @@ err_revision:
>  		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
>  				pdata->leds, sizeof(*pdata->leds));
>  
> +	if (pdata->buttons)
> +		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
> +				pdata->buttons, sizeof(*pdata->buttons));
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/mfd/mc13783.h b/include/linux/mfd/mc13783.h
> index 3756a30..aa824d0 100644
> --- a/include/linux/mfd/mc13783.h
> +++ b/include/linux/mfd/mc13783.h
> @@ -106,6 +106,7 @@ static inline int mc13783_irq_ack(struct mc13783 *mc13783, int irq)
>  #define mc13783_regulator_platform_data mc13xxx_regulator_platform_data
>  #define mc13783_led_platform_data mc13xxx_led_platform_data
>  #define mc13783_leds_platform_data mc13xxx_leds_platform_data
> +#define mc13783_buttons_platform_data mc13xxx_buttons_platform_data
>  
>  #define mc13783_platform_data mc13xxx_platform_data
>  #define MC13783_USE_TOUCHSCREEN	MC13XXX_USE_TOUCHSCREEN
> diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
> index cef1497..f24be68 100644
> --- a/include/linux/mfd/mc13xxx.h
> +++ b/include/linux/mfd/mc13xxx.h
> @@ -137,6 +137,22 @@ struct mc13xxx_leds_platform_data {
>  	char tc3_period;
>  };
>  
> +struct mc13xxx_buttons_platform_data {
> +#define MC13783_BUTTON_DBNC_0MS		0
> +#define MC13783_BUTTON_DBNC_30MS	1
> +#define MC13783_BUTTON_DBNC_150MS	2
> +#define MC13783_BUTTON_DBNC_750MS	3
> +#define MC13783_BUTTON_ENABLE		(1 << 2)
> +#define MC13783_BUTTON_POL_INVERT	(1 << 3)
> +#define MC13783_BUTTON_RESET_EN		(1 << 4)
> +	int b1on_flags;
> +	unsigned short b1on_key;
> +	int b2on_flags;
> +	unsigned short b2on_key;
> +	int b3on_flags;
> +	unsigned short b3on_key;
> +};
> +
>  struct mc13xxx_platform_data {
>  #define MC13XXX_USE_TOUCHSCREEN (1 << 0)
>  #define MC13XXX_USE_CODEC	(1 << 1)
> @@ -146,6 +162,7 @@ struct mc13xxx_platform_data {
>  
>  	struct mc13xxx_regulator_platform_data regulators;
>  	struct mc13xxx_leds_platform_data *leds;
> +	struct mc13xxx_buttons_platform_data *buttons;
>  };
>  
>  #endif /* ifndef __LINUX_MFD_MC13XXX_H */
> -- 
> 1.6.3.3
> 

Otherwise:

	Acked-by: Dmitry Torokhov <dtor@mail.ru>

Please feel free to merge with the rest of the patches.

Thanks.

-- 
Dmitry
