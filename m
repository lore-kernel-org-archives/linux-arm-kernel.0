From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 16 Aug 2011 17:13:34 +0200
Subject: [PATCH v2 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
	SSP/SPI) driver
In-Reply-To: <1313504478.79629.YahooMailClassic@web29002.mail.ird.yahoo.com>
References: <1313504478.79629.YahooMailClassic@web29002.mail.ird.yahoo.com>
Message-ID: <201108161713.34778.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 16, 2011 04:21:18 PM Paul Parsons wrote:
> Hi Marek,
> 
> > obj-$(CONFIG_MOUSE_RISCPC)   
> >     +=
> > 
> > > rpcmouse.
> > >
> > >  obj-$(CONFIG_MOUSE_SERIAL)   
> > 
> >     += sermouse.o
> > 
> > > 
> > 
> > obj-$(CONFIG_MOUSE_SYNAPTICS_I2C)    +=
> > synaptics_i2c.o
> > 
> > >  obj-$(CONFIG_MOUSE_VSXXXAA)   
> > 
> >     += vsxxxaa.o
> > 
> > > +obj-$(CONFIG_MOUSE_NAVPOINT_PXA27x)   
> > 
> > += navpoint.o
> > 
> > Keep the list sorted
> 
> OK, will do.
> 
> > > +struct driver_data {
> > > +    struct ssp_device *ssp;
> > > +    int   
> > 
> >     gpio;
> > 
> > > +    struct input_dev *input;
> > > +    int   
> > 
> >     index;
> > 
> > > +    uint8_t   
> > 
> >     data[8];
> > 
> > > +    int   
> > 
> >     pressed;    /* 1 =
> > pressed, 0 = released */
> > 
> > > +    unsigned   
> > 
> > code;        /* Key code of
> > the last key pressed */
> > 
> > > +};
> > 
> > Use tabs for alignment please.
> 
> OK, but in this case using tabs consistently would have meant breaking up
> lines to stay within the 80-column limit; neither solution was elegant.

Just put tabs before variable names ... keep "struct blah" with space ;-)
> 
> > > +/*
> > > + *    MEP Query $22: Touchpad
> > 
> > Coordinate Range Query is not supported by
> > 
> > > + *    the NavPoint module, so sampled
> > 
> > values provide the N/S/E/W limits.
> > 
> > > + */
> > > +
> > > +#define WEST    2416   
> > 
> >     /* 1/3 width */
> > 
> > > +#define EAST    3904   
> > 
> >     /* 2/3 width */
> > 
> > > +#define SOUTH   
> > 
> > 2480        /* 1/3 height */
> > 
> > > +#define NORTH   
> > 
> > 3424        /* 2/3 height */
> > 
> > Can't we calibrate this instead of having this hardcoded ?
> 
> We could if the NavPoint supported MEP Query $22 (Touchpad Coordinate Range
> Query). Unfortunately it doesn't (I tried), presumably because the
> NavPoint uses an older version of MEP (Synaptics Modular Embedded
> Protocol).

Then you can adjust it via module parameters and have these as default values. 
or sysfs ... maybe sysfs would be better
> 
> > Or use sysfs
> > attributes / module params ?
> 
> Or platform data? That's much simpler. Without knowing how this driver will
> be used by other platforms (if at all) I'm wary about over-engineering it.

True ... then likely module params or sysfs to keep it simple. Pdata seems 
stupid.
> 
> > > +    ret = (status & (sssr |
> > 
> > SSSR_RFS)) ? IRQ_HANDLED : IRQ_NONE;
> > 
> > Please avoid ternary ops.
> 
> OK, will do.
> 
> > > +        if
> > 
> > ((drv_data->data[0] & 0x07) < drv_data->index)
> > 
> > Maybe document magic numbers?
> 
> OK, will do.
> 
> > > +MODULE_AUTHOR("Paul Parsons <lost.distance@yahoo.com>");
> > > +MODULE_DESCRIPTION("Synaptics NavPoint (PXA27x
> > 
> > SSP/SPI) driver");
> > 
> > > +MODULE_LICENSE("GPL");
> > 
> > Isn't the original authors credit missing here and/or in
> > the header?
> 
> Original authors? I don't understand; would you please elaborate.

I dunno, well you took it from linux-hh tree, right? So if there was any 
original author, give him a credit ... if that's you, just ignore this. I didn't 
expect there to be still someone from -hh times around and active :-)
> 
> Regards,
> Paul
