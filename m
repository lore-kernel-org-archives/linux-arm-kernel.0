From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 23 Apr 2014 09:31:29 +0100
Subject: [Xen-devel] [PATCH RFC] arm64: 32-bit tolerant sync bitops
In-Reply-To: <534FB009.5030904@citrix.com>
References: <1397723881-31648-1-git-send-email-murzin.v@gmail.com>
 <534FB009.5030904@citrix.com>
Message-ID: <1398241889.4880.96.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-04-17 at 11:42 +0100, David Vrabel wrote:
> On 17/04/14 09:38, Vladimir Murzin wrote:
> > Xen assumes that bit operations are able to operate on 32-bit size and
> > alignment [1]. For arm64 bitops are based on atomic exclusive load/store
> > instructions to guarantee that changes are made atomically. However, these
> > instructions require that address to be aligned to the data size. Because, by
> > default, bitops operates on 64-bit size it implies that address should be
> > aligned appropriately. All these lead to breakage of Xen assumption for bitops
> > properties.
> > 
> > With this patch 32-bit sized/aligned bitops is implemented. 
> > 
> > [1] http://www.gossamer-threads.com/lists/xen/devel/325613
> > 
> > Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> > ---
> >  Apart this patch other approaches were implemented:
> >  1. turn bitops to be 32-bit size/align tolerant.
> >     the changes are minimal, but I'm not sure how broad side effect might be
> >  2. separate 32-bit size/aligned operations.
> >     it exports new API, which might not be good
> 
> I've never been particularly happy with the way the events_fifo.c uses
> casts for the sync_*_bit() calls and I think we should do option 2.
> 
> A generic implementation could be something like:

It seems like there isn't currently much call for/interest in a generic
32-bit set of bitops. Since this is a regression on arm64 right now how
about we simply fix it up in the Xen layer now and if in the future a
common need is found we can rework to use it.

We already have evtchn_fifo_{clear,set,is}_pending (although
evtchn_fifo_unmask and consume_one_event need fixing to use is_pending)
and evtchn_fifo_{test_and_set_,}mask, plus we would need
evtchn_fifo_set_mask for consume_one_event to use instead of open
coding.

With that then those helpers can become something like:
        #define BM(w) (unsigned long *)(w & ~0x7)
        #define EVTCHN_FIFO_BIT(b, w) (BUG_ON(w&0x3), w & 0x4 ? EVTCHN_FIFO_#b + 32 : EVTCHN_FIFO_#b)
        static void evtchn_fifo_clear_pending(unsigned port)
        {
        	event_word_t *word = event_word_from_port(port);
        	sync_clear_bit(EVTCHN_FIFO_BIT(PENDING, word), BM(word));
        }
similarly for the others.

If that is undesirable in the common code then wrap each existing helper
in #ifndef evtchn_fifo_clean_pending and put something like the above in
arch/arm64/include/asm/xen/events.h with a #define (and/or make the
helpers themselves macros, or #define HAVE_XEN_FIFO_EVTCHN_ACCESSORS etc
etc)

We still need your patch from
http://article.gmane.org/gmane.comp.emulators.xen.devel/196067 for the
other unaligned bitmap case. Note that this also removes the use of BM
for non-PENDING/MASKED bits, which is why it was safe for me to change
it above (also it would be safe to & ~0x7 after that change anyway).

Ian.
