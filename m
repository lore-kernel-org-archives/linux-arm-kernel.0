From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Aug 2010 14:03:49 +0200
Subject: [PATCH/RFC] Samsung device-table approach
Message-ID: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I would like to start the discussion on the redesign of the way the
Samsung platform devices are defined. The current solution has some
important disadvantages that blocks the further kernel development.

Samsung SoC family is quite large. Mainline kernel already has support
for more than 8 representatives, each having different memory and irq
map.

Currently most of the base address and irq differences are hidden behind
the includes and some common defines (usualy named S3C_PA_*). Some
devices also have different variants that are specified by changing the
device name to include the SoC version in it. Others have SoC specific
callbacks (like gpio pin configuration) that are provided thought the
platform data.

There is a lot of code that is needed to handle all these variants and
differences. It also differs in term of style and a way how some
simmilar things are performed (like changing the device name or
providing the default platform data).

In 2009 Ben Dooks did a research and proposed a solution that is called
a device table. This solution solves the most problematic issue.
Different base addresses and irqs can be easily provided for the same
device on different version SoC systems. This is achieved by having a
single table for each SoC that contains all these resources and create
all required platform devices dynamically on SoC init.

The proposed solution was enough for s3c24xx SoC devices and some early
s3c64xx devices. However since then some new devices has been merged to
mainline, mainly for s5p SoC series. These devices have more than one
base address or irq and does not fit well into that framework.

I've extended his approach to handle such more advanced devices. The new
version is capable of setting up devices with more than one irq,
physical register areas or even a dma channel. 

I've also added support for the default platform data. It has been
designed in such a way that it can handle different default data for
each device instance for each SoC system. This requires a bit of C
preprocessor in the includes but make it much easier to register
particular device. With this new solution there is no need for calling a
function for setting platform data in machine startup.

The solution has been designed with the following assumptions:
1. to reduce the number of static structures compiled into the kernel
that are not used at all
2. to reduce the memory used by the unused static structures once kernel
has booted

The requirements has been achieved by:  
1. Conditional compilation and linkage of default platform data and the
required callbacks. This requires a little help from C preprocessor to
NULL some symbols if they are not compiled in but I've tried to keep the
code as readable as possible.
2. Moving all structures to the __initdata section. This require to
duplicate all used data by kmemdup (or kmalloc+memcpy) but it is not a
problem, because most of the structures are created dynamically anyway.

This patch series has been prepared mainly as an RFC not a final
implementation. It covers only a single SoC (S5PV210) and 2 machines
(Aquila and GONI). Once the common way for the device-table will be
agreed, the patches for other SoCs and machines will be prepared.

The patch series consist of the following patches:
[PATCH 1/9] ARM: Samsung: add device-table core functions
[PATCH 2/9] ARM: S5PV210: add initial device-table
[PATCH 3/9] ARM: S5PV210: convert uart to device-table
[PATCH 4/9] ARM: S5PV210: add support for device-table on Aquila&Goni
[PATCH 5/9] ARM: S5PV210: convert OneNAND to device-table
[PATCH 6/9] ARM: S5PV210: convert sdhci to device-table
[PATCH 7/9] ARM: S5PV210: convert framebuffer to device-table
[PATCH 8/9] ARM: S5PV210: convert i2c to device-table
[PATCH 9/9] ARM: S5PV210: add i2c device on Aquila

This patch series contains a device conversion for the following
platform devices:
- UART (s3c64xx-uart, s5pv210-uart, ...)
- SDHCI (s3c-sdhci)
- Frame Buffer (s3c-fb)
- I2C (s3c-i2c)
- OneNAND (s5pv210-onenand)

Each device conversion is provided in a separate patch, so one can
easily notice how the conversion is performed. These five device
conversions can be also used as a template for other devices.

Here are some logs from the Aquila machine boot messages that shows how
the devices are being created:

s3c_device_create: device s5pv210-uart.0, template c0021814, #res 4
s3c_device_create: s5pv210-uart res 0 => c08a70e0 = 00000200 e2900000..e29003ff
s3c_device_create: s5pv210-uart res 1 => c08a70fc = 00000400 00000010..00000010
s3c_device_create: s5pv210-uart res 2 => c08a7118 = 00000400 00000012..00000012
s3c_device_create: s5pv210-uart res 3 => c08a7134 = 00000400 00000011..00000011
s3c_device_create: device s5pv210-uart.1, template c0021814, #res 4
s3c_device_create: s5pv210-uart res 0 => c08a7260 = 00000200 e2900400..e29007ff
s3c_device_create: s5pv210-uart res 1 => c08a727c = 00000400 00000014..00000014
s3c_device_create: s5pv210-uart res 2 => c08a7298 = 00000400 00000016..00000016
s3c_device_create: s5pv210-uart res 3 => c08a72b4 = 00000400 00000015..00000015
s3c_device_create: device s5pv210-uart.2, template c0021814, #res 4
s3c_device_create: s5pv210-uart res 0 => c08a73e0 = 00000200 e2900800..e2900bff
s3c_device_create: s5pv210-uart res 1 => c08a73fc = 00000400 00000018..00000018
s3c_device_create: s5pv210-uart res 2 => c08a7418 = 00000400 0000001a..0000001a
s3c_device_create: s5pv210-uart res 3 => c08a7434 = 00000400 00000019..00000019
s3c_device_create: device s5pv210-uart.3, template c0021814, #res 4
s3c_device_create: s5pv210-uart res 0 => c08a7560 = 00000200 e2900c00..e2900fff
s3c_device_create: s5pv210-uart res 1 => c08a757c = 00000400 0000001c..0000001c
s3c_device_create: s5pv210-uart res 2 => c08a7598 = 00000400 0000001e..0000001e
s3c_device_create: s5pv210-uart res 3 => c08a75b4 = 00000400 0000001d..0000001d

s3c_device_create: device s3c2440-i2c.0, template c00219a4, #res 2
s3c_device_create: s3c2440-i2c res 0 => dfc02ee0 = 00000200 e1800000..e1800fff
s3c_device_create: s3c2440-i2c res 1 => dfc02efc = 00000400 0000004e..0000004e
s3c_device_create: s3c2440-i2c pdata => dfcb6bc0 (24 bytes)
s3c_device_create: device s3c-fb.-1, template c002191c, #res 4
s3c_device_create: s3c-fb res 0 => dfc1d6e0 = 00000200 f8000000..f8003fff
s3c_device_create: s3c-fb res 1 => dfc1d6fc = 00000400 00000061..00000061
s3c_device_create: s3c-fb res 2 => dfc1d718 = 00000400 00000060..00000060
s3c_device_create: s3c-fb res 3 => dfc1d734 = 00000400 00000062..00000062
s3c_device_create: s3c-fb dma mask => ffffffff
s3c_device_create: s3c-fb pdata => dfcb6b00 (32 bytes)
s3c_device_create: device s5pc110-onenand.-1, template c00214b8, #res 2
s3c_device_create: s5pc110-onenand res 0 => dfc1d0e0 = 00000200 b0000000..b001ffff
s3c_device_create: s5pc110-onenand res 1 => dfc1d0fc = 00000200 b0600000..b06007ff
s3c_device_create: device s3c-sdhci.0, template c0021904, #res 2
s3c_device_create: s3c-sdhci res 0 => dfc1d2e0 = 00000200 eb000000..eb000fff
s3c_device_create: s3c-sdhci res 1 => dfc1d2fc = 00000400 0000005a..0000005a
s3c_device_create: s3c-sdhci dma mask => ffffffff
s3c_device_create: s3c-sdhci pdata => dfcb6e80 (40 bytes)
s3c_device_create: device s3c-sdhci.1, template c0021904, #res 2
s3c_device_create: s3c-sdhci res 0 => dfc6c2e0 = 00000200 eb100000..eb100fff
s3c_device_create: s3c-sdhci res 1 => dfc6c2fc = 00000400 0000005b..0000005b
s3c_device_create: s3c-sdhci dma mask => ffffffff
s3c_device_create: s3c-sdhci pdata => dfc68f00 (40 bytes)
s3c_device_create: device s3c-sdhci.2, template c0021904, #res 2
s3c_device_create: s3c-sdhci res 0 => dfc6c6e0 = 00000200 eb200000..eb200fff
s3c_device_create: s3c-sdhci res 1 => dfc6c6fc = 00000400 0000005c..0000005c
s3c_device_create: s3c-sdhci dma mask => ffffffff
s3c_device_create: s3c-sdhci pdata => dfc68700 (40 bytes)

This patch series has been prepared for the kgene/tmp-all-merged
(3eb7878811b8e2218cc485578f2a1ffa07152099) kernel tree (it equal to the
current Samsung for-next tree with all other required patches to make it
build):
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git tmp-all-merged

I would like to get an opinion on this solution. It is a third attempt
on the device-table. The original one, proposed by Ben Dooks, is
available on his git tree, wip-samsung-dev branch:
git://git.fluff.org/bjdooks/linux wip-samsung-dev

The second one has been proposed by Kyungmin Park. It can be found the
following thread:
http://www.spinics.net/lists/arm-kernel/msg93583.html

Best regards,
-- 
Marek Szyprowski
Samsung Poland R&D Center
