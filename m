From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Aug 2014 15:34:30 +0100
Subject: [PATCH v2 2/3] arm64: add helper functions to read I-cache
 attributes
In-Reply-To: <CAKv+Gu-iGZMLgWHEPoc1w8HW3gUyuJXb6uerXg_kGQOhbqySSg@mail.gmail.com>
References: <1407230757-15305-1-git-send-email-ard.biesheuvel@linaro.org>
 <1407230757-15305-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140806130026.GR25953@arm.com>
 <CAKv+Gu_T+FuoS4jEyrG8b5WN8E9=N6nDUL7JC_=9VhaJV-2Pzg@mail.gmail.com>
 <CAKv+Gu-iGZMLgWHEPoc1w8HW3gUyuJXb6uerXg_kGQOhbqySSg@mail.gmail.com>
Message-ID: <20140806143430.GU25953@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 02:27:55PM +0100, Ard Biesheuvel wrote:
> On 6 August 2014 15:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 6 August 2014 15:00, Will Deacon <will.deacon@arm.com> wrote:
> >> On Tue, Aug 05, 2014 at 10:25:56AM +0100, Ard Biesheuvel wrote:
> >>> This adds helper functions and #defines to <asm/cachetype.h> to read the
> >>> line size and the number of sets from the level 1 instruction cache.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>> ---

[...]

> >>> +static inline __attribute_const__ u64 icache_get_ccsidr(void)
> >>> +{
> >>> +     u64 ccsidr;
> >>> +
> >>> +     /* Select L1 I-cache and read its size ID register */
> >>> +     asm("msr csselr_el1, %1; isb; mrs %0, ccsidr_el1"
> >>> +         : "=r"(ccsidr) : "r"(1L));
> >>> +     return ccsidr;
> >>
> >> Is it worth having a WARN_ON(preemptible()) here?
> >>
> >
> > Sure, why not.
> 
> ... if it weren't for the fact that this triggers recursive header
> inclusion hell
> 
>   CC      kernel/bounds.s
> In file included from /home/ard/linux-2.6/include/asm-generic/preempt.h:4:0,
>                  from arch/arm64/include/generated/asm/preempt.h:1,
>                  from /home/ard/linux-2.6/include/linux/preempt.h:18,
>                  from /home/ard/linux-2.6/arch/arm64/include/asm/cachetype.h:21,

[...]

> i.e., linux/bug,h and linux/preempt.h already implicitly #include
> cachetype.h, so including the former from the latter to import the
> declaration of WARN_ON() and/or preemptible respectively produces this
> error.

Damn, that's a real shame. I'm always dubious about adding code like this
which isn't obviously broken from preemptible context when you're just
looking at the function name.

Ho-hum.

Will
