From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 17 Aug 2017 22:11:50 -0500
Subject: [PATCH v2] perf tools: Add ARM Statistical Profiling Extensions
 (SPE) support
In-Reply-To: <20170717194822.81c071a47bc294251dd9fedc@arm.com>
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
 <20170717194822.81c071a47bc294251dd9fedc@arm.com>
Message-ID: <20170817221150.952211435b9a17bf02fb93c5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Jul 2017 19:48:22 -0500
Kim Phillips <kim.phillips@arm.com> wrote:

> On Fri, 30 Jun 2017 15:02:41 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Hi Kim,
> 
> Hi Mark,
> 
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
> interrupt handling accordingly.  Also, if a set of CPUs are missing SPE
> support, and the user doesn't explicitly define a CPU affinity to
> outside that partition, then decline to run, stating why.
> 
> This would also obviously help a lot from an ease-of-use perspective.
> 
> <snip>
> 
> > > +struct arm_spe_recording {
> > > +	struct auxtrace_record		itr;
> > > +	struct perf_pmu			*arm_spe_pmu;
> > > +	struct perf_evlist		*evlist;
> > > +};
> > 
> > A user may wich to record trace on separate uarches simultaneously, so
> > having a singleton arm_spe_pmu for the entire evlist doesn't seem right.
> > 
> > e.g. I don't see why we should allow a user to do:
> > 
> > ./perf record -c 1024 \
> > 	-e arm_spe_0/ts_enable=1,pa_enable=0/ \
> > 	-e arm_spe_1/ts_enable=1,pa_enable=0/ \
> > 	${WORKLOAD}
> > 
> > ... which perf-record seems to accept today, but I don't seem to get any
> > aux trace, regardless of whether I taskset the entire thing to any
> > particular CPU.
> 
> The implementation-defined components of the SPE don't affect a
> 'record'/capture operation, so a single arm_spe should be fine with
> separate uarch setups.
> 
> > It also seems that the events aren't task bound, judging by -vv output:
> 
> <snip>
> 
> > I see something similar (i.e. perf doesn't try to bind the events to the
> > workload PID) when I try to record with only a single PMU. In that case,
> > perf-record blows up because it can't handle events on a subset of CPUs
> > (though it should be able to):
> > 
> > nanook at torsk:~$ ./perf record -vv -c 1024 -e arm_spe_0/ts_enable=1,pa_enable=0/ true
> 
> <snip>
> 
> > mmap size 266240B
> > AUX area mmap length 131072
> > perf event ring buffer mmapped per cpu
> > failed to mmap AUX area
> > failed to mmap with 524 (INTERNAL ERROR: strerror_r(524, 0xffffc8596038, 512)=22)
> 
> FWIW, that INTERNAL ERROR is fixed by this commit, btw:
> 
> commit 8a1898db51a3390241cd5fae267dc8aaa9db0f8b
> Author: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Date:   Tue Jun 20 12:26:39 2017 +0200
> 
>     perf/aux: Correct return code of rb_alloc_aux() if !has_aux(ev)
> 
> So now it should return:
> 
> failed to mmap with 95 (Operation not supported)
> 
> > ... with a SW event, this works as expected, being bound to the workload PID:
> 
> <snip>
> 
> > ... so I guess this has something to do with the way the tool tries to
> > use the cpumask, maknig the wrong assumption that this implies
> > system-wide collection is mandatory / expected.
> 
> Right, I'll take a look at it.
> 
> > > +	if (!opts->full_auxtrace)
> > > +		return 0;
> > > +
> > > +	/* We are in full trace mode but '-m,xyz' wasn't specified */
> > > +	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
> > > +		if (privileged) {
> > > +			opts->auxtrace_mmap_pages = MiB(4) / page_size;
> > > +		} else {
> > > +			opts->auxtrace_mmap_pages = KiB(128) / page_size;
> > > +			if (opts->mmap_pages == UINT_MAX)
> > > +				opts->mmap_pages = KiB(256) / page_size;
> > > +		}
> > > +	}
> > > +
> > > +	/* Validate auxtrace_mmap_pages */
> > > +	if (opts->auxtrace_mmap_pages) {
> > > +		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
> > > +		size_t min_sz = KiB(8);
> > > +
> > > +		if (sz < min_sz || !is_power_of_2(sz)) {
> > > +			pr_err("Invalid mmap size for ARM SPE: must be at least %zuKiB and a power of 2\n",
> > > +			       min_sz / 1024);
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > > +
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
> 
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
> 
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
> 
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
> 
> > > +static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
> > > +				 struct arm_spe_pkt *packet)
> > > +{
> > > +	unsigned int byte;
> > > +
> > > +	memset(packet, 0, sizeof(struct arm_spe_pkt));
> > > +
> > > +	if (!len)
> > > +		return ARM_SPE_NEED_MORE_BYTES;
> > > +
> > > +	byte = buf[0];
> > > +	if (byte == 0)
> > > +		return arm_spe_get_pad(packet);
> > > +	else if (byte == 1) /* no timestamp at end of record */
> > > +		return arm_spe_get_end(packet);
> > > +	else if (byte & 0xc0 /* 0y11000000 */) {
> > > +		if (byte & 0x80) {
> > > +			/* 0x38 is 0y00111000 */
> > > +			if ((byte & 0x38) == 0x30) /* address packet (short) */
> > > +				return arm_spe_get_addr(buf, len, 0, packet);
> > > +			if ((byte & 0x38) == 0x18) /* counter packet (short) */
> > > +				return arm_spe_get_counter(buf, len, 0, packet);
> > > +		} else
> > > +			if (byte == 0x71)
> > > +				return arm_spe_get_timestamp(buf, len, packet);
> > > +			else if ((byte & 0xf) == 0x2)
> > > +				return arm_spe_get_events(buf, len, packet);
> > > +			else if ((byte & 0xf) == 0x3)
> > > +				return arm_spe_get_data_source(buf, packet);
> > > +			else if ((byte & 0x3c) == 0x24)
> > > +				return arm_spe_get_context(buf, len, packet);
> > > +			else if ((byte & 0x3c) == 0x8)
> > > +				return arm_spe_get_insn_type(buf, packet);
> > 
> > Could we have some mnemonics for these?
> > 
> > e.g.
> > 
> > #define SPE_HEADER0_PAD		0x0
> > #define SPE_HEADER0_END		0x1
> > 
> > #define SPE_HEADER0_EVENTS	0x42
> > #define SPE_HEADER0_EVENTS_MASK	0xcf
> > 
> > if (byte == SPE_HEADER0_PAD) { 
> > 	...
> > } else if (byte == SPE_HEADER0_END) {
> > 	...
> > } else if ((byte & SPE_HEADER0_EVENTS_MASK) == SPE_HEADER0_EVENTS) {
> > 	...
> > }
> > 
> > ... which could even be turned into something table-driven.
> 
> It'd be a pretty sparse table, so I doubt it'd be faster, but if it is,
> I'd just as soon leave that type of space tradeoff decision to the
> compiler, given its optimization directives.
> 
> I'll take a look at replacing the constants that have named equivalents
> with their named versions, even though it was pretty clear already what
> they denoted, given the name of the function each branch was calling,
> and the comments.
> 
> > > +	} else if ((byte & 0xe0) == 0x20 /* 0y00100000 */) {
> > > +		/* 16-bit header */
> > > +		byte = buf[1];
> > > +		if (byte == 0)
> > > +			return arm_spe_get_alignment(buf, len, packet);
> > > +		else if ((byte & 0xf8) == 0xb0)
> > > +			return arm_spe_get_addr(buf, len, 1, packet);
> > > +		else if ((byte & 0xf8) == 0x98)
> > > +			return arm_spe_get_counter(buf, len, 1, packet);
> > > +	}
> > > +
> > > +	return ARM_SPE_BAD_PACKET;
> > > +}
> > > +
> > > +int arm_spe_get_packet(const unsigned char *buf, size_t len,
> > > +		       struct arm_spe_pkt *packet)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = arm_spe_do_get_packet(buf, len, packet);
> > > +	if (ret > 0) {
> > > +		while (ret < 1 && len > (size_t)ret && !buf[ret])
> > > +			ret += 1;
> > > +	}
> > 
> > What is this trying to do?
> 
> Nothing!  I've since fixed it to prevent multiple contiguous
> PADs from coming out on their own lines, and rather accumulate up to 16
> (the width of the raw dump format) on one PAD-labeled line, like so:
> 
> .  00007ec9:  00 00 00 00 00 00 00 00 00 00                   PAD
> 
> instead of this:
> 
> .  00007ec9:  00                                              PAD
> .  00007eca:  00                                              PAD
> .  00007ecb:  00                                              PAD
> .  00007ecc:  00                                              PAD
> .  00007ecd:  00                                              PAD
> .  00007ece:  00                                              PAD
> .  00007ecf:  00                                              PAD
> .  00007ed0:  00                                              PAD
> .  00007ed1:  00                                              PAD
> .  00007ed2:  00                                              PAD
> 
> thanks for pointing it out.
> 
> > > +int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> > > +		     size_t buf_len)
> > > +{
> > > +	int ret, ns, el, index = packet->index;
> > > +	unsigned long long payload = packet->payload;
> > > +	const char *name = arm_spe_pkt_name(packet->type);
> > > +
> > > +	switch (packet->type) {
> > > +	case ARM_SPE_BAD:
> > > +	case ARM_SPE_PAD:
> > > +	case ARM_SPE_END:
> > > +		return snprintf(buf, buf_len, "%s", name);
> > > +	case ARM_SPE_EVENTS: {
> > 
> > [...]
> > 
> > > +	case ARM_SPE_DATA_SOURCE:
> > > +	case ARM_SPE_TIMESTAMP:
> > > +		return snprintf(buf, buf_len, "%s %lld", name, payload);
> > > +	case ARM_SPE_ADDRESS:
> > > +		switch (index) {
> > > +		case 0:
> > > +		case 1: ns = !!(packet->payload & NS_FLAG);
> > > +			el = (packet->payload & EL_FLAG) >> 61;
> > > +			payload &= ~(0xffULL << 56);
> > > +			return snprintf(buf, buf_len, "%s %llx el%d ns=%d",
> > > +				        (index == 1) ? "TGT" : "PC", payload, el, ns);
> > 
> > For TTBR1 addresses, this ends up losing the leading 0xff, giving us
> > invalid addresses, which look odd.
> > 
> > Can we please sign-extend bit 55 so that this gives us valid addresses
> > regardless of TTBR?
> 
> I'll take a look at doing this once I get consistent output from an
> implementation.
> 
> > Could we please add a '0x' prefix to hex numbers, and use 0x%016llx so
> > that things get padded consistently?
> 
> I've added the 0x prefix, but prefer to not fix the length to 016: I
> don't see any direct benefit, rather see benefits to having the length
> vary, for output size control and less obvious reasons, e.g., sorting
> address lines by their length to get a sense of address groups caught
> during the run.  FWIW, Intel doesn't do the 016 either.
> 
> If I've omitted a response to the other comments, it's because they are
> being addressed.

Hi Mark, I've tried to proceed as much as possible without your
response, so if you still have comments to my above comments, please
comment in-line above, otherwise review the v2 patch below?

Thanks,

Kim

>From 464d943dcac15d946863399001174e4dc4e00594 Mon Sep 17 00:00:00 2001
From: Kim Phillips <kim.phillips@arm.com>
Date: Wed, 8 Feb 2017 17:11:57 -0600
Subject: [PATCH v2] perf tools: Add ARM Statistical Profiling Extensions
 (SPE) support

'perf record' and 'perf report --dump-raw-trace' supported in this release

Example usage:

taskset -c 2 ./perf record -C 2 -c 1024 -e arm_spe_0/ts_enable=1,pa_enable=1/ \
		dd if=/dev/zero of=/dev/null count=10000

perf report --dump-raw-trace

Note that the perf.data file is portable, so the report can be run on another
architecture host if necessary.

Output will contain raw SPE data and its textual representation, such as:

0xc7d0 [0x30]: PERF_RECORD_AUXTRACE size: 0x82f70  offset: 0  ref: 0x1e947e88189  idx: 0  tid: -1  cpu: 2
.
. ... ARM SPE data: size 536432 bytes
.  00000000:  4a 01                                           B COND
.  00000002:  b1 00 00 00 00 00 00 00 80                      TGT 0 el0 ns=1
.  0000000b:  42 42                                           RETIRED NOT-TAKEN
.  0000000d:  b0 20 41 c0 ad ff ff 00 80                      PC ffffadc04120 el0 ns=1
.  00000016:  98 00 00                                        LAT 0 TOT
.  00000019:  71 80 3e f7 46 e9 01 00 00                      TS 2101429616256
.  00000022:  49 01                                           ST
.  00000024:  b2 50 bd ba 73 00 80 ff ff                      VA ffff800073babd50
.  0000002d:  b3 50 bd ba f3 00 00 00 80                      PA f3babd50 ns=1
.  00000036:  9a 00 00                                        LAT 0 XLAT
.  00000039:  42 16                                           RETIRED L1D-ACCESS TLB-ACCESS
.  0000003b:  b0 8c b4 1e 08 00 00 ff ff                      PC ff0000081eb48c el3 ns=1
.  00000044:  98 00 00                                        LAT 0 TOT
.  00000047:  71 cc 44 f7 46 e9 01 00 00                      TS 2101429617868
.  00000050:  48 00                                           INSN-OTHER
.  00000052:  42 02                                           RETIRED
.  00000054:  b0 58 54 1f 08 00 00 ff ff                      PC ff0000081f5458 el3 ns=1
.  0000005d:  98 00 00                                        LAT 0 TOT
.  00000060:  71 cc 44 f7 46 e9 01 00 00                      TS 2101429617868
...

Other release notes:

- applies to acme's perf/{core,urgent} branches, likely elsewhere

- Record requires Will's SPE driver, currently undergoing upstream review

- the intel-bts implementation was used as a starting point; its
  min/default/max buffer sizes and power of 2 pages granularity need to be
  revisited for ARM SPE

- multiple SPE clusters/domains support pending potential driver changes?

- snapshot support (record -S), and conversion to native perf events
  (e.g., via 'perf inject --itrace'), are still in development

- technically both cs-etm and spe can be used simultaneously, however
  disabled for simplicity in this release

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
v2: mostly addressing Mark Rutland's comments as much as possible without his
feedback to my feedback:

- decoder refactored with a get_payload, not extended to with-ext_len ones like
  get_addr,  named the constants

- 0x-ified %x output formats, but decided to not sign extend the addresses in
  the raw dump, rather do so if necessary in the synthesis stage:
  SPE implementations differ in this area, and raw dump should reflect that.

- CPU mask / new record behaviour bisected to commit e3ba76deef23064 "perf
  tools: Force uncore events to system wide monitoring".  Waiting to hear back
  on why driver can't do system wide monitoring, even across PPIs, by e.g.,
  sharing the SPE interrupts in one handler (SPE's don't differ in this record
  regard).

- addressed off-list comment from M. Williams:
  "Instruction Type" packet was renamed as "Operation Type".
   so in the spe packet decoder: INSN_TYPE -> OP_TYPE

- do_get_packet fixed to handle excessive, successive PADding from a new source
  of raw SPE data, so instead of:

	.  000011ae:  00                                              PAD
	.  000011af:  00                                              PAD
	.  000011b0:  00                                              PAD
	.  000011b1:  00                                              PAD
	.  000011b2:  00                                              PAD
	.  000011b3:  00                                              PAD
	.  000011b4:  00                                              PAD
	.  000011b5:  00                                              PAD
	.  000011b6:  00                                              PAD

  we now get:

	.  000011ae:  00 00 00 00 00 00 00 00 00                      PAD

- fixed 52 00 00 decoded with an empty events clause, adding 'EV' for all events
  clauses now.  parser writers can detect for empty event clauses by finding
  nothing after it.

- patch available and rebased on top of linux-will.git/perf/spe's
  latest, including an attempt to use David Howell's prctl work:

	https://patchwork.kernel.org/patch/9786501/

  to make the driver more communicative to users, here:

	http://www.linux-arm.org/git?p=linux-kp.git;a=shortlog;h=refs/heads/spe-prctl
  or 
	git://linux-arm.org/linux-kp.git  # spe-prctl branch

 tools/perf/arch/arm/util/auxtrace.c   |  20 +-
 tools/perf/arch/arm/util/pmu.c        |   3 +
 tools/perf/arch/arm64/util/Build      |   3 +-
 tools/perf/arch/arm64/util/arm-spe.c  | 210 +++++++++++++++
 tools/perf/util/Build                 |   2 +
 tools/perf/util/arm-spe-pkt-decoder.c | 464 ++++++++++++++++++++++++++++++++++
 tools/perf/util/arm-spe-pkt-decoder.h |  52 ++++
 tools/perf/util/arm-spe.c             | 318 +++++++++++++++++++++++
 tools/perf/util/arm-spe.h             |  39 +++
 tools/perf/util/auxtrace.c            |   3 +
 tools/perf/util/auxtrace.h            |   1 +
 11 files changed, 1111 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/arm-spe.c
 create mode 100644 tools/perf/util/arm-spe-pkt-decoder.c
 create mode 100644 tools/perf/util/arm-spe-pkt-decoder.h
 create mode 100644 tools/perf/util/arm-spe.c
 create mode 100644 tools/perf/util/arm-spe.h

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 8edf2cb71564..ec071609e8ac 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -22,29 +22,43 @@
 #include "../../util/evlist.h"
 #include "../../util/pmu.h"
 #include "cs-etm.h"
+#include "arm-spe.h"
 
 struct auxtrace_record
 *auxtrace_record__init(struct perf_evlist *evlist, int *err)
 {
-	struct perf_pmu	*cs_etm_pmu;
+	struct perf_pmu	*cs_etm_pmu, *arm_spe_pmu;
 	struct perf_evsel *evsel;
-	bool found_etm = false;
+	bool found_etm = false, found_spe = false;
 
 	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
+	arm_spe_pmu = perf_pmu__find(ARM_SPE_PMU_NAME);
 
 	if (evlist) {
 		evlist__for_each_entry(evlist, evsel) {
 			if (cs_etm_pmu &&
 			    evsel->attr.type == cs_etm_pmu->type)
 				found_etm = true;
+			if (arm_spe_pmu &&
+			    evsel->attr.type == arm_spe_pmu->type)
+				found_spe = true;
 		}
 	}
 
+	if (found_etm && found_spe) {
+		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
+		*err = -EOPNOTSUPP;
+		return NULL;
+	}
+
 	if (found_etm)
 		return cs_etm_record_init(err);
 
+	if (found_spe)
+		return arm_spe_recording_init(err);
+
 	/*
-	 * Clear 'err' even if we haven't found a cs_etm event - that way perf
+	 * Clear 'err' even if we haven't found an event - that way perf
 	 * record can still be used even if tracers aren't present.  The NULL
 	 * return value will take care of telling the infrastructure HW tracing
 	 * isn't available.
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 98d67399a0d6..71fb8f13b40a 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -20,6 +20,7 @@
 #include <linux/perf_event.h>
 
 #include "cs-etm.h"
+#include "arm-spe.h"
 #include "../../util/pmu.h"
 
 struct perf_event_attr
@@ -31,6 +32,8 @@ struct perf_event_attr
 		pmu->selectable = true;
 		pmu->set_drv_config = cs_etm_set_drv_config;
 	}
+	if (!strcmp(pmu->name, ARM_SPE_PMU_NAME))
+		pmu->selectable = true;
 #endif
 	return NULL;
 }
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index cef6fb38d17e..f9969bb88ccb 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -3,4 +3,5 @@ libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 
 libperf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
 			      ../../arm/util/auxtrace.o \
-			      ../../arm/util/cs-etm.o
+			      ../../arm/util/cs-etm.o \
+			      arm-spe.o
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
new file mode 100644
index 000000000000..0b37f364bd62
--- /dev/null
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -0,0 +1,210 @@
+/*
+ * ARM Statistical Profiling Extensions (SPE) support
+ * Copyright (c) 2017, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+
+#include "../../util/cpumap.h"
+#include "../../util/evsel.h"
+#include "../../util/evlist.h"
+#include "../../util/session.h"
+#include "../../util/util.h"
+#include "../../util/pmu.h"
+#include "../../util/debug.h"
+#include "../../util/tsc.h"
+#include "../../util/auxtrace.h"
+#include "../../util/arm-spe.h"
+
+#define KiB(x) ((x) * 1024)
+#define MiB(x) ((x) * 1024 * 1024)
+
+struct arm_spe_recording {
+	struct auxtrace_record		itr;
+	struct perf_pmu			*arm_spe_pmu;
+	struct perf_evlist		*evlist;
+};
+
+static size_t
+arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+			 struct perf_evlist *evlist __maybe_unused)
+{
+	return ARM_SPE_AUXTRACE_PRIV_SIZE;
+}
+
+static int arm_spe_info_fill(struct auxtrace_record *itr,
+			       struct perf_session *session,
+			       struct auxtrace_info_event *auxtrace_info,
+			       size_t priv_size)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
+
+	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
+		return -EINVAL;
+
+	if (!session->evlist->nr_mmaps)
+		return -EINVAL;
+
+	auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
+	auxtrace_info->priv[ARM_SPE_PMU_TYPE] = arm_spe_pmu->type;
+
+	return 0;
+}
+
+static int arm_spe_recording_options(struct auxtrace_record *itr,
+				       struct perf_evlist *evlist,
+				       struct record_opts *opts)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
+	struct perf_evsel *evsel, *arm_spe_evsel = NULL;
+	const struct cpu_map *cpus = evlist->cpus;
+	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	struct perf_evsel *tracking_evsel;
+	int err;
+
+	sper->evlist = evlist;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->attr.type == arm_spe_pmu->type) {
+			if (arm_spe_evsel) {
+				pr_err("There may be only one " ARM_SPE_PMU_NAME " event\n");
+				return -EINVAL;
+			}
+			evsel->attr.freq = 0;
+			evsel->attr.sample_period = 1;
+			arm_spe_evsel = evsel;
+			opts->full_auxtrace = true;
+		}
+	}
+
+	if (!opts->full_auxtrace)
+		return 0;
+
+	/* We are in full trace mode but '-m,xyz' wasn't specified */
+	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
+		if (privileged) {
+			opts->auxtrace_mmap_pages = MiB(4) / page_size;
+		} else {
+			opts->auxtrace_mmap_pages = KiB(128) / page_size;
+			if (opts->mmap_pages == UINT_MAX)
+				opts->mmap_pages = KiB(256) / page_size;
+		}
+	}
+
+	/* Validate auxtrace_mmap_pages */
+	if (opts->auxtrace_mmap_pages) {
+		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
+		size_t min_sz = KiB(8);
+
+		if (sz < min_sz || !is_power_of_2(sz)) {
+			pr_err("Invalid mmap size for ARM SPE: must be@least %zuKiB and a power of 2\n",
+			       min_sz / 1024);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	perf_evlist__to_front(evlist, arm_spe_evsel);
+
+	/*
+	 * In the case of per-cpu mmaps, we need the CPU on the
+	 * AUX event.
+	 */
+	if (!cpu_map__empty(cpus))
+		perf_evsel__set_sample_bit(arm_spe_evsel, CPU);
+
+	/* Add dummy event to keep tracking */
+	err = parse_events(evlist, "dummy:u", NULL);
+	if (err)
+		return err;
+
+	tracking_evsel = perf_evlist__last(evlist);
+	perf_evlist__set_tracking_event(evlist, tracking_evsel);
+
+	tracking_evsel->attr.freq = 0;
+	tracking_evsel->attr.sample_period = 1;
+
+	/* In per-cpu case, always need the time of mmap events etc */
+	if (!cpu_map__empty(cpus))
+		perf_evsel__set_sample_bit(tracking_evsel, TIME);
+
+	return 0;
+}
+
+static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
+{
+	u64 ts;
+
+	asm volatile ("isb; mrs %0, cntvct_el0" : "=r" (ts));
+
+	return ts;
+}
+
+static void arm_spe_recording_free(struct auxtrace_record *itr)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+
+       free(sper);
+}
+
+static int arm_spe_read_finish(struct auxtrace_record *itr, int idx)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct perf_evsel *evsel;
+
+	evlist__for_each_entry(sper->evlist, evsel) {
+		if (evsel->attr.type == sper->arm_spe_pmu->type)
+			return perf_evlist__enable_event_idx(sper->evlist,
+							     evsel, idx);
+	}
+	return -EINVAL;
+}
+
+struct auxtrace_record *arm_spe_recording_init(int *err)
+{
+	struct perf_pmu *arm_spe_pmu = perf_pmu__find(ARM_SPE_PMU_NAME);
+	struct arm_spe_recording *sper;
+
+	if (!arm_spe_pmu) {
+		*err = -ENODEV;
+		return NULL;
+	}
+
+	sper = zalloc(sizeof(struct arm_spe_recording));
+	if (!sper) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	sper->arm_spe_pmu = arm_spe_pmu;
+	sper->itr.recording_options = arm_spe_recording_options;
+	sper->itr.info_priv_size = arm_spe_info_priv_size;
+	sper->itr.info_fill = arm_spe_info_fill;
+	sper->itr.free = arm_spe_recording_free;
+	sper->itr.reference = arm_spe_reference;
+	sper->itr.read_finish = arm_spe_read_finish;
+	sper->itr.alignment = 0;
+	return &sper->itr;
+}
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 79dea95a7f68..4ed31e88b8ee 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -82,6 +82,8 @@ libperf-$(CONFIG_AUXTRACE) += auxtrace.o
 libperf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 libperf-$(CONFIG_AUXTRACE) += intel-pt.o
 libperf-$(CONFIG_AUXTRACE) += intel-bts.o
+libperf-$(CONFIG_AUXTRACE) += arm-spe.o
+libperf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
 libperf-y += parse-branch-options.o
 libperf-y += dump-insn.o
 libperf-y += parse-regs-options.o
diff --git a/tools/perf/util/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-pkt-decoder.c
new file mode 100644
index 000000000000..aeae921dd79d
--- /dev/null
+++ b/tools/perf/util/arm-spe-pkt-decoder.c
@@ -0,0 +1,464 @@
+/*
+ * ARM Statistical Profiling Extensions (SPE) support
+ * Copyright (c) 2017, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <endian.h>
+#include <byteswap.h>
+
+#include "arm-spe-pkt-decoder.h"
+
+#define BIT(n)		(1 << (n))
+
+#define BIT61		((uint64_t)1 << 61)
+#define BIT62		((uint64_t)1 << 62)
+#define BIT63		((uint64_t)1 << 63)
+
+#define NS_FLAG		BIT63
+#define EL_FLAG		(BIT62 | BIT61)
+
+#define SPE_HEADER0_PAD			0x0
+#define SPE_HEADER0_END			0x1
+#define SPE_HEADER0_ADDRESS		0x30 /* address packet (short) */
+#define SPE_HEADER0_ADDRESS_MASK	0x38
+#define SPE_HEADER0_COUNTER		0x18 /* counter packet (short) */
+#define SPE_HEADER0_COUNTER_MASK	0x38
+#define SPE_HEADER0_TIMESTAMP		0x71
+#define SPE_HEADER0_TIMESTAMP		0x71
+#define SPE_HEADER0_EVENTS		0x2
+#define SPE_HEADER0_EVENTS_MASK		0xf
+#define SPE_HEADER0_SOURCE		0x3
+#define SPE_HEADER0_SOURCE_MASK		0xf
+#define SPE_HEADER0_CONTEXT		0x24
+#define SPE_HEADER0_CONTEXT_MASK	0x3c
+#define SPE_HEADER0_OP_TYPE		0x8
+#define SPE_HEADER0_OP_TYPE_MASK	0x3c
+#define SPE_HEADER1_ALIGNMENT		0x0
+#define SPE_HEADER1_ADDRESS		0xb0 /* address packet (extended) */
+#define SPE_HEADER1_ADDRESS_MASK	0xf8
+#define SPE_HEADER1_COUNTER		0x98 /* counter packet (extended) */
+#define SPE_HEADER1_COUNTER_MASK	0xf8
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+#define le16_to_cpu bswap_16
+#define le32_to_cpu bswap_32
+#define le64_to_cpu bswap_64
+#define memcpy_le64(d, s, n) do { \
+	memcpy((d), (s), (n));    \
+	*(d) = le64_to_cpu(*(d)); \
+} while (0)
+#else
+#define le16_to_cpu
+#define le32_to_cpu
+#define le64_to_cpu
+#define memcpy_le64 memcpy
+#endif
+
+static const char * const arm_spe_packet_name[] = {
+	[ARM_SPE_PAD]		= "PAD",
+	[ARM_SPE_END]		= "END",
+	[ARM_SPE_TIMESTAMP]	= "TS",
+	[ARM_SPE_ADDRESS]	= "ADDR",
+	[ARM_SPE_COUNTER]	= "LAT",
+	[ARM_SPE_CONTEXT]	= "CONTEXT",
+	[ARM_SPE_OP_TYPE]	= "OP-TYPE",
+	[ARM_SPE_EVENTS]	= "EVENTS",
+	[ARM_SPE_DATA_SOURCE]	= "DATA-SOURCE",
+};
+
+const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
+{
+	return arm_spe_packet_name[type];
+}
+
+/* return ARM SPE payload size from its encoding:
+ * 00 : byte
+ * 01 : halfword (2)
+ * 10 : word (4)
+ * 11 : doubleword (8)
+ */
+static int payloadlen(unsigned char byte)
+{
+	return 1 << ((byte & 0x30) >> 4);
+}
+
+static int arm_spe_get_payload(const unsigned char *buf, size_t len,
+			       struct arm_spe_pkt *packet)
+{
+	size_t payload_len = payloadlen(buf[0]);
+
+	if (len < 1 + payload_len)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	switch (payload_len) {
+	case 1: packet->payload = *(uint8_t *)(buf + 1); break;
+	case 2: packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1)); break;
+	case 4: packet->payload = le32_to_cpu(*(uint32_t *)(buf + 1)); break;
+	case 8: packet->payload = le64_to_cpu(*(uint64_t *)(buf + 1)); break;
+	default: return ARM_SPE_BAD_PACKET;
+	}
+
+	return 1 + payload_len;
+}
+
+static int arm_spe_get_pad(struct arm_spe_pkt *packet)
+{
+	packet->type = ARM_SPE_PAD;
+	return 1;
+}
+
+static int arm_spe_get_alignment(const unsigned char *buf, size_t len,
+				 struct arm_spe_pkt *packet)
+{
+	unsigned int alignment = 1 << ((buf[0] & 0xf) + 1);
+
+	if (len < alignment)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	packet->type = ARM_SPE_PAD;
+	return alignment - (((uint64_t)buf) & (alignment - 1));
+}
+
+static int arm_spe_get_end(struct arm_spe_pkt *packet)
+{
+	packet->type = ARM_SPE_END;
+	return 1;
+}
+
+static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
+				 struct arm_spe_pkt *packet)
+{
+	packet->type = ARM_SPE_TIMESTAMP;
+	return arm_spe_get_payload(buf, len, packet);
+}
+
+static int arm_spe_get_events(const unsigned char *buf, size_t len,
+			      struct arm_spe_pkt *packet)
+{
+	int ret = arm_spe_get_payload(buf, len, packet);
+
+	packet->type = ARM_SPE_EVENTS;
+	packet->index = ret - 1;
+
+	return ret;
+}
+
+static int arm_spe_get_data_source(const unsigned char *buf, size_t len,
+				   struct arm_spe_pkt *packet)
+{
+	packet->type = ARM_SPE_DATA_SOURCE;
+	return arm_spe_get_payload(buf, len, packet);
+}
+
+static int arm_spe_get_context(const unsigned char *buf, size_t len,
+			       struct arm_spe_pkt *packet)
+{
+	packet->type = ARM_SPE_CONTEXT;
+	packet->index = buf[0] & 0x3;
+
+	return arm_spe_get_payload(buf, len, packet);
+}
+
+static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
+			       struct arm_spe_pkt *packet)
+{
+	packet->type = ARM_SPE_OP_TYPE;
+	packet->index = buf[0] & 0x3;
+	return arm_spe_get_payload(buf, len, packet);
+}
+
+static int arm_spe_get_counter(const unsigned char *buf, size_t len,
+			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
+{
+	if (len < 2)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	packet->type = ARM_SPE_COUNTER;
+	if (ext_hdr)
+		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+	else
+		packet->index = buf[0] & 0x7;
+
+	packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
+
+	return 1 + ext_hdr + 2;
+}
+
+static int arm_spe_get_addr(const unsigned char *buf, size_t len,
+			    const unsigned char ext_hdr, struct arm_spe_pkt *packet)
+{
+	if (len < 8)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	packet->type = ARM_SPE_ADDRESS;
+	if (ext_hdr)
+		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+	else
+		packet->index = buf[0] & 0x7;
+
+	memcpy_le64(&packet->payload, buf + 1, 8);
+
+	return 1 + ext_hdr + 8;
+}
+
+static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
+				 struct arm_spe_pkt *packet)
+{
+	unsigned int byte;
+
+	memset(packet, 0, sizeof(struct arm_spe_pkt));
+
+	if (!len)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	byte = buf[0];
+	if (byte == SPE_HEADER0_PAD)
+		return arm_spe_get_pad(packet);
+	else if (byte == SPE_HEADER0_END) /* no timestamp at end of record */
+		return arm_spe_get_end(packet);
+	else if (byte & 0xc0 /* 0y11xxxxxx */) {
+		if (byte & 0x80) {
+			if ((byte & SPE_HEADER0_ADDRESS_MASK) == SPE_HEADER0_ADDRESS)
+				return arm_spe_get_addr(buf, len, 0, packet);
+			if ((byte & SPE_HEADER0_COUNTER_MASK) == SPE_HEADER0_COUNTER)
+				return arm_spe_get_counter(buf, len, 0, packet);
+		} else
+			if (byte == SPE_HEADER0_TIMESTAMP)
+				return arm_spe_get_timestamp(buf, len, packet);
+			else if ((byte & SPE_HEADER0_EVENTS_MASK) == SPE_HEADER0_EVENTS)
+				return arm_spe_get_events(buf, len, packet);
+			else if ((byte & SPE_HEADER0_SOURCE_MASK) == SPE_HEADER0_SOURCE)
+				return arm_spe_get_data_source(buf, len, packet);
+			else if ((byte & SPE_HEADER0_CONTEXT_MASK) == SPE_HEADER0_CONTEXT)
+				return arm_spe_get_context(buf, len, packet);
+			else if ((byte & SPE_HEADER0_OP_TYPE_MASK) == SPE_HEADER0_OP_TYPE)
+				return arm_spe_get_op_type(buf, len, packet);
+	} else if ((byte & 0xe0) == 0x20 /* 0y001xxxxx */) {
+		/* 16-bit header */ 
+		byte = buf[1];
+		if (byte == SPE_HEADER1_ALIGNMENT)
+			return arm_spe_get_alignment(buf, len, packet);
+		else if ((byte & SPE_HEADER1_ADDRESS_MASK) == SPE_HEADER1_ADDRESS)
+			return arm_spe_get_addr(buf, len, 1, packet);
+		else if ((byte & SPE_HEADER1_COUNTER_MASK) == SPE_HEADER1_COUNTER)
+			return arm_spe_get_counter(buf, len, 1, packet);
+	}
+
+	return ARM_SPE_BAD_PACKET;
+}
+
+int arm_spe_get_packet(const unsigned char *buf, size_t len,
+		       struct arm_spe_pkt *packet)
+{
+	int ret;
+
+	ret = arm_spe_do_get_packet(buf, len, packet);
+	if (ret > 0 && packet->type == ARM_SPE_PAD) {
+		while (ret < 16 && len > (size_t)ret && !buf[ret])
+			ret += 1;
+	}
+	return ret;
+}
+
+int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
+		     size_t buf_len)
+{
+	int ret, ns, el, index = packet->index;
+	unsigned long long payload = packet->payload;
+	const char *name = arm_spe_pkt_name(packet->type);
+
+	switch (packet->type) {
+	case ARM_SPE_BAD:
+	case ARM_SPE_PAD:
+	case ARM_SPE_END:
+		return snprintf(buf, buf_len, "%s", name);
+	case ARM_SPE_EVENTS: {
+		size_t blen = buf_len;
+
+		ret = 0;
+		ret = snprintf(buf, buf_len, "EV");
+		buf += ret;
+		blen -= ret;
+		if (payload & 0x1) {
+			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x2) {
+			ret = snprintf(buf, buf_len, " RETIRED");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x4) {
+			ret = snprintf(buf, buf_len, " L1D-ACCESS");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x8) {
+			ret = snprintf(buf, buf_len, " L1D-REFILL");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x10) {
+			ret = snprintf(buf, buf_len, " TLB-ACCESS");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x20) {
+			ret = snprintf(buf, buf_len, " TLB-REFILL");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x40) {
+			ret = snprintf(buf, buf_len, " NOT-TAKEN");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x80) {
+			ret = snprintf(buf, buf_len, " MISPRED");
+			buf += ret;
+			blen -= ret;
+		}
+		if (index > 1) {
+			if (payload & 0x100) {
+				ret = snprintf(buf, buf_len, " LLC-ACCESS");
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & 0x200) {
+				ret = snprintf(buf, buf_len, " LLC-REFILL");
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & 0x400) {
+				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
+				buf += ret;
+				blen -= ret;
+			}
+		}
+		if (ret < 0)
+			return ret;
+		blen -= ret;
+		return buf_len - blen;
+	}
+	case ARM_SPE_OP_TYPE:
+		switch (index) {
+		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
+					"COND-SELECT" : "INSN-OTHER");
+		case 1:	{
+			size_t blen = buf_len;
+
+			if (payload & 0x1)
+				ret = snprintf(buf, buf_len, "ST");
+			else
+				ret = snprintf(buf, buf_len, "LD");
+			buf += ret;
+			blen -= ret;
+			if (payload & 0x2) {
+				if (payload & 0x4) {
+					ret = snprintf(buf, buf_len, " AT");
+					buf += ret;
+					blen -= ret;
+				}
+				if (payload & 0x8) {
+					ret = snprintf(buf, buf_len, " EXCL");
+					buf += ret;
+					blen -= ret;
+				}
+				if (payload & 0x10) {
+					ret = snprintf(buf, buf_len, " AR");
+					buf += ret;
+					blen -= ret;
+				}
+			} else if (payload & 0x4) {
+				ret = snprintf(buf, buf_len, " SIMD-FP");
+				buf += ret;
+				blen -= ret;
+			}
+			if (ret < 0)
+				return ret;
+			blen -= ret;
+			return buf_len - blen;
+		}
+		case 2:	{
+			size_t blen = buf_len;
+
+			ret = snprintf(buf, buf_len, "B");
+			buf += ret;
+			blen -= ret;
+			if (payload & 0x1) {
+				ret = snprintf(buf, buf_len, " COND");
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & 0x2) {
+				ret = snprintf(buf, buf_len, " IND");
+				buf += ret;
+				blen -= ret;
+			}
+			if (ret < 0)
+				return ret;
+			blen -= ret;
+			return buf_len - blen;
+			}
+		default: return 0;
+		}
+	case ARM_SPE_DATA_SOURCE:
+	case ARM_SPE_TIMESTAMP:
+		return snprintf(buf, buf_len, "%s %lld", name, payload);
+	case ARM_SPE_ADDRESS:
+		switch (index) {
+		case 0:
+		case 1: ns = !!(packet->payload & NS_FLAG);
+			el = (packet->payload & EL_FLAG) >> 61;
+			payload &= ~(0xffULL << 56);
+			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
+				        (index == 1) ? "TGT" : "PC", payload, el, ns);
+		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
+		case 3:	ns = !!(packet->payload & NS_FLAG);
+			payload &= ~(0xffULL << 56);
+			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
+					payload, ns);
+		default: return 0;
+		}
+	case ARM_SPE_CONTEXT:
+		return snprintf(buf, buf_len, "%s 0x%lx el%d", name,
+				(unsigned long)payload, index + 1);
+	case ARM_SPE_COUNTER: {
+		size_t blen = buf_len;
+
+		ret = snprintf(buf, buf_len, "%s %d ", name,
+			       (unsigned short)payload);
+		buf += ret;
+		blen -= ret;
+		switch (index) {
+		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
+		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
+		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
+		default: ret = 0;
+		}
+		if (ret < 0)
+			return ret;
+		blen -= ret;
+		return buf_len - blen;
+	}
+	default:
+		break;
+	}
+
+	return snprintf(buf, buf_len, "%s 0x%llx (%d)",
+			name, payload, packet->index);
+}
+
diff --git a/tools/perf/util/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-pkt-decoder.h
new file mode 100644
index 000000000000..f146f4143447
--- /dev/null
+++ b/tools/perf/util/arm-spe-pkt-decoder.h
@@ -0,0 +1,52 @@
+/*
+ * ARM Statistical Profiling Extensions (SPE) support
+ * Copyright (c) 2017, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef INCLUDE__ARM_SPE_PKT_DECODER_H__
+#define INCLUDE__ARM_SPE_PKT_DECODER_H__
+
+#include <stddef.h>
+#include <stdint.h>
+
+#define ARM_SPE_PKT_DESC_MAX		256
+
+#define ARM_SPE_NEED_MORE_BYTES		-1
+#define ARM_SPE_BAD_PACKET		-2
+
+enum arm_spe_pkt_type {
+	ARM_SPE_BAD,
+	ARM_SPE_PAD,
+	ARM_SPE_END,
+	ARM_SPE_TIMESTAMP,
+	ARM_SPE_ADDRESS,
+	ARM_SPE_COUNTER,
+	ARM_SPE_CONTEXT,
+	ARM_SPE_OP_TYPE,
+	ARM_SPE_EVENTS,
+	ARM_SPE_DATA_SOURCE,
+};
+
+struct arm_spe_pkt {
+	enum arm_spe_pkt_type	type;
+	unsigned char		index;
+	uint64_t		payload;
+};
+
+const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
+
+int arm_spe_get_packet(const unsigned char *buf, size_t len,
+		       struct arm_spe_pkt *packet);
+
+int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, size_t len);
+#endif
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
new file mode 100644
index 000000000000..f3eccd73b54a
--- /dev/null
+++ b/tools/perf/util/arm-spe.c
@@ -0,0 +1,318 @@
+/*
+ * ARM Statistical Profiling Extensions (SPE) support
+ * Copyright (c) 2017, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <endian.h>
+#include <errno.h>
+#include <byteswap.h>
+#include <inttypes.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+
+#include "cpumap.h"
+#include "color.h"
+#include "evsel.h"
+#include "evlist.h"
+#include "machine.h"
+#include "session.h"
+#include "util.h"
+#include "thread.h"
+#include "debug.h"
+#include "auxtrace.h"
+#include "arm-spe.h"
+#include "arm-spe-pkt-decoder.h"
+
+struct arm_spe {
+	struct auxtrace			auxtrace;
+	struct auxtrace_queues		queues;
+	struct auxtrace_heap		heap;
+	u32				auxtrace_type;
+	struct perf_session		*session;
+	struct machine			*machine;
+	u32				pmu_type;
+};
+
+struct arm_spe_queue {
+	struct arm_spe		*spe;
+	unsigned int		queue_nr;
+	struct auxtrace_buffer	*buffer;
+	bool			on_heap;
+	bool			done;
+	pid_t			pid;
+	pid_t			tid;
+	int			cpu;
+};
+
+static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
+			   unsigned char *buf, size_t len)
+{
+	struct arm_spe_pkt packet;
+	size_t pos = 0;
+	int ret, pkt_len, i;
+	char desc[ARM_SPE_PKT_DESC_MAX];
+	const char *color = PERF_COLOR_BLUE;
+
+	color_fprintf(stdout, color,
+		      ". ... ARM SPE data: size %zu bytes\n",
+		      len);
+
+	while (len) {
+		ret = arm_spe_get_packet(buf, len, &packet);
+		if (ret > 0)
+			pkt_len = ret;
+		else
+			pkt_len = 1;
+		printf(".");
+		color_fprintf(stdout, color, "  %08x: ", pos);
+		for (i = 0; i < pkt_len; i++)
+			color_fprintf(stdout, color, " %02x", buf[i]);
+		for (; i < 16; i++)
+			color_fprintf(stdout, color, "   ");
+		if (ret > 0) {
+			ret = arm_spe_pkt_desc(&packet, desc,
+					       ARM_SPE_PKT_DESC_MAX);
+			if (ret > 0)
+				color_fprintf(stdout, color, " %s\n", desc);
+		} else {
+			color_fprintf(stdout, color, " Bad packet!\n");
+		}
+		pos += pkt_len;
+		buf += pkt_len;
+		len -= pkt_len;
+	}
+}
+
+static void arm_spe_dump_event(struct arm_spe *spe, unsigned char *buf,
+				 size_t len)
+{
+	printf(".\n");
+	arm_spe_dump(spe, buf, len);
+}
+
+static struct arm_spe_queue *arm_spe_alloc_queue(struct arm_spe *spe,
+						     unsigned int queue_nr)
+{
+	struct arm_spe_queue *speq;
+
+	speq = zalloc(sizeof(struct arm_spe_queue));
+	if (!speq)
+		return NULL;
+
+	speq->spe = spe;
+	speq->queue_nr = queue_nr;
+	speq->pid = -1;
+	speq->tid = -1;
+	speq->cpu = -1;
+
+	return speq;
+}
+
+static int arm_spe_setup_queue(struct arm_spe *spe,
+				 struct auxtrace_queue *queue,
+				 unsigned int queue_nr)
+{
+	struct arm_spe_queue *speq = queue->priv;
+
+	if (list_empty(&queue->head))
+		return 0;
+
+	if (!speq) {
+		speq = arm_spe_alloc_queue(spe, queue_nr);
+		if (!speq)
+			return -ENOMEM;
+		queue->priv = speq;
+
+		if (queue->cpu != -1)
+			speq->cpu = queue->cpu;
+		speq->tid = queue->tid;
+	}
+
+	if (!speq->on_heap && !speq->buffer) {
+		int ret;
+
+		speq->buffer = auxtrace_buffer__next(queue, NULL);
+		if (!speq->buffer)
+			return 0;
+
+		ret = auxtrace_heap__add(&spe->heap, queue_nr,
+					 speq->buffer->reference);
+		if (ret)
+			return ret;
+		speq->on_heap = true;
+	}
+
+	return 0;
+}
+
+static int arm_spe_setup_queues(struct arm_spe *spe)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < spe->queues.nr_queues; i++) {
+		ret = arm_spe_setup_queue(spe, &spe->queues.queue_array[i],
+					    i);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static inline int arm_spe_update_queues(struct arm_spe *spe)
+{
+	if (spe->queues.new_data) {
+		spe->queues.new_data = false;
+		return arm_spe_setup_queues(spe);
+	}
+	return 0;
+}
+
+static int arm_spe_process_event(struct perf_session *session __maybe_unused,
+				   union perf_event *event __maybe_unused,
+				   struct perf_sample *sample __maybe_unused,
+				   struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int arm_spe_process_auxtrace_event(struct perf_session *session,
+					    union perf_event *event,
+					    struct perf_tool *tool __maybe_unused)
+{
+	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe,
+					     auxtrace);
+	struct auxtrace_buffer *buffer;
+	off_t data_offset;
+	int fd = perf_data_file__fd(session->file);
+	int err;
+
+	if (perf_data_file__is_pipe(session->file)) {
+		data_offset = 0;
+	} else {
+		data_offset = lseek(fd, 0, SEEK_CUR);
+		if (data_offset == -1)
+			return -errno;
+	}
+
+	err = auxtrace_queues__add_event(&spe->queues, session, event,
+					 data_offset, &buffer);
+	if (err)
+		return err;
+
+	/* Dump here now we have copied a piped trace out of the pipe */
+	if (dump_trace) {
+		if (auxtrace_buffer__get_data(buffer, fd)) {
+			arm_spe_dump_event(spe, buffer->data,
+					     buffer->size);
+			auxtrace_buffer__put_data(buffer);
+		}
+	}
+
+	return 0;
+}
+
+static int arm_spe_flush(struct perf_session *session __maybe_unused,
+			   struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void arm_spe_free_queue(void *priv)
+{
+	struct arm_spe_queue *speq = priv;
+
+	if (!speq)
+		return;
+	free(speq);
+}
+
+static void arm_spe_free_events(struct perf_session *session)
+{
+	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe,
+					     auxtrace);
+	struct auxtrace_queues *queues = &spe->queues;
+	unsigned int i;
+
+	for (i = 0; i < queues->nr_queues; i++) {
+		arm_spe_free_queue(queues->queue_array[i].priv);
+		queues->queue_array[i].priv = NULL;
+	}
+	auxtrace_queues__free(queues);
+}
+
+static void arm_spe_free(struct perf_session *session)
+{
+	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe,
+					     auxtrace);
+
+	auxtrace_heap__free(&spe->heap);
+	arm_spe_free_events(session);
+	session->auxtrace = NULL;
+	free(spe);
+}
+
+static const char * const arm_spe_info_fmts[] = {
+	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
+};
+
+static void arm_spe_print_info(u64 *arr)
+{
+	if (!dump_trace)
+		return;
+
+	fprintf(stdout, arm_spe_info_fmts[ARM_SPE_PMU_TYPE], arr[ARM_SPE_PMU_TYPE]);
+}
+
+int arm_spe_process_auxtrace_info(union perf_event *event,
+				    struct perf_session *session)
+{
+	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
+	size_t min_sz = sizeof(u64) * ARM_SPE_PMU_TYPE;
+	struct arm_spe *spe;
+	int err;
+
+	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event) +
+					min_sz)
+		return -EINVAL;
+
+	spe = zalloc(sizeof(struct arm_spe));
+	if (!spe)
+		return -ENOMEM;
+
+	err = auxtrace_queues__init(&spe->queues);
+	if (err)
+		goto err_free;
+
+	spe->session = session;
+	spe->machine = &session->machines.host; /* No kvm support */
+	spe->auxtrace_type = auxtrace_info->type;
+	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+
+	spe->auxtrace.process_event = arm_spe_process_event;
+	spe->auxtrace.process_auxtrace_event = arm_spe_process_auxtrace_event;
+	spe->auxtrace.flush_events = arm_spe_flush;
+	spe->auxtrace.free_events = arm_spe_free_events;
+	spe->auxtrace.free = arm_spe_free;
+	session->auxtrace = &spe->auxtrace;
+
+	arm_spe_print_info(&auxtrace_info->priv[0]);
+
+	return 0;
+
+err_free:
+	free(spe);
+	return err;
+}
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
new file mode 100644
index 000000000000..afa4704c5e5e
--- /dev/null
+++ b/tools/perf/util/arm-spe.h
@@ -0,0 +1,39 @@
+/*
+ * ARM Statistical Profiling Extensions (SPE) support
+ * Copyright (c) 2017, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef INCLUDE__PERF_ARM_SPE_H__
+#define INCLUDE__PERF_ARM_SPE_H__
+
+#define ARM_SPE_PMU_NAME "arm_spe_0"
+
+enum {
+	ARM_SPE_PMU_TYPE,
+	ARM_SPE_PER_CPU_MMAPS,
+	ARM_SPE_AUXTRACE_PRIV_MAX,
+};
+
+#define ARM_SPE_AUXTRACE_PRIV_SIZE (ARM_SPE_AUXTRACE_PRIV_MAX * sizeof(u64))
+
+struct auxtrace_record;
+struct perf_tool;
+union perf_event;
+struct perf_session;
+
+struct auxtrace_record *arm_spe_recording_init(int *err);
+
+int arm_spe_process_auxtrace_info(union perf_event *event,
+				  struct perf_session *session);
+
+#endif
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 5547457566a7..92da3981a761 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -57,6 +57,7 @@
 
 #include "intel-pt.h"
 #include "intel-bts.h"
+#include "arm-spe.h"
 
 #include "sane_ctype.h"
 #include "symbol/kallsyms.h"
@@ -913,6 +914,8 @@ int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
 		return intel_pt_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_INTEL_BTS:
 		return intel_bts_process_auxtrace_info(event, session);
+	case PERF_AUXTRACE_ARM_SPE:
+		return arm_spe_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_CS_ETM:
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 33b5e6cdf38c..fa1c8deffac4 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -43,6 +43,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_INTEL_PT,
 	PERF_AUXTRACE_INTEL_BTS,
 	PERF_AUXTRACE_CS_ETM,
+	PERF_AUXTRACE_ARM_SPE,
 };
 
 enum itrace_period_type {
-- 
2.11.0
