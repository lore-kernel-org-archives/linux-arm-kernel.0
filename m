From: sebastien.szymanski@armadeus.com (=?windows-1252?Q?S=E9bastien_SZYMANSKI?=)
Date: Thu, 22 Jan 2015 10:37:33 +0100
Subject: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <54C0AFE4.3020701@i2se.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com>
Message-ID: <54C0C4DD.2040302@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 01/22/2015 09:08 AM, Stefan Wahren wrote:
> 
> In the meantime i made some bugfixes on these patches. Now i think it
> would be better to integrate the on-chip regulator driver into the patch
> series. That would clarify the function of the power driver.
> 

I was about to resend this series with a poweroff driver for the imx28
SoCs. Should I wait this series get merged?

I thought adding a poweroff child node like this:

power: power at 80044000 {
	...
	poweroff: poweroff at 80044100 {
		compatible = "fsl,imx28-poweroff";
		reg = <0x80044100 0x10>;
	};
	...
};

Here is the driver:

/*
 * MXS SoCs reset code.
 *
 * Copyright (c) 2015 Armadeus Systems.
 *
 * Author: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
 *
 * based on imx-snvs-poweroff.c
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 and
 * only version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

#include <linux/err.h>
#include <linux/init.h>
#include <linux/io.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/of_address.h>
#include <linux/platform_device.h>

#define MXS_SET_ADDR                    0x4

#define POWER_RESET_UNLOCK__KEY         (0x3E77 << 16)
#define POWER_RESET_PWD                 0x1

static void __iomem *power_reset;

static void do_mxs_poweroff(void)
{
        writel(POWER_RESET_UNLOCK__KEY | POWER_RESET_PWD,
               power_reset + MXS_SET_ADDR);
}

static int mxs_poweroff_probe(struct platform_device *pdev)
{
        power_reset = of_iomap(pdev->dev.of_node, 0);
        if (!power_reset) {
                dev_err(&pdev->dev, "failed to get memory\n");
                return -ENODEV;
        }

        pm_power_off = do_mxs_poweroff;

        dev_info(&pdev->dev, "power off function set!\n");

        return 0;
}

static const struct of_device_id of_mxs_poweroff_match[] = {
        { .compatible = "fsl,imx28-poweroff", },
        {},
};
MODULE_DEVICE_TABLE(of, of_mxs_poweroff_match);

static struct platform_driver mxs_poweroff_driver = {
        .probe = mxs_poweroff_probe,
        .driver = {
                .name = "mxs-poweroff",
                .of_match_table = of_match_ptr(of_mxs_poweroff_match),
        },
};

static int __init mxs_poweroff_init(void)
{
        return platform_driver_register(&mxs_poweroff_driver);
}
device_initcall(mxs_poweroff_init);

Best Regards,

-- 
S?bastien SZYMANSKI
Software Engineer
Armadeus Systems - A new vision of the embedded world
sebastien.szymanski at armadeus.com
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26
