From: narkewoody@gmail.com (Woody Wu)
Date: Mon, 26 Nov 2012 07:37:12 +0000 (UTC)
Subject: The Ethernet driver doesn't get probed
Message-ID: <slrnkb66vj.3sl.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, List

I enabled an ax88796 Ethernet driver in the kernel configuration menu.
Kernel version is 3.4.19. The arch is ARM and the system type is
Samsung S3C2410.

In my debugging, I found the probe function of the driver did not get
invoked.

This driver is declared as platform_driver

static struct platform_driver axdrv = {
	.driver	= {
		.name		= "ax88796",
		.owner		= THIS_MODULE,
	},
	.probe		= ax_probe,
	.remove		= ax_remove,
	.suspend	= ax_suspend,
	.resume		= ax_resume,
};

module_platform_driver(axdrv);

So, its driver init function actually goes through
platform_driver_register() and then driver_register(), which eventually
call driver_attach() trying to attach the driver to the "platform" bus.
But, on the platform bus, there is no any device that can match the
ax88796 driver, hence the driver failed in attaching.

I discovered the full list of devices found on the platform bus:

    s3c2410-ohci,
    s3c2410-lcd,
    s3c2410-wdt,
    s3c2410-i2c,
    s3c24xx-iis,
    s3c2410-nand,
    s3c24xx_led,
    s3c2410-uart,

You see, in the list, there is no a device looks like ax88796. All these
already existed devices on the platform bus are build-in peripherals on
the SoC of s3c2410, they are compiled into the code by enabling some
kernel configuration options.

My question is, in terms of Linux driver technology, how to enable a
non-PCI and not on-chip device driver? I think the ax_probe function
must be called somehow, is this thinking right? If yes, I think before
the driver get initialized, the corresponding device has to appear on
the bus, but now it seems not.

Thanks in advance.

-- 
woody
I can't go back to yesterday - because I was a different person then.
