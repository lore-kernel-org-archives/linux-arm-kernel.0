From: buytenh@wantstofly.org ('Lennert Buytenhek')
Date: Tue, 14 Dec 2010 20:43:00 +0100
Subject: [PATCH 40/54] ARM: Samsung SoCs: irq_data conversion.
In-Reply-To: <015801cb92e1$117861b0$34692510$%kim@samsung.com>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130134112.GO15575@mail.wantstofly.org>
	<015801cb92e1$117861b0$34692510$%kim@samsung.com>
Message-ID: <20101214194300.GN15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 03, 2010 at 08:56:03PM +0900, Kukjin Kim wrote:

> > Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> > ---
> >  arch/arm/mach-s3c2410/bast-irq.c         |   22 ++--
> >  arch/arm/mach-s3c2412/irq.c              |   50 +++++-----
> >  arch/arm/mach-s3c2416/irq.c              |   72 +++++++-------
> >  arch/arm/mach-s3c2440/irq.c              |   18 ++--
> >  arch/arm/mach-s3c2440/s3c244x-irq.c      |   18 ++--
> >  arch/arm/mach-s3c2443/irq.c              |   90 ++++++++--------
> >  arch/arm/mach-s3c64xx/irq-eint.c         |   34 +++---
> >  arch/arm/mach-s5pv310/irq-combiner.c     |   26 +++--
> >  arch/arm/mach-s5pv310/irq-eint.c         |   55 +++++-----
> >  arch/arm/plat-s3c24xx/include/plat/irq.h |    4 +-
> >  arch/arm/plat-s3c24xx/irq-pm.c           |    9 +-
> >  arch/arm/plat-s3c24xx/irq.c              |  170
> +++++++++++++++-------------
> > --
> >  arch/arm/plat-s5p/irq-eint.c             |   84 ++++++++--------
> >  arch/arm/plat-s5p/irq-gpioint.c          |   50 +++++-----
> >  arch/arm/plat-s5p/irq-pm.c               |    6 +-
> >  arch/arm/plat-samsung/include/plat/pm.h  |    4 +-
> >  arch/arm/plat-samsung/irq-uart.c         |   44 ++++----
> >  arch/arm/plat-samsung/irq-vic-timer.c    |   22 ++--
> >  arch/arm/plat-samsung/pm.c               |    7 +-
> >  19 files changed, 396 insertions(+), 389 deletions(-)
> 
> Hi Lennert,

Hi Kukjin,


> (Added Mark Brown in Cc)
> 
> Looks ok to me but there are some comments.
> 
> Firstly, how about to separate this to regarding S3C24XX(mach-s3c24xx and
> plat-s3c24xx), S5P(mach-s5pxxxx and plat-s5p) and plat-samsung?
> (Actually, already applied S3C64XX changes so that we can drop that in your
> patch.)

The reason I originally put everything into one patch is that the
change touches s3c_irqext_wake(), which is defined in plat-samsung
and used in mach-s3c64xx, mach-s5pv310, plat-s3c24xx and plat-s5p --
so just splitting the patch across directory boundaries wouldn't work.

Since the s3c_irqext_wake() change is already in your tree, that
argument isn't valid anymore, but..


> As you know, I already applied some changes which is from Mark Brown in my
> tree.
> You can find that in
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> #for-next
> 
> So could you please re-work this based on that?

..wouldn't it just be easier if you merged the remainder of this
patch via your tree, so as not to introduce a merge dependency between
our trees?


> >  static struct irq_chip  bast_pc104_chip = {
> > -	.mask	     = bast_pc104_mask,
> > -	.unmask	     = bast_pc104_unmask,
> > -	.ack	     = bast_pc104_maskack
> > +	.irq_mask	= bast_pc104_mask,
> > +	.irq_unmask     = bast_pc104_unmask,
>                    ^^^^
> Tab is better instead of white space.

I agree, but the original version also had spaces -- and people
appear to get nervous when they perceive you to be sneaking in
'cleanup' patches along with your changes.


> > -static void s3c2416_irq_lcd_ack(unsigned int irqno)
> > +static void s3c2416_irq_lcd_ack(struct irq_data *d)
> >  {
> > -	s3c_irqsub_maskack(irqno, INTMSK_LCD, SUBMSK_LCD);
> > +	s3c_irqsub_maskack(d->irq, INTMSK_LCD, SUBMSK_LCD);
> >  }
> > 
> >  static struct irq_chip s3c2416_irq_lcd = {
> > -	.mask	    = s3c2416_irq_lcd_mask,
> > -	.unmask	    = s3c2416_irq_lcd_unmask,
> > -	.ack	    = s3c2416_irq_lcd_ack,
> > +	.irq_mask	= s3c2416_irq_lcd_mask,
> > +	.irq_unmask	= s3c2416_irq_lcd_unmask,
> > +	.irq_ack	= s3c2416_irq_lcd_ack,
> >  };
> > 
> > 
> > @@ -142,25 +142,25 @@ static void s3c2416_irq_demux_dma(unsigned int irq,
> > struct irq_desc *desc)
> >  #define SUBMSK_DMA	INTMSK(IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5)
> > 
> > 
> 
> If possible, please remove useless empty line.
> As you know, just one empty line is enough :-)

The original blank line was already there, and I left it there for
reasons stated above.


> > diff --git a/arch/arm/mach-s3c2440/s3c244x-irq.c b/arch/arm/mach-
> > s3c2440/s3c244x-irq.c
> > index a75c0c2..3878c0a 100644
> > --- a/arch/arm/mach-s3c2440/s3c244x-irq.c
> > +++ b/arch/arm/mach-s3c2440/s3c244x-irq.c
> > @@ -68,27 +68,27 @@ static void s3c_irq_demux_cam(unsigned int irq,
> >  #define INTMSK_CAM (1UL << (IRQ_CAM - IRQ_EINT0))
> > 
> >  static void
> > -s3c_irq_cam_mask(unsigned int irqno)
> > +s3c_irq_cam_mask(struct irq_data *d)
> >  {
> > -	s3c_irqsub_mask(irqno, INTMSK_CAM, 3<<11);
> > +	s3c_irqsub_mask(d->irq, INTMSK_CAM, 3<<11);
> 
> 3 << 11
> Need to add blank around "<<"

See above.


> >  static struct irq_chip s3c2443_irq_lcd = {
> > -	.mask	    = s3c2443_irq_lcd_mask,
> > -	.unmask	    = s3c2443_irq_lcd_unmask,
> > -	.ack	    = s3c2443_irq_lcd_ack,
> > +	.irq_mask	= s3c2443_irq_lcd_mask,
> > +	.irq_unmask	= s3c2443_irq_lcd_unmask,
> > +	.irq_ack	= s3c2443_irq_lcd_ack,
> >  };
> 
> Same...please remove useless empty line.

See above.


thanks,
Lennert
