From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Sep 2016 15:30:37 +0100
Subject: [PATCH v7 8/9] arm64: pmu: Detect and enable multiple PMUs in an
 ACPI system
In-Reply-To: <b4d5397f-2ab0-8c19-d36e-ea23edb71bfb@arm.com>
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
 <1471985280-2243-9-git-send-email-jeremy.linton@arm.com>
 <8737lro9lq.fsf@e105922-lin.cambridge.arm.com>
 <b4d5397f-2ab0-8c19-d36e-ea23edb71bfb@arm.com>
Message-ID: <20160901143037.GL6721@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 05:44:59PM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 08/26/2016 10:04 AM, Punit Agrawal wrote:
> (trimming)
> >>+			pmu = kzalloc(sizeof(struct pmu_types), GFP_KERNEL);
> >>+			if (!pmu) {
> >>+				pr_warn("Unable to allocate pmu_types\n");
> >>+				/*
> >>+				 * continue to count cpus for any pmu_types
> >>+				 * already allocated, but don't allocate any
> >>+				 * more pmu_types. This avoids undercounting.
> >>+				 */
> >>+				alloc_failure = true;
> >
> >Why not just fail probe and return an error? What is the benefit of
> >having some of the PMUs available?
> 
> AFAIC, there isn't a good reason for penalizing PMU's which we can get
> working if a subset of the system PMUs can't be created. But this is per PMU
> type, so with current systems the kzalloc will be called a max of 2 times
> (there is the potential of a 3rd time, due to some other error handling, but
> that doesn't change the argument much). AKA, this doesn't result in "partial
> registration" of a PMU.

... but this will look mighty confusing to userspace, where things will
appear to "half-work", if for some reason the machine makes it that far
at all.

I think we should stick with the KISS approach and just fail the probe
as Punit is suggesting.

Will
