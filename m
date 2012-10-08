From: m.olbrich@pengutronix.de (Michael Olbrich)
Date: Mon, 8 Oct 2012 18:08:41 +0200
Subject: Problem with 64-bit registers on i.MX53
Message-ID: <20121008160841.GM19651@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

I have a problem that looks like that 64-bit registers (I think) are not
saved/restored correctly on a context switch. I've reduced it to the
following test case:

- Latest Linux mainline kernel (v3.6-8559-ge9eca4d)
  v3.5 is also affected
- imx_v6_v7_defconfig
- arch/arm/boot/dts/imx53-evk.dts

The following test program is compiled with "-mcpu=cortex-a8 -mfpu=neon
-O2".
------------------------>8--------------------------------
#include <inttypes.h>
#include <assert.h>

volatile int x = 2;
volatile int64_t y = 2;

int main() {
	volatile int a = 0;
	volatile int64_t b = 0;
	while (1) {
		a = (a + x) % (1 << 30);
		b = (b + y) % (1 << 30);
		assert(a == b);
	}
}
------------------------>8--------------------------------
The ".. (b + y) .." should result in "vadd.i64 d19, d18, d16" or
something like that.

If I start the program twice in parallel, then on aborts immediately with
the assert().
When looking at it with the debugger, it seems as if the calculation
"b = (b + y) % (1 << 30)" produces an incorrect value.

A single instance of the program runs longer, but hits the assert()
eventually. So running multiple processes that use 64-bit registers
triggers the problem really fast. This is why I think the problem has
something to do with context switches.
Not using 64-bit registers (-msoft-float) makes the problem go away.
So it's definitely related to 64-bit registers.

If I disable all MX31/MX35 boards (and therefore all ARMv6 support), then
it works as expected.

Any ideas what goes wrong here?

Regards,
Michael Olbrich

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
