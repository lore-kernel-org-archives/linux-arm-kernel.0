From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Aug 2011 10:51:37 +0100
Subject: [PATCH 10/10] ARM: perf: add mode exclusion for Cortex-A15 PMU
In-Reply-To: <4E55BCD9.7050703@codeaurora.org>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
	<1312823771-9952-11-git-send-email-will.deacon@arm.com>
	<CAKHPGBZ1eXzhsjFvLt_KTYKsR_OH7rgbeSGedTY5g8dhi90uzQ@mail.gmail.com>
	<4E55BCD9.7050703@codeaurora.org>
Message-ID: <20110825095136.GB27143@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 04:09:13AM +0100, Ashwin Chaugule wrote:
> Hey Will,

Hi Ashwin,

> > From: Will Deacon <will.deacon@arm.com>
> > 
> > The Cortex-A15 PMU implements the PMUv2 specification and therefore
> > has support for some mode exclusion.
> > 
> > This patch adds support for excluding user, kernel and hypervisor counts
> > from a given event.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> 
> 
> --8<---
> 
> > +
> > +/*
> > + * Event filters for PMUv2
> > + */
> > +#define        ARMV7_EXCLUDE_PL1       (1 << 31)
> > +#define        ARMV7_EXCLUDE_USER      (1 << 30)
> > +#define        ARMV7_INCLUDE_HYP       (1 << 27)
> > +
> 
> This mode exclusion stuff is confusing me.

I'm not surprised, the wording is pretty hard to follow in the
documentation.

> For exclude user mode, shouldn't PMXEVTYPER[PL1,U] = 0b11

No - this is a reserved encoding and results in the counters stopping for
*all* modes!

> With this patch the counters will spin with secure mode activity as well,
> if exclude user mode is selected ?

Yes, but they won't tick for either secure or non-secure user-mode, which is
what we want. Note that secure software can stop the counters ticking by
messing with the SDER.

> /me goes to bother the h/w guys.

Bah, they deserve it :)

Will
