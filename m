From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Thu, 25 Mar 2010 08:10:18 +0100
Subject: [PATCH 1/5] ARM: define the PrimeCell DMA API
In-Reply-To: <e9c3a7c21003241630u5c4c1f45qc0608c124a062350@mail.gmail.com>
References: <1268056327-16577-1-git-send-email-linus.walleij@stericsson.com>
	<e9c3a7c21003241408g2a704425g47ccdfb60d606683@mail.gmail.com>
	<CEE6BB42CAD6E947908279175AF8470A0391EEB1@EXDCVYMBSTM006.EQ1STM.local>
	<e9c3a7c21003241501x1f1ed857pcaaaf8ea8dc563ec@mail.gmail.com>
	<CEE6BB42CAD6E947908279175AF8470A0391EEB9@EXDCVYMBSTM006.EQ1STM.local>
	<e9c3a7c21003241630u5c4c1f45qc0608c124a062350@mail.gmail.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A0391EF1F@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Dan]

> From: dan.j.williams at gmail.com [mailto:dan.j.williams at gmail.com] On Behalf
> Of Dan Williams
> On Wed, Mar 24, 2010 at 3:13 PM, Linus WALLEIJ
> <linus.walleij@stericsson.com> wrote:
> > [Dan]
> >
> >> What are your semantics for keeping the transaction information alive
> >> until it gets consumed. ?Currently the dma_ctrl_flags have the
> >> DMA_CTRL_ACK bit to specify that the descriptor not be
> >> recycled/destroyed until the client has a chance to attach a dependent
> >> operation. ?Seems you need something similar to indicate that the
> >> residue information not be destroyed until it is consumed. ?In other
> >> words how does a client guarantee that the engine provides the
> >> information it needs?
> >
> > Well exactly to avoid that kind of trouble I STOP (or PAUSE),
> > get numer of bytes left, then terminate in that order. This
> > keeps the descriptor.
> 
> But doesn't this assume you win the race with the engine completing
> and cleaning up the descriptor before the 'stop' takes effect?

Sure does! So now I have to think of some solution to that.
I'll hack around a bit...

> The configuration issues will always be arch specific I grant you
> that, but I think we can define top level "operation query" and
> "channel control" apis in a generic/extensible fashion.  Something
> like:
> 
> 1/ Change ->device_terminate_all() into ->device_control():
> 
> enum {
> 	DMA_TERMINATE_ALL, /* legacy semantics */
> 	DMA_PAUSE, /* your new primecell command semantics */
> } dma_crtl;
> 
> int (*device_control)(struct dma_chan *chan, enum dma_ctrl cmd);
> 
> 
> 2/ Change device_is_tx_complete to device_tx_status along the lines of
> what Guennadi and I talked about.

OK I'll take a stab at this... There are not too many users so
should be possible to switch them over easily.

Yours,
Linus Walleij
