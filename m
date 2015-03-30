From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Mar 2015 19:23:09 +0200
Subject: [PATCH v5 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <1427703252.26464.14.camel@mtksdaap41>
References: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
 <1426917922-61356-3-git-send-email-eddie.huang@mediatek.com>
 <20150323084237.GG9742@pengutronix.de>
 <1427703252.26464.14.camel@mtksdaap41>
Message-ID: <20150330172309.GB9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 04:14:12PM +0800, Eddie Huang wrote:
> Hi Sascha,
> 
> > 
> > [...]
> > 
> > > +	if (i2c->speed_hz > 400000)
> > > +		control_reg |= I2C_CONTROL_RS;
> > > +	if (i2c->op == I2C_MASTER_WRRD)
> > > +		control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
> > > +	mtk_i2c_writew(control_reg, i2c, OFFSET_CONTROL);
> > > +
> > > +	/* set start condition */
> > > +	if (i2c->speed_hz <= 100000)
> > > +		mtk_i2c_writew(I2C_ST_START_CON, i2c, OFFSET_EXT_CONF);
> > > +	else
> > > +		mtk_i2c_writew(I2C_FS_START_CON, i2c, OFFSET_EXT_CONF);
> > > +
> > > +	if (~control_reg & I2C_CONTROL_RS)
> > > +		mtk_i2c_writew(I2C_DELAY_LEN, i2c, OFFSET_DELAY_LEN);
> > 
> > speed <= 400000 here to make this more obvious?
> There are two cases, not only speed<=400000, but I2C_MASTER_WRRD. I tend
> to keep it.

Still it looks strange. You only ever write this default value to the
register. Putting this register write under an if() seems bogus since
the same value will be in the register the next time this code is
executed. It looks like you should move this register write to some
initialization function.

> > > +
> > > +	/* Enable interrupt */
> > > +	mtk_i2c_writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
> > > +		i2c, OFFSET_INTR_MASK);
> > 
> > Why do you enable/disable interrupts for each transfer? Enabling them
> > once and just acknowledge them in the interrupt handler should be
> > enough.
> This can avoid unwanted I2C interrupt. For example, I2C transfer error,
> and cause timeout, I2C driver report error to caller. Then I2C error
> interrupt happen.

So isn't the same unwanted interrupt then just delayed until you enable
the interrupts again? Is this something that really happens or just
something you think that might happen?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
