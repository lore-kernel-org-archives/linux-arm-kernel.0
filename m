From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Jul 2014 12:21:56 +0200
Subject: [PATCH v3 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <93903d5fdf85427bb8a418894540c122@BN1PR0301MB0772.namprd03.prod.outlook.com>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
 <22032517.gk8PRUMaIU@wuerfel>
 <93903d5fdf85427bb8a418894540c122@BN1PR0301MB0772.namprd03.prod.outlook.com>
Message-ID: <5456516.0fVZeXjF8k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 July 2014 01:20:54 Peter Chen wrote:
> Thanks, arnd.
> 
> For chipidea generic glue layer case, if there are three devices who use this
> driver, and all devices have 32-bit bus, some devices have less 32 address lines.
> For example:
> 
> - the device_a doesn't need to use dma_mask
> - the device_b needs dma_mask as 0xfffffffff
> - the device_c needs dma_mask as 0xfffffff0, assume it has only 28 address lines

This makes no sense. You always need a dma mask, so the first case doesn't exist,
and the second one is the default.

In the third case, I assume you mean 0x0fffffff, which is a 28-bit mask.

> My questions are:
> - Can we not set dma_mask at driver, and only set dma-ranges at dts for device_b
> and device_c as a solution to cover this different dma mask use case?

try to understand my earlier reply. What is the problem with device_b?
Is that a limitation of the bus it is connected to, or the version of the
chipidea hardware?

> - If we can't use this solution, would you suggest one?

It depends on what the requirement of the hardware is, as I explained
now for three times.

> - If we can use this solution, for device_b and device_c, how can we write dma-ranges?
> I can't find any arm platforms use it, only some powerpc platform use it.
> According to the definition from Power_ePAPR_APPROVED_v1.1.pdf, it is
> dma-ranges = <child-bus-address, parent-bus-address, length>
> but I find the powerpc has different way for using dma-ranges. 

It's now handled by of_dma_configure() in drivers/of/platform.c for all
architectures.

	Arnd
