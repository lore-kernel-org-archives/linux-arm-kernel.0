From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 18 Jan 2012 14:32:23 -0700
Subject: [PATCH] ARM: gic: refactor irq_start assignment
In-Reply-To: <20120117160334.GD27350@mudshark.cambridge.arm.com>
References: <1326802195-11412-1-git-send-email-will.deacon@arm.com>
 <4F159B81.9080104@gmail.com>
 <20120117160334.GD27350@mudshark.cambridge.arm.com>
Message-ID: <20120118213223.GQ4223@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 04:03:34PM +0000, Will Deacon wrote:
> On Tue, Jan 17, 2012 at 04:02:09PM +0000, Rob Herring wrote:
> > On 01/17/2012 06:09 AM, Will Deacon wrote:
> > > The irq_start and hwirq_base assignment code is fairly hairy and ended
> > > up being difficult to read following a conflict resolution for 3.2.
> > > 
> > > This patch rearranges the code slightly to make it easier to read.
> > > 
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm/common/gic.c |   13 ++++++-------
> > >  1 files changed, 6 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> > > index c47d619..ca6b5dd 100644
> > > --- a/arch/arm/common/gic.c
> > > +++ b/arch/arm/common/gic.c
> > > @@ -694,13 +694,12 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
> > >  	 * For primary GICs, skip over SGIs.
> > >  	 * For secondary GICs, skip over PPIs, too.
> > >  	 */
> > > -	domain->hwirq_base = 32;
> > > -	if (gic_nr == 0) {
> > > -		if ((irq_start & 31) > 0) {
> > > -			domain->hwirq_base = 16;
> > > -			if (irq_start != -1)
> > > -				irq_start = (irq_start & ~31) + 16;
> > > -		}
> > > +	if (gic_nr == 0 && (irq_start & 31) > 0) {
> > > +		domain->hwirq_base = 16;
> > > +		if (irq_start != -1)
> > > +			irq_start = (irq_start & ~31) + 16;
> > > +	} else {
> > > +		domain->hwirq_base = 32;
> > >  	}
> > 
> > This should probably just be rolled into Grant's irqdomain work. In any
> > case, it's going to conflict with it.
> 
> Ok, it's purely cosmetic so I'm fine with that. Grant - would you be able to
> pick this up please?

The conflict is pretty trivial and I'll handle any fixups if a
conflict occurs.  I'd rather not have changes unrelated to the
conversion in my series.

g.
