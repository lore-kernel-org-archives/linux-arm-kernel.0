From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Feb 2015 12:12:25 +0000
Subject: [PATCH 2/4] arm64: pmu: add support for interrupt-affinity
 property
In-Reply-To: <20150205115601.GH11344@leverpostej>
References: <1422294858-28100-1-git-send-email-will.deacon@arm.com>
 <1422294858-28100-2-git-send-email-will.deacon@arm.com>
 <20150205115601.GH11344@leverpostej>
Message-ID: <20150205121224.GG23241@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 11:56:01AM +0000, Mark Rutland wrote:
> On Mon, Jan 26, 2015 at 05:54:16PM +0000, Will Deacon wrote:
> > Historically, the PMU devicetree bindings have expected SPIs to be
> > listed in order of *logical* CPU number. This is problematic for
> > bootloaders, especially when the boot CPU (logical ID 0) isn't listed
> > first in the devicetree.
> > 
> > This patch adds a new optional property, interrupt-affinity, to the
> > PMU node which allows the interrupt affinity to be described using
> > a list of phandled to CPU nodes, with each entry in the list
> > corresponding to the SPI at the same index in the interrupts property.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/pmu.txt |  6 +++
> >  arch/arm64/include/asm/pmu.h                  |  1 +
> >  arch/arm64/kernel/perf_event.c                | 57 +++++++++++++++++++++++++--
> >  3 files changed, 60 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> > index 75ef91d08f3b..a9281fc48743 100644
> > --- a/Documentation/devicetree/bindings/arm/pmu.txt
> > +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> > @@ -24,6 +24,12 @@ Required properties:
> >  
> >  Optional properties:
> >  
> > +- interrupt-affinity : Valid only when using SPIs, specifies a list of phandles
> > +                       to CPU nodes corresponding directly to the affinity of
> > +		       the SPIs listed in the interrupts property. If absent,
> > +		       the interrupts are assumed to be listed in logical CPU
> > +		       order.
> 
> This covers the case we care about today, but it's problematic in cases
> where the number of interrupts is not equal to the number of CPUs affine
> to that interrupt. For example:
> 
> * PPIs in big.LITTLE systems, where we may need a node per cluster, and
>   will need a way of associating a PMU node with a subset of all CPUs,
>   despite having only one interrupt.
> 
> * Muxed SPIs per-cluster (is this likely to happen?)
> 
> The former can be covered by allowing multiple entries in
> interrupt-affintiy for PPIs.

Yes, that sounds like a sensible extension in the future if we have to
support such a platform.

> I'm not sure if the latter is something we need to cater for. If we do,
> then perhaps we need an interruptN-affinity property per interrupt (though
> that's ugly and painful to deal with).

I'm not keen to handle this, so I'd rather defer it to whoever ends up
building it. Trying to design for every possibility is usually impossible
in my experience and you just end up carrying something that isn't useful.

Will
