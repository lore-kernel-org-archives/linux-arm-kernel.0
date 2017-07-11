From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Jul 2017 18:58:54 +0100
Subject: prefetch inconsistency in copy_page()
In-Reply-To: <CY4PR07MB34150D0718D0A101FD433E0893AE0@CY4PR07MB3415.namprd07.prod.outlook.com>
References: <CAKv+Gu9hGwLJxBCMCTK2fsK31SgX7E=qc3PQcNXZA6OP2uUs8Q@mail.gmail.com>
 <20170711175257.GF13977@arm.com>
 <CY4PR07MB34150D0718D0A101FD433E0893AE0@CY4PR07MB3415.namprd07.prod.outlook.com>
Message-ID: <CAKv+Gu9C7dn2cJ9nj0xyMRqn8yfqGj05hxONr1sOXuOUKaN_AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 July 2017 at 18:53, Pinski, Andrew <Andrew.Pinski@cavium.com> wrote:
>> -----Original Message-----
>> From: Will Deacon [mailto:will.deacon at arm.com]
>> Sent: Tuesday, July 11, 2017 10:53 AM
>> To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>; Pinski, Andrew
>> <Andrew.Pinski@cavium.com>; linux-arm-kernel at lists.infradead.org
>> Subject: Re: prefetch inconsistency in copy_page()
>>
>> On Tue, Jul 11, 2017 at 10:42:19AM +0100, Ard Biesheuvel wrote:
>> > Hi all,
>> >
>> > No big deal, but I spotted an inconsistency in how copy_page() does
>> > its prefetching. With the code as-is, it prefetches 2 lines at the
>> > start of the function, but it is off by one line in the loop, i.e., it
>> > prefetches 3 lines ahead (and skips a line at entry). So imo, we need
>> > either
>> >
>> > """
>> > @@ -30,9 +30,10 @@
>> >   */
>> >  ENTRY(copy_page)
>> >  alternative_if ARM64_HAS_NO_HW_PREFETCH
>> > -       # Prefetch two cache lines ahead.
>> > +       # Prefetch three cache lines ahead.
>> >         prfm    pldl1strm, [x1, #128]
>> >         prfm    pldl1strm, [x1, #256]
>> > +       prfm    pldl1strm, [x1, #384]
>> >  alternative_else_nop_endif
>> >
>> >         ldp     x2, x3, [x1]
>> > """
>> >
>> > or
>> >
>> > """
>> > @@ -50,7 +51,7 @@ alternative_else_nop_endif
>> >         subs    x18, x18, #128
>> >
>> >  alternative_if ARM64_HAS_NO_HW_PREFETCH
>> > -       prfm    pldl1strm, [x1, #384]
>> > +       prfm    pldl1strm, [x1, #256]
>> >  alternative_else_nop_endif
>> >
>> >         stnp    x2, x3, [x0]
>> >
>> > """
>> >
>> > to make things consistent again.
>> >
>> > Thoughts?
>>
>> Either of those look good to me. Andrew -- any preference? If not, I'll
>> take the second one.
>
> The first one is my preference but both are ok to me.
>

I suppose the second one is the least likely to invalidate existing
benchmark results.

Will: should I spin it as a proper patch? Mind if I clean up the
whitespace at the same time?
