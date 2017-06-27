From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Jun 2017 18:12:18 +0100
Subject: [PATCH v4 4/5] drivers/perf: Add support for ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <20170621153932.GD6041@arm.com>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
 <1496676177-29356-5-git-send-email-will.deacon@arm.com>
 <20170615145729.GB26471@leverpostej>
 <20170621153932.GD6041@arm.com>
Message-ID: <20170627171218.GF30002@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 21, 2017 at 04:39:33PM +0100, Will Deacon wrote:
> On Thu, Jun 15, 2017 at 03:57:29PM +0100, Mark Rutland wrote:
> > On Mon, Jun 05, 2017 at 04:22:56PM +0100, Will Deacon wrote:

> > > +	SPE_PMU_CAP_ERND,
> > > +	SPE_PMU_CAP_FEAT_MAX,
> > > +	SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
> > > +	SPE_PMU_CAP_MIN_IVAL,
> > > +};

> > We could get rid of the confusing SPE_PMU_CAP_FEAT_MAX definition here,
> > if we were to:
> > 
> > > +static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
> > > +	[SPE_PMU_CAP_ARCH_INST]	= SPE_PMU_FEAT_ARCH_INST,
> > > +	[SPE_PMU_CAP_ERND]	= SPE_PMU_FEAT_ERND,
> > > +};
> > 
> > .. change this to:
> > 
> > static int arm_spe_pmu_feat_caps[] = {
> > 	...
> > };
> > 
> > ... and:
> > 
> > > +static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
> > > +{
> > > +	if (cap < SPE_PMU_CAP_FEAT_MAX)
> > 
> > ... change this to:
> > 
> > 	if (cap < ARRAY_SIZE(arm_spe_pmu_feat_caps))
> 
> I quite liked this suggestion at first and I even implemented it, but the
> result was IMO less maintainable than the above. There's ABI involved here,
> so I want to make it as difficult as possible to break the ABI when adding a
> new hardware capability to the driver. The current code does a good job of
> that:
> 
>   - If you add a boolean feature in the wrong place in arm_spe_capabilities,
>     then you'll get a WARN
> 
>   - If you add a non-boolean feature in the wrong place then it will be
>     reported as non-present, unless you add an entry in
>     arm_spe_pmu_feat_caps (at which point you'd realise the mistake)
> 
>   - If you only update arm_spe_pmu_feat_caps, then you'll get a build error.
> 
> With your change, it's a lot easier to break things subtly, so I'd rather
> keep this as-is unless you have non-cosmetic reasons to change it.

No objections here; that's a pretty good rationale for keeping this
as-is.

[...]

> > > +static void arm_spe_event_sanitise_period(struct perf_event *event)
> > > +{
> > > +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> > > +	u64 period = event->hw.sample_period & ~PMSIRR_EL1_IVAL_MASK;

> > > +	if (period < spe_pmu->min_period)
> > > +		period = spe_pmu->min_period;
> > 
> > We already verify this in arm_spe_pmu_event_init(), so we don't need to
> > check this here.
> > 
> > We can drop arm_spe_event_sanitise_period() entirely. Given we validate
> > the period at event_init() time, there's no need to sanitize the value.
> 
> What about PERF_IOC_PERIOD? I don't think that re-inits the event.

Ugh; good point.

Given that, it's arguably worth not validating the period at
event_init() time, to have consistent behaviour across opening an event
with a given period, and fiddling with tha via PERF_IOC_PERIOD.

I also think that rather than masking the period with
PMSIRR_EL1_IVAL_MASK we should have something like:

	if (period > SPE_PMU_MAX_PERIOD)
		period = SPE_PMU_MAX_PERIOD;

... as that avoids the user asking for max_period + 1, and getting the
minimum period, and other such weirdness.

[...]

> > > +static bool arm_spe_pmu_buffer_mgmt_pending(u64 pmbsr)
> > > +{
> > > +	const char *err_str;
> > > +
> > > +	/* Service required? */
> > > +	if (!(pmbsr & BIT(PMBSR_EL1_S_SHIFT)))
> > > +		return false;
> > > +
> > > +	/* We only expect buffer management events */
> > > +	switch (pmbsr & (PMBSR_EL1_EC_MASK << PMBSR_EL1_EC_SHIFT)) {
> > > +	case PMBSR_EL1_EC_BUF:
> > > +		/* Handled below */
> > > +		break;
> > > +	case PMBSR_EL1_EC_FAULT_S1:
> > > +	case PMBSR_EL1_EC_FAULT_S2:
> > > +		err_str = "Unexpected buffer fault";
> > > +		goto out_err;
> > > +	default:
> > > +		err_str = "Unknown error code";
> > > +		goto out_err;
> > > +	}
> > 
> > For the error cases, I take it the assumption is that we leave
> > PMBSR_EL1.S set, so that the HW doesn't start again?
> 
> No, I don't think I actually handle these cases at all. Whilst they're
> probably catastrophic (vmapped mappings are faulting!), I should at least
> try to park the profiler. Will fix for the next version.

Great; thanks.

[...]

> > > +		handle->head = PERF_IDX2OFF(limit, buf);
> > > +		limit = ((buf->nr_pages * PAGE_SIZE) >> 1) + handle->head;
> > > +	}
> > > +
> > > +	return limit;
> > > +}
> > > +
> > > +static u64 __arm_spe_pmu_next_off(struct perf_output_handle *handle)
> > > +{
> > > +	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
> > > +	u64 head = PERF_IDX2OFF(handle->head, buf);
> > > +	u64 tail = PERF_IDX2OFF(handle->head + handle->size, buf);
> > > +	u64 wakeup = PERF_IDX2OFF(handle->wakeup, buf);
> > > +	u64 limit = buf->nr_pages * PAGE_SIZE;
> > > +
> > > +	/*
> > > +	 * Set the limit pointer to either the watermark or the
> > > +	 * current tail pointer; whichever comes first.
> > > +	 */
> > > +	if (handle->head + handle->size <= handle->wakeup) {
> > > +		/* The tail is next, so check for wrapping */
> > > +		if (tail >= head) {
> > > +			/*
> > > +			 * No wrapping, but need to align downwards to
> > > +			 * avoid corrupting unconsumed data.
> > > +			 */
> > > +			limit = round_down(tail, PAGE_SIZE);
> > > +
> > > +		}
> > > +	} else if (wakeup >= head) {
> > 
> > When wakeup == head, do we need to signal a wakeup event somehow?
> > Currently we'll pad the buffer, signal truncation, and end output, which
> > seems a little odd, but maybe that's what perf expects.
> 
> Wakeup can never be equal to head here. We know that the wakeup is next (by
> the first if above) and therefore it is within handle->size of head. Since
> we're starting a session, then we either have:
> 
>   1. Wakeup calculated by perf_aux_output_{skip,end}, or
>   2. Wakeup calculated by rb_alloc_aux (initial mmap)
> 
> In case (1), the wakeup will have been signalled when it was calculated to
> be equal to head, and then the wakeup will have been moved to the next
> watermark point. In case (2), the only way it can be equal to head is if
> the watermark was 0, but an initial watermark is converted to half the
> buffer size by the core.
> 
> Admittedly, I'd not realised this at the time (hence the >= check), and it
> looks like we're going to rewrite this anyway :)

Thanks for the explanation; the above is really helpful.

For (2) I agree that after the mmap(), handle->wakeup > handle->head.

For (1), I think that we can hit a case where perf_aux_output_end() will
signal a wakeup, but even after rb->aux_wakeup is moved along, we still
have rb->aux_wakeup <= rb->aux_head.

Rationale for the below; enjoy.

Consider a non-snapshot case where we set up the mmap with aux_watermark
being PAGE_SIZE / 2, and the buffer size being 2 * PAGE_SIZE. Our
initial state of things is:

	rb->aux_head = 0;
	rb->aux_wakeup = 0;
	rb->aux_watermark = PAGE_SIZE / 2;

The first time we start, perf_aux_output_begin() gives us:

	handle->head = 0;
	handle->size = 2 * PAGE_SIZE;
	handle->wakeup = PAGE_SIZE / 2;

Given that, __arm_spe_pmu_next_off() gives us a limit of PAGE_SIZE (both
in your version and mine).

We set SPE off, and it fills PAGE_SIZE worth of buffer, then asserts its
maintenance IRQ. We thus call perf_aux_output_end(handle, PAGE_SIZE),
which adjusts the aux_head, detects we passed wakeup, adjusts the
aux_wakeup, and signals the wakeup:

	local_add(size, &rb->aux_head);
	local_add(rb->aux_watermark, &rb->aux_wakeup);
	...
	perf_output_wakeup(handle);

... leaving us with:

	rb->aux_head = PAGE_SIZE
	rb->aux_wakeup = PAGE_SIZE / 2;
	rb->aux_watermark = PAGE_SIZE / 2;

... so next time we call arm_spe_perf_aux_output_begin() we see:

	handle->head = PAGE_SIZE;
	handle->wakeup = PAGE_SIZE;

So AFAICT, we can see wakeup == head here, though it's arguably the core
code that's at fault. Hopefully I've missed something.

Assuming that above is correct,in either of our __arm_spe_pmu_next_off()
implementations that results in signalling truncation, and calling
perf_aux_output_end(), which will detect another wakeup, and move wakeup
past head. However, as we (spuriously) signalled truncation we end up
stopping.

I think that it would make sense for the perf core to advance the wakeup
beyond head in perf_aux_output_end(), even if this means outputting a
number of wakeup events.

> > > +		/*
> > > +		 * The wakeup is next and doesn't wrap. Align upwards to
> > > +		 * ensure that we do indeed reach the watermark.
> > > +		 */
> > > +		limit = round_up(wakeup, PAGE_SIZE);
> > > +
> > > +		/*
> > > +		 * If rounding up crosses the tail, then we have to
> > > +		 * round down to avoid corrupting unconsumed data.
> > > +		 * Hopefully the tail will have moved by the time we
> > > +		 * hit the new limit.
> > > +		 */
> > > +		if (wakeup < tail && limit > tail)
> > > +			limit = round_down(wakeup, PAGE_SIZE);
> > > +	}
> > 
> > It took me a while to grok that we must consider the wakeup in
> > free-running counter space to avoid early wakeups, while we must
> > consider the tail in ring-buffer offset space to avoid clobbering data.
> > 
> > With that understanding, I think we have an issue here. If wakeup is
> > more than buffer size in the future, and the buffer is empty, I think we
> > set the limit too low.
> > 
> > In that case, we'd evaluate:
> > 
> > 	handle->head + handle->size <= handle->wakeup
> > 
> > ... as true, since size is at most buffer size. Thus we'd go into the
> > first if block. There we'd evaluate:
> 
> If the buffer is empty, then size is exactly buffer size - 1, but I take
> your point.

Heh, I missed that the CIRC_*() helpers  enforced that at least a byte
was always free.

> > 
> > 	tail >= head
> > 
> > ... as true, since when the buffer is empty, head == tail. Thus, we'd
> > set the limit to:
> > 
> > 	round_down(tail, PAGE_SIZE)
> > 
> > ... which'll leave us with limit <= head, since head == tail. Thus,
> > we'll hit the case below:
> > 
> > > +
> > > +	/*
> > > +	 * If rounding down crosses the head, then the buffer is full,
> > > +	 * so pad to tail and end the session.
> > > +	 */
> > > +	if (limit <= head) {
> > > +		memset(buf->base + head, 0, handle->size);
> > > +		perf_aux_output_skip(handle, handle->size);
> > > +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> > > +		perf_aux_output_end(handle, 0);
> > > +		limit = 0;
> > > +	}
> > > +
> > > +	return limit;
> > > +}
> > 
> > ... and end all output, even though the entire buffer was empty, and we
> > could have returned the end of the buffer as the limit.
> > 
> > It might be that something prevents wakeup from being that far in the
> > future, but in previous discussions we'd assumed that it could be any
> > arbitrary value.
> 
> Yes, I think this case does indeed go wrong. Well spotted!
> 
> > I believe we can solve that, and simplify the logic as below. I've left
> > the wakeup < head and wakeup == head cases as above, ignored and
> > terminating respectively.
> 
> I think this mostly works, some suggestions/questions below.
> 
> > static u64 __arm_spe_pmu_next_off(struct perf_output_handle *handle)
> > {
> > 	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
> > 	const u64 bufsize = buf->nr_pages * PAGE_SIZE;
> > 	u64 limit = bufsize;
> > 	u64 head = PERF_IDX2OFF(handle->head, buf);
> > 	u64 tail = PERF_IDX2OFF(handle->head + handle->size, buf);
> > 	u64 wakeup = PERF_IDX2OFF(handle->wakeup, buf);
> > 
> > 	if (!handle->size)
> > 		goto no_space;
> 
> We can avoid the memset/output_skip in this case.

True.

We can move the no_space label if we remove the other goto (by inverting
the condition paired with it and returning limit there instead). i.e.

	if (!handle->size)
		goto no_space;

	< rounding down limit, etc >

	if (limit > head)
		return limit;
	
	/* 
	 * The buffer wasn't completely full, but we can't use the
	 * remaining space. Fill the unusable remainder with padding
	 */
no_space:
	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
	perf_aux_output_end(handle, 0);
	return 0;

> > 	/*
> > 	 * Avoid clobbering unconsumed data. We know we have space, so
> > 	 * if we see head == tail we know that the buffer is empty. If
> > 	 * head > tail, then there's nothing to clobber prior to
> > 	 * wrapping.
> > 	 */
> > 	if (head < tail)
> > 		limit = round_down(tail, PAGE_SIZE);
> > 	
> > 	/*
> > 	 * Wakeup may be arbitrarily far into future. If it's not in the
> > 	 * current generation, either we'll wrap before hitting it, or
> > 	 * it's in the past and has been handled already.
> > 	 *
> > 	 * If there's a wakeup before we wrap, arrange to be woken up by
> > 	 * the page boundary following it. Keep the tail boundary if
> > 	 * that's lower.
> > 	 */
> > 	if ((handle->wakeup / bufsize) == (handle->head / bufsize)) &&
> 
> I'd really like to get rid of these divisions, since we're not working with
> nice powers of 2 here. Can't you just do:
> 
>   handle->wakeup < (handle->head + handle->size)
> 
> to establish that they're in the same "generation"?

I initially thought that, but then realised that would also be true if
wakeup was a "generation" behind. When I wrote this, I wasn't sure if
that could happen, and/or what we should do in that case -- as noted
above I'd retained the fact we ignored wakeup in that case.

Extending my argument from earlier, I think that *can* happen for
certain values of aux_watermark, but we have other problems resulting
from that, and we should try to rule that out in the core code.

> > 	    head <= wakeup)
> > 		limit = min(limit, round_up(wakeup, PAGE_SIZE));
> > 
> > 	if (limit <= head)
> > 		goto no_space;
> 
> Does this correctly handle the case where the buffer is full and head
> == tail, but limit == bufsize? AFAICT, we can return a limit of
> bufsize and corrupt the whole buffer.

When head == tail, handle->size == 0, so at the start of the function
we'd have gone straight to no_space.

So AFAICT, we're fine on that front.

[...]

> > > +static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
> > > +					  struct perf_event *event)
> > > +{

> > > +	write_sysreg_s(base, PMBPTR_EL1);
> > > +	limit += (u64)buf->base;
> > > +
> > 
> > I believe an isb() is necessary here to ensure the write to PMBPTR_EL1
> > occurs before the write to PMBLIMITR_EL1 enables the PMU. Otherwise, the
> > CPU could execute those out-of-order.
> 
> This function is always called in a context where the profiler is disabled
> due to some other control (e.g. in PMSCR or because we're in fault context)
> so the isb isn't necessary.
> 
> > > +out_write_limit:
> > > +	write_sysreg_s(limit, PMBLIMITR_EL1);
> > > +}

Ah, I see. Sorry for the noise.

[...]

> > > +static bool arm_spe_perf_aux_output_end(struct perf_output_handle *handle,
> > > +					struct perf_event *event,
> > > +					bool resume)
> > > +{
> > > +	u64 pmbptr, pmbsr, offset, size;
> > > +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> > > +	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
> > > +	bool truncated;
> > > +
> > > +	/*
> > > +	 * We can be called via IRQ work trying to disable the PMU after
> > > +	 * a buffer full event. In this case, the aux session has already
> > > +	 * been stopped, so there's nothing to do here.
> > > +	 */
> > > +	if (!buf)
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * If there isn't a pending management event and we're not stopping
> > > +	 * the current session, then just leave everything alone.
> > > +	 */
> > > +	pmbsr = read_sysreg_s(PMBSR_EL1);
> > 
> > When we call from arm_spe_pmu_irq_handler(), I think we need
> > synchronisation before reading PMBSR_EL1.
> > 
> > AFAICT from the spec, a context synchronisation event doesn't ensure
> > that the PMU's indirect write to PMBSR_EL1 is visible to the PE's direct
> > read above. I beleive we need a PSB CSYNC (and subsequent ISB) to ensure
> > that.
> 
> I don't think that's right, but the spec isn't completely clear. PSB CSYNC
> is about the profiling data itself, but in this case we've taken an IRQ
> already so the PMBSR will be up-to-date. I'll seek clarification anyway.

Thanks; I'll await this.

> > The only other caller is from arm_spe_pmu_stop(), which first calls
> > arm_spe_pmu_disable_and_drain_local(), so I guess the new barriers
> > should live in arm_spe_pmu_irq_handler(). I'll comment there.
> > 
> > > +	if (!arm_spe_pmu_buffer_mgmt_pending(pmbsr) && resume)
> > > +		return false; /* Spurious IRQ */
> > > +
> > > +	/* Ensure hardware updates to PMBPTR_EL1 are visible */
> > > +	isb();
> > 
> > Can we please move this into arm_spe_pmu_buffer_mgmt_pending(), after
> > the associated PSB CSYNC?
> 
> Hmmm, I deliberately *didn't* do that because I wanted
> arm_spe_pmu_buffer_mgmt_pending to ensure the buffer writes are visible, and
> then the caller can decide if it cares about indirect SPE register writes
> being visible. In reality, I ended up with a single caller, but let's see
> how it looks when I rework it to deal with fatal aborts.

Ok.

> > > +	/*
> > > +	 * Work out how much data has been written since the last update
> > > +	 * to the head index.
> > > +	 */
> > > +	pmbptr = round_down(read_sysreg_s(PMBPTR_EL1), spe_pmu->align);
> > 
> > I don't believe we need to align this.
> > 
> > Per the spec, PMBPTR_EL1[M:0] are RES0 in HW unless sync external abort
> > reporting is present, in which case they're valid. We write these bits
> > as zero, unless we have a bug elsewhere.
> > 
> > ... so either the bits are zero, and we're fine, or an external abourt
> > has been hit. In the external abort case, we have no idea how far we
> > need to reverse the base pointer anyhow.
> 
> As part of the fatal abort handling, I should probably round down to
> max_record_sz (keyed off DL==1, which I don't think can ever happen
> at the moment).

I don't think that's sufficient.

For an async external abort the spec says we cannot assume any valid
data has been written to the buffer when DL==1, so we must throw away
the whole run.

For other cases, it's not clear to me whether PMBPTR_EL1 is guaranteed
to be within max_record_sz of the end of the last complete record. The
spec says that PMBPTR_EL1 might not point at the byte after the last
complete record, and it doesn't say how far beyond this is may be.

Given that the async case is called out specifically, I think the intent
is that it is bounded somehow, but this could do with clarification.

[...]

> > > +	/*
> > > +	 * Either the buffer is full or we're stopping the session. Check
> > > +	 * that we didn't write a partial record, since this can result
> > > +	 * in unparseable trace and we must disable the event.
> > > +	 */
> > > +	if (pmbsr & BIT(PMBSR_EL1_COLL_SHIFT))
> > > +		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> > > +
> > > +	truncated = pmbsr & BIT(PMBSR_EL1_DL_SHIFT);
> > > +	if (truncated)
> > > +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> > > +
> > > +	perf_aux_output_end(handle, size);
> > 
> > The comment block above perf_aux_output_end() says:
> > 
> >   It is the pmu driver's responsibility to observe ordering rules of the
> >   hardware, so that all the data is externally visible before this is
> >   called.
> > 
> > ... but in arm_spe_pmu_buffer_mgmt_pending() we only ensured that the
> > data was visible in the current NSH domain (i.e. only to this CPU).
> > 
> > I followed the callchain for updating head:
> > 
> > perf_aux_output_end()
> > -> perf_event_aux_event()
> > -> perf_output_end()
> > -> perf_output_put_handle()
> > 
> > ... I see that there's an smp_wmb() (i.e. a DMB ISHST) on that path, but
> > it's not clear to me if that's sufficient to ensure that the PMU's
> > writes are made visible to other CPUs.
> 
> With the new memory model, it should be sufficient; the DSB NSH ensures
> data is visible to us locally, and then we order that before the update
> of the ring buffer.
> 
> > Given the comment, I'd feel happier if we had something here or in
> > arm_spe_pmu_buffer_mgmt_pending() to ensure that the PMU's prior writes
> > are visible to other CPUs.
> 
> I could add a comment?

A comment would be great.

> > > +	/*
> > > +	 * If we're not resuming the session, then we can clear the fault
> > > +	 * and we're done, otherwise we need to start a new session.
> > > +	 */
> > > +	if (!resume)
> > > +		write_sysreg_s(0, PMBSR_EL1);
> > > +	else if (!truncated)
> > > +		arm_spe_perf_aux_output_begin(handle, event);
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +/* IRQ handling */
> > > +static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
> > > +{
> > > +	struct perf_output_handle *handle = dev;
> > > +
> > > +	if (!perf_get_aux(handle))
> > > +		return IRQ_NONE;
> > > +
> > > +	if (!arm_spe_perf_aux_output_end(handle, handle->event, true))
> > > +		return IRQ_NONE;
> > 
> > As commented in arm_spe_perf_aux_output_end(), I think we need a
> > psb_csync(); isb() sequence prior to the read of PMBSR_EL1 in
> > arm_spe_perf_aux_output_end() to ensure that it is up-to-date w.r.t. the
> > interrupt.
> 
> As above, I don't agree but am checking this with the architects.

Sure. I'm also hoping that you're correct here!

> > > +	irq_work_run();
> > > +	isb(); /* Ensure the buffer is disabled if data loss has occurred */
> > 
> > What exactly are we synchronising here?
> > 
> > AFAICT, when truncation occurs we don't clear PMBLIMITR_EL1.E, so the
> > buffer is only implicitly disabled by the PMU's indirect write
> > PMBSR_EL1.S, which we must have already synchronised prior to reading
> > PMBSR_EL1.
> 
> When you report truncation to perf_aux_output_end, it eventually (the
> irq_work_run() above) calls back into arm_spe_pmu_stop, and I want to make
> sure we've nobbled the limit pointer.
> 
> It would probably be clearer just to add an ISB to the end of
> arm_spe_pmu_disable_and_drain_local, which goes back to your previous comments
> about the mgmt_pending code.

That would work for me.

> > ... so I can't see why this is necessary.
> > 
> > > +	write_sysreg_s(0, PMBSR_EL1);
> > 
> > ... and regardless, we clear PMBSR_EL1.S here, which'll start the PMU
> > again, even if truncation occured, which I don't think we want.
> > 
> > Can we have arm_spe_perf_aux_output_end() clear PMBLIMITR_EL1.E when
> > truncation occurs?
> 
> Right, that's exactly what happens. It's just highly convoluted.

Thanks; I see what's going on now. What a joy.

> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +/* Perf callbacks */
> > > +static int arm_spe_pmu_event_init(struct perf_event *event)
> > > +{
> > > +	u64 reg;
> > > +	struct perf_event_attr *attr = &event->attr;
> > > +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> > > +
> > > +	/* This is, of course, deeply driver-specific */
> > > +	if (attr->type != event->pmu->type)
> > > +		return -ENOENT;
> > > +
> > > +	if (event->cpu >= 0 &&
> > > +	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
> > > +		return -ENOENT;
> > 
> > We're not rejecting cpu < 0, so I take it we're trying to handle
> > per-task events?
> 
> Yes, like intel-pt does.
> 
> > As I've mentioned before, that case worries me. One thing I've just
> > realised we need to figure out is what happens if attr.inherit is set.
> > The core doesn't reject that, and I suspect we may need to here.
> 
> That's already rejected by perf_mmap.

Ok. Odd that we even allow those events to be created, though.

> > > +	if (arm_spe_event_to_pmsevfr(event) & PMSEVFR_EL1_RES0)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (event->hw.sample_period < spe_pmu->min_period ||
> > > +	    event->hw.sample_period & PMSIRR_EL1_IVAL_MASK)
> > > +		return -EOPNOTSUPP;
> > 
> > As mentioned in the sysreg comments, we need to check the upper 32 bits
> > of the PMSIRR value are zero, so we'll need something like:
> > 
> > 	if (event->hw.sample_period < spe_pmu->min_period)
> > 		return -EOPNOTSUPP;
> > 	
> > 	if (event->hw.sample_period &
> > 	    ~(PMSIRR_EL1_INTERVAL_MASK << PMSIRR_EL1_INTERVAL_SHIFT))
> > 		return -EOPNOTSUPP;
> 
> I wonder if we're actually better off just truncating the interval. That
> way, if the interval is extended in the future, then new software won't
> get an error on older cores.

As above, given the PERF_EVENT_IOC_INTERVAL case, I agree that it's
better to not validate the interval here, and to truncate it as
necessary when installing the event.

> It feels a bit weird putting the max interval in sysfs.

I have no strong feelings either way. Maybe it's useful for the user to
choose a sensible / optimum userspace buffer size?

[...]

> > Does anything prevent this event from being added to a group?
> 
> PERF_PMU_CAP_EXCLUSIVE should take care of that in the core.

So it does. Phew.

[...]

> > > +static void arm_spe_pmu_disable_and_drain_local(void)
> > > +{
> > > +	/* Disable profiling at EL0 and EL1 */
> > > +	write_sysreg_s(0, PMSCR_EL1);
> > > +	isb();
> > > +
> > > +	/* Drain any buffered data */
> > > +	psb_csync();
> > > +	dsb(nsh);
> > > +
> > > +	/* Disable the profiling buffer */
> > > +	write_sysreg_s(0, PMBLIMITR_EL1);
> > 
> > Can't this be done when we clear PMSCR_EL1? Surely buffered data would
> > be written out regardless?
> 
> I think the buffered data could be silently dropped if you did that.

Having looked over the spec again, I think you're correct. Sorry for the
noise.

I'd missed the distinction between disabling sampling and disabling
the buffer into which samples are fed.

> > > +static void *arm_spe_pmu_setup_aux(int cpu, void **pages, int nr_pages,
> > > +				   bool snapshot)
> > > +{
> > > +	int i;
> > > +	struct page **pglist;
> > > +	struct arm_spe_pmu_buf *buf;
> > > +
> > > +	/*
> > > +	 * We require an even number of pages for snapshot mode, so that
> > > +	 * we can effectively treat the buffer as consisting of two equal
> > > +	 * parts and give userspace a fighting chance of getting some
> > > +	 * useful data out of it.
> > > +	 */
> > > +	if (!nr_pages || (snapshot && (nr_pages & 1)))
> > > +		return NULL;
> > 
> > As noted above, we may need to ensure that this is a pwoer of two.
> 
> Sorry, I don't follow. The power-of-two bug was in my IDX2OFF macro, which
> I've fixed. For snapshot mode, we just need an even number of pages.

Sure; with IDX2OFF() fixed the above is sufficient.

> > > +	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, cpu_to_node(cpu));
> > > +	if (!buf)
> > > +		return NULL;
> > > +
> > > +	pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
> > > +	if (!pglist)
> > > +		goto out_free_buf;
> > > +
> > > +	for (i = 0; i < nr_pages; ++i) {
> > > +		struct page *page = virt_to_page(pages[i]);
> > > +
> > > +		if (PagePrivate(page)) {
> > > +			pr_warn("unexpected high-order page for auxbuf!");
> > 
> > It looks like the intel-pt driver expects high-order pages.
> > 
> > What prevents us from seeing those?
> 
> The fact that we don't set the PERF_PMU_CAP_AUX_NO_SG capability. The intel
> driver uses physical address and scatter/gather lists, whereas ours just
> takes virtual addresses for the buffer.
> 
> > Why can't we handle those?
> 
> We never get them, so we don't need to.

Ok.

> > How are these pages pinned? Does the core ensure that?
> 
> Yes, they're GFP_KERNEL pages underneath.

Ok.

> > > +	spe_pmu->pmu = (struct pmu) {
> > > +		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
> > > +		.attr_groups	= arm_spe_pmu_attr_groups,
> > > +		/*
> > > +		 * We hitch a ride on the software context here, so that
> > > +		 * we can support per-task profiling (which is not possible
> > > +		 * with the invalid context as it doesn't get sched callbacks).
> > > +		 * This requires that userspace either uses a dummy event for
> > > +		 * perf_event_open, since the aux buffer is not setup until
> > > +		 * a subsequent mmap, or creates the profiling event in a
> > > +		 * disabled state and explicitly PERF_EVENT_IOC_ENABLEs it
> > > +		 * once the buffer has been created.
> > > +		 */
> > > +		.task_ctx_nr	= perf_sw_context,
> > 
> > While other tracing PMUs do this, I think this is a horrible bodge, and
> > a bad idea, given it violates assumptions made in the core code.
> > 
> > For example, unlike true SW events, add() and start() can fail, so a
> > tracing event can unexpectedly stop SW events from being scheduled.
> > 
> > AFAICT, we could also try to move a tracing event into a later-created
> > HW PMU group, which is very worrying.
> > 
> > I really think we should have a separate tracing context for this class
> > of PMU, or we make it so that the invalid context can receive sched
> > callbacks.
> 
> Fair point, and I already have a comment to call this out. Whilst I'm not
> against seeing this fixed, I think it should be a separate patch series
> given that this is a common idiom amongst system/uncore PMU drivers.

I'll add this to my list of things to look at.

I would like to give this a poke in at least the group attach scenario I
mention above.

Thanks,
Mark.
