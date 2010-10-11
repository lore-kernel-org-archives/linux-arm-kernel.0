From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 Oct 2010 15:10:09 +0200
Subject: [PATCH 3/3] mx51: Move OTG initialisation for all boards to a
	single file
In-Reply-To: <AANLkTimVo8uLHq4zCskBU4C_nWYiw89BxUw2FM_p3qhQ@mail.gmail.com>
References: <cover.1286412080.git.amit.kucheria@linaro.org>
	<2306a14fec6647b68a4aee1743a75d040ec141b1.1286412080.git.amit.kucheria@linaro.org>
	<20101007074853.GZ28242@pengutronix.de>
	<AANLkTimVo8uLHq4zCskBU4C_nWYiw89BxUw2FM_p3qhQ@mail.gmail.com>
Message-ID: <20101011131009.GY28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

On Mon, Oct 11, 2010 at 01:34:30PM +0300, Amit Kucheria wrote:
> On Thu, Oct 7, 2010 at 10:48 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Added Daniel to Cc as he might say something here aswell.
> 
> <snip>
> 
> > I have recently looked at the way the USB phy settings are handled on
> > i.MX and it's coming to its limits. Currently the phy settings are coded
> > into generic flags, passed to the usb driver which then calls
> > mxc_initialize_usb_hw() which dispatches the different SoCs and translates
> > the generic flags back into SoC specific ones. ?While this was doable
> > until now it fails badly on i.MX51 as we see here.
> > The phy settings are totally static to a given board, so we could simply
> > let the board call a mx51_init_usb_phy() which gets a pointer to a
> > struct with all relevant register settings. And we could pass this
> > function SoC specific register settings without having to encode them
> > into generic flags and decode them again later.
> >
> > Sascha
> 
> Sascha,
> 
> Do you think something like this will be better? It looks even more
> scattered to me, the usb configuration information is scattered across
> platform_data and phy_data.

My problem is not that it's scattered around platform_data and phy_data,
but that it's not possible to add proper i.MX51 support without
introducing a initialize_otg_port which wont' be flexible enough for
future boards.

> 
> Or did you want to get rid of platform_data->init too from the driver?

No, I think we can't do this without breaking at least some boards. I
found out that on some boards we have to configure the iomux pins and
the rest of the USB hardware in a short time frame, otherwise we get
ULPI errors.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
