From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 20 Feb 2015 09:38:42 +0100
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <6291e308ab77a480c6b1732e16108c5fe6f66afa.1424412815.git.viresh.kumar@linaro.org>
References: <6291e308ab77a480c6b1732e16108c5fe6f66afa.1424412815.git.viresh.kumar@linaro.org>
Message-ID: <20150220083842.GA20387@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Many clockevent drivers are using a switch block for handling modes in their
> ->set_mode() callback. Some of these do not have a 'default' case and adding a
> new mode in the 'enum clock_event_mode', starts giving following warnings for
> these platforms about unhandled modes (e.g. XXX).
> 
> 	warning: enumeration value ?XXX? not handled in switch [-Wswitch]
> 
> This patch adds default cases for them.
> 
> In order to keep things simple, add following to the switch blocks:
> 
> 	default:
> 		break;
> 
> This can lead to different behavior for individual cases.
> 
> 1) Some of the drivers don't have any special stuff in their ->set_mode()
>    callback before or after the switch blocks. And so this default case would
>    simply return for them without any updates to the clockevent device.
> 
> 2) But in some cases, the clockevent device is disabled/stopped as soon as we
>    enter the ->set_mode() callback and is enabled within the switch block or
>    after it. And the clockevent device *may* stay disabled for default case.

So this whole approach looks fragile for several reasons:

   - 'mode setting' callbacks are just bad by design
     because they mix several functions into the same entry
     point, complicating the handler functions 
     unnecessarily. We should reduce complexity, not expand 
     on it.

   - now by adding 'default' you hide from drivers the
     ability to easily discover whether it has been updated
     to some new core clockevents mode setting feature or
     not.

So NAK: the real solution would be to eliminate 'mode 
setting' altogether: treat it as a legacy, introduce 
properly separated callbacks and function pointer callback 
driver templates, and let drivers fill in (or not) 
individual entries. Clockevents core can mandate certain 
entries to be filled in, or allow NULL with some default 
behavior.

The ->set_mode() approach allows none of this. It is 
ioctl()-alike interface design, and that is a singularly 
bad design for the aforementioned reasons.

So to give a quick example what I have in mind, I looked up 
a random clockevents driver callback from your patch 
(arch/arm/mach-mmp/time.c):

static void timer_set_mode(enum clock_event_mode mode,
			   struct clock_event_device *dev)
{
	unsigned long flags;

	local_irq_save(flags);
	switch (mode) {
	case CLOCK_EVT_MODE_ONESHOT:
	case CLOCK_EVT_MODE_UNUSED:
	case CLOCK_EVT_MODE_SHUTDOWN:
		/* disable the matching interrupt */
		__raw_writel(0x00, mmp_timer_base + TMR_IER(0));
		break;
	case CLOCK_EVT_MODE_RESUME:
	case CLOCK_EVT_MODE_PERIODIC:
		break;
	default:
		break;
	}
	local_irq_restore(flags);
}

Instead of that I'd let the driver define just a single 
function:

static void mmp_timer_disable(struct clock_event_device *dev __unused)
{
	unsigned long flags;

	local_irq_save(flags);
	__raw_writel(0x00, mmp_timer_base + TMR_IER(0));
	local_irq_restore(flags);
}


static struct clockevents_driver mmp_clockevents {
	.clock_event__oneshot	= mmp_timer_disable,
	.clock_event__shutdown	= mmp_timer_disable,

	/* clock_event__resume and __periodic are NULL */
};

See how much cleaner and easier to read it all is?

Note how the NULL entries express a 'don't do anything' 
default in a natural fashion. It's also future proof: if a 
new callback is added to 'struct clockevents_driver' then 
it's filled in with NULL and the clockevents core may 
define a default behavior, without having to touch the 
driver.

It's also _faster_: no function call needed and there's a 
pointless local_irq_save()/restore() call optimized out as 
well.

So let's clean up the clockevents mode setting design, 
okay?

Thanks,

	Ingo
