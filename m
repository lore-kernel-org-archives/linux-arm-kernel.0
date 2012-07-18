From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 18 Jul 2012 12:15:02 +0300
Subject: [PATCHv6 4/7] ARM: OMAP: hwmod: Add support for per
 hwmod/module context lost count
In-Reply-To: <CAOMWX4fecw5A0BhDG-swVubKtxTEKdNpcODOh7=uFBFbSAnbgw@mail.gmail.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
 <1339428387-4800-5-git-send-email-t-kristo@ti.com>
 <CAOMWX4fecw5A0BhDG-swVubKtxTEKdNpcODOh7=uFBFbSAnbgw@mail.gmail.com>
Message-ID: <1342602902.4672.91.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-07-17 at 02:59 -0500, Menon, Nishanth wrote:
> Couple of minor comments:
> On Mon, Jun 11, 2012 at 10:26 AM, Tero Kristo <t-kristo@ti.com> wrote:
> [...]
> >  /**
> > + * _omap4_update_context_lost - increment hwmod context loss counter if
> > + * hwmod context was lost, and clear hardware context loss reg
> > + * @oh: hwmod to check for context loss
> > + *
> > + * If the PRCM indicates that the hwmod @oh lost context, increment
> > + * our in-memory context loss counter, and clear the RM_*_CONTEXT
> > + * bits. No return value.
> > + */
> > +static void _omap4_update_context_lost(struct omap_hwmod *oh)
> > +{
> > +       u32 r;
> > +
> > +       if (oh->prcm.omap4.context_offs == USHRT_MAX)
> > +               return;
> would'nt it be better to return a dummy incremental counter instead of
> returning no context loss (count = 0)?

I guess you are right, this way we may have some extra context restores
for modules which don't have context offs defined, rather than not
restoring them at all. Only thing I can think might prevent this is if
there are modules that never lose context but don't have context
register? How about omap5+?

> 
> > +
> > +       r = omap4_prminst_read_inst_reg(oh->clkdm->pwrdm.ptr->prcm_partition,
> > +                                       oh->clkdm->pwrdm.ptr->prcm_offs,
> > +                                       oh->prcm.omap4.context_offs);
> > +
> > +       if (!r)
> > +               return;
> > +
> > +       oh->prcm.omap4.context_lost_counter++;
> need to be careful about counter overflow.

Well, this code can't do much for that even if it overflows... the type
for the context_lost_counter is unsigned though, maybe it should be
expanded if you are worried...?

-Tero
