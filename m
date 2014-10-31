From: xudong.chen@mediatek.com (xudong chen)
Date: Fri, 31 Oct 2014 14:31:41 +0800
Subject: [PATCH 3/3] I2C: mediatek: Add driver for MediaTek I2C controller
In-Reply-To: <CABuKBe+RXboBEZD7Bu_kSbVwiapJJcAuuw_wo=xw67osJWJ20w@mail.gmail.com>
References: <1414561058-23803-1-git-send-email-xudong.chen@mediatek.com>
 <1414561058-23803-4-git-send-email-xudong.chen@mediatek.com>
 <CABuKBe+RXboBEZD7Bu_kSbVwiapJJcAuuw_wo=xw67osJWJ20w@mail.gmail.com>
Message-ID: <1414737101.32208.18.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-10-30 at 14:16 +0100, Matthias Brugger wrote:
> 2014-10-29 6:37 GMT+01:00 Xudong Chen <xudong.chen@mediatek.com>:
> > The mediatek SoCs have I2C controller that handle I2C transfer.
> > This patch include common I2C bus driver.
> > This driver is compatible with I2C controller on mt65xx/mt81xx.
> >
> > Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
> > Change-Id: Icc17e326b9df46a226d536956e103f17b0382b6e
> > ---
> >  drivers/i2c/busses/Kconfig      |   9 +
> >  drivers/i2c/busses/Makefile     |   1 +
> >  drivers/i2c/busses/i2c-mt65xx.c | 728 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 738 insertions(+)
> >  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
> >
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 917c358..0d7d0a4 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -564,6 +564,15 @@ config I2C_MPC
> >           This driver can also be built as a module.  If so, the module
> >           will be called i2c-mpc.
> >
> > +config I2C_MT65XX
> > +       tristate "MediaTek I2C adapter"
> > +       depends on ARCH_MEDIATEK
> > +       help
> > +         This selects the MediaTek(R) Integrated Inter Circuit bus driver
> > +         for MT65xx and MT81xx.
> > +         If you want to use MediaTek(R) I2C interface, say Y or M here.
> > +         If unsure, say N.
> > +
> >  config I2C_MV64XXX
> >         tristate "Marvell mv64xxx I2C Controller"
> >         depends on MV64X60 || PLAT_ORION || ARCH_SUNXI
> > diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> > index 78d56c5..7a9f0f3 100644
> > --- a/drivers/i2c/busses/Makefile
> > +++ b/drivers/i2c/busses/Makefile
> > @@ -54,6 +54,7 @@ obj-$(CONFIG_I2C_IMX)         += i2c-imx.o
> >  obj-$(CONFIG_I2C_IOP3XX)       += i2c-iop3xx.o
> >  obj-$(CONFIG_I2C_KEMPLD)       += i2c-kempld.o
> >  obj-$(CONFIG_I2C_MPC)          += i2c-mpc.o
> > +obj-$(CONFIG_I2C_MT65XX)       += i2c-mt65xx.o
> > +
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
> 
Hi,

This feature means the chip can use I2C pins from PMIC(mt6397).
In this case,
1. We actually control the register on mt8135 and the DMA/Control Logic
is on mt8135, only use pins from mt6397. If set register OFFSET_PATH_DIR
bit0 to 1, the I2C data will go/from PMIC pins.
2. We also need mt6397 pinctrl and clk manager driver to make it
actually work.

After looking up datasheets, the mt6589 and mt8135 support PMIC I2C, the
other chips mt6577/mt6582/mt6582/mt8127 do not.

Thanks!
    Xudong.chen
