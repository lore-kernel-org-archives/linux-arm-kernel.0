From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 11 Dec 2015 14:53:20 +0100
Subject: [PATCH v4 01/58] mtd: nand: denali: add missing nand_release()
 call in denali_remove()
In-Reply-To: <20151211004008.GQ144338@google.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449734442-18672-2-git-send-email-boris.brezillon@free-electrons.com>
 <20151211004008.GQ144338@google.com>
Message-ID: <20151211145320.1560fac3@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Thu, 10 Dec 2015 16:40:08 -0800
Brian Norris <computersforpeace@gmail.com> wrote:

> On Thu, Dec 10, 2015 at 08:59:45AM +0100, Boris Brezillon wrote:
> > Unregister the NAND device from the NAND subsystem when removing a denali
> > NAND controller, otherwise the MTD attached to the NAND device is still
> > exposed by the MTD layer, and accesses to this device will likely crash
> > the system.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Cc: <stable@vger.kernel.org> #3.8+
> 
> Does this follow these rules, from
> Documentation/stable_kernel_rules.txt?
> 
>  - It must be obviously correct and tested.
> 
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing).

As you wish, I'll remove those Cc and Fixes tags, or just drop the
patch if you think it's useless...
I just noticed the bug while reworking this series, and thought it
would be useful to fix it, but I honestly don't care if it's applied
or not (I don't use this platform).

> 
> > Fixes: 2a0a288ec258 ("mtd: denali: split the generic driver and PCI layer")
> > ---
> >  drivers/mtd/nand/denali.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
> > index 67eb2be..8feece3 100644
> > --- a/drivers/mtd/nand/denali.c
> > +++ b/drivers/mtd/nand/denali.c
> > @@ -1622,6 +1622,7 @@ EXPORT_SYMBOL(denali_init);
> >  /* driver exit point */
> >  void denali_remove(struct denali_nand_info *denali)
> >  {
> > +	nand_release(&denali->mtd);
> >  	denali_irq_cleanup(denali->irq, denali);
> >  	dma_unmap_single(denali->dev, denali->buf.dma_buf,
> >  			 denali->mtd.writesize + denali->mtd.oobsize,
> 
> It feels a bit odd to allow usage of MTD fields after it has been
> unregistered. Maybe precompute this before the nand_release()?

nand_realease() is not releasing the mtd instance or re-initialazing
its field, so it should be safe, but I agree that pre-computing the DMA
buffer size is more future-proof.

I'll fix that, send a v5 and let you decide whether it's needed or not.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
