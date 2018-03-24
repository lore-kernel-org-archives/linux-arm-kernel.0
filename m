From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Sat, 24 Mar 2018 22:50:54 +0100
Subject: [PATCH] watchdog: Add support for Armada 37xx CPU watchdog
In-Reply-To: <20180323164422.27959-1-marek.behun@nic.cz> ("Marek
 =?utf-8?Q?Beh=C3=BAn=22's?=
 message of "Fri, 23 Mar 2018 17:44:22 +0100")
References: <20180323164422.27959-1-marek.behun@nic.cz>
Message-ID: <87r2o9uoqp.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,
 
 On ven., mars 23 2018, Marek Beh?n <marek.behun@nic.cz> wrote:


> This adds support for the CPU watchdog found on Marvell Armada 37xx
> SoCs.
>
> There are 4 counters which can be set as CPU watchdog counters.
> This driver uses the second counter (ID 1, counting from 0)
> (Marvell's Linux also uses second counter by default).
> In the future it could be adapted to use other counters, with
> definition in the device tree.

Thanks for your contribution! Here it is my first level of feedback for
the obvious issue. I will do a more complete review on the beginning of
the next week.

>
> Signed-off-by: Marek Behun <marek.behun@nic.cz>
> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi |   7 +
>  drivers/watchdog/Kconfig                     |  11 +
>  drivers/watchdog/Makefile                    |   1 +
>  drivers/watchdog/armada_37xx_wdt.c           | 356 +++++++++++++++++++++++++++
>  4 files changed, 375 insertions(+)
>  create mode 100644 drivers/watchdog/armada_37xx_wdt.c
>

The following file should be submit as a separate patch

> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 8c0cf7efac65..fcd2186e869c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -139,6 +139,13 @@
>  				status = "disabled";
>  			};
>  
> +			wdt: watchdog-timer at 8300 {
> +				compatible = "marvell,armada-3700-wdt";

You introduce a new binding so you should document it under Documentation/devicetree/bindings/watchdog/.

> +				reg = <0xd064 0x4>,
> +				      <0x8300 0x40>;
> +				clocks = <&xtalclk>;
> +			};
> +
>  			nb_periph_clk: nb-periph-clk at 13000 {
>  				compatible = "marvell,armada-3700-periph-clock-nb";
>  				reg = <0x13000 0x100>;
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbfdc7e6..b2dfafcde741 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -255,6 +255,17 @@ config ARM_SBSA_WATCHDOG
>  	  To compile this driver as module, choose M here: The module
>  	  will be called sbsa_gwdt.
>  
> +config ARMADA_37XX_WATCHDOG
> +	tristate "Armada 37xx watchdog"
> +	depends on ARCH_MVEBU || COMPILE_TEST

> +	depends on ARM64
Not sue we really need this dependency

[...]

> diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
> new file mode 100644
> index 000000000000..99145168e93e
> --- /dev/null
> +++ b/drivers/watchdog/armada_37xx_wdt.c
> @@ -0,0 +1,356 @@

Use a SPDX-License-Identifier tag here and then you can remove the
license text.


> +/*
> + * drivers/watchdog/armada_37xx_wdt.c

I think we do not put anymore the name of the file inside the file itself

> + *
> + * Watchdog driver for Marvell Armada 37xx SoCs
> + *
> + * Author: Marek Behun <marek.behun@nic.cz>
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +

You could sort the header in alphabetical order

> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <asm/io.h>
> +
> +/*
> + * There are four counters that can be used for watchdog on Armada 37xx.
> + * The adresses for counter control registers are register base plus ID*0x10,
          addresses

> + * where ID is 0, 1, 2 or 3.
> + * In this driver we use ID 1. Marvell's Linux also uses this ID by default,
> + * and the U-Boot driver written simultaneosly by the same author as this
> + * driver also uses ID 1.
> + * Maybe in the future we could change this driver to support other counters,
> + * depending on the device tree, but I don't think this is necessary.
> + *
> + * Note that CNTR_ID cannot be 3, because the third counter is an increment
> + * counter, and this driver is written to support decrementing counters only.
> + */
> +
> +#define CNTR_ID				1
> +
> +#define CNTR_CTRL			(CNTR_ID * 0x10)
> +#define CNTR_CTRL_ENABLE		0x0001
> +#define CNTR_CTRL_ACTIVE		0x0002
> +#define CNTR_CTRL_MODE_MASK		0x000c
> +#define CNTR_CTRL_MODE_ONESHOT		0x0000
> +#define CNTR_CTRL_PRESCALE_MASK		0xff00
> +#define CNTR_CTRL_PRESCALE_MIN		2
> +#define CNTR_CTRL_PRESCALE_SHIFT	8
> +
> +#define CNTR_COUNT_LOW			(CNTR_CTRL + 0x4)
> +#define CNTR_COUNT_HIGH			(CNTR_CTRL + 0x8)
> +
> +#define WDT_TIMER_SELECT_MASK		0xf
> +#define WDT_TIMER_SELECT		(1 << CNTR_ID)

you could use BIT(CNTR_ID)

[...]

> +static int armada_37xx_wdt_probe(struct platform_device *pdev)
> +{
> +	struct armada_37xx_watchdog *dev;
> +	struct resource *res;
> +	int ret;
> +
> +	dev = devm_kzalloc(&pdev->dev, sizeof(struct armada_37xx_watchdog),
> +			   GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->wdt.info = &armada_37xx_wdt_info;
> +	dev->wdt.ops = &armada_37xx_wdt_ops;
> +	dev->wdt.min_timeout = 1;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +	dev->sel_reg = devm_ioremap(&pdev->dev, res->start,
> +				    resource_size(res));
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res)
> +		return -ENODEV;
> +	dev->reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +
> +	/* init clock */
> +	dev->clk = clk_get(&pdev->dev, NULL);

you could use devm_clk_get here..

> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);
> +
> +	ret = clk_prepare_enable(dev->clk);
> +	if (ret) {
> +		clk_put(dev->clk);
.. and then remove the clk_put here ...

> +		return ret;
> +	}
> +
> +	dev->clk_rate = clk_get_rate(dev->clk);
> +
> +	/*
> +	 * Since the timeout in seconds is given as 32 bit unsigned int, and
> +	 * the counters hold 64 bit values, even after multiplication by clock
> +	 * rate the counter can hold timeout of UINT_MAX seconds.
> +	 */
> +	dev->wdt.min_timeout = 0;
> +	dev->wdt.max_timeout = UINT_MAX;
> +	dev->wdt.parent = &pdev->dev;
> +
> +	/* default value, possibly override by module parameter or dtb */
> +	dev->wdt.timeout = WATCHDOG_TIMEOUT;
> +	watchdog_init_timeout(&dev->wdt, timeout, &pdev->dev);
> +
> +	platform_set_drvdata(pdev, &dev->wdt);
> +	watchdog_set_drvdata(&dev->wdt, dev);
> +
> +	armada_37xx_wdt_set_timeout(&dev->wdt, dev->wdt.timeout);
> +
> +	if (armada_37xx_wdt_is_running(dev))
> +		set_bit(WDOG_HW_RUNNING, &dev->wdt.status);
> +	else
> +		armada_37xx_wdt_stop(&dev->wdt);
> +
> +	watchdog_set_nowayout(&dev->wdt, nowayout);
> +	ret = watchdog_register_device(&dev->wdt);
> +	if (ret)
> +		goto disable_clk;
> +
> +	dev_info(&pdev->dev, "Initial timeout %d sec%s\n",
> +		 dev->wdt.timeout, nowayout ? ", nowayout" : "");
> +
> +	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(dev->clk);
> +	clk_put(dev->clk);
... and here ...

> +	return ret;
> +}
> +
> +static int armada_37xx_wdt_remove(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdt = platform_get_drvdata(pdev);
> +	struct armada_37xx_watchdog *dev = watchdog_get_drvdata(wdt);
> +
> +	watchdog_unregister_device(wdt);
> +	clk_disable_unprepare(dev->clk);
> +	clk_put(dev->clk);
... and here

> +	return 0;
> +}

Gregory

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
