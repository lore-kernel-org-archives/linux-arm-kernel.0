From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Aug 2017 17:59:25 +0100
Subject: [PATCH] perf tools: Add ARM Statistical Profiling Extensions
 (SPE) support
In-Reply-To: <20170717194822.81c071a47bc294251dd9fedc@arm.com>
References: <20170621153108.GC6041@arm.com>
 <20170622105640.c444b8b0f16266ba2c3ce304@arm.com>
 <20170622183620.GJ15336@arm.com>
 <20170627160758.cdaebc3e7f0cd88455e07763@arm.com>
 <20170628112601.GD5981@leverpostej>
 <20170628113249.GF5981@leverpostej>
 <20170628201638.01204c14719514217433e82d@arm.com>
 <20170628204310.b45fd92458a2fba810a7520b@arm.com>
 <20170630140240.GB27839@leverpostej>
 <20170717194822.81c071a47bc294251dd9fedc@arm.com>
Message-ID: <20170818165925.GA23083@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kim,

Sorry for the late reply. I see you've send an updated version. I'm
replying here first so as to answer your queries, and I intend to look
at the updated patch shortly.

On Mon, Jul 17, 2017 at 07:48:22PM -0500, Kim Phillips wrote:
> On Fri, 30 Jun 2017 15:02:41 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Jun 28, 2017 at 08:43:10PM -0500, Kim Phillips wrote:
> <snip>
> > >  	if (evlist) {
> > >  		evlist__for_each_entry(evlist, evsel) {
> > >  			if (cs_etm_pmu &&
> > >  			    evsel->attr.type == cs_etm_pmu->type)
> > >  				found_etm = true;
> > > +			if (arm_spe_pmu &&
> > > +			    evsel->attr.type == arm_spe_pmu->type)
> > > +				found_spe = true;
> > 
> > Given ARM_SPE_PMU_NAME is defined as "arm_spe_0", this won't detect all
> > SPE PMUs in heterogeneous setups (e.g. this'll fail to match "arm_spe_1"
> > and so on).
> > 
> > Can we not find all PMUs with a "arm_spe_" prefix?
> > 
> > ... or, taking a step back, do we need some sysfs "class" attribute to
> > identify multi-instance PMUs?
> 
> Since there is one SPE per core, and it looks like the buffer full
> interrupt line is the only difference between the SPE device node
> specification in the device tree, I guess I don't understand why the
> driver doesn't accept a singular "arm_spe" from the tool, and manage
> interrupt handling accordingly.

There are also differences which can be probed from the device, which
are not described in the DT (but are described in sysfs). Some of these
are exposed under sysfs.

There may be further differences in subsequent revisions of the
architecture, too. So the safest bet is to expose them separately, as we
do for other CPU-affine PMUs in heterogeneous systems.

> Also, if a set of CPUs are missing SPE support, and the user doesn't
> explicitly define a CPU affinity to outside that partition, then
> decline to run, stating why.

It's possible for userspace to do this regardless; look for the set of
SPE PMUs, and then look at their masks.

[...]

> > > +	/*
> > > +	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
> > > +	 * must come first.
> > > +	 */
> > > +	perf_evlist__to_front(evlist, arm_spe_evsel);
> > 
> > Huh? *what* needs the auxtrace buffer fd?
> > 
> > This seems really fragile. Can't we store this elsewhere?
> 
> It's copied from the bts code, and the other auxtrace record users do
> the same; it looks like auxtrace record has implicit dependencies on it?

Is it definitely required? What happens if this isn't done?

> > > +static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
> > > +{
> > > +	u64 ts;
> > > +
> > > +	asm volatile ("isb; mrs %0, cntvct_el0" : "=r" (ts));
> > > +
> > > +	return ts;
> > > +}
> > 
> > I do not think it's a good idea to read the counter directly like this.
> > 
> > What is this "reference" intended to be meaningful relative to?
> 
> AFAICT, it's just a nonce the perf tool uses to track unique events,
> and I thought this better than the ETM driver's heavier get-random
> implementation.
> 
> > Why do we need to do this in userspace?
> > 
> > Can we not ask the kernel to output timestamps instead?
> 
> Why?  This gets the job done faster.

I had assumed that this needed to be correlated with the timestamps in
the event.

If this is a nonce, please don't read the counter directly in this way.
It may be trapped/emulated by a higher EL, making it very heavyweight.
The counter is only exposed so that the VDSO can use it, and that will
avoid using it in cases where it is unsafe.

[...]

> > > +static int arm_spe_get_events(const unsigned char *buf, size_t len,
> > > +			      struct arm_spe_pkt *packet)
> > > +{
> > > +	unsigned int events_len = payloadlen(buf[0]);
> > > +
> > > +	if (len < events_len)
> > > +		return ARM_SPE_NEED_MORE_BYTES;
> > 
> > Isn't len the size of the whole buffer? So isn't this failing to account
> > for the header byte?
> 
> well spotted; I changed /events_len/1 + events_len/.
> 
> > > +	packet->type = ARM_SPE_EVENTS;
> > > +	packet->index = events_len;
> > 
> > Huh? The events packet has no "index" field, so why do we need this?
> 
> To identify Events with a less number of comparisons in arm_spe_pkt_desc():
> E.g., the LLC-ACCESS, LLC-REFILL, and REMOTE-ACCESS events are
> identified iff index > 1.

It would be clearer to do the additional comparisons there.

Does this make a measureable difference in practice?

> > > +	switch (events_len) {
> > > +	case 1: packet->payload = *(uint8_t *)(buf + 1); break;
> > > +	case 2: packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1)); break;
> > > +	case 4: packet->payload = le32_to_cpu(*(uint32_t *)(buf + 1)); break;
> > > +	case 8: packet->payload = le64_to_cpu(*(uint64_t *)(buf + 1)); break;
> > > +	default: return ARM_SPE_BAD_PACKET;
> > > +	}
> > > +
> > > +	return 1 + events_len;
> > > +}
> > > +
> > > +static int arm_spe_get_data_source(const unsigned char *buf,
> > > +				   struct arm_spe_pkt *packet)
> > > +{
> > > +	int len = payloadlen(buf[0]);
> > > +
> > > +	packet->type = ARM_SPE_DATA_SOURCE;
> > > +	if (len == 1)
> > > +		packet->payload = buf[1];
> > > +	else if (len == 2)
> > > +		packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
> > > +
> > > +	return 1 + len;
> > > +}
> > 
> > For those packets with a payload, the header has a uniform format
> > describing the payload size. Given that, can't we make the payload
> > extraction generic, regardless of the packet type?
> > 
> > e.g. something like:
> > 
> > static int arm_spe_get_payload(const unsigned char *buf, size_t len,
> > 			       struct arm_spe_pkt *packet)
> > {
> > 	<determine paylaod size>
> > 	<length check>
> > 	<switch>
> > 	<return nr consumed bytes (inc header), or error>
> > }
> > 
> > static int arm_spe_get_events(const unsigned char *buf, size_t len,
> > 			      struct arm_spe_pkt *packet)
> > {
> > 	packet->type = ARM_SPE_EVENTS;
> > 	return arm_spe_get_payload(buf, len, packet);
> > }
> > 
> > static int arm_spe_get_data_source(const unsigned char *buf,
> > 				   struct arm_spe_pkt *packet)
> > {
> > 	packet->type = ARM_SPE_DATA_SOURCE;
> > 	return arm_spe_get_payload(buf, len, packet);
> > }
> > 
> > ... and so on for the other packets with a payload.
> 
> done for TIMESTAMP, EVENTS, DATA_SOURCE, CONTEXT, INSN_TYPE.  It
> wouldn't fit ADDR and COUNTER well since they can occur in an
> extended-header, and their lengths are encoded differently, and are
> fixed anyway.

Ok. That sounds good to me.

[...]

> > > +int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> > > +		     size_t buf_len)
> > > +{
> > > +	int ret, ns, el, index = packet->index;
> > > +	unsigned long long payload = packet->payload;
> > > +	const char *name = arm_spe_pkt_name(packet->type);
> > > +
> > > +	switch (packet->type) {

> > > +	case ARM_SPE_ADDRESS:
> > > +		switch (index) {
> > > +		case 0:
> > > +		case 1: ns = !!(packet->payload & NS_FLAG);
> > > +			el = (packet->payload & EL_FLAG) >> 61;
> > > +			payload &= ~(0xffULL << 56);
> > > +			return snprintf(buf, buf_len, "%s %llx el%d ns=%d",
> > > +				        (index == 1) ? "TGT" : "PC", payload, el, ns);

> > Could we please add a '0x' prefix to hex numbers, and use 0x%016llx so
> > that things get padded consistently?
> 
> I've added the 0x prefix, but prefer to not fix the length to 016: I
> don't see any direct benefit, rather see benefits to having the length
> vary, for output size control and less obvious reasons, e.g., sorting
> address lines by their length to get a sense of address groups caught
> during the run.  FWIW, Intel doesn't do the 016 either.

With padding, sorting will also place address groups together, so I'm
not sure I follow.

Padding makes it *much* easier to scan over the output by eye, as
columns of event data will always share the same alignment.

> If I've omitted a response to the other comments, it's because they
> are being addressed.

Cool!

Thanks,
Mark.
