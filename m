From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 17 Jan 2011 09:16:22 +0100
Subject: [PATCH v4 05/10] net/fec: add dual fec support for mx28
In-Reply-To: <20110114130849.GA27583@freescale.com>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<1294297998-26930-6-git-send-email-shawn.guo@freescale.com>
	<20110113144805.GS24920@pengutronix.de>
	<20110114054838.GA14491@freescale.com>
	<20110114075223.GC24920@pengutronix.de>
	<20110114130849.GA27583@freescale.com>
Message-ID: <19763.64214.220441.325208@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Fri, Jan 14, 2011 at 08:52:23AM +0100, Uwe Kleine-K?nig wrote:
> > On Fri, Jan 14, 2011 at 01:48:40PM +0800, Shawn Guo wrote:
> > > Hi Uwe,
> > > 
> > > On Thu, Jan 13, 2011 at 03:48:05PM +0100, Uwe Kleine-K?nig wrote:
> > > 
> > > [...]
> > > 
> > > > > +/* Controller is ENET-MAC */
> > > > > +#define FEC_QUIRK_ENET_MAC           (1 << 0)
> > > > does this really qualify to be a quirk?
> > > > 
> > > My understanding is that ENET-MAC is a type of "quirky" FEC
> > > controller.
> > > 
> > > > > +/* Controller needs driver to swap frame */
> > > > > +#define FEC_QUIRK_SWAP_FRAME         (1 << 1)
> > > > IMHO this is a bit misnamed.  FEC_QUIRK_NEEDS_BE_DATA or similar would
> > > > be more accurate.
> > > > 
> > > When your make this change, you may want to pick a better name for
> > > function swap_buffer too.
> > > 
> > > [...]
> > > 
> > > > > +static void *swap_buffer(void *bufaddr, int len)
> > > > > +{
> > > > > +     int i;
> > > > > +     unsigned int *buf = bufaddr;
> > > > > +
> > > > > +     for (i = 0; i < (len + 3) / 4; i++, buf++)
> > > > > +             *buf = cpu_to_be32(*buf);
> > > > if len isn't a multiple of 4 this accesses bytes behind len.  Is this
> > > > generally OK here?  (E.g. because skbs always have a length that is a
> > > > multiple of 4?)
> > > The len may not be a multiple of 4.  But I believe bufaddr is always
> > > a buffer allocated in a length that is a multiple of 4, and the 1~3
> > > bytes exceeding the len very likely has no data that matters.  But
> > > yes, it deserves a safer implementation.
> > Did you test what happens if bufaddr isn't aligned?  Does it work at all
> > then?
> > 
> I see many calls passing a len that is not a multiple of 4, but it
> works good.
> 
That does not prove anything, actually.

Anyway "bufaddr isn't aligned" != "len is not a multiple of 4".
Is there any guarantee that the function cannot be called with a
non-aligned buffer address?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
