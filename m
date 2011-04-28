From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 16:41:08 +0100
Subject: [PATCH] ARM: perf: remove erroneous check on active_events
In-Reply-To: <1303898236-14263-1-git-send-email-mark.rutland@arm.com>
References: <1303898236-14263-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20110428154108.GV17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 10:57:16AM +0100, Mark Rutland wrote:
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index fd6403c..29a0cf8 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -560,11 +560,6 @@ static int armpmu_event_init(struct perf_event *event)
>  	event->destroy = hw_perf_event_destroy;
>  
>  	if (!atomic_inc_not_zero(&active_events)) {
> -		if (atomic_read(&active_events) > armpmu->num_events) {
> -			atomic_dec(&active_events);

Yuck.  This is a good example of atomic_* abuse.  The above does nothing
to deal with the situation where two threads are running thusly:

CPU0					CPU1
atomic_inc_not_zero(&active_events)
					atomic_inc_not_zero(&active_events)
atomic_read(&active_events)
					atomic_read(&active_events)
atomic_dec(&active_events)
					atomic_dec(&active_events)
return -ENOSPC
					return -ENOSPC

when one of those two should have succeeded.  I do wish people would
get out of the habbit of using atomic variables - they seem to be ripe
for this kind of abuse.

The only time that atomic variables are atomic is for each individual
_operation_ on the type, not across several operations, and certainly
not atomic_read() or atomic_set().

What it really wants to be is a spinlock or mutex so that it can do
something like this:

	int err = 0;

	mutex_lock(&active_events_lock);
	if (++active_events > armpmu->num_events) {
		active_events--;
		err = -ENOSPC;
	}
	mutex_unlock(&active_events);

	if (err)
		return err;

which gives well defined semantics, and ensures that when two CPUs are
racing, one will at least succeed.
