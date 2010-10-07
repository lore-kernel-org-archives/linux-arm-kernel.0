From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 Oct 2010 14:22:30 +0200
Subject: [PATCH 3/3] mx51: Move OTG initialisation for all boards to a
	single file
In-Reply-To: <20101007120459.GJ2457@matterhorn.lan>
References: <cover.1286412080.git.amit.kucheria@linaro.org>
	<2306a14fec6647b68a4aee1743a75d040ec141b1.1286412080.git.amit.kucheria@linaro.org>
	<20101007070839.GO29673@pengutronix.de>
	<20101007120459.GJ2457@matterhorn.lan>
Message-ID: <20101007122230.GS29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

On Thu, Oct 07, 2010 at 03:04:59PM +0300, Amit Kucheria wrote:
> On 10 Oct 07, Uwe Kleine-K?nig wrote:
> > On Thu, Oct 07, 2010 at 03:58:48AM +0300, Amit Kucheria wrote:
> > > +	/* Set the PHY clock to 24 MHz */
> > > +	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
> > > +	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
> > I wonder why a field in a register called MXC_USB_PHY_CTR_FUNC2 is named
> > MX5_USB_UTMI_PHYCTRL1_PLLDIV.  Usually the register name is a prefix for
> > the field name?!
> 
> I have a patch renaming the various bit-fields and registers to conform to
> the reference manual. I'll post it soon.
great

> > > +	v |= MX51_USB_PLL_DIV_24_MHZ;
> > hmm, babbage used
> 
> > 	> -     v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
> > 	> -     v |= MX51_USB_PLL_DIV_19_2_MHZ;
> > 
> > ?
> 
> Good catch :)
> 
> But if you look at the reference manual, table 60-6, 19.2 MHz would use a
> value of 0x0, but the actual code uses a value of 0x1 that corresponds to
> 24MHz. 19.2MHz (0x0) doesn't even work for me.
Then maybe note it in the commit log?!

> > Maybe you want to reorder your patches such that your patch 2 comes
> > after this one, as currently this patch removes ~80% of the code patch 2
> > introduces.
> 
> I did it to make bisection easier. I didn't want to add a new board feature
> and do consolidation in a single patch.
Yep, that is ok.  Currently you have:

	1/3: add board support for iforgotthename
	2/3: add usb support for iforgotthename
	3/3: consolidate usb support

I suggested to do 1, 3, 2 instead.  Thinking again 3, 1+2 might even be
better.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
