From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2009 11:31:58 +0000
Subject: [RESENT PATCH] Don't disable irqs in set_next_event and
	set_mode callbacks
In-Reply-To: <20091126105002.GB2393@n2100.arm.linux.org.uk>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091126105002.GB2393@n2100.arm.linux.org.uk>
Message-ID: <20091126113158.GC2393@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2009 at 10:50:02AM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 26, 2009 at 11:26:04AM +0100, Uwe Kleine-K?nig wrote:
> > These functions are called with irqs already off.
> > 
> > AT91RM2000 had a WARN_ON_ONCE if irqs were enabled since Nov 2008 with
> > noone reporting having hit it.
> 
> Can we please start to create some documentation for this, even if it
> just starts off as "these callbacks are always called with irqs
> disabled" or some such thing.
> 
> I find the generic time stuff extremely difficult to work with, and I
> suspect I'm not the only one.  This is probably why people like to be
> sure by having their own IRQ disabling.

To prove the IRQ-ness of the set_next_event callback, I've traced through
all the time code and come up with all these possible call paths:

set_next_event
`-clockevents_program_event
  +-tick_handle_periodic_broadcast
  | `- dev->event_handler
  |
  +-tick_handle_periodic
  | `- dev->event_handler
  |
  +-tick_setup_periodic
  | +-tick_broadcast_start_periodic
  | | +-tick_check_broadcast_device
  | | | `-tick_check_new_device (irqsave)
  | | |
  | | +-tick_device_uses_broadcast (irqsave)
  | | |
  | | +-tick_do_broadcast_on_off (irqsave)
  | | |
  | | `-tick_resume_broadcast (irqsave)
  | |
  | +-tick_do_broadcast_on_off (irqsave)
  | |
  | +-tick_setup_device
  | | `-tick_check_new_device (irqsave)
  | |
  | `-tick_resume (irqsave)
  |
  `-tick_dev_program_event
    +-tick_broadcast_set_event
    | +-tick_handle_oneshot_broadcast
    | | `- dev->event_handler
    | |
    | +-tick_broadcast_oneshot_control (irqsave)
    | |
    | +-tick_broadcast_setup_oneshot
    |   +-tick_do_broadcast_on_off (irqsave)
    |   `-tick_broadcast_switch_to_oneshot (irqsave)
    |
    +-tick_program_event
    | +-tick_resume_oneshot
    | | `-tick_resume (irqsave)
    | |
    | +-tick_nohz_stop_sched_tick (irqsave)
    | |
    | +-tick_nohz_restart
    | | +-tick_nohz_restart_sched_tick (irqdisable)
    | | |
    | | `-tick_nohz_kick_tick (#if 0'd out)
    | |
    | +-tick_nohz_reprogram
    | | `-tick_nohz_handler
    | |   `- dev->event_handler
    | |
    | `-tick_nohz_switch_to_nohz (irqdisable)
    |
    `-tick_setup_oneshot
      `-tick_setup_device
        `-tick_check_new_device (irqsave)

All leaves end in one of four cases:
1. a call via dev->event_handler
2. a function which uses spin_lock_irqsave before calling the child
3. a function which uses local_irq_disable before calling the child
4. a call which is #if 0'd out

So, we can be certain that in cases 2, 3, 4, set_next_event will be
called with IRQs disabled.  That leaves case 1, which is called from
the implementations interrupt handling function, or:

tick_do_broadcast
+-tick_do_periodic_broadcast
| `-tick_handle_periodic_broadcast
|   `- dev->event_handler
`-tick_handle_oneshot_broadcast
   `- dev->event_handler

which basically leaves us with the implementations interrupt handling
function.  If that always calls the event handler with IRQs disabled,
then set_next_event will also be called with IRQs disabled.

Is the same true for set_mode?  Without doing a similar analysis, I
wouldn't know.  I'm sure the folk who created generic time would surely
know the answer off the tops of their heads.
