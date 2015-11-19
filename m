From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 Nov 2015 18:45:34 +0000
Subject: [PATCH 2/5] arm64: cpufeature: Track unsigned fields
In-Reply-To: <564D9E61.8010802@arm.com>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-2-git-send-email-suzuki.poulose@arm.com>
 <564D56CA.60502@linaro.org> <564D9E61.8010802@arm.com>
Message-ID: <20151119184533.GB10823@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 10:03:13AM +0000, Suzuki K. Poulose wrote:
> On 19/11/15 04:57, AKASHI Takahiro wrote:
> > From my curiosity,
> >can you please clarify your criteria regarding which fields of a register should be signed or unsigned?
> >I guessed that the fields marked with FTR_LOWER_SAFE or FTR_HIGHER_SAFE could be unsigned,
> >but it seems to be not always true looking at your patch.
> >Anyhow, for example,
> 
> ...
> 
> >>-    ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
> >>+    U_ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
> >>      ARM64_FTR_END,
> >>  };
> >
> >BigEnd, bits[11:8], is 0b0000 for "No mixed-endian support", and 0b0001 for
> >"Mixed-endian support". But can any other value be possible? If not, why signed?
> >If there are some hidden (or undocumented) specifications, as Ard mentioned, that's fine.
> >Please ignore my comments.
> 
> There are no hidden specifications, but just that they are
> undocumented. To be precise, the criteria I selected was based on the
> meaning of their values.
> 
> 1) If value represents something which cannot be negative and hence
>    should be treated as unsigned. e.g, number of break points
>    ID_AA64DFR0:BRPs.
> 
> 2) If the individual values are mapped to some other values which
>    cannot be negative, but have LOWER_SAFE/HIGHER_SAFE relation. e.g,
>    CTR_EL0:WRG - Log2 of the write granule size. ID_AA64MMFR0:PARANGE
>    - Supported PA Size

I asked for a clarification to be added to the ARM ARM but, in the
meantime, we have three types of fields:

a) A precise value (number of breakpoint registers) or a value from
   which you derive some precise value. You mentioned these above

b) Fields defining the presence of a feature (1, 2, 3). These would
   always be positive since the absence of such feature would mean a
   value of 0

c) Fields defining the absence of a feature by setting 0xf. These are
   usually fields that were initial RAZ and turned to -1. I don't expect
   such field be greater than 0, nor smaller than -1.

So I think we can treat (a) and (b) as unsigned permanently. We could
treat (c) as unsigned as well with a value of 0xf though I'm not sure
how it matches your LOWER/HIGHER_SAFE definitions.

If we go for all unsigned, we no longer need the sign extension of a
4-bit value.

-- 
Catalin
