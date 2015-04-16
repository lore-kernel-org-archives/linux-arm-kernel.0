From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Thu, 16 Apr 2015 11:36:35 +0300
Subject: [PATCH V3 2/6] i2c: qup: Add V2 tags support
In-Reply-To: <552E7962.40606@codeaurora.org>
References: <1428736145-18361-1-git-send-email-sricharan@codeaurora.org>
 <1428736145-18361-3-git-send-email-sricharan@codeaurora.org>
 <1429024595.16939.5.camel@mm-sol.com> <552E07B5.5080605@codeaurora.org>
 <1429087776.30601.1.camel@mm-sol.com> <552E7962.40606@codeaurora.org>
Message-ID: <1429173395.26621.5.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sricharan,

On Wed, 2015-04-15 at 20:14 +0530, Sricharan R wrote:
> 
> > > > > 
> > > > > +#define QUP_I2C_MX_CONFIG_DURING_RUN   BIT(31)
> > > > 
> > > > Could you explain what is this for?
> > > > 
> > >     This is a new feature in the V2 version of the controller,
> > >     to support multiple i2c sub transfers without having
> > >     a 'stop' bit in-between. Without this the i2c controller
> > >     inserts a 'stop' on the bus when the WR/RD count registers
> > >     reaches zero and are configured for the next transfer. So setting
> > >     this bit when the controller is in 'RUN' state, avoids sending the
> > >     'stop' during RUN state.
> > >     I can add this comment in the patch.
> > 
> > And how v2 of this patch was worked if you introduce this bit now?
> > Bit is also not used by downstream driver, AFICS?
> > 
> The one of the reason for this and the bam support patches in
> this series was to support multiple transfers of i2c_msgs without
>   a 'stop' inbetween them. So without that the driver sends a 'stop'
> between each sub-transfer. 

Are you saying that there is bug in the hardware? Please, could you
point me to codeaurora driver, which is using this bit? 



-static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> > > > > +static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg,
> > > > > +                                                       int run)
> > > > 
> > > > And 'run' stands for?
> > >    'run' just says whether the controller is in 'RUN' or 'RESET' state.
> > >     I can change it to is_run_st to make it clear.
> > > > >    {
> > > > > -       /* Number of entries to shift out, including the start */
> > > > > -       int total = msg->len + 1;
> > > > > +       /* Total Number of entries to shift out, including the tags */
> > > > > +       int total;
> > > > > +
> > > > > +       if (qup->use_v2_tags) {
> > > > > +               total = msg->len + qup->tx_tag_len;
> > > > > +               if (run)
> > > > > +                       total |= QUP_I2C_MX_CONFIG_DURING_RUN;
> > > > 
> > > > What?
> > > > 
> > >        This means, if the controller is in 'RUN' state, for
> > >        reconfiguring the RD/WR counts this bit has to be set to avoid
> > >        'stop' bits.
> > 
> > I don't buy it, sorry. Problem with v1 of the tags is that controller
> > can not read more than 256 bytes without automatically generate STOP
> > at the end, because transfer length specified with QUP_TAG_REC tag
> > is 8 bits wide. There is no limitation for writes with v1 tags,
> > because controller is explicitly instructed when to send out STOP.
> > 
> correct till this.
> 
> > For v2 of the tags, writes behaves more or less the same, and the
> > good news are that there is new read tag QUP_TAG_V2_DATARD, which
> > did't generate STOP when specified amount of data is read, still
> > up to 256 bytes in chunk. Read transfers with size more than 256
> > could be formed in following way:
> > 
> > V2_START | Slave Address | V2_DATARD | countx | ... | V2_DATARD_STOP | county.
> > 
>   The above is true for a single subtransfer for reading/writing
> more than > 256 bytes. But for doing WRITE, READ kind of sub
>   transfers once the first sub transfer (write) is over, and
>   while re-configuring the _COUNT registers for the next transfers,
> 'a stop' between is inserted.

>From controller itself or driver?

> > > > > +static void qup_i2c_issue_xfer_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> > > > > +{
> > > > > +       u32 data_len = 0, tag_len;
> > > > > +
> > > > > +       tag_len = qup->blk.block_tag_len[qup->blk.block_pos];
> > > > > +
> > > > > +       if (!(msg->flags & I2C_M_RD))
> > > > > +               data_len = qup->blk.block_data_len[qup->blk.block_pos];
> > > > > +
> > > > > +       qup_i2c_send_data(qup, tag_len, qup->tags, data_len, msg->buf);
> > > > 
> > > > This assumes that writes are up to 256 bytes, and tags and data blocks
> > > > are completely written to FIFO buffer, right?
> > > > 
> > >    Yes, since we send/read data in blocks (256 bytes).
> > 
> > How deep is the FIFO? Is it guaranteed that "the whole" write
> > or read data, including tags will fit in.
> > 
>   Write/read fifo functions (also for V1) currently wait for the
>    fifo full and empty flags conditions.

I will say that this is true for v1, but not for v2, 
because the way of how FIFO is filled in v2.

> > > > > +static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg,
> > > > > +                                                               int run, int last)
> > > > >    {
> > > > >           unsigned long left;
> > > > >           int ret;
> > > > > @@ -329,13 +501,20 @@ static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct 
> > > > > i2c_msg *msg)
> > > > >           qup->msg = msg;
> > > > >           qup->pos = 0;
> > > > > 
> > > > > +       if (qup->use_v2_tags)
> > > > > +               qup_i2c_create_tag_v2(qup, msg, last);
> > > > > +       else
> > > > > +               qup->blk.blocks = 0;
> > > > > +
> > > > >           enable_irq(qup->irq);
> > > > > 
> > > > > -       qup_i2c_set_write_mode(qup, msg);
> > > > > +       qup_i2c_set_write_mode(qup, msg, run);
> > > > > 
> > > > > -       ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
> > > > > -       if (ret)
> > > > > -               goto err;
> > > > > +       if (!run) {
> > > > > +               ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
> > > > 
> > > > To run away, or not?
> > > > 
> > >     Means, if the controller is not in RUN state, put it in to 'RUN'
> > >     state.
> > 
> > And what is the problem if controller is put in PAUSED state, FIFO
> > filled with data and then RUN again, like in v2 of this patch?
> > 
>   This function is not entered with controller in PAUSED state
>   Only in Reset state (for the first transfer) and Run state for
>   the subsequent sub-transfers. The reason for having this 'run'
>   variable was that while using the lock-unlock feature, the
>   controller should not be put in to run-reset-run state
>   in-between transfers.

Lets see how it will look, when new qup_i2c_write_one_v2 is introduced :-)

Ivan
