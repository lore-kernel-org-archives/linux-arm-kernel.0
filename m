From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Jul 2015 14:20:22 +0100
Subject: [PATCH v2 1/6] arm64: kernel: Add cpuid_feature_extract_field()
 for 4bit sign extension
In-Reply-To: <20150720113236.GH20385@e104818-lin.cambridge.arm.com>
References: <1437154221-5736-1-git-send-email-james.morse@arm.com>
 <1437154221-5736-2-git-send-email-james.morse@arm.com>
 <20150720113236.GH20385@e104818-lin.cambridge.arm.com>
Message-ID: <20150720132022.GI20385@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 12:32:37PM +0100, Catalin Marinas wrote:
> On Fri, Jul 17, 2015 at 06:30:16PM +0100, James Morse wrote:
> > Copied from arch/arm/include/asm/cputype.h, this function does the
> > shifting and sign extension necessary when accessing cpu feature fields.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Suggested-by: Russell King <linux@arm.linux.org.uk>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/cpufeature.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index c1044218a63a..56c843918504 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -70,6 +70,19 @@ static inline void cpus_set_cap(unsigned int num)
> >  		__set_bit(num, cpu_hwcaps);
> >  }
> >  
> > +static inline int __attribute_const__ cpuid_feature_extract_field(u64 features,
> > +								  int field)
> > +{
> > +	int feature = (features >> field) & 15;
> > +
> > +	/* feature registers are signed values */
> > +	if (feature > 8)
> > +		feature -= 16;
> > +
> > +	return feature;
> > +}
> 
> It may generate better code like, especially when field is a constant:
> 
> 	return (s64)(feature << (64 - 4 - field)) >> (64 - 4);
> 
> (in asm I think we could do it with a single instruction but the above
> shouldn't be that bad either).

gcc managed to impress me ;). It detects the left-right shifts and
inlines "sbfx xn, xn, #field, #4" when the field is a constant.

-- 
Catalin
