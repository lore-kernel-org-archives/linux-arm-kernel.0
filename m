From: liguo.zhang@mediatek.com (liguo zhang)
Date: Wed, 2 Dec 2015 10:51:36 +0800
Subject: [PATCH v2 2/2] i2c: mediatek: fix i2c multi transfer issue in
 high speed mode
In-Reply-To: <CAGS+omAixwqw2QwR5_4VffHN66aAYNXP1ZJPxsq2WKcgzVxOZw@mail.gmail.com>
References: <1447047839-5223-1-git-send-email-liguo.zhang@mediatek.com>
 <1447047839-5223-3-git-send-email-liguo.zhang@mediatek.com>
 <CAGS+omAixwqw2QwR5_4VffHN66aAYNXP1ZJPxsq2WKcgzVxOZw@mail.gmail.com>
Message-ID: <1449024696.7079.6.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-11-14 at 22:38 +0800, Daniel Kurtz wrote:
> On Mon, Nov 9, 2015 at 1:43 PM, Liguo Zhang <liguo.zhang@mediatek.com> wrote:
> > For platform with auto restart support, when doing i2c multi transfer
> > in high speed, for example, doing write-then-read transfer, the master
> > code will occupy the first transfer, and the second transfer will be
> > the read transfer, the write transfer will be discarded. So we should
> > first send the master code, and then start i2c multi transfer.
> >
> > Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> > Reviewed-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  drivers/i2c/busses/i2c-mt65xx.c | 45 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> > index dc4aac6..249df86 100644
> > --- a/drivers/i2c/busses/i2c-mt65xx.c
> > +++ b/drivers/i2c/busses/i2c-mt65xx.c
> > @@ -53,6 +53,8 @@
> >  #define I2C_FS_TIME_INIT_VALUE         0x1303
> >  #define I2C_WRRD_TRANAC_VALUE          0x0002
> >  #define I2C_RD_TRANAC_VALUE            0x0001
> > +#define I2C_TRAN_DEFAULT_VALUE         0x0001
> > +#define I2C_TRANAC_DEFAULT_VALUE       0x0001
> 
> "TRAN" and "TRANAC" are not good names; this should be "TRANSFER_LEN"
> and "TRANSAC", based on the names of the registers to which you write
> these constants.
> 
> Furthermore, these are not "default" values, they are the transfer
> length and number of transactions for sending the "master code", so:
> 
> #define I2C_TRANSFER_LEN_MASTER_CODE         0x0001
> #define I2C_TRANSAC_LEN_MASTER_CODE       0x0001
> 
> Similarly, I think the "TRANAC" in I2C_WRRD_TRANAC_VALUE and
> I2C_RD_TRANAC_VALUE should also be TRANSAC.
> 

Yes, I will follow your advice.

> >
> >  #define I2C_DMA_CON_TX                 0x0000
> >  #define I2C_DMA_CON_RX                 0x0001
> > @@ -365,6 +367,43 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk,
> >         return 0;
> >  }
> >
> > +static int mtk_i2c_send_master_code(struct mtk_i2c *i2c)
> > +{
> > +       int ret = 0;
> > +
> > +       reinit_completion(&i2c->msg_complete);
> > +
> > +       writew(I2C_CONTROL_RS | I2C_CONTROL_ACKERR_DET_EN |
> > +              I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN,
> > +              i2c->base + OFFSET_CONTROL);
> > +
> > +       /* Clear interrupt status */
> > +       writew(I2C_RS_TRANSFER | I2C_TRANSAC_COMP | I2C_HS_NACKERR | I2C_ACKERR,
> > +              i2c->base + OFFSET_INTR_STAT);
> > +
> > +       /* Enable interrupt */
> > +       writew(I2C_RS_TRANSFER | I2C_TRANSAC_COMP, i2c->base +
> > +              OFFSET_INTR_MASK);
> > +
> > +       writew(I2C_TRAN_DEFAULT_VALUE, i2c->base + OFFSET_TRANSFER_LEN);
> > +       writew(I2C_TRANAC_DEFAULT_VALUE, i2c->base + OFFSET_TRANSAC_LEN);
> > +
> > +       writew(I2C_TRANSAC_START | I2C_RS_MUL_CNFG, i2c->base + OFFSET_START);
> > +
> > +       ret = wait_for_completion_timeout(&i2c->msg_complete,
> > +                                         i2c->adap.timeout);
> 
> How does the hardware know that this transaction should be a "master code"?
> Do you have to tell the hardware what value ('00001XXX') to use as the
> master code?

When we set i2c speed > 400K , the hardware will send master code. We
have a register to configure master code?and usually we use the default
value "00001000".

> The Master Code must be sent at <= 400 kHz, not the target clock.  How
> does the hardware know what rate to use?

The i2c speed is defined in dts, and we will set the i2c speed in i2c
register, so HW will know the rate to use.

> When sending the master code, arbitration is supposed to occur, such
> that only one winning master can proceed with the following high speed
> transaction.
> Where do you check that you won this arbitration?

> If this is not implemented, adding a "TODO" would be helpful.
> 
Our i2c driver now only support one master.

> > +
> > +       completion_done(&i2c->msg_complete);
> 
> This completion_done() is only useful if you check the return value.
> You should check it too, since we should only check for timeout if the
> message hasn't completed.
> 
I will delete the completion_done() function.

> > +
> > +       if (ret == 0) {
> > +               dev_dbg(i2c->dev, "send master code timeout.\n");
> > +               mtk_i2c_init_hw(i2c);
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
> >                                int num, int left_num)
> >  {
> > @@ -539,6 +578,12 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
> >                 }
> >         }
> >
> > +       if (i2c->auto_restart && i2c->speed_hz > 400000) {
> 
> Don't we need to send the master code for *every* HS transaction, not
> just "auto_restart"?
> 
When we don't use auto restart, we also need to send the master code,
the master code is sent by HW automatically.
I am improving the master code section when use auto restart, and this
will be released in the next patch.

> "400000" => You already have a macro for this: MAX_FS_MODE_SPEED
> 
Yes, I will use MAX_FS_MODE_SPEED.

> > +               ret = mtk_i2c_send_master_code(i2c);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> >         while (left_num--) {
> >                 if (!msgs->buf) {
> >                         dev_dbg(i2c->dev, "data buffer is NULL.\n");
> > --
> > 1.8.1.1.dirty
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
