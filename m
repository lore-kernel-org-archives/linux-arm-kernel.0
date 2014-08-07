From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Aug 2014 10:22:54 +0100
Subject: [PATCH v2 2/2] iommu/arm-smmu: Do not access non-existing SMR
 registers
In-Reply-To: <53E2BB71.9000201@codeaurora.org>
References: <1407175263-10699-1-git-send-email-ohaugan@codeaurora.org>
 <1407175263-10699-3-git-send-email-ohaugan@codeaurora.org>
 <20140806101948.GD23882@arm.com> <53E25B76.6090208@codeaurora.org>
 <20140806173518.GG25953@arm.com> <53E2BB71.9000201@codeaurora.org>
Message-ID: <20140807092254.GH13703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 12:34:09AM +0100, Olav Haugan wrote:
> On 8/6/2014 10:35 AM, Will Deacon wrote:
> > Hmm, I'm checking this with the architects because the TRMs aren't exactly
> > clear. The NUMSMRG works for stream-indexing (i.e. reports the number of
> > S2CRs), then all we have to do is change the above ~SMR_VALID to 0x0, since
> > those registers will be SBZP.
> 
> You don't agree that we should avoid doing register writes if not
> necessarily? In general I like to avoid trying to write registers that
> is not needed so that we don't do more work than needed.

If this was a fast-path then I'd certainly agree. However, device reset is
a pretty rare event and I'd be inclined to err on the side of code clarity
in preference to performance.

Anyway, it turns out that we can't use NUMSMRG for this so all that's moot.
We instead need to do 1 << SMMU_IDR0.NUMSIDB, which will give us the number
of S2CRs.

> >> As far as I can tell there are no other register telling us how many S2CR
> >> registers exist. That also brings up another point that there is no check
> >> in the code to ensure we are not trying to program more than the available
> >> S2CR registers when we use stream indexing.
> > 
> > On an SMMU using stream-indexing, if the StreamID goes off the end of the
> > S2CRs that's a fairly serious hardware configuration issue which I don't
> > think Linux is in a position to handle. I agree that a warning wouldn't
> > hurt on device add/attach though.
> > 
> 
> Yes, I meant to protect against programming errors where someone
> specified more Stream IDs than available S2CRs.

Sure. Could you have a go at hacking this up, please?

Will
