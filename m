From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Nov 2009 14:19:42 +0100
Subject: [alsa-devel] [PATCH V2] Add i.MX sound support
In-Reply-To: <eedb5540911300513j3730078v1393b9b42dca497b@mail.gmail.com>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<eedb5540911260753u369d6cffp97c05089cdd30868@mail.gmail.com>
	<20091127075834.GG27548@pengutronix.de>
	<eedb5540911270101o4bf06b2ct6ff22e29b7c1fe15@mail.gmail.com>
	<20091127095416.GK27548@pengutronix.de>
	<eedb5540911300243t20ecf407o317b414720cf962e@mail.gmail.com>
	<20091130124305.GQ27548@pengutronix.de>
	<eedb5540911300513j3730078v1393b9b42dca497b@mail.gmail.com>
Message-ID: <20091130131942.GR27548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2009 at 02:13:47PM +0100, javier Martin wrote:
> 2009/11/30 Sascha Hauer <s.hauer@pengutronix.de>
> 
> > On Mon, Nov 30, 2009 at 11:43:23AM +0100, javier Martin wrote:
> > > Hi Sascha,
> > > have you tested capture direction on an i.MX27 based board?
> > >
> > > I have been testing your patches in the place you suggested and playback
> > > seems to work fine but I have several problems with capture stream. I
> > found
> > > a BUG in the audmux_v1 code
> > > and I have fixed it but I am still having problems with capture. The file
> > > keeps empty and nothing is recorded.
> >
> > Capture works fine on my boards.
> >
> >
> >
> > > Please could you try the following on an i.MX27 based board?
> > >
> > > arecord -t raw -c 1 -f S16_LE test.wav
> >
> > Does it work with two channels? Do you use DMA or FIQ? Could you try the
> > other variant?
> >
> 
>  Unfortunately, I can't test it using two channels because our board has a
> wm8974 mono codec. Please could you point me how can I change between FIQ
> and DMA? I thought FIQ was only for AC97,

It's around line 662:


	if ((cpu_is_mx27() || cpu_is_mx21()) &&
			!(ssi->flags & IMX_SSI_USE_AC97)) {
		ssi->flags |= IMX_SSI_DMA;
		platform = imx_ssi_dma_mx2_init(pdev, ssi);
	} else
		platform = imx_ssi_fiq_init(pdev, ssi);

Just make sure IMX_SSI_DMA is cleared and imx_ssi_fiq_init() is called.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
