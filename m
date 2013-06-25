From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 25 Jun 2013 10:48:30 -0400 (EDT)
Subject: [PATCH v2 1/4] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <CACVXFVNwwULYg_2==CLh=dJrKJekhWqcOKdKYd_koPNoLzFfgQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306251046190.1340-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jun 2013, Ming Lei wrote:

> >> +
> >> +     spin_lock(&bh->lock);
> >> +     list_add_tail(&urb->urb_list, &bh->head);
> >> +     if (bh->running)
> >> +             sched = 0;
> >> +     else
> >> +             sched = 1;
> >> +     spin_unlock(&bh->lock);
> >
> > How about calling this variable "running" instead of "sched"?  Then you
> > could just say:
> >
> >         running = bh->running;
> >
> > with no "if" statement.
> 
> OK, even we can do this below without name change:
> 
>            sched = !bh->running;
> 
> >
> >> +
> >> +     if (!sched)
> >> +             ;
> >> +     else if (high_prio_bh)
> >> +             tasklet_hi_schedule(&bh->bh);
> >> +     else
> >> +             tasklet_schedule(&bh->bh);

The advantage of "running" instead of "sched" is that it avoids a 
double negative:

	sched = !bh->running;
	...
	if (!sched) ...

as opposed to

	running = bh->running;
	...
	if (running) ...

Alan Stern
