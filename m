From: hebert.marcandre@gmail.com (=?ISO-8859-1?Q?Marc=2DAndr=E9_H=E9bert?=)
Date: Mon, 23 Aug 2010 13:56:18 -0400
Subject: Trying to use SDRAM on an omapl138 board
Message-ID: <AANLkTinUBqPrj14sET6_s4QNAm-yCMR9XRnCuhsLdfOK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to get an OMAPL138 board using SDRAM to boot. From what I
observing, the kernel hangs when accessing registers from certain
controllers depending on their locations. The mapping for the internal
registers is done using:
#define IO_PHYS				0x01c00000
#define IO_OFFSET			0xfd000000 /* Virtual IO = 0xfec00000 */
#define IO_SIZE				0x00400000
static struct map_desc da850_io_desc[] = {{
		.virtual	= IO_VIRT,
		.pfn		= __phys_to_pfn(IO_PHYS),
		.length		= IO_SIZE,
		.type		= MT_DEVICE
},

But on my board using SDRAM, accesses to 0x01d00000-0x01dfffff and
0x01f00000 0x01ffffff stall.

To permit the usage of the SDRAM instead of the DDR, I modified the
PHYS_OFFSET to be 0x40000000 instead of 0xC0000000 when a SDRAM board
is used. I did this by adding an option to the
arch/arm/mach-davinci/Kconfig and by modifying the defines in
arch/arm/mach-davinci/include/mach/memory.h.

The kernel does uncompress, registers the platform drivers and starts
initializing each driver but then hangs when it initializes a driver
with a controller located in one of the regions (in my case the SPI1
controller is the first encountered).

I am guessing I messed up the memory mapping by modifying the
PHYS_OFFSET. Either I shouldn't have done it entirely or I need to
change something else as well (page shift, size, ...).

Any leads or suggestions would be appreciated.
Thanks
Marc
