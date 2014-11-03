From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 3 Nov 2014 09:11:05 +0100
Subject: [PATCH 3/3] I2C: mediatek: Add driver for MediaTek I2C controller
In-Reply-To: <CABuKBe+RXboBEZD7Bu_kSbVwiapJJcAuuw_wo=xw67osJWJ20w@mail.gmail.com>
References: <1414561058-23803-1-git-send-email-xudong.chen@mediatek.com>
 <1414561058-23803-4-git-send-email-xudong.chen@mediatek.com>
 <CABuKBe+RXboBEZD7Bu_kSbVwiapJJcAuuw_wo=xw67osJWJ20w@mail.gmail.com>
Message-ID: <20141103081105.GD14482@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 02:16:04PM +0100, Matthias Brugger wrote:
> 2014-10-29 6:37 GMT+01:00 Xudong Chen <xudong.chen@mediatek.com>:
> > +static int mt_i2c_do_transfer(struct mt_i2c *i2c)
> > +{
> > +       u16 addr_reg;
> > +       u16 control_reg;
> > +       int tmo = i2c->adap.timeout;
> > +
> > +       i2c->trans_stop = false;
> > +       i2c->irq_stat = 0;
> > +
> > +       /* If use i2c pin from PMIC mt6397 side, need set PATH_DIR first */
> > +       if (i2c->have_pmic)
> > +               i2c_writew(I2C_CONTROL_WRAPPER, i2c, OFFSET_PATH_DIR);
> 
> So this is some sort of multiplexer bit, right?
> I think in this case we need to build a multi function device (mfd)
> where the pmic driver will set this bit.

This bit is in the i2c controller register space, so it shouldn't be
controlled by some other driver. I think the configuration of this
register is already in the correct place. What I could think of is that
the PMIC could implement a pinctrl driver and the i2c controller driver
gets the pins from the PMIC. Anyway, the controlling of this bit would
still be in the i2c driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
