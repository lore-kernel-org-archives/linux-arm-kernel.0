From: oliver@neukum.org (Oliver Neukum)
Date: Mon, 10 Jun 2013 16:12:58 +0200
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306100946570.1133-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1306100946570.1133-100000@iolanthe.rowland.org>
Message-ID: <19045559.gYzJhRHBbp@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 June 2013 10:03:00 Alan Stern wrote:
> [Thomas and Steve, please see the question below.]
> 
> On Mon, 10 Jun 2013, Ming Lei wrote:
> 

> That isn't clear.  It is documented that USB completion handlers are 
> called with local interrupts disabled.  An IRQ arriving before the 
> tasklet starts up might therefore be serviced during the short interval 
> before the tasklet disables local interrupts, but if that happens it 
> would mean that the completion handler would be delayed.

That is what tasklets do by definition, isn't it?
 
> In effect, you are prioritizing other IRQs higher than USB completion
> handlers.  Nevertheless, the total time spent with interrupts disabled
> will remain the same.

It pobably slightly increases. You have colder caches twice.
And potentially you swich CPUs.
 
> (There's one other side effect that perhaps you haven't considered.  
> When multiple URBs are addressed to the same endpoint, their completion 
> handlers are called in order of URB completion, which is the same as 
> the order of URB submission unless an URB is cancelled.  By delegating 
> the completion handlers to tasklets, and particularly by using per-CPU 
> tasklets, you may violate this behavior.)

This is quite serious. It mustn't happen.

	Regards
		Oliver
