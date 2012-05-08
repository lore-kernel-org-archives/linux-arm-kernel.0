From: neilb@suse.de (NeilBrown)
Date: Wed, 9 May 2012 06:52:02 +1000
Subject: [PATCH 2/3] IRQ: allow check_wakeup_irqs to notice
 level-triggered interrupts.
In-Reply-To: <alpine.LFD.2.02.1205041759540.6271@ionos>
References: <20120425025637.7832.14013.stgit@notabene.brown>
 <20120425030524.7832.85239.stgit@notabene.brown>
 <alpine.LFD.2.02.1204251018530.2542@ionos>
 <20120425193916.0db1b4b1@notabene.brown>
 <alpine.LFD.2.02.1204251402360.2542@ionos>
 <20120504151221.6998d4e5@notabene.brown>
 <alpine.LFD.2.02.1205041759540.6271@ionos>
Message-ID: <20120509065202.3b3b0436@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 May 2012 18:01:22 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de>
wrote:

> Neil,
> 
> On Fri, 4 May 2012, NeilBrown wrote:
> 
> > On Wed, 25 Apr 2012 14:54:54 +0200 (CEST) Thomas Gleixner
> > <tglx@linutronix.de> wrote:
> > 
> > > Why not simply managing the pending bit for level irqs ?
> > > 
> > 
> > Hi Thomas,
> >  thanks again for the patch.  I finally made time to test it and it works as
> > expected.  I've included it below with a change-log entry and tested-by:
> > in case that helps.
> 
> thanks for testing. The changelog is great. You know how to make the
> live of lazy buggers easier :)

Just buttering you up so any future patches slip past easily :-)

I think I'll need to ask for IRQS_PENDING to be set for nested interrupts too
but I'll be a little while before  I an look at that issue properly and
propose a patch.

Thanks for your help,
NeilBrown



>   
> >  	for_each_irq_desc(irq, desc) {
> > -		if (irqd_is_wakeup_set(&desc->irq_data)) {
> > +		if (desc->depth == 1 &&
> > +		    irqd_is_wakeup_set(&desc->irq_data)) {
> >  			if (desc->istate & IRQS_PENDING)
> >  				return -EBUSY;
> >  			continue;
> 
> I split that part into a separate patch, as it's really a different
> issue.
> 
> Thanks,
> 
> 	tglx

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/4bb23696/attachment.sig>
