From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 16 Jun 2015 17:51:29 +0100
Subject: [PATCH 00/10] arm64: Use BRK instruction for generic BUG traps
In-Reply-To: <20150616145105.GG30522@arm.com>
References: <1434036566-9848-1-git-send-email-Dave.Martin@arm.com>
 <20150616145105.GG30522@arm.com>
Message-ID: <20150616165129.GC3651@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 03:51:05PM +0100, Will Deacon wrote:
> Hi Dave,
> 
> On Thu, Jun 11, 2015 at 04:29:14PM +0100, Dave P Martin wrote:
> > Currently, the minimal default BUG() implementation from asm-generic is
> > used for arm64.
> > 
> > This series uses the BRK software breakpoint instruction to generate a
> > trap instead, similarly to most other arches, with the generic BUG code
> > generating the dmesg boilerplate.  This eliminates a fair amount of
> > inlined code at BUG() and WARN() sites.
> 
> I think patches 3 and 8 are a bit OTT and don't really bring us much.
> 
> However, for the rest of the series (modulo my minor comments):
> 
>   Reviewed-by: Will Deacon <will.deacon@arm.com>

Patch 3 is needed to silence compiler warnings that happen as a side-
effect of the redefinition of DBG_ESR_VAL_BRK in patch 4.

A point hack in DBG_ESR_VAL_BRK could have fixed this, but the existing
ESR definitions are the real cause -- simply stripping all the type
information didn't appear safe due to the use of shifts and masking.
Unfortunately, attempting to fix this properly touched more code than I
would have liked...


Patch 8 was requested by Mark Rutland, who preferred a separate header
for those definitions rather than allowing them to sprawl in place.
It seemed a fair point, but I'm happy either way.

I can still drop the affected patches if you want -- let me know.

Cheers
---Dave
