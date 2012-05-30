From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 31 May 2012 01:15:31 +0200
Subject: [RFC PATCH 0/6] ARM: Disintegrating mach/uncompress.h: low-level debug
Message-ID: <20120530231531.673897171@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

  Earlycon is a thin I/O layer used in the early stage of the
kernel loading, before the kernel is decompressed. It provides basic
functionality to output characters one by one and flush a queue/buffer.

Such abstraction allows the management of multiple drivers and the runtime
selection of the one to be used (ex. "earlyprintk=amba-pl011,0xc1000" on
the cmdline).  If no suitable driver is found, fallback ops are used.

Mainline implementation of low-level debugging functionality is currently
left to the machine specific uncompress.h header file, which greatly
limits the usage of the kernel on multiple machines. Hence the need to
remove any driver implementation detail from the said headers.

The idea is to collect/refactor the various implementations into separate
drivers which can coexist in the same kernel image. In the case of debug
UARTs, the natural place for such drivers is the respective kernel
serial driver.  Some linker magics is used later to inject them into
the decompressor.

Here is a minimal (and very commmon) driver example:

static void __earlyconinit minimal_earlycon_putc(struct earlycon_drv *drv, int ch)
{
	while (STATUS_REG(drv->base) & BUSY_MASK)
		barrier();

	DATA_REG(drv->base) = ch;
}

EARLYCON_START("minimal-uart")
	.putc = minimal_earlycon_putc,
EARLYCON_END

The EARLYCON_START's argument ("minimal-uart") is the name used to
select this driver during the early boot process.  The __earlyconinit and
EARLYCON_START specifiers are defined to put all the related driver stuff
into the sections designated to be injected.  Besides some restrictions,
the Earlycon driver is quite straightforward to code.

Some effort has been spent also to lay down an easy migration path
for the various platforms, each one independently from the others.
The backward compatibility is granted by the fallback logics, which
is controller by two pre-processor knobs: CONFIG_DEBUG_LL_EARLYCON
and EARLYCON_STATIC_SETUP.

The fallback logics is used when no suitable Earlycon driver is found
or none is searched.  In case neither CONFIG_DEBUG_LL_EARLYCON nor
EARLYCON_STATIC_SETUP are defined, the fallback ops actually invoke
the legacy putc/flush otherwise they don't do anything.

CONFIG_DEBUG_LL_EARLYCON is a configuration option that says "whatever
legacy putc/flush stuff is coming from uncompress.h, don't use it,
use only the available Earlycom drivers". It's a global setting,
it should help to simulate a world without uncompress.h. Actually it
really removes the dependency on uncompress.h at the cost of breaking
stuff depending on arch_decomp_setup().

EARLYCON_STATIC_SETUP instead is local, it's defined in the uncompress.h
header itself. It is used by the driver writer to quickly go back and
forth the "world without uncompress.h" and find his/her way out of
the blank console. It also helps to identify the uncompress.h headers
substantially ready to be removed.

I'm surely missing something but I hope you'll spot it reading/testing
the code, which is based on mainline commit f2fde3a.

Thank you for reading so far.

cheers,
Domenico
