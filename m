From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Jun 2018 10:01:21 +0100
Subject: [PATCH] arm64: alternative:flush cache with unpatched code
In-Reply-To: <1527882765869.38555@nvidia.com>
References: <1527799054-29592-1-git-send-email-rokhanna@nvidia.com>
 <20180601090321.sy3t64rtps7qn2nx@salmiak>
 <1527882765869.38555@nvidia.com>
Message-ID: <20180604090120.c5lrdpzeannc4p6i@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 07:52:05PM +0000, Rohit Khanna wrote:
> [RK] - Thanks for the comments Mark. Reply inlined.
> 
> Thanks
> Rohit
> ________________________________________
> From: Mark Rutland <mark.rutland@arm.com>
> Sent: Friday, June 1, 2018 2:03 AM
> To: Rohit Khanna
> Cc: catalin.marinas at arm.com; robin.murphy at arm.com; Suzuki.Poulose at arm.com; linux-arm-kernel at lists.infradead.org; Alexander Van Brunt; Bo Yan; will.deacon at arm.com
> Subject: Re: [PATCH] arm64: alternative:flush cache with unpatched code

[...]

> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -617,6 +617,9 @@
> >  #define MVFR1_FPDNAN_SHIFT           4
> >  #define MVFR1_FPFTZ_SHIFT            0
> >
> > +/* SYS_CTR_EL0 */
> > +#define SYS_CTR_ISIZE_SHIFT          0
> > +#define SYS_CTR_DSIZE_SHIFT          16
> 
> We already have CTR_DMINLINE_SHIFT in <asm/cache.h>
> 
> Can we please add CTR_IMINLIN_SHIFT there too?
> 
> Maybe those should be moved into sysreg.h, but that can be a separate cleanup.
> 
> [RK] -  <asm/cache.h> doesnt contain CTR_DMINLINE_SHIFT.

It's on line 23 of arch/arm64/include/asm/cache.h, looking at v4.17.

[...]

> > +     /* use sanitised value of ctr_el0 rather than raw value from CPU */
> > +     ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
> > +     /* size in bytes */
> > +     d_size = cpuid_feature_extract_unsigned_field(ctr_el0,
> > +                     SYS_CTR_DSIZE_SHIFT);
> > +     i_size = cpuid_feature_extract_unsigned_field(ctr_el0,
> > +                     SYS_CTR_ISIZE_SHIFT);
> 
> This isn't the size in bytes. Each is log2 the number of (4-byte) words.
> 
> i.e. the size in bytes is (xMinLine << 2).
> [RK] - This doesnt seem right. For eg if IMinLine = 4 or 0b100
>            then with above formula ICacheSize in Bytes = 4 << 2 = 16
>            The correct formula should be (4 << xMinLine). 
>             So in case IMinLine = 4 or 0b100,
>             ICacheSizeBytes = 4 << 4 = 64B             

Whoops. You are correct with 4 << xMinLine.

[...]

> > +     d_start = (u64)start & ~(d_size - 1);
> > +     while (d_start <= (u64)end) {
> > +             /* Use civac instead of cvau. This is required
> > +              * due to ARM errata 826319, 827319, 824069,
> > +              * 819472 on A53
> > +              */
> > +             asm volatile("dc civac, %0" : : "r" (d_start));
> 
> Either this needs a memory clobber, or we need barrier() first, to ensure that
> the compiler doesn't re-order this against some of the patching code, however
> unlikely that may be.
> [RK] - So add barrier() before calling clean_dcache_range_nopatch() ?

I'd put it before the loop here so that it's clearly associated with the DC CIVAC.

Thanks,
Mark.
