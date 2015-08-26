From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 26 Aug 2015 15:22:46 +0200
Subject: [PATCH] regmap: Fix the null function of format_val on
 regmap_bulk_read.
In-Reply-To: <20150826123556.GB2977@sirena.org.uk>
References: <1440589396-696-1-git-send-email-henryc.chen@mediatek.com>
 <20150826123556.GB2977@sirena.org.uk>
Message-ID: <20150826132246.GR706@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 01:35:56PM +0100, Mark Brown wrote:
> On Wed, Aug 26, 2015 at 07:43:16PM +0800, Henry Chen wrote:
> > The regmap_format will not be initialize if device driver not declare the regmap_bus
> > when registering the regmap. To avoid the null function of format_val when
> > called regmap_bulk_read(). It need to give a format function when regmap init.
> 
> > Call trace:
> > [<          (null)>]           (null)
> > [<ffffffc0004cbdd0>] mtk_rtc_read_time+0x9c/0x134
> > [<ffffffc0004c9618>] __rtc_read_time.isra.3+0x40/0x7c
> > [<ffffffc0004c9688>] rtc_read_time+0x34/0x58
> 
> Please don't paste entire backtraces in, they're enormous and tend to
> obscure the actual content while adding little value.  If needed then
> edited highlights work better.  I'm fairly sure I've mentioned this
> before...
> 
> > @@ -783,8 +783,22 @@ struct regmap *regmap_init(struct device *dev,
> >  		map->defer_caching = true;
> >  		map->reg_write = _regmap_bus_raw_write;
> >  	}
> > +/*
> > + * For bulk read, need to hook the format function.
> > + */
> > +simple_format_initialization:
> 
> The indentation is all messed up here, we're misssing a blank line and
> the comment is not indented.
> 
> > -skip_format_initialization:
> > +	switch (config->val_bits) {
> > +		case 8:
> > +			map->format.format_val = regmap_format_8;
> > +			break;
> > +		case 16:
> > +			map->format.format_val = regmap_format_16_native;
> > +			break;
> > +		case 32:
> > +			map->format.format_val = regmap_format_32_native;
> > +			break;
> > +	}
> 
> Why are these format functions sensible?  Converting a null pointer
> dereference into data corruption wouldn't be ideal.  The commit message
> should really cover this.

The regmap_bulk_read() function worked before the following patch:
	15b8d2c41fe5 (regmap: Fix regmap_bulk_read in BE mode)

As far as I can see this patch fixes this issue by using simple format
functions. Before the above mentioned patch, the code used memcpy. Now
regmap_format_*_native is used which should result in the same behaviour
but fixes the null pointer.

I am not sure if there are other locations in the code where format_val
is used in this setup so I don't know if this would change behavior in a
different codepath.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150826/d7064fcd/attachment.sig>
