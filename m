From: devendra.aaru@gmail.com (devendra.aaru)
Date: Wed, 26 Sep 2012 14:17:46 -0400
Subject: dead code in arch/arm/common/scoop.c
Message-ID: <CAHdPZaP0GePFxtknrUuhMG6rMXyZUkqJfgLe6+FMMAUK4adozw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

First of all sorry to disturb you all with my silly questions,

While looking at the scoop_probe in arch/arm/common/scoop.c, i found a
code path which will never run, please correct me if i am wrong,


code path: from arch/arm/common/scoop.c


@line  = 179 scoop_probe
.........

@line = 212
        iowrite16(inf->io_out & 0xffff, devptr->base + SCOOP_GPWR);

        devptr->suspend_clr = inf->suspend_clr;
        devptr->suspend_set = inf->suspend_set;

        devptr->gpio.base = -1;

        if (inf->gpio_base != 0) {
                devptr->gpio.label = dev_name(&pdev->dev);
                devptr->gpio.base = inf->gpio_base;
                devptr->gpio.ngpio = 12; /* PA11 = 0, PA12 = 1, etc.
up to PA22 = 11 */
                devptr->gpio.set = scoop_gpio_set;
                devptr->gpio.get = scoop_gpio_get;
                devptr->gpio.direction_input = scoop_gpio_direction_input;
                devptr->gpio.direction_output = scoop_gpio_direction_output;

                ret = gpiochip_add(&devptr->gpio);
                if (ret)
                        goto err_gpio;
        }

        return 0;

/////------------- This execution path will never trigger to run --------/////

@line 235:
        if (devptr->gpio.base != -1)
                temp = gpiochip_remove(&devptr->gpio);
////------------------------------------------------------------------------------/////

err_gpio:
        platform_set_drvdata(pdev, NULL);
err_ioremap:
        iounmap(devptr->base);
        kfree(devptr);


i dont think we should move err_gpio to just below return 0.

thanks,
