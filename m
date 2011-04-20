From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 20 Apr 2011 13:47:47 +0800
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary to
	be appended to zImage
In-Reply-To: <20110413140030.GE12665@atomide.com>
References: <20110324231830.2586.7150.stgit@riker>
	<20110328091259.GA18721@S2100-06.ap.freescale.net>
	<20110413140030.GE12665@atomide.com>
Message-ID: <20110420054746.GA31127@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Apr 13, 2011 at 05:00:30PM +0300, Tony Lindgren wrote:
> * Shawn Guo <shawn.guo@freescale.com> [110328 12:10]:
> > On Thu, Mar 24, 2011 at 04:18:41PM -0700, John Bonesio wrote:
> > > This patch provides the ability to boot using a device tree that is appended
> > > to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> > > 
> > > Signed-off-by: John Bonesio <bones@secretlab.ca>
> > > ---
> > > 
> > Tested on mx51 babbage.  The non-dt kernel works fine, but dt kernel
> > does not.
> > 
> > I tracked it down a little bit and found, before calling kernel from
> > arch/arm/boot/compressed/head.S, the dtb magic number (at address
> > pointed by r8) was interpolated to 0x73fbc000 which happens to be the
> > value of 'uart_base' assigned in plat-mxc/include/mach/uncompress.h.
> 
I got it working by remove the 'static' from uart_base definition.

> Gave this a try on an omap3 based board, looks like decompress_kernel
> will trash the first 16 bytes of the device tree data somehow.
> 
16 bytes corruption is a little beyond my guess.  I expect only 8
bytes corruption on omap3.  Can you please remove the 'static' in
uncompress.h to see if it helps?

--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -27,8 +27,8 @@

 #define MDR1_MODE_MASK                 0x07

-static volatile u8 *uart_base;
-static int uart_shift;
+volatile u8 *uart_base;
+int uart_shift;
---

Here is how I tracked it down with help from Dave Martin and Nicolas
Pitre.

http://lists.linaro.org/pipermail/linaro-kernel/2011-April/000259.html

With the comments given by Nicolas below, this seems a global issue in
platform uncompress.h.

--- quote begins ---
You must not use static variable in the decompressor.  For one thing, 
that breaks the ability to XIP the decompressor code and move writable 
data elsewhere.

So the fix is indeed to _not_ declare any global variable as static in 
this case.
--- quote ends ---

I would like to confirm it fixes your setup before I send fixing
patch to remove 'static' from global variables in all platform
uncompress.h.

-- 
Regards,
Shawn
