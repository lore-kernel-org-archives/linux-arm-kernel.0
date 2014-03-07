From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 7 Mar 2014 12:51:09 -0300
Subject: [PATCH 1/3] dma: mv_xor: take channel spinlock in mv_xor_status()
In-Reply-To: <CAPcyv4hRP3o0=LTByvp8mg3x2iBo5fQ_pwmTzXnjHs4hxPXvkA@mail.gmail.com>
References: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1388144314-1581-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAPcyv4hRP3o0=LTByvp8mg3x2iBo5fQ_pwmTzXnjHs4hxPXvkA@mail.gmail.com>
Message-ID: <20140307155109.GA12784@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dan,

Thomas is a bit busy right now, so I'm picking this where he left it.

On Dec 31, Dan Williams wrote:
> On Fri, Dec 27, 2013 at 3:38 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
[..]
> > @@ -701,14 +701,20 @@ static enum dma_status mv_xor_status(struct dma_chan *chan,
> >         struct mv_xor_chan *mv_chan = to_mv_xor_chan(chan);
> >         enum dma_status ret;
> >
> > +       spin_lock_bh(&mv_chan->lock);
> > +
> >         ret = dma_cookie_status(chan, cookie, txstate);
> >         if (ret == DMA_COMPLETE) {
> >                 mv_xor_clean_completed_slots(mv_chan);
> 
> I think you can just delete this call to
> mv_xor_clean_completed_slots().  The fact that the descriptors are
> complete means that __mv_xor_slot_cleanup ran, and if that is the case
> there should be nothing to cleanup.
> 

In that case, we don't need to take the lock anywhere in this function:

1. It's not needed for dma_cookie_status() (as per Andy's comment).
2. It's not needed for mv_xor_slot_cleanup(), which takes the lock.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
