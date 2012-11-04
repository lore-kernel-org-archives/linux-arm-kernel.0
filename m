From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sun, 4 Nov 2012 15:26:02 +0000
Subject: [PATCH 01/15] ARM: OMAP2+: mailbox: Add an API for flushing the
 FIFO
In-Reply-To: <50954063.5010901@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-2-git-send-email-vaibhav.bedia@ti.com>
 <50954063.5010901@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFFD12@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 21:33:47, Shilimkar, Santosh wrote:
[...]

> > +static int omap2_mbox_fifo_needs_flush(struct omap_mbox *mbox)
> > +{
> > +	struct omap_mbox2_fifo *fifo =
> > +		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
> type casting is generally avoided in linux code.

I was just trying to be consistent with the rest of the mailbox FIFO
related code :)

Will see how to get rid of these globally in the next version.

> > +	return mbox_read_reg(fifo->msg_stat);
> > +}
> > +
> > +static mbox_msg_t omap2_mbox_fifo_readback(struct omap_mbox *mbox)
> > +{
> > +	struct omap_mbox2_fifo *fifo =
> > +		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
> > +	return (mbox_msg_t) mbox_read_reg(fifo->msg);
> same here.

Ok.

> > +}
> > +
> >   /* Mailbox IRQ handle functions */
> >   static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
> >   		omap_mbox_type_t irq)
> > @@ -205,19 +219,21 @@ static void omap2_mbox_restore_ctx(struct omap_mbox *mbox)
> >   }
> >
> >   static struct omap_mbox_ops omap2_mbox_ops = {
> > -	.type		= OMAP_MBOX_TYPE2,
> > -	.startup	= omap2_mbox_startup,
> > -	.shutdown	= omap2_mbox_shutdown,
> > -	.fifo_read	= omap2_mbox_fifo_read,
> > -	.fifo_write	= omap2_mbox_fifo_write,
> > -	.fifo_empty	= omap2_mbox_fifo_empty,
> > -	.fifo_full	= omap2_mbox_fifo_full,
> > -	.enable_irq	= omap2_mbox_enable_irq,
> > -	.disable_irq	= omap2_mbox_disable_irq,
> > -	.ack_irq	= omap2_mbox_ack_irq,
> > -	.is_irq		= omap2_mbox_is_irq,
> > -	.save_ctx	= omap2_mbox_save_ctx,
> > -	.restore_ctx	= omap2_mbox_restore_ctx,
> > +	.type			= OMAP_MBOX_TYPE2,
> > +	.startup		= omap2_mbox_startup,
> > +	.shutdown		= omap2_mbox_shutdown,
> > +	.fifo_read		= omap2_mbox_fifo_read,
> > +	.fifo_write		= omap2_mbox_fifo_write,
> > +	.fifo_empty		= omap2_mbox_fifo_empty,
> > +	.fifo_full		= omap2_mbox_fifo_full,
> > +	.fifo_needs_flush	= omap2_mbox_fifo_needs_flush,
> > +	.fifo_readback		= omap2_mbox_fifo_readback,
> > +	.enable_irq		= omap2_mbox_enable_irq,
> > +	.disable_irq		= omap2_mbox_disable_irq,
> > +	.ack_irq		= omap2_mbox_ack_irq,
> > +	.is_irq			= omap2_mbox_is_irq,
> > +	.save_ctx		= omap2_mbox_save_ctx,
> > +	.restore_ctx		= omap2_mbox_restore_ctx,
> You should do the indentation fix in another patch.
> 

Ok will split it up.

> >   };
> >
> >   /*
> > diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
> > index cc3921e..e136529 100644
> > --- a/arch/arm/plat-omap/include/plat/mailbox.h
> > +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> > @@ -29,6 +29,8 @@ struct omap_mbox_ops {
> >   	void		(*fifo_write)(struct omap_mbox *mbox, mbox_msg_t msg);
> >   	int		(*fifo_empty)(struct omap_mbox *mbox);
> >   	int		(*fifo_full)(struct omap_mbox *mbox);
> > +	int		(*fifo_needs_flush)(struct omap_mbox *mbox);
> > +	mbox_msg_t	(*fifo_readback)(struct omap_mbox *mbox);
> Do you think passing the msg structure as an argument and letting the
> function populate it will be better instead of returning the msg
> structure ? No strong opinion since from read_foo() point of view
> what you have done might be right thing. In either case, please
> get rid of typecasting.
> 

Passing the msg structure looks fine. Will do that in the next version.

Regards,
Vaibhav 
