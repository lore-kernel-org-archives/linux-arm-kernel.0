From: kim.phillips@arm.com (Kim Phillips)
Date: Mon, 17 Jul 2017 19:48:22 -0500
Subject: [PATCH] perf tools: Add ARM Statistical Profiling Extensions
 (SPE) support
In-Reply-To: <20170630140240.GB27839@leverpostej>
References: <20170612112048.69561e8d067488e8689de755@arm.com>
 <20170615105735.b89183a9190a261d3b8d132a@arm.com>
 <20170621153108.GC6041@arm.com>
 <20170622105640.c444b8b0f16266ba2c3ce304@arm.com>
 <20170622183620.GJ15336@arm.com>
 <20170627160758.cdaebc3e7f0cd88455e07763@arm.com>
 <20170628112601.GD5981@leverpostej>
 <20170628113249.GF5981@leverpostej>
 <20170628201638.01204c14719514217433e82d@arm.com>
 <20170628204310.b45fd92458a2fba810a7520b@arm.com>
 <20170630140240.GB27839@leverpostej>
Message-ID: <20170717194822.81c071a47bc294251dd9fedc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Jun 2017 15:02:41 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Kim,

Hi Mark,

> On Wed, Jun 28, 2017 at 08:43:10PM -0500, Kim Phillips wrote:
<snip>
> >  	if (evlist) {
> >  		evlist__for_each_entry(evlist, evsel) {
> >  			if (cs_etm_pmu &&
> >  			    evsel->attr.type == cs_etm_pmu->type)
> >  				found_etm = true;
> > +			if (arm_spe_pmu &&
> > +			    evsel->attr.type == arm_spe_pmu->type)
> > +				found_spe = true;
> 
> Given ARM_SPE_PMU_NAME is defined as "arm_spe_0", this won't detect all
> SPE PMUs in heterogeneous setups (e.g. this'll fail to match "arm_spe_1"
> and so on).
> 
> Can we not find all PMUs with a "arm_spe_" prefix?
> 
> ... or, taking a step back, do we need some sysfs "class" attribute to
> identify multi-instance PMUs?

Since there is one SPE per core, and it looks like the buffer full
interrupt line is the only difference between the SPE device node
specification in the device tree, I guess I don't understand why the
driver doesn't accept a singular "arm_spe" from the tool, and manage
interrupt handling accordingly.  Also, if a set of CPUs are missing SPE
support, and the user doesn't explicitly define a CPU affinity to
outside that partition, then decline to run, stating why.

This would also obviously help a lot from an ease-of-use perspective.

<snip>

> > +struct arm_spe_recording {
> > +	struct auxtrace_record		itr;
> > +	struct perf_pmu			*arm_spe_pmu;
> > +	struct perf_evlist		*evlist;
> > +};
> 
> A user may wich to record trace on separate uarches simultaneously, so
> having a singleton arm_spe_pmu for the entire evlist doesn't seem right.
> 
> e.g. I don't see why we should allow a user to do:
> 
> ./perf record -c 1024 \
> 	-e arm_spe_0/ts_enable=1,pa_enable=0/ \
> 	-e arm_spe_1/ts_enable=1,pa_enable=0/ \
> 	${WORKLOAD}
> 
> ... which perf-record seems to accept today, but I don't seem to get any
> aux trace, regardless of whether I taskset the entire thing to any
> particular CPU.

The implementation-defined components of the SPE don't affect a
'record'/capture operation, so a single arm_spe should be fine with
separate uarch setups.

> It also seems that the events aren't task bound, judging by -vv output:

<snip>

> I see something similar (i.e. perf doesn't try to bind the events to the
> workload PID) when I try to record with only a single PMU. In that case,
> perf-record blows up because it can't handle events on a subset of CPUs
> (though it should be able to):
> 
> nanook at torsk:~$ ./perf record -vv -c 1024 -e arm_spe_0/ts_enable=1,pa_enable=0/ true

<snip>

> mmap size 266240B
> AUX area mmap length 131072
> perf event ring buffer mmapped per cpu
> failed to mmap AUX area
> failed to mmap with 524 (INTERNAL ERROR: strerror_r(524, 0xffffc8596038, 512)=22)

FWIW, that INTERNAL ERROR is fixed by this commit, btw:

commit 8a1898db51a3390241cd5fae267dc8aaa9db0f8b
Author: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Date:   Tue Jun 20 12:26:39 2017 +0200

    perf/aux: Correct return code of rb_alloc_aux() if !has_aux(ev)

So now it should return:

failed to mmap with 95 (Operation not supported)

> ... with a SW event, this works as expected, being bound to the workload PID:

<snip>

> ... so I guess this has something to do with the way the tool tries to
> use the cpumask, maknig the wrong assumption that this implies
> system-wide collection is mandatory / expected.

Right, I'll take a look at it.

> > +	if (!opts->full_auxtrace)
> > +		return 0;
> > +
> > +	/* We are in full trace mode but '-m,xyz' wasn't specified */
> > +	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
> > +		if (privileged) {
> > +			opts->auxtrace_mmap_pages = MiB(4) / page_size;
> > +		} else {
> > +			opts->auxtrace_mmap_pages = KiB(128) / page_size;
> > +			if (opts->mmap_pages == UINT_MAX)
> > +				opts->mmap_pages = KiB(256) / page_size;
> > +		}
> > +	}
> > +
> > +	/* Validate auxtrace_mmap_pages */
> > +	if (opts->auxtrace_mmap_pages) {
> > +		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
> > +		size_t min_sz = KiB(8);
> > +
> > +		if (sz < min_sz || !is_power_of_2(sz)) {
> > +			pr_err("Invalid mmap size for ARM SPE: must be at least %zuKiB and a power of 2\n",
> > +			       min_sz / 1024);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
> > +	 * must come first.
> > +	 */
> > +	perf_evlist__to_front(evlist, arm_spe_evsel);
> 
> Huh? *what* needs the auxtrace buffer fd?
> 
> This seems really fragile. Can't we store this elsewhere?

It's copied from the bts code, and the other auxtrace record users do
the same; it looks like auxtrace record has implicit dependencies on it?

> > +static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
> > +{
> > +	u64 ts;
> > +
> > +	asm volatile ("isb; mrs %0, cntvct_el0" : "=r" (ts));
> > +
> > +	return ts;
> > +}
> 
> I do not think it's a good idea to read the counter directly like this.
> 
> What is this "reference" intended to be meaningful relative to?

AFAICT, it's just a nonce the perf tool uses to track unique events,
and I thought this better than the ETM driver's heavier get-random
implementation.

> Why do we need to do this in userspace?
> 
> Can we not ask the kernel to output timestamps instead?

Why?  This gets the job done faster.

> > +static int arm_spe_get_events(const unsigned char *buf, size_t len,
> > +			      struct arm_spe_pkt *packet)
> > +{
> > +	unsigned int events_len = payloadlen(buf[0]);
> > +
> > +	if (len < events_len)
> > +		return ARM_SPE_NEED_MORE_BYTES;
> 
> Isn't len the size of the whole buffer? So isn't this failing to account
> for the header byte?

well spotted; I changed /events_len/1 + events_len/.

> > +	packet->type = ARM_SPE_EVENTS;
> > +	packet->index = events_len;
> 
> Huh? The events packet has no "index" field, so why do we need this?

To identify Events with a less number of comparisons in arm_spe_pkt_desc():
E.g., the LLC-ACCESS, LLC-REFILL, and REMOTE-ACCESS events are
identified iff index > 1.

> > +	switch (events_len) {
> > +	case 1: packet->payload = *(uint8_t *)(buf + 1); break;
> > +	case 2: packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1)); break;
> > +	case 4: packet->payload = le32_to_cpu(*(uint32_t *)(buf + 1)); break;
> > +	case 8: packet->payload = le64_to_cpu(*(uint64_t *)(buf + 1)); break;
> > +	default: return ARM_SPE_BAD_PACKET;
> > +	}
> > +
> > +	return 1 + events_len;
> > +}
> > +
> > +static int arm_spe_get_data_source(const unsigned char *buf,
> > +				   struct arm_spe_pkt *packet)
> > +{
> > +	int len = payloadlen(buf[0]);
> > +
> > +	packet->type = ARM_SPE_DATA_SOURCE;
> > +	if (len == 1)
> > +		packet->payload = buf[1];
> > +	else if (len == 2)
> > +		packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
> > +
> > +	return 1 + len;
> > +}
> 
> For those packets with a payload, the header has a uniform format
> describing the payload size. Given that, can't we make the payload
> extraction generic, regardless of the packet type?
> 
> e.g. something like:
> 
> static int arm_spe_get_payload(const unsigned char *buf, size_t len,
> 			       struct arm_spe_pkt *packet)
> {
> 	<determine paylaod size>
> 	<length check>
> 	<switch>
> 	<return nr consumed bytes (inc header), or error>
> }
> 
> static int arm_spe_get_events(const unsigned char *buf, size_t len,
> 			      struct arm_spe_pkt *packet)
> {
> 	packet->type = ARM_SPE_EVENTS;
> 	return arm_spe_get_payload(buf, len, packet);
> }
> 
> static int arm_spe_get_data_source(const unsigned char *buf,
> 				   struct arm_spe_pkt *packet)
> {
> 	packet->type = ARM_SPE_DATA_SOURCE;
> 	return arm_spe_get_payload(buf, len, packet);
> }
> 
> ... and so on for the other packets with a payload.

done for TIMESTAMP, EVENTS, DATA_SOURCE, CONTEXT, INSN_TYPE.  It
wouldn't fit ADDR and COUNTER well since they can occur in an
extended-header, and their lengths are encoded differently, and are
fixed anyway.

> > +static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
> > +				 struct arm_spe_pkt *packet)
> > +{
> > +	unsigned int byte;
> > +
> > +	memset(packet, 0, sizeof(struct arm_spe_pkt));
> > +
> > +	if (!len)
> > +		return ARM_SPE_NEED_MORE_BYTES;
> > +
> > +	byte = buf[0];
> > +	if (byte == 0)
> > +		return arm_spe_get_pad(packet);
> > +	else if (byte == 1) /* no timestamp at end of record */
> > +		return arm_spe_get_end(packet);
> > +	else if (byte & 0xc0 /* 0y11000000 */) {
> > +		if (byte & 0x80) {
> > +			/* 0x38 is 0y00111000 */
> > +			if ((byte & 0x38) == 0x30) /* address packet (short) */
> > +				return arm_spe_get_addr(buf, len, 0, packet);
> > +			if ((byte & 0x38) == 0x18) /* counter packet (short) */
> > +				return arm_spe_get_counter(buf, len, 0, packet);
> > +		} else
> > +			if (byte == 0x71)
> > +				return arm_spe_get_timestamp(buf, len, packet);
> > +			else if ((byte & 0xf) == 0x2)
> > +				return arm_spe_get_events(buf, len, packet);
> > +			else if ((byte & 0xf) == 0x3)
> > +				return arm_spe_get_data_source(buf, packet);
> > +			else if ((byte & 0x3c) == 0x24)
> > +				return arm_spe_get_context(buf, len, packet);
> > +			else if ((byte & 0x3c) == 0x8)
> > +				return arm_spe_get_insn_type(buf, packet);
> 
> Could we have some mnemonics for these?
> 
> e.g.
> 
> #define SPE_HEADER0_PAD		0x0
> #define SPE_HEADER0_END		0x1
> 
> #define SPE_HEADER0_EVENTS	0x42
> #define SPE_HEADER0_EVENTS_MASK	0xcf
> 
> if (byte == SPE_HEADER0_PAD) { 
> 	...
> } else if (byte == SPE_HEADER0_END) {
> 	...
> } else if ((byte & SPE_HEADER0_EVENTS_MASK) == SPE_HEADER0_EVENTS) {
> 	...
> }
> 
> ... which could even be turned into something table-driven.

It'd be a pretty sparse table, so I doubt it'd be faster, but if it is,
I'd just as soon leave that type of space tradeoff decision to the
compiler, given its optimization directives.

I'll take a look at replacing the constants that have named equivalents
with their named versions, even though it was pretty clear already what
they denoted, given the name of the function each branch was calling,
and the comments.

> > +	} else if ((byte & 0xe0) == 0x20 /* 0y00100000 */) {
> > +		/* 16-bit header */
> > +		byte = buf[1];
> > +		if (byte == 0)
> > +			return arm_spe_get_alignment(buf, len, packet);
> > +		else if ((byte & 0xf8) == 0xb0)
> > +			return arm_spe_get_addr(buf, len, 1, packet);
> > +		else if ((byte & 0xf8) == 0x98)
> > +			return arm_spe_get_counter(buf, len, 1, packet);
> > +	}
> > +
> > +	return ARM_SPE_BAD_PACKET;
> > +}
> > +
> > +int arm_spe_get_packet(const unsigned char *buf, size_t len,
> > +		       struct arm_spe_pkt *packet)
> > +{
> > +	int ret;
> > +
> > +	ret = arm_spe_do_get_packet(buf, len, packet);
> > +	if (ret > 0) {
> > +		while (ret < 1 && len > (size_t)ret && !buf[ret])
> > +			ret += 1;
> > +	}
> 
> What is this trying to do?

Nothing!  I've since fixed it to prevent multiple contiguous
PADs from coming out on their own lines, and rather accumulate up to 16
(the width of the raw dump format) on one PAD-labeled line, like so:

.  00007ec9:  00 00 00 00 00 00 00 00 00 00                   PAD

instead of this:

.  00007ec9:  00                                              PAD
.  00007eca:  00                                              PAD
.  00007ecb:  00                                              PAD
.  00007ecc:  00                                              PAD
.  00007ecd:  00                                              PAD
.  00007ece:  00                                              PAD
.  00007ecf:  00                                              PAD
.  00007ed0:  00                                              PAD
.  00007ed1:  00                                              PAD
.  00007ed2:  00                                              PAD

thanks for pointing it out.

> > +int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> > +		     size_t buf_len)
> > +{
> > +	int ret, ns, el, index = packet->index;
> > +	unsigned long long payload = packet->payload;
> > +	const char *name = arm_spe_pkt_name(packet->type);
> > +
> > +	switch (packet->type) {
> > +	case ARM_SPE_BAD:
> > +	case ARM_SPE_PAD:
> > +	case ARM_SPE_END:
> > +		return snprintf(buf, buf_len, "%s", name);
> > +	case ARM_SPE_EVENTS: {
> 
> [...]
> 
> > +	case ARM_SPE_DATA_SOURCE:
> > +	case ARM_SPE_TIMESTAMP:
> > +		return snprintf(buf, buf_len, "%s %lld", name, payload);
> > +	case ARM_SPE_ADDRESS:
> > +		switch (index) {
> > +		case 0:
> > +		case 1: ns = !!(packet->payload & NS_FLAG);
> > +			el = (packet->payload & EL_FLAG) >> 61;
> > +			payload &= ~(0xffULL << 56);
> > +			return snprintf(buf, buf_len, "%s %llx el%d ns=%d",
> > +				        (index == 1) ? "TGT" : "PC", payload, el, ns);
> 
> For TTBR1 addresses, this ends up losing the leading 0xff, giving us
> invalid addresses, which look odd.
> 
> Can we please sign-extend bit 55 so that this gives us valid addresses
> regardless of TTBR?

I'll take a look at doing this once I get consistent output from an
implementation.

> Could we please add a '0x' prefix to hex numbers, and use 0x%016llx so
> that things get padded consistently?

I've added the 0x prefix, but prefer to not fix the length to 016: I
don't see any direct benefit, rather see benefits to having the length
vary, for output size control and less obvious reasons, e.g., sorting
address lines by their length to get a sense of address groups caught
during the run.  FWIW, Intel doesn't do the 016 either.

If I've omitted a response to the other comments, it's because they are
being addressed.

Thanks!

Kim
