From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 2 Aug 2013 12:54:41 +0200
Subject: [PATCH 3/7] pinctrl: imx1 core driver
In-Reply-To: <1375440684.157419108@f61.mail.ru>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
 <1375439907-10462-4-git-send-email-mpa@pengutronix.de>
 <1375440684.157419108@f61.mail.ru>
Message-ID: <20130802105441.GU16871@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 02:51:24PM +0400, Alexander Shiyan wrote:
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> [...]
> > +++ b/drivers/pinctrl/pinctrl-imx1-core.c
> > @@ -0,0 +1,667 @@
> > +/*
> > + * Core driver for the imx pin controller in imx1/21/27
> [...]
> > +static void imx1_write_2bit(struct imx1_pinctrl *ipctl, unsigned int pin_id,
> > +		u32 value, u32 reg_offset)
> > +{
> > +	void __iomem *reg = imx1_mem(ipctl, pin_id) + reg_offset;
> > +	int shift = (pin_id % 16) * 2;
> > +	int mask = ~(0x3 << shift);
> 
> 0x3.
> 
> > +	u32 old_value;
> > +
> > +	dev_dbg(ipctl->dev, "write: register 0x%p shift %d value 0x%x\n",
> > +			reg, shift, value);
> > +
> > +	if (pin_id % 32 >= 16)
> > +		reg += 0x04;
> > +
> > +	value = (value & 0x11) << shift;
> 
> 0x11. Is this correct?

oh no, should be 0x3.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
