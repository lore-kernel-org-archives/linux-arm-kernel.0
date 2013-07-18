From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 18 Jul 2013 10:08:53 -0400 (EDT)
Subject: [PATCH] [RFC] EHCI: add to memory barrier to updating hw_next
In-Reply-To: <CACVXFVNV-hGZpcy2ANQaca1K5yXJ88EOq1PTkJUEHEkFk9Btvw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1307181004190.1245-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Jul 2013, Ming Lei wrote:

> > I guess that HC could have a use-after-free problem like following situation.
> >
> > 1. A qtd which is not at the queue head should be removed in qh_completions().
> > 2. The last->hw_next become be pointing at the next qtd but the hw_next value is delayed in write-buffer.
> > 3. The qtd is removed in the list.
> > 4. The qtd is freed into DMA pool and re-allocated for another urb.
> > 5. HC try to process last->hw_next and it is pointing re-allocated qtd.
> >
> > What do you think about it? Is it possible?
> 
> I understand it might not be possible because:  when 'stopped' is set, that
> said the HC might not advance the queue. But I don't understand why
> 'last->hw_next' is patched here under 'stopped' situation.

It should not be possible.  When "stopped" is set, the QH gets unlinked 
and relinked before it can start up again.  Relinking involves some 
memory barriers, so the qTD will not be accessed again by the HC.

last->hw_next gets patched because the qTD might belong to some URB in 
the middle of the queue that is being unlinked.  The URBs before it and 
after it will still be active, so the queue link has to be updated.

> Even the 'stopped' case may be seldom triggered, do you know under
> which condition the stopped is triggered in your problem?(stall, short read
> or others)

I was going to ask the same question.  This particular piece of code
gets executed _only_ when an URB is unlinked.  Not during any other
kind of error.

Alan Stern
