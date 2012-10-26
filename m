From: mporter@ti.com (Matt Porter)
Date: Fri, 26 Oct 2012 07:45:33 -0400
Subject: [PATCH] davinci: check for presence of channel controller on
 slot alloc
In-Reply-To: <508A7665.4030109@ti.com>
References: <1347473642-9948-1-git-send-email-cyril@ti.com>
 <508A7665.4030109@ti.com>
Message-ID: <20121026114533.GA2710@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 05:09:17PM +0530, Sekhar Nori wrote:
> + Matt, who is doing the DMA engine conversion for EDMA
> 
> On 9/12/2012 11:44 PM, Cyril Chemparathy wrote:
> > This patch adds a check for the presence of the channel controller when
> > trying to allocate a slot.  Without this fix, the kernel panics with a NULL
> > pointer dereference when the dma-engine drivers are probed.
> > 
> > Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> > ---
> >  arch/arm/mach-davinci/dma.c |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
> > index a685e97..2fee31e 100644
> > --- a/arch/arm/mach-davinci/dma.c
> > +++ b/arch/arm/mach-davinci/dma.c
> > @@ -743,6 +743,9 @@ EXPORT_SYMBOL(edma_free_channel);
> >   */
> >  int edma_alloc_slot(unsigned ctlr, int slot)
> >  {
> > +	if (!edma_cc[ctlr])
> > +		return -ENODEV;
> 
> I am ok with this patch, although I wonder if a better error is -ENXIO
> or even -EINVAL (since its most likely the result of a wrong argument).
> 
> This patch will conflict with the EDMA movement series that Matt is
> doing and he should probably include it in his series to avoid
> conflicts. From the description it appears to be not required for v3.7
> anyway.

I'll add this to the am33xx dmaengine series with -EINVAL, thanks.

-Matt
