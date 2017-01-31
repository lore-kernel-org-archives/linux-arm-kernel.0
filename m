From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Jan 2017 14:36:35 +0000
Subject: [PATCH v5 2/2] arm64: Work around Falkor erratum 1009
In-Reply-To: <20170131124223.GE11191@leverpostej>
References: <20170130230818.9848-1-cov@codeaurora.org>
 <20170130230818.9848-2-cov@codeaurora.org>
 <20170131124223.GE11191@leverpostej>
Message-ID: <20170131143635.GC22283@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 12:42:23PM +0000, Mark Rutland wrote:
> On Mon, Jan 30, 2017 at 06:08:17PM -0500, Christopher Covington wrote:
> > During a TLB invalidate sequence targeting the inner shareable domain,
> > Falkor may prematurely complete the DSB before all loads and stores using
> > the old translation are observed. Instruction fetches are not subject to
> > the conditions of this erratum. If the original code sequence includes
> > multiple TLB invalidate instructions followed by a single DSB, onle one of
> > the TLB instructions needs to be repeated to work around this erratum.
> > While the erratum only applies to cases in which the TLBI specifies the
> > inner-shareable domain (*IS form of TLBI) and the DSB is ISH form or
> > stronger (OSH, SYS), this changes applies the workaround overabundantly--
> > to local TLBI, DSB NSH sequences as well--for simplicity.
> > 
> > Based on work by Shanker Donthineni <shankerd@codeaurora.org>
> > 
> > Signed-off-by: Christopher Covington <cov@codeaurora.org>
> 
> This looks simple, self-contained, and correct, so FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Catalin/Will, since we may see a documentation conflict against a timer
> erratum, would you be hapyp to pick up [1] first, fixing up this patch
> as necessary?
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/484594.html

I replied over there, but I'd rather just take all the silicon-errata.txt
changes because I don't see them as being dependent on the rest of the
series.

For this patch specifically, I can't merge it until you're happy with the
other workaround, since they conflict.

Will
