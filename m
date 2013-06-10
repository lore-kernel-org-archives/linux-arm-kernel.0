From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 10 Jun 2013 11:33:55 -0400 (EDT)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <19045559.gYzJhRHBbp@linux-5eaq.site>
Message-ID: <Pine.LNX.4.44L0.1306101130330.1133-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jun 2013, Oliver Neukum wrote:

> On Monday 10 June 2013 10:03:00 Alan Stern wrote:
> > [Thomas and Steve, please see the question below.]
> > 
> > On Mon, 10 Jun 2013, Ming Lei wrote:
> > 
> 
> > That isn't clear.  It is documented that USB completion handlers are 
> > called with local interrupts disabled.  An IRQ arriving before the 
> > tasklet starts up might therefore be serviced during the short interval 
> > before the tasklet disables local interrupts, but if that happens it 
> > would mean that the completion handler would be delayed.
> 
> That is what tasklets do by definition, isn't it?

Yes.  Although tasklets in general have no reason to leave interrupts 
disabled.

> > In effect, you are prioritizing other IRQs higher than USB completion
> > handlers.  Nevertheless, the total time spent with interrupts disabled
> > will remain the same.
> 
> It pobably slightly increases. You have colder caches twice.
> And potentially you swich CPUs.

Actually, the situation is a little better in one respect, which was
pointed out earlier but not emphasized.  The DMA unmapping can be
deferred to the tasklet, and it can run with interrupts enabled before
the completion hanlder is called.  Since the unmapping sometimes takes
a while to run, this is an advantage.

Alan Stern
