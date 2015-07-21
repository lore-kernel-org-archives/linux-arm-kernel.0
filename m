From: sricharan@codeaurora.org (Sricharan)
Date: Tue, 21 Jul 2015 12:41:37 +0530
Subject: [PATCH V4 3/7] i2c: qup: Add V2 tags support
In-Reply-To: <1437385443.6267.5.camel@mm-sol.com>
References: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>	
 <1436412350-19519-4-git-send-email-sricharan@codeaurora.org>
 <1437385443.6267.5.camel@mm-sol.com>
Message-ID: <000301d0c384$7fe8d890$7fba89b0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivan,

> -----Original Message-----
> From: Ivan T. Ivanov [mailto:iivanov at mm-sol.com]
> Sent: Monday, July 20, 2015 3:14 PM
> To: Sricharan R
> Cc: devicetree at vger.kernel.org; linux-arm-msm at vger.kernel.org;
> galak at codeaurora.org; linux-kernel at vger.kernel.org; linux-
> i2c at vger.kernel.org; agross at codeaurora.org; dmaengine at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V4 3/7] i2c: qup: Add V2 tags support
> 
> 
> Hi Sricharan,
> 
> On Thu, 2015-07-09 at 08:55 +0530, Sricharan R wrote:
> > QUP from version 2.1.1 onwards, supports a new format of i2c command
> > tags. Tag codes instructs the controller to perform a operation like
> > read/write. This new tagging version supports bam dma and transfers of
> > more than 256 bytes without 'stop'
> > in between. Adding the support for the same.
> 
> IIRC, more than 256 bytes in message is supported only in BAM(DMA) mode,
> if this is true, please be more explicit in commit message.

   More than 256 byte read transfers are possible in V2 mode and not possible only
   in V1 mode.  So qup_i2c_quirks should be populated only for V1 mode and V2 mode
   during probe.

> 
> You haven't tried to read more than 256 bytes with this patch, right? See
> qup_i2c_quirks ;-)
     Ya I have tested for 256 bytes transfer in my previous series, not on
     this one. My bad. Should have error'ed out with qup_i2c_quirks in place.
     Anyways will not populate qup_i2c_quirks for v2 mode.

> 
> >
> >
> >  struct qup_i2c_dev {
> >         struct device*dev;
> >         void __iomem*base;
> > @@ -117,6 +138,7 @@ struct qup_i2c_dev {
> >         int     in_blk_sz;
> >
> >         unsigned longone_byte_t;
> > +       struct qup_i2c_blockblk;
> >
> >         struct i2c_msg*msg;
> >         /* Current posion in user message buffer */ @@ -126,6 +148,14
> > @@ struct qup_i2c_dev {
> >         /* QUP core errors */
> >         u32     qup_err;
> >
> > +       int     use_v2_tags;
> > +
> > +       int (*qup_i2c_write_one)(struct qup_i2c_dev *qup,
> > +                                       struct i2c_msg *msg);
> > +
> > +       int (*qup_i2c_read_one)(struct qup_i2c_dev *qup,
> > +                               struct i2c_msg *msg);
> > +
> 
> Do we really need additional level of indirection?
> 
> We have separate struct i2c_algorithm, then we have common
> qup_i2c_read/write methods and then we have different read/write sub
> functions. I don't think 3-4 lines code reuse deserve increased complexity.

   Infact I was thinking this way as well. But anyways wanted to get reviewed
   and see which was better. Will change this.

> 
> <snip>
> 
> > +static void qup_i2c_get_blk_data(struct qup_i2c_dev *qup,
> > +                                       struct i2c_msg *msg) {
> 
> This is more like "set_blk_metadata". Second argument could fit line above.
> 
 Ok. Will change name and indentation.

> > +       memset(&qup->blk, 0, sizeof(qup->blk));
> > +
> > +       if (!qup->use_v2_tags) {
> > +               if (!(msg->flags & I2C_M_RD))
> > +                       qup->blk.tx_tag_len = 1;
> > +               return;
> > +       }
> > +
> > +       qup->blk.data_len = msg->len;
> > +       qup->blk.count = (msg->len + QUP_READ_LIMIT - 1) /
> > + QUP_READ_LIMIT;
> > +
> > +       /* 4 bytes for first block and 2 writes for rest */
> > +       qup->blk.tx_tag_len = 4 + (qup->blk.count - 1) * 2;
> > +
> > +       /* There are 2 tag bytes that are read in to fifo for every block */
> > +       if (msg->flags & I2C_M_RD)
> > +               qup->blk.rx_tag_len = qup->blk.count * 2; }
> > +
> 
> <snip>
> 
> > +static int qup_i2c_get_tags(u8 *tags, struct qup_i2c_dev *qup,
> > +                                                       struct i2c_msg
> > +*msg) {
> 
> This is more like "set_tags".

 Ok, will change.
> 
> > +       u16 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) ==
> I2C_M_RD);
> > +       int len = 0;
> > +       int data_len;
> > +
> > +       if (qup->blk.pos == 0) {
> > +               tags[len++] = QUP_TAG_V2_START;
> > +               tags[len++] = addr & 0xff;
> > +
> > +               if (msg->flags & I2C_M_TEN)
> > +                       tags[len++] = addr >> 8;
> > +       }
> > +
> > +       /* Send _STOP commands for the last block */
> > +       if (qup->blk.pos == (qup->blk.count - 1)) {
> > +               if (msg->flags & I2C_M_RD)
> > +                       tags[len++] = QUP_TAG_V2_DATARD_STOP;
> > +               else
> > +                       tags[len++] = QUP_TAG_V2_DATAWR_STOP;
> > +       } else {
> > +               if (msg->flags & I2C_M_RD)
> > +                       tags[len++] = QUP_TAG_V2_DATARD;
> > +               else
> > +                       tags[len++] = QUP_TAG_V2_DATAWR;
> > +       }
> > +
> > +       data_len = qup_i2c_get_data_len(qup);
> > +
> > +       /* 0 implies 256 bytes */
> > +       if (data_len == QUP_READ_LIMIT)
> > +               tags[len++] = 0;
> > +       else
> > +               tags[len++] = data_len;
> > +
> > +       return len;
> > +}
> > +

Regards,
  Sricharan
