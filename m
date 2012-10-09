From: m.olbrich@pengutronix.de (Michael Olbrich)
Date: Tue, 9 Oct 2012 11:02:22 +0200
Subject: Problem with 64-bit registers on i.MX53
In-Reply-To: <20121008175052.GG2302@linaro.org>
References: <20121008160841.GM19651@pengutronix.de>
 <20121008170124.GZ4625@n2100.arm.linux.org.uk>
 <20121008171011.GA4625@n2100.arm.linux.org.uk>
 <20121008175052.GG2302@linaro.org>
Message-ID: <20121009090222.GP19651@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 06:50:52PM +0100, Dave Martin wrote:
> On Mon, Oct 08, 2012 at 06:10:11PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 08, 2012 at 06:01:24PM +0100, Russell King - ARM Linux wrote:
> > > On Mon, Oct 08, 2012 at 06:08:41PM +0200, Michael Olbrich wrote:
> > > > I have a problem that looks like that 64-bit registers (I think) are not
> > > > saved/restored correctly on a context switch. I've reduced it to the
> > > > following test case:
> > > > 
> > > > - Latest Linux mainline kernel (v3.6-8559-ge9eca4d)
> > > >   v3.5 is also affected
> > > > - imx_v6_v7_defconfig
> > > > - arch/arm/boot/dts/imx53-evk.dts
> > > > 
> > > > The following test program is compiled with "-mcpu=cortex-a8 -mfpu=neon
> > > > -O2".
> > > > ------------------------>8--------------------------------
> > > > #include <inttypes.h>
> > > > #include <assert.h>
> > > > 
> > > > volatile int x = 2;
> > > > volatile int64_t y = 2;
> > > > 
> > > > int main() {
> > > > 	volatile int a = 0;
> > > > 	volatile int64_t b = 0;
> > > > 	while (1) {
> > > > 		a = (a + x) % (1 << 30);
> > > > 		b = (b + y) % (1 << 30);
> > > > 		assert(a == b);
> > > > 	}
> > > > }
> > > > ------------------------>8--------------------------------
> > > > The ".. (b + y) .." should result in "vadd.i64 d19, d18, d16" or
> > > > something like that.
> 
> Just for my curiosity, can you let me know what compiler version you're
> using and the disassembly?  I'm actually a little surprised to see
> NEON code being generated here,

Im using oselas.toolchain which includes a gcc-linaro-4.6-2011.11. It
generates quite a bit of NEON code actually. I originally tracked down the
issue to a commit in libxcb: "xcb_in: Use 64-bit sequence numbers
internally everywhere.". The compiler generated NEON code to calculate
sequence numbers...

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
