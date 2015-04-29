From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Apr 2015 08:35:08 +0200
Subject: [PATCH 2/4] mtd: mxc_nand: limit the size of used oob
In-Reply-To: <20150429061853.GB2258@tarshish>
References: <cover.1430034929.git.baruch@tkos.co.il>
 <4bd5da1f7d57aa32c5682297f7aa0c768e8c6e49.1430034929.git.baruch@tkos.co.il>
 <20150426200725.GC19431@pengutronix.de>
 <20150427043906.GR2258@tarshish>
 <20150427071238.GE19431@pengutronix.de>
 <20150427072057.GT2258@tarshish>
 <20150427075023.GF19431@pengutronix.de>
 <20150427114341.GW2258@tarshish>
 <20150427193127.GU19431@pengutronix.de>
 <20150429061853.GB2258@tarshish>
Message-ID: <20150429063508.GE19431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Baruch,

Cc += Fabio

On Wed, Apr 29, 2015 at 09:18:53AM +0300, Baruch Siach wrote:
> On Mon, Apr 27, 2015 at 09:31:27PM +0200, Uwe Kleine-K?nig wrote:
> > On Mon, Apr 27, 2015 at 02:43:41PM +0300, Baruch Siach wrote:
> > > On Mon, Apr 27, 2015 at 09:50:23AM +0200, Uwe Kleine-K?nig wrote:
> > > > On Mon, Apr 27, 2015 at 10:20:57AM +0300, Baruch Siach wrote:
> > > > > On Mon, Apr 27, 2015 at 09:12:38AM +0200, Uwe Kleine-K?nig wrote:
> > > > > > Hmm I rechecked the reference manual and found a register to specify the
> > > > > > size of the spare area (I didn't notice that one before). Did you try
> > > > > > what happens if you set this to 0x70 for 224 bytes oob?
> > > > > 
> > > > > Which register is that?
> > > > Spare Area Size Register (SPAS) at offset 0x1e10 for the i.MX25 (that's
> > > > what you're using, don't you?).
> > > 
> > > Yes, that's what I'm using.
> > > 
> > > I tried setting the SPAS register to oobsize/2 (0x70 in my case), but I see no 
> > > change in behaviour. Moreover, it turns out the previously Barebox set this 
> > > register (apparently wrongly) to 0x20 for spare size of 64. Current Barebox 
> > > master still do. For v3 Barebox limits CONFIG2_SPAS to 218 bytes spare size 
> > I guess for v21 writing to SPAS is just what the controller assumes
> > after reset. I.e. that a 512-byte nand has 16 bytes spare and a 2k-nand
> > has 64.
> > 
> > > since Eric B?nard's commit 632c45795065 (nand_imx: update to support onfi & 4k 
> > > flashs, 2012-07-05). As you can see, the kernel doesn't touch this register 
> > > for v2 NFC.
> > right.
> > 
> > > I have no idea what is the effect of the SPAS in v2 (or any other) NFC.
> > I didn't try, but I'm surprised it doesn't make a difference. How did
> > you test? I'd do in barebox:
> > 
> > 	memset -w 0xbb000000 0x55 0x1200
> > 	set SPAS to 218/2
> > 	trigger page read
> > 	check how much of the 0x55 was overwritten
> > 	set SPAS to 224/2
> > 	trigger page read
> > 	compare with above
> 
> Just did this test. No matter how I set SPAS, Only first 26 bytes of each 64 
> bytes spare data buffer chunk are overwritten. I tried setting SPAS to 224/2 
> (0x70), 218/2 (0x6d), and 128/2 (0x40).
That's surprising. It would be interesting to hear from Freescale what
is wrong here (Fabio? Maybe contact support?). I quickly skimmed through
the errata documents but didn't found anything. So it's not only that
you need to handle a pristine flash differently on i.MX than on all
other controllers but also that you cannot make full use of the flash's
capacity. *sigh*

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
