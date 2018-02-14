From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Feb 2018 11:30:45 +0000
Subject: [PATCH v2 1/2] arm64: dts: marvell: add CP110 uart peripherals
In-Reply-To: <20180214111745.6lelfxrj5wutqzne@tarshish>
References: <03f1bec6e11c9f6fb9d5520c745eafca28597801.1517381798.git.baruch@tkos.co.il>
 <87vaezonrn.fsf@bootlin.com>
 <20180214105653.r4hcdxgbdmth3d7a@tarshish>
 <20180214110750.GP9418@n2100.armlinux.org.uk>
 <20180214111745.6lelfxrj5wutqzne@tarshish>
Message-ID: <20180214113045.GQ9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 01:17:45PM +0200, Baruch Siach wrote:
> Hi Ressell,
> 
> On Wed, Feb 14, 2018 at 11:07:51AM +0000, Russell King - ARM Linux wrote:
> > On Wed, Feb 14, 2018 at 12:56:53PM +0200, Baruch Siach wrote:
> > > On Wed, Feb 14, 2018 at 11:42:52AM +0100, Gregory CLEMENT wrote:
> > > >  On mer., janv. 31 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> > > > 
> > > > > The CP110 component has 4 uart peripherals. All of them use the same clock
> > > > > gate for slow peripherals that is shared with the i2c and spi peripherals.
> > > > >
> > > > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > > > 
> > > > Applied on mvebu/dt64
> > > 
> > > Thanks.
> > > 
> > > What about patch 2/2 in this series?
> > 
> > I'm not entirely convinced that it's something that should be done.
> > I know that some people are already using the UART headers for other
> > purposes (other than UART) and the later revision boards have the
> > placement of the microUSB fixed so it is accessible.
> > 
> > While you can tell Linux to use the other UART headers with this
> > patch, uboot won't use them, which means you can't configure the
> > boot loader without (in your case) taking the board out of the case.
> > 
> > I've a similar problem (with the mcbin in a rackmount case), and my
> > solution to that has been to put a single washer under the mounting
> > post near the microUSB to lift the board sufficiently to allow a
> > connector to be plugged in.  Sometimes simple hardware fixes are
> > better than software fixes.
> > 
> > Others have used a dremel to modify the case to access the microUSB.
> 
> Just for the record, I'm fine with dropping 'status = "okay"' from the mcbin 
> CP{0,1} UART nodes. This would still allow anyone who needs this functionality 
> to enable it with a simple .dts modification, or a run-time dtb modification 
> from the bootloader.

Talking more with Jon (who works for SolidRun, the board manufacturer),
the feeling there is:

1. Why enable both UART headers - it makes more sense (given your reason)
   to enable one as UART but keep the other as GPIO.  The labelling up of
   them being a UART is merely a historical artifact of the very early
   development of the board.

2. They are developer boards, not a final product.  Case modification is
   somewhat expected.

(2) is especially relevant when SFP support gets added - some of the
early revision boards have the SCL/SDA lines swapped on the I2C bus.
With that fixed, all boards have way too strong pull-ups on the I2C
bus which means some modules don't work - and worse than that, may
result in corrupted module EEPROMs.

I ended up with corruption here, and although I've a rev 1.3 board now,
I'm still using my self-modified rev 1.1 in preference to it, because
I don't want to have to deal with another corrupted EEPROM.

In order for SFP to be reliably functional, board modification is
required (either replacement of resistor packs, or in the case of the
early boards, cutting the I2C lines and rewiring them.)

IOW, board modification will be required for SFP on most mcbins.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
