From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jun 2012 11:01:59 +0100
Subject: [CFT 01/11] dmaengine: add OMAP DMA engine driver
In-Reply-To: <CAMQu2gzGp=eznnXweX=ZN03cxVbbhbHconowigk964ojx99mJQ@mail.gmail.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaXw-0003tR-U8@rmk-PC.arm.linux.org.uk>
 <20120608090200.GA15831@n2100.arm.linux.org.uk>
 <CAMQu2gzGp=eznnXweX=ZN03cxVbbhbHconowigk964ojx99mJQ@mail.gmail.com>
Message-ID: <20120608100159.GB15831@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2012 at 03:30:23PM +0530, Shilimkar, Santosh wrote:
> On Fri, Jun 8, 2012 at 2:32 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jun 07, 2012 at 12:06:32PM +0100, Russell King wrote:
> >> Tested-by: Tony Lindgren <tony@atomide.com>
> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >> ---
> >> ?drivers/dma/Kconfig ? ? ?| ? ?6 +
> >> ?drivers/dma/Makefile ? ? | ? ?1 +
> >> ?drivers/dma/omap-dma.c ? | ?522 ++++++++++++++++++++++++++++++++++++++++++++++
> >> ?include/linux/omap-dma.h | ? 24 ++
> >> ?4 files changed, 553 insertions(+), 0 deletions(-)
> >> ?create mode 100644 drivers/dma/omap-dma.c
> >> ?create mode 100644 include/linux/omap-dma.h
> >
> > There is a bug in here which no one has spotted... I just noticed it.
> >
> > diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> > index 500bc71..02eb2fd 100644
> > --- a/drivers/dma/omap-dma.c
> > +++ b/drivers/dma/omap-dma.c
> > @@ -130,14 +130,13 @@ static void omap_dma_callback(int ch, u16 status, void *data)
> >
> > ? ? ? ?spin_lock_irqsave(&c->vc.lock, flags);
> > ? ? ? ?d = c->desc;
> > - ? ? ? if (!d)
> > - ? ? ? ? ? ? ? return;
> > -
> > - ? ? ? if (++c->sgidx < d->sglen) {
> > - ? ? ? ? ? ? ? omap_dma_start_sg(c, d, c->sgidx);
> > - ? ? ? } else {
> > - ? ? ? ? ? ? ? omap_dma_start_desc(c);
> > - ? ? ? ? ? ? ? vchan_cookie_complete(&d->vd);
> > + ? ? ? if (d) {
> > + ? ? ? ? ? ? ? if (++c->sgidx < d->sglen) {
> > + ? ? ? ? ? ? ? ? ? ? ? omap_dma_start_sg(c, d, c->sgidx);
> > + ? ? ? ? ? ? ? } else {
> > + ? ? ? ? ? ? ? ? ? ? ? omap_dma_start_desc(c);
> > + ? ? ? ? ? ? ? ? ? ? ? vchan_cookie_complete(&d->vd);
> > + ? ? ? ? ? ? ? }
> > ? ? ? ?}
> > ? ? ? ?spin_unlock_irqrestore(&c->vc.lock, flags);
> > ?}
> >
> You mean the lock release, right ?

Yes, if c->desc is NULL, we exit this function with the lock held,
which will lead to a lockup.
