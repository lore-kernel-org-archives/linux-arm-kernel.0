From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 16 Nov 2016 18:46:50 +0000
Subject: Boot failures in -next due to 'ARM: dts: imx: Remove
 skeleton.dtsi'
In-Reply-To: <cda2df55-f2f3-00d6-c6b1-816ed47bbf56@roeck-us.net>
References: <cda2df55-f2f3-00d6-c6b1-816ed47bbf56@roeck-us.net>
Message-ID: <20161116184649.GF11228@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 09:45:35AM -0800, Guenter Roeck wrote:
> Hi,

Hi,

> my 'sabrelite' and 'imx25-pdk' qemu boot tests are failing in linux-next.
> 
> Bisect for the sabrelite failure points to commit 'ARM: dts: imx: Remove skeleton.dtsi'.
> 
> Bisect log is attached. Complete test logs are at
> http://kerneltests.org/builders/qemu-arm-next/builds/571/steps/qemubuildcommand/logs/stdio
> 
> Boot log for imx25-pdk:
> 
> qemu-system-arm: findnode_nofail Couldn't find node /chosen: FDT_ERR_NOTFOUND

So this implies we no longer have a /chosen node. We should add one to
the relevant dts{i,} files, with stdout-path and so on.

> Boot log for sabrelite:
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.9.0-rc5-next-20161116 (groeck at jupiter.roeck-us.net) (gcc version 4.9.2 (GCC) ) #1 SMP Tue Nov 15 22:34:35 PST 2016
> [    0.000000] CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> [    0.000000] OF: fdt:Machine model: Freescale i.MX6 DualLite SABRE Lite Board
> [    0.000000] earlycon: ec_imx21 at MMIO 0x021e8000 (options '')
> [    0.000000] bootconsole [ec_imx21] enabled
> [    0.000000] INITRD: 0x14000000+0x00501600 is not a memory region - disabling initrd
> [    0.000000] cma: Failed to reserve 64 MiB
> [    0.000000] Memory policy: Data cache writeback
> 
> [ stuck here until aborted ]

The last message was from build_mem_types_table(), called from
paging_init(). We'll head on to unflatten_device_tree() shortly
afterwards.

I wonder if the DTB is corrupted somehow in this case. Maybe the initrd
and cma failures is due to unparseable memory nodes.

Could you try with memblock=debug to see if memory looks as expected?

Thanks,
Mark.
