From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jan 2017 10:56:27 +0000
Subject: [PATCH v4 2/4] arm64: Work around Falkor erratum 1003
In-Reply-To: <e3343971-9e21-3462-f07b-569b496ab8ad@codeaurora.org>
References: <20170125155232.10277-1-cov@codeaurora.org>
 <20170125155232.10277-2-cov@codeaurora.org>
 <20170127143848.GA25899@leverpostej>
 <e3343971-9e21-3462-f07b-569b496ab8ad@codeaurora.org>
Message-ID: <20170130105627.GA1160@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 27, 2017 at 04:52:23PM -0500, Christopher Covington wrote:
> On 01/27/2017 09:38 AM, Mark Rutland wrote:
> > On Wed, Jan 25, 2017 at 10:52:30AM -0500, Christopher Covington wrote:

> >> Replacing the above sequence with the one below will ensure that no TLB
> >> entries with an incorrect ASID are used by software.
> >>
> >>   write reserved value to TTBRx_EL1[ASID]
> >>   ISB
> >>   write new value to TTBRx_EL1[BADDR]
> >>   ISB
> >>   write new value to TTBRx_EL1[ASID]
> >>   ISB
> >>
> >> When the above sequence is used, page table entries using the new BADDR
> >> value may still be incorrectly allocated into the TLB using the reserved
> >> ASID. Yet this will not reduce functionality, since TLB entries incorrectly
> >> tagged with the reserved ASID will never be hit by a later instruction.
> > 
> > I agree that there should be no explicit accesses to the VAs for these
> > entries. So tasks should not see erroneous VAs, and we shouldn't see
> > synchronous TLB conflict aborts.
> > 
> > Regardless, can this allow conflicting TLB entries to be allocated to
> > the reserved ASID? e.g. if one task has a 4K mapping at a given VA, and
> > another has a 2M mapping which covers that VA, can both be allocated
> > into the TLBs under the reserved ASID?
> > 
> > Can that have any effect on asynchronous TLB lookups or page table
> > walks, e.g. for speculated accesses?
> 
> A speculative access that inserts an entry into the TLB could
> possibly find the conflict but will not signal it. Does that answer
> your question?

Yes!

The other case I was worried about was intermediate caching. I take it
the values in TLBs are not used as part of subsequent page table walks?

If so, the above sounds fine to me.

Otherwise, we'll need additional TLB maintenance.

Thanks,
Mark.
