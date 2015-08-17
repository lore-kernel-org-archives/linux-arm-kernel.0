From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 17 Aug 2015 13:06:35 +0200
Subject: [PATCH] arm64: ignore memory outside of the linear range
In-Reply-To: <20150817110454.GC2482@e104818-lin.cambridge.arm.com>
References: <1439640824-30498-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150817104049.GB2482@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_9zx5gZBRWO_Yg082Afoc7ksy2yJm-1xqprq06ptLJQw@mail.gmail.com>
 <20150817110454.GC2482@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu9j2_u4Bbtr+yvSfiNe_Vw4ZapO+r1xqxSUmbVBJ4GB3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 August 2015 at 13:04, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Aug 17, 2015 at 12:44:50PM +0200, Ard Biesheuvel wrote:
>> On 17 August 2015 at 12:40, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Sat, Aug 15, 2015 at 02:13:44PM +0200, Ard Biesheuvel wrote:
>> >> We need to ensure that we don't try to map system RAM ranges whose
>> >> offset relative to the start of the kernel image exceeds the size of
>> >> the linear range. This may happen even on systems that don't have
>> >> huge amounts of RAM if it is laid out very sparsely.
>> >>
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >> ---
>> >>
>> >> This is the minimal fix for addressing the issue we discussed. I dropped
>> >> the other changes for now, let's revisit those when (if) my patches for
>> >> decoupling the kernel mapping from the linear mapping are back under
>> >> discussion.
>> >>
>> >> I will leave it up to the maintainers whether this constitutes a bugfix or
>> >> not, but since this has never worked from the beginning afaict, I don't
>> >> think it belongs in stable per se.
>> >
>> > Even though it is not a regression, I think it is a bug fix and it's
>> > worth cc'ing stable (though we could push it after 4.3-rc1).
>> >
>> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> >> index ad87ce826cce..c65e57d4c3e7 100644
>> >> --- a/arch/arm64/mm/init.c
>> >> +++ b/arch/arm64/mm/init.c
>> >> @@ -158,6 +158,19 @@ early_param("mem", early_mem);
>> >>
>> >>  void __init arm64_memblock_init(void)
>> >>  {
>> >> +     /*
>> >> +      * Remove the memory that we will not be able to cover
>> >> +      * with the linear mapping.
>> >> +      */
>> >> +     const s64 linear_region_size = -(s64)PAGE_OFFSET;
>> >> +
>> >> +     if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {
>> >> +             pr_warn("Ignoring memory outside of linear range (0x%012llx - 0x%012llx)\n",
>> >> +                     memstart_addr + linear_region_size,
>> >> +                     (u64)memblock_end_of_DRAM() - 1);
>> >> +             memblock_remove(memstart_addr + linear_region_size, ULLONG_MAX);
>> >> +     }
>> >
>> > For memory blocks below PHYS_OFFSET, we ignore them in
>> > early_init_dt_add_memory_arch() directly (and also print a warning).
>> > Could we not do something similar for higher blocks? This function has a
>> > check for MAX_PHYS_ADDR but thats -1ULL, so I guess the check is pretty
>> > much useless. We should allow the arch code define this macro and only
>> > leave the current value as default if not overridden.
>> >
>>
>> That is actually more or less what Mark Rutland proposed here
>>
>> http://article.gmane.org/gmane.linux.ports.arm.kernel/430239
>
> Ah, I missed this. I prefer Mark's variant more (once it's fixed).
>
>> I proposed to override early_init_dt_add_memory_arch() completely
>> instead, but Rob had some comments, after which the discussion kind of
>> fizzled out.
>
> I don't think we should override early_init_dt_add_memory_arch(), unless
> we diverge too much from it. Currently, it looks to me like the end of
> PA range check is pretty useless in this function.
>

OK. But note that, when we decouple the linear mapping from the
mapping of the kernel image, we will need to override this function
anyway.
