From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 9 Jan 2013 05:16:19 +0000
Subject: [RFC v2 02/18] mailbox: Add an API for flushing the FIFO
In-Reply-To: <50EC25A3.6070906@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-3-git-send-email-vaibhav.bedia@ti.com>
 <50EC25A3.6070906@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDCFC5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 19:26:51, Shilimkar, Santosh wrote:
> On Monday 31 December 2012 06:36 PM, Vaibhav Bedia wrote:
> > On AM33XX, the mailbox module between the MPU and the
> > WKUP-M3 co-processor facilitates a one-way communication.
> > MPU uses the assigned mailbox sub-module to issue the
> > interrupt to the WKUP-M3 co-processor which then goes
> > and reads the the IPC data from registers in the control
> > module.
> >
> > WKUP-M3 is in the L4_WKUP and does not have any access to
> > the mailbox module. Due to this limitation, the MPU is
> > completely responsible for FIFO maintenance and interrupt
> > generation. MPU needs to ensure that the FIFO does not
> > overflow by reading back the assigned mailbox sub-module.
> >
> > This patch adds an API in the mailbox code which the MPU
> > can use to empty the FIFO by issuing a readback command.
> >
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> > Note: This patch which will be slightly reworked once the mailbox
> > driver changes are finalized.
> >
> Can you expand a bit please ?

There could be some changes in the structure names.

> 
> >   drivers/mailbox/mailbox-omap2.c |   19 +++++++++++++++++++
> >   drivers/mailbox/mailbox.c       |   36 ++++++++++++++++++++++++++++++++++++
> >   drivers/mailbox/mailbox.h       |    3 +++
> >   include/linux/mailbox.h         |    1 +
> >   4 files changed, 59 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mailbox/mailbox-omap2.c b/drivers/mailbox/mailbox-omap2.c
> > index 6d61159..c732be1 100644
> > --- a/drivers/mailbox/mailbox-omap2.c
> > +++ b/drivers/mailbox/mailbox-omap2.c
> > @@ -125,6 +125,23 @@ static int omap2_mbox_fifo_full(struct mailbox *mbox)
> >   	return mbox_read_reg(fifo->fifo_stat);
> >   }
> >
> > +static int omap2_mbox_fifo_needs_flush(struct mailbox *mbox)
> > +{
> > +	struct omap_mbox2_priv *p = mbox->priv;
> > +	struct omap_mbox2_fifo *fifo = &p->tx_fifo;
> > +
> > +	return mbox_read_reg(fifo->msg_stat);
> > +}
> > +
> > +static void omap2_mbox_fifo_readback(struct mailbox *mbox,
> > +			struct mailbox_msg *msg)
> > +{
> > +	struct omap_mbox2_priv *p = mbox->priv;
> > +	struct omap_mbox2_fifo *fifo = &p->tx_fifo;
> > +
> > +	msg->header = mbox_read_reg(fifo->msg);
> > +}
> > +
> >   static int ompa2_mbox_poll_for_space(struct mailbox *mbox)
> >   {
> >   	if (omap2_mbox_fifo_full(mbox))
> > @@ -221,6 +238,8 @@ static struct mailbox_ops omap2_mbox_ops = {
> >   	.read           = omap2_mbox_fifo_read,
> >   	.write          = omap2_mbox_fifo_write,
> >   	.empty          = omap2_mbox_fifo_empty,
> > +	.fifo_needs_flush	= omap2_mbox_fifo_needs_flush,
> > +	.fifo_readback		= omap2_mbox_fifo_readback,
> >   	.poll_for_space = ompa2_mbox_poll_for_space,
> >   	.enable_irq     = omap2_mbox_enable_irq,
> >   	.disable_irq    = omap2_mbox_disable_irq,
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index 2f50226..92c9f68 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -57,6 +57,15 @@ static inline int mbox_empty(struct mailbox *mbox)
> >   {
> >   	return mbox->ops->empty(mbox);
> >   }
> > +static inline int mbox_fifo_needs_flush(struct mailbox *mbox)
> > +{
> > +	return mbox->ops->fifo_needs_flush(mbox);
> > +}
> > +static inline void mbox_fifo_readback(struct mailbox *mbox,
> > +				struct mailbox_msg *msg)
> > +{
> > +	mbox->ops->fifo_readback(mbox, msg);
> > +}
> >
> >   /* Mailbox IRQ handle functions */
> >   static inline void ack_mbox_irq(struct mailbox *mbox, mailbox_irq_t irq)
> > @@ -110,6 +119,33 @@ out:
> >   }
> >   EXPORT_SYMBOL(mailbox_msg_send);
> >
> > +/*
> s/*/**

Will do.

> > + * Flush the Rx FIFO by reading back the messages
> > + * Since the normal expectation is that the Rx will do the
> > + * reading, add a debug message to indicate if we really flush
> > + *
> > + * Returns the no. of messages read back
> > + */
> Just look at the kernel doc style for above
> 
> Rest looks fine.
> 

Ok.

Thanks,
Vaibhav 
