From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Thu, 22 Mar 2012 20:23:58 -0400
Subject: ioremap to a specific virtual address
Message-ID: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When iotable is used to initially map memory you can specify the
mapping address. In this case IO_SDMMC_PHYS is 0x18000000 and it gets
mapped to  0xf1800000

NXP has supplied this handly macro
#define io_p2v(x) (0xf0000000 | (((x) & 0xff000000) >> 4) | ((x) & 0x000fffff))

iotable_init(lpc313x_io_desc, ARRAY_SIZE(lpc313x_io_desc));

	{
		.virtual	= io_p2v(IO_SDMMC_PHYS),
		.pfn		= __phys_to_pfn(IO_SDMMC_PHYS),
		.length		= IO_SDMMC_SIZE,
		.type		= MT_DEVICE
	},

The supplied kernel is full of code that uses this type of addressing.
It has macros for register definition that all depend on the registers
being mapped to a well know location - io_p2v(x).

I'd like to move the map out of the core code and into the SDMMC
device driver and then only do it if the driver loads.  Is there some
way to ioremap to a specific address on ARM? Or is there another way
to build the mapping in the driver?

-- 
Jon Smirl
jonsmirl at gmail.com
