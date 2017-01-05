From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 5 Jan 2017 12:31:51 +0100
Subject: [RFC PATCH 09/10] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <20170104191414.GU18193@arm.com>
References: <1483467027-14547-1-git-send-email-will.deacon@arm.com>
 <1483467027-14547-10-git-send-email-will.deacon@arm.com>
 <20170104103713.GH25813@worktop.programming.kicks-ass.net>
 <20170104191414.GU18193@arm.com>
Message-ID: <20170105113151.GG3093@worktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 07:14:14PM +0000, Will Deacon wrote:
> Hi Peter,
> 
> On Wed, Jan 04, 2017 at 11:37:13AM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 03, 2017 at 06:10:26PM +0000, Will Deacon wrote:
> > > The ARMv8.2 architecture introduces the Statistical Profiling Extension
> > > (SPE). SPE provides a way to configure and collect profiling samples
> > > from the CPU in the form of a trace buffer, which can be mapped directly
> > > into userspace using the perf AUX buffer infrastructure.
> > > 
> > > This patch adds support for SPE in the form of a new perf driver.
> > > 
> > 
> > Can you give a little high level overview of what exactly SPE is?
> 
> Sure, I can try, although there is no public documentation yet so it's a
> bit fiddly.
> 
> SPE can be used to profile a population of operations in the CPU pipeline
> after instruction decode. These are either architected instructions (i.e.
> a dynamic instruction trace) or CPU-specific uops and the choice is fixed
> statically in the hardware and advertised to userspace via caps/. Sampling
> is controlled using a sampling interval, similar to a regular PMU counter,
> but also with an optional random perturbation to avoid falling into patterns
> where you continuously profile the same instruction in a hot loop.
> 
> After each operation is decoded, the interval counter is decremented. When
> it hits zero, an operation is chosen for profiling and tracked within the
> pipeline until it retires. Along the way, information such as TLB lookups,
> cache misses, time spent to issue etc is captured in the form of a sample.
> The sample is then filtered according to certain criteria (e.g. load
> latency) that can be specified in the event config (described under
> format/) and, if the sample satisfies the filter, it is written out to
> memory as a record, otherwise it is discarded. Only one operation can
> be sampled at a time.
> 
> The in-memory buffer is linear and virtually addressed, raising an
> interrupt when it fills up. The PMU driver handles these interrupts to
> give the appearance of a ring buffer, as expected by the AUX code.
> 
> The in-memory trace-like format is self-describing (though not parseable
> in reverse) and written as a series of records, with each record
> corresponding to a sample and consisting of a sequence of packets. These
> packets are defined by the architecture, although some have CPU-specific
> fields for recording information specific to the microarchitecture.
> 
> As a simple example, a record generated for a branch instruction may
> consist of the following packets:
> 
>   0 (Address) : Virtual PC of the branch instruction
>   1 (Type)    : Conditional direct branch
>   2 (Counter) : Number of cycles taken from Dispatch to Issue
>   3 (Address) : Virtual branch target + condition flags
>   4 (Counter) : Number of cycles taken from Dispatch to Complete
>   5 (Events)  : Mispredicted as not-taken
>   6 (END)     : End of record
> 
> You can also toggle things like timestamp packets in each record.
> 
> Since SPE is an optional extension to the architecture, I'm sure there
> will be big.LITTLE systems where only one of the clusters has SPE support,
> so the driver is slightly complicated by handling that.

Hmm, on first reading that sounds a bit like a combination of AMD-IBS
and Intel-PEBS. PEBS has the memory buffer, but we keep that private to
the implementation, we rewrite the events into 'normal' perf SAMPLE
records on interrupt and context switch. IBS otoh doesn't have the
memory buffer but does similar things like tagging u-ops and providing
various metrics, which are exposed as is through SAMPLE_RAW.

I have no immediate objection to using AUX for this though, its arguably
similar to SAMPLE_RAW and makes sense since you have a memory buffer
already.

We also have an AUX enabled driver for Intel-BTS, which is similar to
PEBS but records branch traces (the precursor to PT in a sense).
