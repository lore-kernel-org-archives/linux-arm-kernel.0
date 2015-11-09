From: slash.tmp@free.fr (Mason)
Date: Mon, 9 Nov 2015 18:03:47 +0100
Subject: Grafting old platform drivers onto a new DT kernel
In-Reply-To: <yw1xpozj5ezj.fsf@unicorn.mansr.com>
References: <563B3749.50701@free.fr> <20151105151559.GA16666@lunn.ch>
 <CABxcv=k5mzw_TDsD1eQna9+HY9aqCUd03YAc62750Gs--sMozw@mail.gmail.com>
 <5640B877.4020108@free.fr> <yw1xtwov5gh1.fsf@unicorn.mansr.com>
 <5640C4BF.2010204@free.fr> <yw1xpozj5ezj.fsf@unicorn.mansr.com>
Message-ID: <5640D1F3.1010100@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2015 17:12, M?ns Rullg?rd wrote:

> Mason writes:
> 
>> On 09/11/2015 16:40, M?ns Rullg?rd wrote:
>>
>>> The simplest solution for you is probably to add a quick and dirty DT
>>> binding to the old driver.  If it doesn't use any driver-specific
>>> platform data struct, you only need to set .of_match_table in the
>>> struct platform_driver.  If there is a platform data struct, you'll also
>>> need to write some code to populate it from DT properties.  It shouldn't
>>> take more than a few minutes per driver in most cases.
>>
>> I'll try that approach, although I fear that "a few minutes per driver"
>> is an optimistic assessment.
> 
> If the driver only needs an MMIO region and an IRQ, it is literally five
> lines of code.

It took me 7 days to figure out there were 2 lines missing in the
interrupt controller driver.

My problem is that I don't understand the platform API, nor the
interaction with the DT API.

Let me see...

In arch/arm/mach-tangox/platform_dev.c

static struct platform_device tangox_sdhci0_device = { ... };
static struct platform_device tangox_sdhci1_device = { ... };

static void tangox_init_sdhci(void)
{
	if (tangox_sdio_enabled(0))
		platform_device_register(&tangox_sdhci0_device);

	if (tangox_sdio_enabled(1))
		platform_device_register(&tangox_sdhci1_device);
}

called from tangox_init_devices() which is marked arch_initcall.



In the driver

static struct platform_driver tangox_platform_sdio0 = {
	.remove		= sdhci_tangox_remove,
	.suspend	= sdhci_tangox_suspend,
	.resume		= sdhci_tangox_resume,
	.driver		= {
		.name	= "tangox-sdhci",
		.owner	= THIS_MODULE,
	},
};


static struct platform_driver tangox_platform_sdio0 = {
	.remove		= sdhci_tangox_remove,
	.driver		= {
		.name	= "tangox-sdhci",
		.owner	= THIS_MODULE,
	},
};

static int __init tangox_sdhci_drv_init(void) {
	return platform_driver_probe(&tangox_platform_sdio0, sdhci_tangox_probe);
}

static void __exit tangox_sdhci_drv_exit(void) {
	platform_driver_unregister(&tangox_platform_sdio0);
}

module_init(tangox_sdhci_drv_init);
module_exit(tangox_sdhci_drv_exit);


The old way:

1) call platform_device_register() with a "struct platform_device"
2) call platform_driver_probe with a "struct platform_driver"

The new way(?)

The mess in 2) is hidden behind module_platform_driver?
The platform_device_register() is done by the DT core?
The struct platform_driver requires a probe function?

Regards.
