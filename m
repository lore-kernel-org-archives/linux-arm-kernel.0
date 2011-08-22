From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Aug 2011 20:51:57 +0100
Subject: [RFC PATCH 05/15] ARM: perf: move active_events into struct
	arm_pmu
In-Reply-To: <4E529F30.4070607@codeaurora.org>
References: <4B9A4BAF850C914D8DED94776A2C477E073D90C2@nasanexd01f.na.qualcomm.com>
	<4E529F30.4070607@codeaurora.org>
Message-ID: <20110822195157.GB22755@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ashwin,

On Mon, Aug 22, 2011 at 07:25:52PM +0100, Ashwin Chaugule wrote:
> Hi Mark,
> 
> >> From: Mark Rutland 
> >> 	case PERF_TYPE_RAW:
> >> @@ -556,15 +559,14 @@ static int armpmu_event_init(struct perf_event
> >> *event)
> >>
> >> 	event->destroy = hw_perf_event_destroy;
> >>
> >> -	if (!atomic_inc_not_zero(&active_events)) {
> >> -		mutex_lock(&pmu_reserve_mutex);
> >> -		if (atomic_read(&active_events) == 0) {
> >> +	if (!atomic_inc_not_zero(active_events)) {
> >> +		mutex_lock(&armpmu->reserve_mutex);
> >> +		if (atomic_read(active_events) == 0)
> 
> 
> Isn't this use of atomic_* still racy ?

I don't believe so.

> http://www.spinics.net/lists/arm-kernel/msg123297.html

That thread is referring to previous behaviour where it was assumed that a
group of atomic operations would execute as an atomic block. The code
in question was fixed in 57ce9bb3 ("ARM: 6902/1: perf: Remove erroneous check
on active_events").

Now that we only modify active_events with the reserve_mutex held, we're
safe as houses.

Will
