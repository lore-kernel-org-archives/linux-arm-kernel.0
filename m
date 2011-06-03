From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 Jun 2011 16:18:09 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110603121702.DB9E82FA@gemini.denx.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601210855.663A3CEFB4E@gemini.denx.de>
	<BANLkTi=HqEBRzyU4_HXnNHTeOPL9vPW8PA@mail.gmail.com>
	<20110602154659.697EFD09481@gemini.denx.de>
	<20110603120258.GR23771@pengutronix.de>
	<20110603121702.DB9E82FA@gemini.denx.de>
Message-ID: <20110603141809.GS23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2011 at 02:17:02PM +0200, Wolfgang Denk wrote:
> Dear Sascha Hauer,
> 
> In message <20110603120258.GR23771@pengutronix.de> you wrote:
> >
> > > I'm not a friend of using magic values that are "totally-impossible".
> > > This is confusing, and here it is not needed.
> > 
> > I find using a field labelled 'entry point' and 'load address' as
> > absolute addresses or offsets into sdram depending on some flag
> > also quite confusing. btw how do you want to decide whether the
> > fields are offsets or absolute addresses? I see no flags field in
> > the uImage format.
> 
> I would define a new image type.  Instead of "-T kernel" we could for
> example use a new type "-T relkernel" to indicate that addresses are
> relative to start of system RAM.
> 
> > > If we could agree to interpret load address and entry point as
> > > offsets, the only remaining problem is to find out if we can use a
> > > common offset.
> > 
> > The zImages encapsulated in uImages are relocatable. So pick any offset
> > between 32k and 128MB into sdram like Russell explained. Higher values
> > are not desirable as this would break boards with less sdram.
> 
> What about the images without the preloader?  You know that U-Boot
> already provides all the needed code to perform the uncompressing, so
> it would be nice if we could avoid to include this into each and every
> image.  Is the raw kernel image, without the preloader, also
> relocatable and can be started at any address (keeping above
> restrictions in mind, of course)?

No, the raw image has to be started at
virt_to_phys(PAGE_OFFSET + TEXT_OFFSET) which is usually 32k into sdram.
Only some subarchs define it differently:

textofs-y := 0x00008000
textofs-$(CONFIG_ARCH_CLPS711X) := 0x00028000
textofs-$(CONFIG_PM_H1940)      := 0x00108000
textofs-$(CONFIG_SA1111) := 0x00208000

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
