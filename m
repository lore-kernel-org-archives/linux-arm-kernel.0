From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Jun 2011 10:54:30 +0100
Subject: [RFC PATCH 1/4] dt: early platform devices support
In-Reply-To: <20110625204435.GA15026@ponder.secretlab.ca>
References: <1308924659-31894-1-git-send-email-marc.zyngier@arm.com>
	<1308924659-31894-2-git-send-email-marc.zyngier@arm.com>
	<BANLkTi=7cM2dXniHM4mnXs46KaTc05hh-Q@mail.gmail.com>
	<20110625121142.4c73ca70@taxman.wild-wind.fr.eu.org>
	<20110625204435.GA15026@ponder.secretlab.ca>
Message-ID: <4E085356.7060407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/06/11 21:44, Grant Likely wrote:
> On Sat, Jun 25, 2011 at 12:11:42PM +0100, Marc Zyngier wrote:
>> On Fri, 24 Jun 2011 22:49:56 -0600
>> The current ARM code relies on the timers *not* being a standard
>> device, and being directly setup by an board specific method. The SMP
>> timers are even worse, as they are directly called by the core code,
>> meaning that we can only have *one* implementation at a time in the
>> kernel.
>>
>> So the early platform stuff is a potential solution for that, though
>> there is no way it would handle any kind of dependency. What I dream of
>> is to have the full device/driver infrastructure available much
>> earlier, before the rest of the kernel starts relying on some hardware
>> being up and running...
> 
> My suggestion: don't use platform_device for this.  I think it is
> entirely the wrong model.  Keep the timers *not* standard devices.
> 
> Instead, use a timer setup function that accepts a list of compatible
> properties and an initialization hook for each timer type.  Since
> timers have exist, have to be called by core code, and cannot ever be
> built as modules, the Linux device model really doesn't offer much
> advantage.
> 
> It is completely valid and often done to access device tree data from
> early setup code without any context of a struct device.

Grant,

There's a few conflicting aspects we need to reconcile here:
- We want to keep the early setup code as simple as possible so it
doesn't rely on anything (well, as little as possible)
- We want to move driver code out of arch/arm (they often are generic,
not specific to a particular architecture)
- We want to support DT and non-DT in a similar way (some ARM platforms
will never see a DT port)

If I follow your advice, I end up with something like the following
thing in the core code:

extern int timerx_probe(struct of_device_id *id);
struct of_device_id timerx_ids[] = {
	...
};

extern int timery_probe(struct of_device_id *id);
struct of_device_id timery_ids[] = {
	...
};

extern int timerz_probe(struct of_device_id *id);
struct of_device_id timerz_ids[] = {
	...
};

struct arm_timer_probe {
	struct of_device_if **ids;
	int (*probe)(struct of_device_id *);
};

struct arm_timer_probe arm_timer_probe_list[] = {
	{ .ids = timerx_ids, probe = timerx_probe, },
	{ .ids = timery_ids, probe = timery_probe, },
	{ .ids = timerz_ids, probe = timerz_probe, },
	{ },
};

... with some additional #ifdef-ery to make that work. This could solve
the first two points above, though each timer_probe function has to
parse the tree itself to gather resources (code duplication).

If you add the non-DT support in the picture, you get an additional,
completely separate code path, where the platform code directly calls
into the driver code, each platform inventing its own stuff. Again.

I think we all agree that early_platform_device are distasteful. They
abuse the platform_device and command line. They give you a false sense
of infrastructure.

But they also offer you:
- a clean separation between core code and drivers, with a standardized
interface
- drivers shared across architectures (sh & shmobile, for example)
- use of common code (fetching resources from DT)
- a relative independence from the level of DT support (the driver only
knows about platform devices).

If there are issues in the early platform stuff, I'd rather tackle them
instead of just inventing yet another custom mechanism. And if we decide
that it is terminally broken, I hope we can agree on something generic
enough to satisfy the above requirements.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
