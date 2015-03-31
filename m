From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 31 Mar 2015 19:50:58 +0800
Subject: [PATCH v5 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <1427785715.3500.16.camel@mtksdaap41>
References: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
 <1426917922-61356-3-git-send-email-eddie.huang@mediatek.com>
 <20150323084237.GG9742@pengutronix.de>
 <1427703252.26464.14.camel@mtksdaap41>
 <20150330172309.GB9742@pengutronix.de>
 <1427785715.3500.16.camel@mtksdaap41>
Message-ID: <1427802658.32196.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, 2015-03-31 at 15:08 +0800, Eddie Huang wrote:
> Hi Sascha,
> 
> On Mon, 2015-03-30 at 19:23 +0200, Sascha Hauer wrote:
> > On Mon, Mar 30, 2015 at 04:14:12PM +0800, Eddie Huang wrote:
> > > Hi Sascha,
> > >
> > > >
> > > > [...]
> > > >
> > > > > +       if (i2c->speed_hz > 400000)
> > > > > +               control_reg |= I2C_CONTROL_RS;
> > > > > +       if (i2c->op == I2C_MASTER_WRRD)
> > > > > +               control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
> > > > > +       mtk_i2c_writew(control_reg, i2c, OFFSET_CONTROL);
> > > > > +
> > > > > +       /* set start condition */
> > > > > +       if (i2c->speed_hz <= 100000)
> > > > > +               mtk_i2c_writew(I2C_ST_START_CON, i2c, OFFSET_EXT_CONF);
> > > > > +       else
> > > > > +               mtk_i2c_writew(I2C_FS_START_CON, i2c, OFFSET_EXT_CONF);
> > > > > +
> > > > > +       if (~control_reg & I2C_CONTROL_RS)
> > > > > +               mtk_i2c_writew(I2C_DELAY_LEN, i2c, OFFSET_DELAY_LEN);
> > > >
> > > > speed <= 400000 here to make this more obvious?
> > > There are two cases, not only speed<=400000, but I2C_MASTER_WRRD. I tend
> > > to keep it.
> >
> > Still it looks strange. You only ever write this default value to the
> > register. Putting this register write under an if() seems bogus since
> > the same value will be in the register the next time this code is
> > executed. It looks like you should move this register write to some
> > initialization function.
> OK, move to mtk_i2c_init_hw function
> 
Sorry for my negligence. Write-then-read (I2C_MASTER_WRRD) decides
according to each I2C transfer, so I still need to judge whether set
I2C_CONTROL_RS and DELAY_LEN here. Other control setting can move to
init function.

Eddie
