From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Jan 2014 10:57:44 -0800
Subject: [PATCH 3/7] ARM: perf_event: Add basic support for Krait CPU PMUs
In-Reply-To: <20140110110114.GC10455@mudshark.cambridge.arm.com>
References: <1389221984-10973-1-git-send-email-sboyd@codeaurora.org>
 <1389221984-10973-4-git-send-email-sboyd@codeaurora.org>
 <20140109110440.GC17838@mudshark.cambridge.arm.com>
 <52CEFF18.2070501@codeaurora.org>
 <20140110110114.GC10455@mudshark.cambridge.arm.com>
Message-ID: <20140110185744.GF14405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10, Will Deacon wrote:
> On Thu, Jan 09, 2014 at 07:57:12PM +0000, Stephen Boyd wrote:
> > (Adding DT reviewers)
> > 
> > On 01/09/14 03:04, Will Deacon wrote:
> > > On Wed, Jan 08, 2014 at 10:59:40PM +0000, Stephen Boyd wrote:
> > >
> > >> +static int krait_pmu_init(struct arm_pmu *cpu_pmu)
> > >> +{
> > >> +	u32 id = read_cpuid_id() & 0xffffff00;
> > >> +
> > >> +	armv7pmu_init(cpu_pmu);
> > >> +	cpu_pmu->name		= "ARMv7 Krait";
> > >> +	/* Some early versions of Krait don't support PC write events */
> > >> +	if (id == 0x511f0400 || id == 0x510f0600)
> > >> +		cpu_pmu->map_event	= krait_map_event_no_branch;
> > > Hmm, I'd really rather this information came via the DT. In fact, you could
> > > just drop the branch event from your main map_event_function and keep things
> > > simple. It depends how badly you want to advertise it in perf list :)
> > >
> > 
> > Not every version of Krait is missing support for this event, so I'd
> > like to keep it so things like perf stat show branch counts. How about I
> > add a bool property to the pmu node indicating that this PMU is missing
> > support for the PC write events? Something like "no-pc-write"?
> 
> Perhaps, although I think it should be qualcomm-specific, so something like
> "qcom,krait-no-pc-write"? Again, I'd be glad to hear something from a DT
> reviewer on this.
> 

Yes a vendor prefix is probably a good idea. I'll add that in.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
