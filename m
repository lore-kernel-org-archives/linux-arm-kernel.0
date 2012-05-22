From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 22 May 2012 09:34:17 -0400
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <4FBB7FD7.4060604@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk> <4FB25A9A.3070306@gmail.com>
 <20120517233512.GH16338@titan.lakedaemon.net>
 <4FB5AFF4.7060900@gmail.com> <4FBB7FD7.4060604@codethink.co.uk>
Message-ID: <20120522133417.GX24238@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 01:00:23PM +0100, Ben Dooks wrote:
> On 18/05/12 03:12, Rob Herring wrote:
> >On 05/17/2012 06:35 PM, Jason Cooper wrote:
> >>On Tue, May 15, 2012 at 08:31:06AM -0500, Rob Herring wrote:
> >>>marvell is the documented vendor string, not mrvl.
> >>
> >>When Arnd and I were adding the initial kirkwood support for devicetree,
> >>the common wisdom was to use the stock ticker symbol when available.
> >>Hence, mrvl, iom, and dlink (only on taiwanese exchange, which uses
> >>numbers)...
> >
> >Yes, that's true. But consistency is more important. If we have cases of
> >both, then one needs to be deprecated.
> 
> I'd go for "should" instead of "needs". I would say it would be nice
> to settle on marvell.

Looking back on it, when Arnd and I were discussing this, I should have
voiced my concerns.  Stock ticker symbols are concise, unique, and
generally recognizable.  However, not all companies are publicly traded,
nor do all stock exchanges use english contractions/abbreviations.  The
taiwanese stock exchange, for example, uses numerical identifiers.

> There are already instances of "mrvl" in the kernel, see
> 
> 	drivers/i2c/busses/i2c-pxa.c
> 	drivers/tty/serial/pxa.c
> 	drivers/rtc/rtc-mv.c
> 	drivers/rtc/rtc-sa1100.c

drivers with dt bindings are easy to maintain reverse compatibility:

diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index b2185f4..de7b231 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -298,6 +298,7 @@ static int __exit mv_rtc_remove(struct
platform_device *pdev)
 #ifdef CONFIG_OF
 static struct of_device_id rtc_mv_of_match_table[] = {
        { .compatible = "mrvl,orion-rtc", },
+       { .compatible = "marvell,orion-rtc", },
        {}
 };
 #endif

If that ends up being necessary.

> Do people mind if the original compatibilities are left in to avoid
> having to rename .dts file contents, or are we happy to go with just
> "marvell"?

The kirkwood DT support is young enough, I think, that everyone using it
is also compiling/hacking/tweaking on it.  So, if we are going to change
it, now's the time.

> Also, it seems that some of the marvell bluetooth firmware is defined
> to be mrvl prefixed.

It would seem you are finding a lot of evidence for "mrvl" to be
preferred.  So, I started digging. There's quite a bit where "marvell"
is preferred:

$ git grep -l [^@]marvell,

	Documentation/devicetree/bindings/marvell.txt
	Documentation/devicetree/bindings/net/mdio-mux-gpio.txt
	Documentation/devicetree/bindings/net/mdio-mux.txt
	arch/powerpc/boot/cuboot-c2k.c
	arch/powerpc/boot/dts/c2k.dts
	arch/powerpc/boot/dts/prpmc2800.dts
	arch/powerpc/boot/mv64x60.c
	arch/powerpc/boot/mv64x60_i2c.c
	arch/powerpc/boot/prpmc2800.c
	arch/powerpc/boot/serial.c
	arch/powerpc/platforms/embedded6xx/c2k.c
	arch/powerpc/platforms/embedded6xx/prpmc2800.c
	arch/powerpc/sysdev/mv64x60_dev.c
	arch/powerpc/sysdev/mv64x60_pci.c
	arch/powerpc/sysdev/mv64x60_pic.c
	arch/powerpc/sysdev/mv64x60_udbg.c
	drivers/net/phy/marvell.c

And, just to compare apples to apples:

$ git grep -l [^@]mrvl,

	Documentation/devicetree/bindings/arm/mrvl.txt
	Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
	Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
	Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
	Documentation/devicetree/bindings/serial/mrvl-serial.txt
	arch/arm/boot/dts/kirkwood-dreamplug.dts
	arch/arm/boot/dts/kirkwood.dtsi
	arch/arm/boot/dts/pxa168-aspenite.dts
	arch/arm/boot/dts/pxa168.dtsi
	arch/arm/mach-mmp/mmp-dt.c
	drivers/i2c/busses/i2c-pxa.c
	drivers/rtc/rtc-mv.c
	drivers/rtc/rtc-sa1100.c
	drivers/tty/serial/pxa.c

So, basically, the powerpc folks have been using "marvell", and now
we're trying to change it to "mrvl".

I can't think of a technical reason to prefer one over the other.  So,
based purely on compatibility and uniformity, I'd say stick with
"marvell".  Grant, Arnd, is there something we're missing?

thx,

Jason.
