From: kim.phillips@arm.com (Kim Phillips)
Date: Fri, 18 Aug 2017 17:22:48 -0500
Subject: [PATCH] perf tools: Add ARM Statistical Profiling Extensions
 (SPE) support
In-Reply-To: <20170818165925.GA23083@leverpostej>
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
 <20170818165925.GA23083@leverpostej>
Message-ID: <20170818172248.3453ba81809d9ff454f87b34@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Aug 2017 17:59:25 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Mon, Jul 17, 2017 at 07:48:22PM -0500, Kim Phillips wrote:
> > On Fri, 30 Jun 2017 15:02:41 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Wed, Jun 28, 2017 at 08:43:10PM -0500, Kim Phillips wrote:
> > <snip>
> > > >  	if (evlist) {
> > > >  		evlist__for_each_entry(evlist, evsel) {
> > > >  			if (cs_etm_pmu &&
> > > >  			    evsel->attr.type == cs_etm_pmu->type)
> > > >  				found_etm = true;
> > > > +			if (arm_spe_pmu &&
> > > > +			    evsel->attr.type == arm_spe_pmu->type)
> > > > +				found_spe = true;
> > > 
> > > Given ARM_SPE_PMU_NAME is defined as "arm_spe_0", this won't detect all
> > > SPE PMUs in heterogeneous setups (e.g. this'll fail to match "arm_spe_1"
> > > and so on).
> > > 
> > > Can we not find all PMUs with a "arm_spe_" prefix?
> > > 
> > > ... or, taking a step back, do we need some sysfs "class" attribute to
> > > identify multi-instance PMUs?
> > 
> > Since there is one SPE per core, and it looks like the buffer full
> > interrupt line is the only difference between the SPE device node
> > specification in the device tree, I guess I don't understand why the
> > driver doesn't accept a singular "arm_spe" from the tool, and manage
> > interrupt handling accordingly.
> 
> There are also differences which can be probed from the device, which

The only thing I see is PMSIDR fields describing things like minimum
recommended sampling interval.  So if CPU A's SPE has that as 256, and
CPU B's is 512, then deny the user asking for a 256 interval across the
two CPUs.  Or, better yet, issue a warning stating the driver has raised
the interval to the lowest common denominator of all CPU SPEs involved
(512 in the above case).

> are not described in the DT (but are described in sysfs). Some of these
> are exposed under sysfs.
> 
> There may be further differences in subsequent revisions of the
> architecture, too.

Future SPE lowest common denominator rules can be amended
according to the capabilities of the new system.

> So the safest bet is to expose them separately, as we
> do for other CPU-affine PMUs in heterogeneous systems.

Yes, perf is very hard to use on heterogeneous systems for this reason.
Cycles are cycles, it doesn't matter whether they're on an A53 or an
A72.

Meanwhile, this type of driver behaviour - and the fact that the drivers
are mute - hurts usability in heterogeneous environments, and can
easily be avoided.

> > Also, if a set of CPUs are missing SPE support, and the user doesn't
> > explicitly define a CPU affinity to outside that partition, then
> > decline to run, stating why.
> 
> It's possible for userspace to do this regardless; look for the set of
> SPE PMUs, and then look at their masks.

The driver still has to check if what the user is asking for, is
doable.  They also may not be using the perf tool.

> > > > +	/*
> > > > +	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
> > > > +	 * must come first.
> > > > +	 */
> > > > +	perf_evlist__to_front(evlist, arm_spe_evsel);
> > > 
> > > Huh? *what* needs the auxtrace buffer fd?
> > > 
> > > This seems really fragile. Can't we store this elsewhere?
> > 
> > It's copied from the bts code, and the other auxtrace record users do
> > the same; it looks like auxtrace record has implicit dependencies on it?
> 
> Is it definitely required? What happens if this isn't done?

It says it wouldn't obtain the auxtrace buffer file descriptor.

> > > > +static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
> > > > +{
> > > > +	u64 ts;
> > > > +
> > > > +	asm volatile ("isb; mrs %0, cntvct_el0" : "=r" (ts));
> > > > +
> > > > +	return ts;
> > > > +}
> > > 
> > > I do not think it's a good idea to read the counter directly like this.
> > > 
> > > What is this "reference" intended to be meaningful relative to?
> > 
> > AFAICT, it's just a nonce the perf tool uses to track unique events,
> > and I thought this better than the ETM driver's heavier get-random
> > implementation.
> > 
> > > Why do we need to do this in userspace?
> > > 
> > > Can we not ask the kernel to output timestamps instead?
> > 
> > Why?  This gets the job done faster.
> 
> I had assumed that this needed to be correlated with the timestamps in
> the event.
> 
> If this is a nonce, please don't read the counter directly in this way.
> It may be trapped/emulated by a higher EL, making it very heavyweight.
> The counter is only exposed so that the VDSO can use it, and that will
> avoid using it in cases where it is unsafe.

Got it, thanks.

> > > > +	packet->type = ARM_SPE_EVENTS;
> > > > +	packet->index = events_len;
> > > 
> > > Huh? The events packet has no "index" field, so why do we need this?
> > 
> > To identify Events with a less number of comparisons in arm_spe_pkt_desc():
> > E.g., the LLC-ACCESS, LLC-REFILL, and REMOTE-ACCESS events are
> > identified iff index > 1.
> 
> It would be clearer to do the additional comparisons there.
> 
> Does this make a measureable difference in practice?

It should - I'll add a comment.

> > > > +int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> > > > +		     size_t buf_len)
> > > > +{
> > > > +	int ret, ns, el, index = packet->index;
> > > > +	unsigned long long payload = packet->payload;
> > > > +	const char *name = arm_spe_pkt_name(packet->type);
> > > > +
> > > > +	switch (packet->type) {
> 
> > > > +	case ARM_SPE_ADDRESS:
> > > > +		switch (index) {
> > > > +		case 0:
> > > > +		case 1: ns = !!(packet->payload & NS_FLAG);
> > > > +			el = (packet->payload & EL_FLAG) >> 61;
> > > > +			payload &= ~(0xffULL << 56);
> > > > +			return snprintf(buf, buf_len, "%s %llx el%d ns=%d",
> > > > +				        (index == 1) ? "TGT" : "PC", payload, el, ns);
> 
> > > Could we please add a '0x' prefix to hex numbers, and use 0x%016llx so
> > > that things get padded consistently?
> > 
> > I've added the 0x prefix, but prefer to not fix the length to 016: I
> > don't see any direct benefit, rather see benefits to having the length
> > vary, for output size control and less obvious reasons, e.g., sorting
> > address lines by their length to get a sense of address groups caught
> > during the run.  FWIW, Intel doesn't do the 016 either.
> 
> With padding, sorting will also place address groups together, so I'm
> not sure I follow.

sorting by *line length* can be done to easily assess the address
groups in a dump:

$ grep -w PC dump | awk '{ print length, $0 }' | sort -nu
77 .  00000080:  b0 00 00 00 00 00 00 00 a0                      PC 0x0 el1 ns=1
82 .  00000000:  b0 94 61 43 00 00 00 00 80                      PC 0x436194 el0 ns=1
88 .  00000000:  b0 50 20 ac a7 ff ff 00 80                      PC 0xffffa7ac2050 el0 ns=1
89 .  00000040:  b0 80 2d 08 08 00 00 01 a0                      PC 0x1000008082d80 el1 ns=1

> Padding makes it *much* easier to scan over the output by eye, as
> columns of event data will always share the same alignment.

Addresses are already technically misaligned by virtue of their being
prepended with "PC" (2 chars) vs. "TGT" (3 chars):

82 .  00000000:  b0 94 61 43 00 00 00 00 80                      PC 0x436194 el0 ns=1
83 .  0000001e:  b1 68 61 43 00 00 00 00 80                      TGT 0x436168 el0 ns=1

89 .  00000040:  b0 80 2d 08 08 00 00 01 a0                      PC 0x1000008082d80 el1 ns=1
91 .  000005de:  b1 ec 9a 92 08 00 00 ff a0                      TGT 0xff000008929aec el1 ns=1

If you're talking about the postpended "elX ns=Y", well, that less
significant given the variable length is more quickly detected by the
eye - giving the astute reader hints of which execution level the
address is in - and can be parsed using variable length delimeters.

OTOH, we can rename the tokens, e.g., 

current PC  -> {NS,SE}EL{0,1,2,3}PC 0xAAAA
current TGT -> {NS,SE}EL{0,1,2,3}BT 0xAAAA

Where "BT" -> "Branch Target", which admittedly is less obvious to the
uninitiated.

So the last sample above would be:

89 .  00000040:  b0 80 2d 08 08 00 00 01 a0                      NSEL1PC 0x1000008082d80
91 .  000005de:  b1 ec 9a 92 08 00 00 ff a0                      NSEL1BT 0xff000008929aec

Is that better though?

Are there others opinionated here?

I'll get to the v2 review comments later.

Thanks for your feedback!

Kim
