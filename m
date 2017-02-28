From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 28 Feb 2017 19:53:20 +0100 (CET)
Subject: [PATCH v3 04/25] clocksource: Add Owl timer
In-Reply-To: <20170228173950.GD30601@mai>
References: <20170228063535.32069-1-afaerber@suse.de>
 <20170228063535.32069-5-afaerber@suse.de> <20170228164745.GC30601@mai>
 <1994faec-7936-aa96-87b4-df48f75f179b@suse.de> <20170228173950.GD30601@mai>
Message-ID: <alpine.DEB.2.20.1702281950380.4007@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Feb 2017, Daniel Lezcano wrote:
> On Tue, Feb 28, 2017 at 06:08:06PM +0100, Andreas F?rber wrote:
> > >> +static irqreturn_t owl_timer1_interrupt(int irq, void *dev_id)
> > >> +{
> > >> +	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> > >> +
> > >> +	writel(OWL_Tx_CTL_PD, owl_timer_get_base(1) + OWL_Tx_CTL);
> > >> +
> > >> +	evt->event_handler(evt);
> > 
> > Is there any guideline as to whether to clear such flag before or after?
> 
> Mmh, good question. I'm not sure it makes a different.

It makes a difference depending on what this flag does. If it clears the
current pending interrupt, then you _must_ do it before rearming the
timer. Otherwise you might clear the pending interrupt of the rearmed timer
(when the timeout is very small) which makes the machine wait forever for
the next timer interrupt.

Thanks,

	tglx
