From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 9 Apr 2015 15:16:23 +0200
Subject: [PATCH v3 2/5] arm64: use fixmap region for permanent FDT mapping
In-Reply-To: <20150409131223.GA9527@leverpostej>
References: <1426698308-726-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426698308-726-3-git-send-email-ard.biesheuvel@linaro.org>
 <20150409114911.GB18488@leverpostej>
 <CAKv+Gu_dqMtLhLdCjj-eWn+tiAkwwXvNE6LJv7GPkx4aqTqsdA@mail.gmail.com>
 <20150409131223.GA9527@leverpostej>
Message-ID: <CAKv+Gu9b9Now_B_xftJDFyGxs8DGOTRZeGQjgOusiPh8Qvi0uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 April 2015 at 15:12, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> +NOTE: versions prior to v4.1 require, in addition to the requirements
>> >> +listed above, that the dtb be placed above the kernel Image inside the
>> >> +same naturally aligned 512 MB region.
>> >
>> > Minor nit: This would read a little better if we just said "versions
>> > prior to v4.1 also require that ...", dropping "in addition to the
>> > requirements listed above".
>> >
>>
>> OK
>>
>> Actually, I realized that this is incorrect anyway: it is not the same
>> naturally aligned 512 MB region, it is actually 'within 512 MB of the
>> start of the kernel Image' since that itself is naturally aligned to
>> 512 MB in the virtual address space.
>
> Surely starting at TEXT_OFFSET bytes below the kernel image? ;)
>

Only if you find it acceptable that people start putting their FDT in
the TEXT_OFFSET region ... :-)

>> >> +static void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
>> >> +{
>> >> +     const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
>> >> +     phys_addr_t dt_phys_base = dt_phys & ~(FIX_FDT_SIZE - 1);
>> >> +
>> >> +     /*
>> >> +      * Make sure that the FDT region can be mapped without the need to
>> >> +      * allocate additional translation table pages, so that it is safe
>> >> +      * to call create_pgd_mapping() this early.
>> >> +      * On 4k pages, we'll use section mappings for the region so we
>> >> +      * only have to be in the same PUD as the rest of the fixmap.
>> >> +      * On 64k pages, we need to be in the same PMD as well, as the region
>> >> +      * will be mapped using PTEs.
>> >> +      */
>> >> +     BUILD_BUG_ON(dt_virt_base & (SZ_2M - 1));
>> >
>> > s/SZ_2M/FIX_FDT_SIZE/
>> >
>> > Perhaps we should also have:
>> >
>> > BUILD_BUG_ON_NOT_POWER_OF_2(FIX_FDT_SIZE);
>> >
>> > ... given it's necessary for the address masking we do here.
>> >
>> > [...]
>> >
>>
>> I was going to suggest to use SZ_2M for the masking, but map a 4 MB
>> window. That way, we can relax the requirement from "should not cross
>> a 2 MB boundary' to 'should not exceed 2 MB in size', which is
>> arguable easier to adhere to, since the latter is a property of the
>> DTB itself, whereas the former is a property of whatever your malloc()
>> gives you. That means the mask would remain SZ_2M, and the size would
>> become SZ_4M
>
> That sounds good so long as it doesn't get in the way of increasing
> FIX_FDT_SIZE in future.
>

No, it shouldn't. And it actually makes it more obvious when we do
increase it later which values should be left alone (SZ_2M) and which
values should be increased (the higher ones)

>> > I've tested this on my Juno (atop of arm64 for-next/core), and all seems
>> > well, so with those points addressed:
>> >
>> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> > Tested-by: Mark Rutland <mark.rutland@arm.com>
>>
>> Thanks, but this code will likely look quite different if we are going
>> to cater for moving the kernel out of the linear range, so by then I
>> probably won't be able to retain these tags.
>
> Ok. I guess you'll merge the two series together?
>

Yes. I am currently looking into a way to make early_fixmap_init() not
rely on __va(), and if that is easily doable, I will propose something
for the FDT which is quite close to the latest submitted version. But
otherwise, it may be a bit more complicated, and the FDT mapping needs
more work.

-- 
Ard.
