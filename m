From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Wed, 15 Apr 2015 11:49:36 +0300
Subject: [PATCH V3 2/6] i2c: qup: Add V2 tags support
In-Reply-To: <552E07B5.5080605@codeaurora.org>
References: <1428736145-18361-1-git-send-email-sricharan@codeaurora.org>
 <1428736145-18361-3-git-send-email-sricharan@codeaurora.org>
 <1429024595.16939.5.camel@mm-sol.com> <552E07B5.5080605@codeaurora.org>
Message-ID: <1429087776.30601.1.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sricharan,

On Wed, 2015-04-15 at 12:09 +0530, Sricharan R wrote:

> > > +/* frequency definitions for high speed and max speed */
> > > +#define I2C_QUP_CLK_FAST_FREQ          1000000
> > 
> > This is fast mode, if I am not mistaken.
> > 
>   ya, up to 1MHZ is fast and up to 3.4MHZ is HS.
>   We use this macro to check if the desired freq is in HS range.
>   The above comment can be changed though to make it clear.

My point was that this is neither high nor max speed.

> > > +
> > >   /* Status, Error flags */
> > >   #define I2C_STATUS_WR_BUFFER_FULL      BIT(0)
> > >   #define I2C_STATUS_BUS_ACTIVE          BIT(8)
> > > @@ -102,6 +119,15 @@
> > >   #define RESET_BIT                      0x0
> > >   #define ONE_BYTE                       0x1
> > > 
> > > +#define QUP_I2C_MX_CONFIG_DURING_RUN   BIT(31)
> > 
> > Could you explain what is this for?
> > 
>    This is a new feature in the V2 version of the controller,
>    to support multiple i2c sub transfers without having
>    a 'stop' bit in-between. Without this the i2c controller
>    inserts a 'stop' on the bus when the WR/RD count registers
>    reaches zero and are configured for the next transfer. So setting
>    this bit when the controller is in 'RUN' state, avoids sending the
>    'stop' during RUN state.
>    I can add this comment in the patch.

And how v2 of this patch was worked if you introduce this bit now?
Bit is also not used by downstream driver, AFICS?

> 
> > > +
> > > +struct qup_i2c_block {
> > > +       int     blocks;

count

> > > +       u8      *block_tag_len;

just tag_len, 

> > > +       int     *block_data_len;

just data_len,

> > > +       int     block_pos;

just pos?

> > > +};
> > > +
> > >   struct qup_i2c_dev {
> > >          struct device*dev;
> > >          void __iomem*base;
> > > @@ -115,9 +141,17 @@ struct qup_i2c_dev {
> > >          int     in_fifo_sz;
> > >          int     out_blk_sz;
> > >          int     in_blk_sz;
> > > -
> > > +       struct  qup_i2c_blockblk;
> > >          unsigned longone_byte_t;
> > > 
> > > +       int     is_hs;
> > > +       bool    use_v2_tags;
> > > +
> > > +       int     tx_tag_len;
> > > +       int     rx_tag_len;
> > > +       u8      *tags;
> > > +       int     tags_pos;
> > > +
> > >          struct i2c_msg*msg;
> > >          /* Current posion in user message buffer */
> > >          int     pos;
> > > @@ -263,10 +297,19 @@ static int qup_i2c_wait_ready(struct qup_i2c_dev *qup, int op, bool val,
> > >          }
> > >   }
> > 
> > Is this better tag related fields grouping?
> > 
> 
> > struct qup_i2c_tag_block {
> > 
> >          u8      tag[2];
> >          // int  tag_len; this is alway 2, or?
> >          int     data_len; // this could be zero, right?
> > };
> > 
> There is a struct for qup_i2c_block which has tag and data len. Not sure
> what change you suggest above ? Also with V2 transfers tag len need
>   not be 2. It can be more than that based on the data len.

The point is that: I will like to see better grouping of
related variables. Now they are spread all over. Would it
be possible to also take care for tx_tag_len, rx_tag_len, 
tags, tags_pos.

> 
> > > -static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> > > +static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg,
> > > +                                                       int run)
> > 
> > And 'run' stands for?
>   'run' just says whether the controller is in 'RUN' or 'RESET' state.
>    I can change it to is_run_st to make it clear.
> > >   {
> > > -       /* Number of entries to shift out, including the start */
> > > -       int total = msg->len + 1;
> > > +       /* Total Number of entries to shift out, including the tags */
> > > +       int total;
> > > +
> > > +       if (qup->use_v2_tags) {
> > > +               total = msg->len + qup->tx_tag_len;
> > > +               if (run)
> > > +                       total |= QUP_I2C_MX_CONFIG_DURING_RUN;
> > 
> > What?
> > 
>       This means, if the controller is in 'RUN' state, for
>       reconfiguring the RD/WR counts this bit has to be set to avoid
>       'stop' bits.

I don't buy it, sorry. Problem with v1 of the tags is that controller
can not read more than 256 bytes without automatically generate STOP
at the end, because transfer length specified with QUP_TAG_REC tag
is 8 bits wide. There is no limitation for writes with v1 tags,
because controller is explicitly instructed when to send out STOP.

For v2 of the tags, writes behaves more or less the same, and the
good news are that there is new read tag QUP_TAG_V2_DATARD, which 
did't generate STOP when specified amount of data is read, still
up to 256 bytes in chunk. Read transfers with size more than 256
could be formed in following way:

V2_START | Slave Address | V2_DATARD | countx | ... | V2_DATARD_STOP | county.

> 
> > > 
> > > -static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> > > +static void qup_i2c_create_tag_v2(struct qup_i2c_dev *qup,
> > > +                                               struct i2c_msg *msg, int last)
> > > +{
> > > +       u16 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) == I2C_M_RD);
> > > +       int len = 0, prev_len = 0;
> > > +       int blocks = 0;
> > > +       int rem;
> > > +       int block_len = 0;
> > > +       int data_len;
> > > +
> > > +       qup->blk.block_pos = 0;
> > > +       qup->pos = 0;
> > > +       qup->blk.blocks = (msg->len + QUP_READ_LIMIT - 1) / QUP_READ_LIMIT;
> > > +       rem = msg->len % QUP_READ_LIMIT;
> > > +
> > > +       /* 2 tag bytes for each block + 2 extra bytes for first block */
> > > +       qup->tags = kzalloc((qup->blk.blocks * 2) + 2, GFP_KERNEL);
> > > +       qup->blk.block_tag_len = kzalloc(qup->blk.blocks, GFP_KERNEL);
> > > +       qup->blk.block_data_len = kzalloc(sizeof(*qup->blk.block_data_len) *
> > > +                                               qup->blk.blocks, GFP_KERNEL);
> > 
> > Whouldn't be easy to kcalloc struct qup_i2c_tag_block?
> > 
> > 
> > Allocations could fail and memory is leaking here.
> > 
>   ya correct, will change this. Freeing is done at the end of xfer
>   function, but will have to check for allocation failure.

Do you see how memory leak here? 

> 
> > > +
> > > +       while (blocks < qup->blk.blocks) {
> > > 
> > > +               blocks++;
> > 
> > Looks like 'for' cycle to me.
> > 
>   sorry, not getting it ?

This 'while' loop is old plain 'for'.

> > > +       }
> > > +
> > > +       qup->tx_tag_len = len;
> > > +
> > > +       if (msg->flags & I2C_M_RD)
> > > +               qup->rx_tag_len = (qup->blk.blocks * 2);

This will need some explanation.


> > > +
> > > +static void qup_i2c_issue_xfer_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> > > +{
> > > +       u32 data_len = 0, tag_len;
> > > +
> > > +       tag_len = qup->blk.block_tag_len[qup->blk.block_pos];
> > > +
> > > +       if (!(msg->flags & I2C_M_RD))
> > > +               data_len = qup->blk.block_data_len[qup->blk.block_pos];
> > > +
> > > +       qup_i2c_send_data(qup, tag_len, qup->tags, data_len, msg->buf);
> > 
> > This assumes that writes are up to 256 bytes, and tags and data blocks
> > are completely written to FIFO buffer, right?
> > 
>   Yes, since we send/read data in blocks (256 bytes).

How deep is the FIFO? Is it guaranteed that "the whole" write 
or read data, including tags will fit in.

> > > 
> > > +
> > > +static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg,
> > > +                                                               int run, int last)
> > >   {
> > >          unsigned long left;
> > >          int ret;
> > > @@ -329,13 +501,20 @@ static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> > >          qup->msg = msg;
> > >          qup->pos = 0;
> > > 
> > > +       if (qup->use_v2_tags)
> > > +               qup_i2c_create_tag_v2(qup, msg, last);
> > > +       else
> > > +               qup->blk.blocks = 0;
> > > +
> > >          enable_irq(qup->irq);
> > > 
> > > -       qup_i2c_set_write_mode(qup, msg);
> > > +       qup_i2c_set_write_mode(qup, msg, run);
> > > 
> > > -       ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
> > > -       if (ret)
> > > -               goto err;
> > > +       if (!run) {
> > > +               ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
> > 
> > To run away, or not?
> > 
>    Means, if the controller is not in RUN state, put it in to 'RUN'
>    state.

And what is the problem if controller is put in PAUSED state, FIFO
filled with data and then RUN again, like in v2 of this patch?

<snip>

> > > 
> > > -static void qup_i2c_read_fifo(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> > > +static void qup_i2c_read_fifo_v1(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> > >   {
> > > -       u32 opflags;
> > >          u32 val = 0;
> > >          int idx;
> > > +       int len = msg->len + qup->rx_tag_len;
> > 
> > Is this intentional?
> > 
>     Yes, since i changed the loop around qup_i2c_read_one to count for
>     blocks. 

No, this doesn't make any sense. v1 tags didn't use rx_tag_len, and 
I don't see how this is related to counting blocks, in this function.

<snip>

> > > 
> > > -       qup_i2c_issue_read(qup, msg);
> > > +               qup_i2c_issue_read(qup, msg);
> > > 
> > > -       ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
> > > -       if (ret)
> > > -               goto err;
> > > +               ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
> > > +               if (ret)
> > > +                       goto err;
> > > 
> > > -       do {
> > >                  left = wait_for_completion_timeout(&qup->xfer, HZ);
> > >                  if (!left) {
> > >                          writel(1, qup->base + QUP_SW_RESET);
> > > @@ -481,7 +726,8 @@ static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> > >                  }
> > > 
> > >                  qup_i2c_read_fifo(qup, msg);
> > > -       } while (qup->pos < msg->len);
> > > +               qup->blk.block_pos++;
> > 
> > This should not be incremented, unless we really have read this block.
> > 
>    We are reading it and only then incrementing it.

But read FIFO function could exit because of timeout, which is
not checked. The same is true for write operations.

Somehow this patch looks overly complex, I don't believe
that it should be.

Ivan.
