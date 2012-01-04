From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 4 Jan 2012 16:21:33 +0000 (GMT)
Subject: [PATCH v5 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
In-Reply-To: <4F014E2C.4000402@ti.com>
Message-ID: <1325694093.98137.YahooMailClassic@web29006.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shubhrajyoti,

--- On Mon, 2/1/12, Shubhrajyoti <shubhrajyoti@ti.com> wrote:

> > +    int   
>        
> pressed;    /* 1 = pressed, 0 = released */
> Could this be bool ?

OK.

> > +config MOUSE_NAVPOINT_PXA27x
> > +??? tristate "Synaptics NavPoint
> (PXA27x SSP/SPI)"
> > +??? depends on PXA27x &&
> PXA_SSP
> > +??? help
> > +??? ? This option enables support
> for the Synaptics NavPoint connected to
> > +??? ? a PXA27x SSP port in SPI
> slave mode. The driver implements a simple
> > +??? ? navigation pad. The four
> raised dots are mapped to UP/DOWN/LEFT/RIGHT
> > +??? ? buttons and the centre of
> the touchpad is mapped to the ENTER button.
> Maybe some help on module building as tristate.

OK.

> > +??? ret = request_irq(ssp->irq,
> navpoint_int, 0, pdev->name, &pdev->dev);
> Could this be a threadded irq?

The reading of the SSDR could not, because that is needed to clear the
interrupt.
The initial processing of navpoint_packet() could, but would require a new FIFO between the hard irq and threaded irq handlers to buffer the 16-bit data from the SSDR. Since most of the data is ultimately discarded I can avoid the FIFO by keeping this initial processing in the hard irq handler.
The final processing of navpoint_packet(), the calls to input_report_key() and input_sync(), could and should. I presume this was your main concern.

> navpoint_resume(&pdev->dev);
> Could this be pushed to open instead?

It could. In practice the navpoint device would only be opened by the X server, and thus would remain open for the duration of the system anyway.
But I'm happy to add a new open function.
