From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Aug 2016 11:27:21 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <20160831084938.GQ1041@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home>
 <20160830091805.GL1041@n2100.armlinux.org.uk>
 <87k2eycip0.fsf@belgarion.home>
 <20160830184612.GO1041@n2100.armlinux.org.uk>
 <87fupmc59b.fsf@belgarion.home>
 <20160831084938.GQ1041@n2100.armlinux.org.uk>
Message-ID: <20160831102721.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 09:49:38AM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 30, 2016 at 11:32:16PM +0200, Robert Jarzmik wrote:
> > Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> > 
> > > If you can wait a day or two, I'll push a branch out for everything in
> > > all these multiple series.
> > Sure, just ping me when you have something.
> 
> git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
> 
> should get you something suitable to test.  It's based on 4.7-rc3 plus
> my fixes branch.
> 
> It would be great to have this tested on Lubbock, and get the PCMCIA
> issues fixed.  Maybe we can look at converting mainstone as well?

Yes, looking at mainstone's PCMCIA, it uses a MAX1602 device, which
is supported by the new max1600.c code.

#define MST_PCMCIA_PWR_VPP_0    0x0        /* voltage VPP = 0V */
#define MST_PCMCIA_PWR_VPP_120  0x2        /* voltage VPP = 12V*/
#define MST_PCMCIA_PWR_VPP_VCC  0x1        /* voltage VPP = VCC */
#define MST_PCMCIA_PWR_VCC_0    0x0        /* voltage VCC = 0V */
#define MST_PCMCIA_PWR_VCC_33   0x8        /* voltage VCC = 3.3V */
#define MST_PCMCIA_PWR_VCC_50   0x4        /* voltage VCC = 5.0V */

This follows the Cirrus code (also used by Lubbock.)  So, if we represent
the MST_PCMCIA[01] registers as GPIOs, we can switch pxa2xx_mainstone.c
to use the max1600.c code for power control.

With the other signals in MST_PCMCIA[01] represented as GPIOs (we'd
need to add the VS* to soc_common), we'd then have those read by
generic code, which means mst_pcmcia_socket_state() becomes just the
hack for STSCHG.

With gpio-reg, we can represent these registers easily as GPIOs, eg:

	gc = gpio_reg_init(NULL, (void __iomem *)&MST_PCMCIA0,
			   -1, 11, "mst-pcmcia0", ~MST_PCMCIA_PWR_MASK, 0,
			   mst_pcmcia_names);

There is a slight issue, which is that the interrupts can't be
translated to an interrupt by gpio-reg, which will currently cause
soc_common problems - but that's an easy fix, though leaves us with
more code than I'd desire in pxa2xx_mainstone.c.  Maybe a solution
there would be to have gpio-reg also take an array of interrupt
numbers... not sure yet.


For IrDA, it looks like it has the same transceiver as the assabet, so
I've (already) patches to split out the gpio-based transceiver control
from sa1100_ir - maybe we can re-use that in pxaficp_ir too.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
