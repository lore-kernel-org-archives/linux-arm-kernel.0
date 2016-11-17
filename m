From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 17 Nov 2016 11:28:12 -0700
Subject: [PATCH fpga 4/9] fpga zynq: Check for errors after completing DMA
In-Reply-To: <CAAtXAHeGJjQ22d=OP6cEt8Ssg1bhAEVQ5_GWFFd26xp-j8EUFg@mail.gmail.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-5-git-send-email-jgunthorpe@obsidianresearch.com>
 <CAAtXAHeGJjQ22d=OP6cEt8Ssg1bhAEVQ5_GWFFd26xp-j8EUFg@mail.gmail.com>
Message-ID: <20161117182812.GB26039@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 10:10:35PM -0800, Moritz Fischer wrote:
> >   /* FPGA programmed */
> >  #define IXR_PCFG_DONE_MASK             BIT(2)
> > -#define IXR_ERROR_FLAGS_MASK           0x00F0F860
> > +#define IXR_ERROR_FLAGS_MASK           0x00F0C860
> 
> True. Ouch.

Yeah, this only works at all by accident..


> > -static void zynq_fpga_mask_irqs(struct zynq_fpga_priv *priv)
> > +static inline void zynq_fpga_set_irq_mask(struct zynq_fpga_priv *priv,
> > +                                         u32 enable)
> >  {
> > -       u32 intr_mask;
> > -
> > -       intr_mask = zynq_fpga_read(priv, INT_MASK_OFFSET);
> > -       zynq_fpga_write(priv, INT_MASK_OFFSET,
> > -                       intr_mask | IXR_DMA_DONE_MASK | IXR_ERROR_FLAGS_MASK);
> > -}
> > +       zynq_fpga_write(priv, INT_MASK_OFFSET, ~enable);
> 
> Not a fan of this ~enable here. Function name indicates you're doing
> the opposite

Lets call it zynq_fpga_set_irq then

The ~ is best placed here because it is after the compiler has coerced
the argument into u32 so the ~ will always do the right
thing

I've been reading the IXR_*_MASK as indicating it is a bit pattern for
the INT_MASK register not as actually meaning literal masking.

> > +out_clk:
> >         clk_disable(priv->clk);
> > -
> 
> Personally found it more readable with newline.

sure

Jason
