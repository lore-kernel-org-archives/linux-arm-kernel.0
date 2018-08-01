From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 1 Aug 2018 07:31:25 +0200
Subject: [PATCH v8 4/4] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <CABb+yY2PN=LN3bgTTzL9SpA43atughAbS1OjNsg0XZg42JxD3w@mail.gmail.com>
References: <20180731141146.10788-1-o.rempel@pengutronix.de>
 <20180731141146.10788-5-o.rempel@pengutronix.de>
 <CABb+yY2PN=LN3bgTTzL9SpA43atughAbS1OjNsg0XZg42JxD3w@mail.gmail.com>
Message-ID: <20180801053125.gmdgojgejyremaul@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 09:51:37PM +0530, Jassi Brar wrote:
> Hi Oleksij,
> 
>  A fast and fine turnaround! Mostly nits and a suggestion follows ...
> 
> On Tue, Jul 31, 2018 at 7:41 PM, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > The Mailbox controller is able to send messages (up to 4 32 bit words)
> > between the endpoints.
> >
> > This driver was tested using the mailbox-test driver sending messages
> > between the Cortex-A7 and the Cortex-M4.
> >
> Do we need something MU specific here?
> I mean MU doesn't really care if the endpoints are CA, CR or CM. So,
> maybe just the two-line ritual intro to MU?

Till now, every additional word about MU added more disagreement in this
topic. I prefer the reduced variant.

> 
> > +enum imx_mu_chan_type {
> > +       IMX_MU_TYPE_TX,         /* Tx with FIFO */
> > +       IMX_MU_TYPE_RX,         /* Rx with FIFO */
> >
> nit: its a register, not fifo

ok

> 
> > +
> > +static void imx_mu_txdb_work(struct work_struct *work)
> > +{
> > +       struct imx_mu_con_priv *cp =
> > +                       container_of(work, struct imx_mu_con_priv, work);
> > +       mbox_chan_txdone(cp->chan, 0);
> > +}
> >
> The api assumes a controller have same type of channels. So we are
> having to do this here.
> I am not sure, but would declaring two mailbox controllers (one with
> doorbells and the other data channels) work?

I was thinking about it and decided that this pain was not worth it.

> If not, at least we could use a tasklet instead of a work queue?

ok. probably it is better to fix the mailbox framework.... may be not right
now.

> 
> > +static bool imx_mu_last_tx_done(struct mbox_chan *chan)
> > +{
> > +       struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> > +       struct imx_mu_con_priv *cp = chan->con_priv;
> > +
> > +       /* test if transmit register is empty */
> > +       return imx_mu_read(priv, IMX_MU_xSR) & IMX_MU_xSR_TEn(cp->idx);
> > +}
> > +
> > +static int imx_mu_send_data(struct mbox_chan *chan, void *data)
> > +{
> > +       struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> > +       struct imx_mu_con_priv *cp = chan->con_priv;
> > +       u32 *arg = data;
> > +
> > +       switch (cp->type) {
> > +       case IMX_MU_TYPE_TX:
> > +               if (!imx_mu_last_tx_done(chan))
> > +                       return -EBUSY;
> >
> This test should be moved to imx_mu_startup().
> The api won't ever call if last tx was not done, and so it doesn't
> know how to recover from send_data() failure.

ok.

> 
> > +
> > +static int imx_mu_startup(struct mbox_chan *chan)
> > +{
> > +       struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> > +       struct imx_mu_con_priv *cp = chan->con_priv;
> > +       int ret;
> > +
> > +       if (cp->type == IMX_MU_TYPE_TXDB) {
> > +               /* Tx doorbell don't have ACK support */
> > +               INIT_WORK(&cp->work, imx_mu_txdb_work);
> > +               return 0;
> > +       }
> > +
> > +       cp->irq_desc = kasprintf(GFP_KERNEL, "imx_mu_chan[%i-%i]", cp->type,
> > +                                cp->idx);
> > +       if (!cp->irq_desc)
> > +               return -ENOMEM;
> >
> Probably you won't do but still .... name of irq is but one channel
> property. So you could set it in probe() and avoid creating another
> situation when startup could fail.

You mean, fail on probe with no mem is better then fail on startup? Why?

> 
> > +       ret = request_irq(priv->irq, imx_mu_isr, IRQF_SHARED, cp->irq_desc,
> > +                         chan);
> > +       if (ret) {
> > +               dev_err(priv->dev,
> > +                       "Unable to acquire IRQ %d\n", priv->irq);
> > +               return ret;
> > +       }
> > +
> > +       switch (cp->type) {
> > +               break;
> >
> Is this intentional?

no. thx.

> 
> > +
> > +static void imx_mu_shutdown(struct mbox_chan *chan)
> > +{
> > +       struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> > +       struct imx_mu_con_priv *cp = chan->con_priv;
> > +
> > +       if (IMX_MU_TYPE_TXDB == cp->type)
> >
> nit: usually we do (cp->type == IMX_MU_TYPE_TXDB)

why? I do it with simple reason:
this error will be detected by compiler
if (IMX_MU_TYPE_TXDB = cp->type)

this error will silently fail
if (cp->type = IMX_MU_TYPE_TXDB)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180801/3154343e/attachment.sig>
