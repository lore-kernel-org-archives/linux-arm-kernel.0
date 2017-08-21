From: kim.phillips@arm.com (Kim Phillips)
Date: Mon, 21 Aug 2017 18:18:21 -0500
Subject: [PATCH v2] perf tools: Add ARM Statistical Profiling Extensions
 (SPE) support
In-Reply-To: <20170818173609.GB23083@leverpostej>
References: <20170622105640.c444b8b0f16266ba2c3ce304@arm.com>
 <20170622183620.GJ15336@arm.com>
 <20170627160758.cdaebc3e7f0cd88455e07763@arm.com>
 <20170628112601.GD5981@leverpostej>
 <20170628113249.GF5981@leverpostej>
 <20170628201638.01204c14719514217433e82d@arm.com>
 <20170628204310.b45fd92458a2fba810a7520b@arm.com>
 <20170630140240.GB27839@leverpostej>
 <20170717194822.81c071a47bc294251dd9fedc@arm.com>
 <20170817221150.952211435b9a17bf02fb93c5@arm.com>
 <20170818173609.GB23083@leverpostej>
Message-ID: <20170821181821.cef7b0f8d2c624c33d6b6c15@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Aug 2017 18:36:09 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Kim,

Hi Mark,

> On Thu, Aug 17, 2017 at 10:11:50PM -0500, Kim Phillips wrote:
> > Hi Mark, I've tried to proceed as much as possible without your
> > response, so if you still have comments to my above comments, please
> > comment in-line above, otherwise review the v2 patch below?
> 
> Apologies again for the late response, and thanks for the updated patch!

Thanks for your prompt response this time around.

> > .
> > . ... ARM SPE data: size 536432 bytes
> > .  00000000:  4a 01                                           B COND
> > .  00000002:  b1 00 00 00 00 00 00 00 80                      TGT 0 el0 ns=1
> > .  0000000b:  42 42                                           RETIRED NOT-TAKEN
> > .  0000000d:  b0 20 41 c0 ad ff ff 00 80                      PC ffffadc04120 el0 ns=1
> > .  00000016:  98 00 00                                        LAT 0 TOT
> > .  00000019:  71 80 3e f7 46 e9 01 00 00                      TS 2101429616256
> > .  00000022:  49 01                                           ST
> > .  00000024:  b2 50 bd ba 73 00 80 ff ff                      VA ffff800073babd50
> > .  0000002d:  b3 50 bd ba f3 00 00 00 80                      PA f3babd50 ns=1
> > .  00000036:  9a 00 00                                        LAT 0 XLAT
> > .  00000039:  42 16                                           RETIRED L1D-ACCESS TLB-ACCESS
> > .  0000003b:  b0 8c b4 1e 08 00 00 ff ff                      PC ff0000081eb48c el3 ns=1
> > .  00000044:  98 00 00                                        LAT 0 TOT
> > .  00000047:  71 cc 44 f7 46 e9 01 00 00                      TS 2101429617868
> > .  00000050:  48 00                                           INSN-OTHER
> > .  00000052:  42 02                                           RETIRED
> > .  00000054:  b0 58 54 1f 08 00 00 ff ff                      PC ff0000081f5458 el3 ns=1
> > .  0000005d:  98 00 00                                        LAT 0 TOT
> > .  00000060:  71 cc 44 f7 46 e9 01 00 00                      TS 2101429617868
> 
> So FWIW, I think this is a good example of why that padding I requested
> last time round matters.
> 
> For the first PC packet, I had to count the number of characters to see
> that it was a TTBR0 address, which is made much clearer with leading
> padding, as 0000ffffadc04120. With the addresses padded, the EL and NS
> fields would also be aligned, making it *much* easier to scan by eye.

See my response in my prior email.

> > - multiple SPE clusters/domains support pending potential driver changes?
> 
> As covered in my other reply, I don't believe that the driver is going
> to change in this regard. Userspace will need to handle multiple SPE
> instances.
> 
> I'll ignore that in the code below for now.

Please let's continue the discussion in one place, and again in this
case, in the last email.

> > - CPU mask / new record behaviour bisected to commit e3ba76deef23064 "perf
> >   tools: Force uncore events to system wide monitoring".  Waiting to hear back
> >   on why driver can't do system wide monitoring, even across PPIs, by e.g.,
> >   sharing the SPE interrupts in one handler (SPE's don't differ in this record
> >   regard).
> 
> Could you elaborate on this? I don't follow the interrupt handler
> comments.

Would it be possible for the driver to request the IRQs with
IRQF_SHARED, in order to be able to operate across the multiple PPIs?

> > +static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
> > +{
> > +	u64 ts;
> > +
> > +	asm volatile ("isb; mrs %0, cntvct_el0" : "=r" (ts));
> > +
> > +	return ts;
> > +}
> 
> As covered in my other reply, please don't use the counter for this.
> 
> It sounds like we need a simple/generic function to get a nonce, that
> we could share with the ETM code.

I've switched to using clock_gettime(CLOCK_MONOTONIC_RAW, ...).  The
ETM code uses two rand() calls, which, according to some minor
benchmarking on Juno, is almost twice as slow as clock_gettime. It's
three lines still, so I'll update the ETM code in-place independently
of this patch, and after the gettime implementation is reviewed.

> > +int arm_spe_get_packet(const unsigned char *buf, size_t len,
> > +		       struct arm_spe_pkt *packet)
> > +{
> > +	int ret;
> > +
> > +	ret = arm_spe_do_get_packet(buf, len, packet);
> > +	if (ret > 0 && packet->type == ARM_SPE_PAD) {
> > +		while (ret < 16 && len > (size_t)ret && !buf[ret])
> > +			ret += 1;
> > +	}
> > +	return ret;
> > +}
> 
> What's this doing? Skipping padding? What's the significance of 16?

I'll repeat the relevant part of the v2 changelog here:

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

...the 16 is the width of the dump format: max. 16 byte being displayed
per line: I'll add a comment as such.

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
> > +		size_t blen = buf_len;
> > +
> > +		ret = 0;
> > +		ret = snprintf(buf, buf_len, "EV");
> > +		buf += ret;
> > +		blen -= ret;
> > +		if (payload & 0x1) {
> > +			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
> > +			buf += ret;
> > +			blen -= ret;
> > +		}
> > +		if (payload & 0x2) {
> > +			ret = snprintf(buf, buf_len, " RETIRED");
> > +			buf += ret;
> > +			blen -= ret;
> > +		}
> > +		if (payload & 0x4) {
> > +			ret = snprintf(buf, buf_len, " L1D-ACCESS");
> > +			buf += ret;
> > +			blen -= ret;
> > +		}
> > +		if (payload & 0x8) {
> > +			ret = snprintf(buf, buf_len, " L1D-REFILL");
> > +			buf += ret;
> > +			blen -= ret;
> > +		}
> > +		if (payload & 0x10) {
> > +			ret = snprintf(buf, buf_len, " TLB-ACCESS");
> > +			buf += ret;
> > +			blen -= ret;
> > +		}
> > +		if (payload & 0x20) {
> > +			ret = snprintf(buf, buf_len, " TLB-REFILL");
> > +			buf += ret;
> > +			blen -= ret;
> > +		}
> > +		if (payload & 0x40) {
> > +			ret = snprintf(buf, buf_len, " NOT-TAKEN");
> > +			buf += ret;
> > +			blen -= ret;
> > +		}
> > +		if (payload & 0x80) {
> > +			ret = snprintf(buf, buf_len, " MISPRED");
> > +			buf += ret;
> > +			blen -= ret;
> > +		}
> > +		if (index > 1) {
> > +			if (payload & 0x100) {
> > +				ret = snprintf(buf, buf_len, " LLC-ACCESS");
> > +				buf += ret;
> > +				blen -= ret;
> > +			}
> > +			if (payload & 0x200) {
> > +				ret = snprintf(buf, buf_len, " LLC-REFILL");
> > +				buf += ret;
> > +				blen -= ret;
> > +			}
> > +			if (payload & 0x400) {
> > +				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
> > +				buf += ret;
> > +				blen -= ret;
> > +			}
> > +		}
> > +		if (ret < 0)
> > +			return ret;
> > +		blen -= ret;
> > +		return buf_len - blen;
> > +	}
> 
> This looks like it could be turned into another switch, sharing the
> repeated logic.

How, if the payload may have multiple bits set?

I've addressed the rest of your comments and therefore trimmed them
out.  I can post a v3, but would rather shake out the pending issues
first, so please reply to my comments on this and Friday's email (Date:
Fri, 18 Aug 2017 17:22:48 -0500).

Thanks,

Kim
